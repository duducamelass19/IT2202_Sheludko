import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(KubGAUNewsApp());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class KubGAUNewsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Лента новостей КубГАУ',
      theme: ThemeData(
        primarySwatch: Colors.green,
        cardColor: Colors.green[50],
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.green[700],
          foregroundColor: Colors.white,
        ),
      ),
      home: NewsScreen(),
    );
  }
}

class NewsItem {
  final String title;
  final String content;
  final String date;
  final String imageUrl;
  final String detailUrl;

  NewsItem({
    required this.title,
    required this.content,
    required this.date,
    required this.imageUrl,
    required this.detailUrl,
  });

  factory NewsItem.fromJson(Map<String, dynamic> json) {
    final rawDate = json['ACTIVE_FROM'] ?? '';
    final formattedDate = _formatDate(rawDate);

    return NewsItem(
      title: _stripHtml(json['TITLE'] ?? 'Ошибка заголовка'),
      content: _stripHtml(json['PREVIEW_TEXT'] ?? 'Ошибка текста'),
      date: formattedDate,
      imageUrl: json['PREVIEW_PICTURE_SRC'] ?? 'Ошибка изображения',
      detailUrl: json['DETAIL_PAGE_URL'] ?? 'Ошибка ссылки на новость',
    );
  }

  static String _formatDate(String dateStr) {
    try {
      final parsedDate = DateFormat('dd.MM.yyyy HH:mm:ss').parse(dateStr);
      return DateFormat('d MMMM yyyy', 'ru').format(parsedDate);
    } catch (e) {
      return dateStr;
    }
  }

  static String _stripHtml(String htmlText) {
    return htmlText.replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), '').trim();
  }
}

class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  late Future<List<NewsItem>> futureNews;

  @override
  void initState() {
    super.initState();
    futureNews = fetchNews();
  }

  Future<List<NewsItem>> fetchNews() async {
    final url = 'https://kubsau.ru/api/getNews.php?key=6df2f5d38d4e16b5a923a6d4873e2ee295d0ac90';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List jsonData = json.decode(response.body);
      return jsonData.map((item) => NewsItem.fromJson(item)).toList();
    } else {
      throw Exception('Ошибка загрузки новостей');
    }
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Не удалось открыть $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Лента новостей КубГАУ'),
      ),
      body: FutureBuilder<List<NewsItem>>(
        future: futureNews,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final newsList = snapshot.data!;
            return ListView.builder(
              itemCount: newsList.length,
              itemBuilder: (context, index) {
                final news = newsList[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (news.imageUrl.isNotEmpty)
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              news.imageUrl,
                              width: double.infinity,
                              height: 180,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Text('Не удалось загрузить изображение');
                              },
                            ),
                          ),
                        SizedBox(height: 8),
                        Text(
                          news.title,
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 6),
                        Text(news.date, style: TextStyle(color: Colors.grey[600])),
                        SizedBox(height: 10),
                        Text(news.content),
                        SizedBox(height: 8),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () => _launchUrl(news.detailUrl),
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.green, // зелёный цвет текста
                            ),
                            child: Text('Читать далее'),

                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Ошибка: ${snapshot.error}'));
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

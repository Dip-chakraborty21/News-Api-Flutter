import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:phone_app/constant.dart';
import 'package:phone_app/news_response.dart';

class NetworkCallScreen extends StatelessWidget {
  NetworkCallScreen({super.key});

  var client = http.Client();
  final newsController = StreamController<NewsResponse>();
  BuildContext? loaderContext;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News API'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await getAllNews(context);
        },
        label: Text('CAll'),
      ),
      body: StreamBuilder<NewsResponse>(
          stream: newsController.stream,
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return SizedBox.shrink();
            }
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            final data = snapshot.data;
            return ListView.separated(
              physics: BouncingScrollPhysics(
                decelerationRate: ScrollDecelerationRate.fast,
              ),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data?.articles[index].title ?? 'N/A',
                        style: TextStyle(fontSize: 24),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        data?.articles[index].description ?? 'N/A',
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) => Divider(),
              itemCount: data?.articles.length ?? 0,
            );
          }),
    );
  }

  Future<void> getAllNews(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) {
        loaderContext = context;
        return BackdropFilter(
          filter: ImageFilter.blur(),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
              child: CircularProgressIndicator(
                color: Colors.deepOrange,
              ),
            ),
          ),
        );
      },
    );
    try {
      final response = await client.get(
        Uri.https(
          'newsapi.org',
          'v2/everything',
          {
            'q': 'tesla',
            'from': '2024-07-11',
            'sortBy': 'publishedAt',
            'apiKey': Constant.API_KEY,
          },
        ),
      );
      final newsResponse = newsResponseFromJson(response.body);
      newsController.add(newsResponse);
    } catch (e) {
      debugPrint(e.toString());
    }
    if (loaderContext != null) {
      Navigator.pop(loaderContext!);
    }
  }
}

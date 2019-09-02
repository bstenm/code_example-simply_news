import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class NewsFeed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance.collection('articles').snapshots(),
      builder: (_, snapshot) {
        if (!snapshot.hasData) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              CircularProgressIndicator(),
            ],
          );
        }

        List articles = snapshot.data.documents;

        return ListView.builder(
          itemCount: articles.length,
          itemBuilder: (_, int index) {
            final List body = jsonDecode(articles[index]['processed_body']);
            final String title = articles[index]['title'];

            return Card(
              child: GestureDetector(
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            child: Text(
                              title,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                              ),
                            ),
                            padding: EdgeInsets.only(
                              top: 15.0,
                              right: 15.0,
                              left: 15.0,
                            ),
                          ),
                          Row(
                            children: [
                              Padding(
                                child: Text(
                                  body.length.toString() + ' words',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                  ),
                                ),
                                padding: EdgeInsets.all(15.0),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Image.asset(
                      'assets/images/lake.jpg',
                      width: 100,
                      height: 100,
                    ),
                  ],
                ),
                onTap: () => Navigator.pushNamed(_, '/article', arguments: {
                      'title': title,
                      'body': body,
                    }),
              ),
            );
          },
        );
      },
    );
  }
}

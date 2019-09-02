import 'dart:collection';

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simply_news/lib/report_error.dart';
import 'package:simply_news/messages.dart';
import 'package:simply_news/state/user_state.dart';
import 'package:simply_news/widgets/home.dart';
import 'package:simply_news/widgets/news_feed.dart';
import 'package:simply_news/widgets/not_found.dart';
import 'package:simply_news/widgets/require_auth.dart';
import 'package:simply_news/widgets/user_vocabulary.dart';

class TabbedPages extends StatefulWidget {
  final page;

  TabbedPages({this.page});

  @override
  _TabbedPagesState createState() => _TabbedPagesState();
}

class _TabbedPagesState extends State<TabbedPages> {
  int selectedIndex;
  final messages = Messages.fromJson();
  final screens = LinkedHashMap<String, Widget>.from({
    'home': Home(),
    'articles': NewsFeed(),
    'notfound': NotFound(),
    'uservocab': RequireAuth((_) => UserVocabulary()),
  });

  @override
  Widget build(BuildContext context) {
    // [TODO]: Not sure we need that (getting index from navigator requesting this page)
    int requestedIndex =
        selectedIndex ?? screens.keys.toList().indexOf(widget.page);
    final user = Provider.of<UserState>(context);

    // to first screen if unknown route
    if (requestedIndex < 0) {
      requestedIndex = 0;
      reportError('${messages.unknownRoute}: ${widget.page}');
    }

    return Scaffold(
      body: IndexedStack(
        index: requestedIndex,
        children: screens.values.toList(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books),
            title: Text('Articles'),
          ),
          BottomNavigationBarItem(
            icon: Badge(
              showBadge: user.isSignedIn,
              animationType: BadgeAnimationType.scale,
              badgeContent: Text(
                user.vocab.length.toString(),
                style: TextStyle(color: Colors.white),
              ),
              badgeColor: Colors.purple,
              child: Icon(Icons.school),
            ),
            title: Text('Vocabulary'),
          ),
        ],
        currentIndex: requestedIndex,
        fixedColor: Colors.black,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
      ),
    );
  }
}

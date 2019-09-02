import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simply_news/state/user_state.dart';
import 'package:simply_news/widgets/article.dart';
import 'package:simply_news/widgets/bottom_navigation_article.dart';
import 'package:simply_news/widgets/user_vocabulary.dart';

class ArticlePage extends StatefulWidget {
  final Map article;

  ArticlePage(this.article);

  @override
  _ArticlePageState createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  final audioCache = AudioCache();
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserState>(context);
    AudioPlayer audioPlayer;

    void playAudio() async {
      if (audioPlayer != null) {
        audioPlayer.stop();
      }
      audioPlayer = await audioCache.play('audio/intro.mp3');
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Article'),
        backgroundColor: Colors.black,
      ),
      body: [
        Article(widget.article),
        Article(widget.article),
        UserVocabulary(),
      ][selectedIndex],
      bottomNavigationBar: BottonNavigationArticle(
        badgeNb: user.vocab.length,
        showBadge: user.isSignedIn,
        onTapListenIcon: playAudio,
      ),
    );
  }
}

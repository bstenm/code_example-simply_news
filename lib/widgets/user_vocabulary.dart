import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:simply_news/messages.dart';
import 'package:simply_news/state/user_state.dart';
import 'package:simply_news/widgets/flash_cards.dart';
import 'package:simply_news/widgets/vocab_list.dart';

class UserVocabulary extends StatefulWidget {
  @override
  _UserVocabularyState createState() => _UserVocabularyState();
}

class _UserVocabularyState extends State<UserVocabulary> {
  bool listView = true;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserState>(context);
    final List vocab = user.vocab;

    if (vocab.length < 1) return EmptyVocabList();

    return listView
        ? VocabList(
            vocab: vocab,
            onTapOpenIcon: () {
              setState(() {
                listView = false;
              });
            },
          )
        : FlashCards(
            vocab: vocab,
            onTapListIcon: () {
              setState(() {
                listView = true;
              });
            },
          );
  }
}

class EmptyVocabList extends StatelessWidget {
  final messages = Messages.fromJson();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(messages.noSavedVocab,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 30.0,
              color: Colors.black45,
            )),
        FlatButton(
          padding: EdgeInsets.only(top: 40.0),
          child: Text(messages.toArticlesButton,
              style: TextStyle(
                fontSize: 20.0,
              )),
          textColor: Theme.of(context).primaryColor,
          onPressed: () {
            Navigator.pushNamed(context, '/articles');
          },
        )
      ],
    );
  }
}

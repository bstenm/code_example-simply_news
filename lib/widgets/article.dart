import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:simply_news/widgets/dialog_save_vocab.dart';

class Article extends StatefulWidget {
  final Map data;

  Article(this.data);

  @override
  _ArticleState createState() => _ArticleState();
}

class _ArticleState extends State<Article> {
  List<TapGestureRecognizer> _tapRecognizers = [];

  @override
  void dispose() {
    _tapRecognizers.map((recognizer) => recognizer.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List body = widget.data['body'];
    final String title = widget.data['title'];

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(20.0),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: 20.0,
            right: 20.0,
          ),
          child: Text.rich(
            TextSpan(
              children: body.map(
                (token) {
                  bool hasData = token['lemma'] != null;
                  TapGestureRecognizer tapRecognizer = TapGestureRecognizer();
                  _tapRecognizers.add(tapRecognizer);
                  tapRecognizer.onTap = () => hasData
                      ? showDialog(
                          context: context,
                          builder: (_) {
                            Map w = Map.from(token);
                            w.remove('tag');
                            w.remove('text');
                            w.remove('text_with_ws');
                            return DialogSaveVocab(w);
                          },
                        )
                      : null;
                  return TextSpan(
                    recognizer: tapRecognizer,
                    text: token['text_with_ws'],
                    style: TextStyle(
                      fontSize: 18.0,
                      color: hasData ? Colors.lightBlue : Colors.black,
                    ),
                  );
                },
              ).toList(),
            ),
          ),
        )
      ],
    );
  }
}

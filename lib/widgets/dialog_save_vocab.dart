import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simply_news/messages.dart';
import 'package:simply_news/state/user_state.dart';
import 'package:simply_news/lib/report_error.dart';

class DialogSaveVocab extends StatefulWidget {
  final token;

  DialogSaveVocab(this.token);

  @override
  _SaveVocabDialogState createState() => _SaveVocabDialogState();
}

class _SaveVocabDialogState extends State<DialogSaveVocab> {
  bool showError = false;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserState>(context);
    Map token = widget.token;
    String pos = token['pos'];
    String lemma = token['lemma'];
    List examples = token['examples'] ?? [];

    void onSave() async {
      try {
        setState(() {
          showError = false;
        });
        await user.addVocab(token);
        Navigator.pop(context);
      } catch (error) {
        setState(() {
          showError = true;
        });
        reportError(error);
      }
    }

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(5.0),
        ),
      ),
      title: Text.rich(
        TextSpan(
          children: [
            TextSpan(text: lemma),
            TextSpan(
              text: '   $pos',
              style: TextStyle(
                color: Colors.black54,
                fontSize: 16.0,
              ),
            ),
          ],
        ),
      ),
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        ...examples.map((example) =>
          Padding(
            padding: EdgeInsets.only(bottom: 10.0),
            child: Text(
              example,
              style: TextStyle(
                color: Colors.black87,
                fontStyle: FontStyle.italic,
              ),
            ),
          )
        ).toList(),
        Visibility(
          visible: showError,
          child: Text(Messages.fromJson().unexpectedError,
              style: TextStyle(
                color: Colors.red,
              )),
        )
      ]),
      actions: <Widget>[
        FlatButton(
          onPressed: onSave,
          padding: EdgeInsets.all(10.0),
          child: Text('SAVE'),
        ),
        FlatButton(
          onPressed: () => Navigator.pop(context),
          padding: EdgeInsets.all(10.0),
          child: Text('CANCEL'),
        )
      ],
    );
  }
}

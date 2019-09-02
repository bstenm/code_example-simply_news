import 'package:flutter/material.dart';

class VocabList extends StatelessWidget {
  const VocabList({
    Key key,
    @required this.vocab,
    @required this.onTapOpenIcon,
  }) : super(key: key);

  final List vocab;
  final Function onTapOpenIcon;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: vocab.length,
        itemBuilder: (_, index) => Card(
          child: ListTile(
            trailing: IconButton(
              icon: Icon(Icons.open_in_new),
              onPressed: onTapOpenIcon,
            ),
            title: Row(
              children: [
                Text(
                  vocab[index]['lemma'],
                  style: TextStyle(
                    fontSize: 24.0,
                    fontFamily: 'RobotoSlab',
                  ),
                ),
                Container(
                  height: 28.0,
                  alignment: Alignment.bottomCenter,
                  padding: EdgeInsets.only(left: 15.0),
                  child: Text(
                    vocab[index]['pos'],
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black45,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
  }
}

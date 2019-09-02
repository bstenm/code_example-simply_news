import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';

class FlashCards extends StatelessWidget {
  FlashCards({
    Key key,
    @required this.vocab,
    @required this.onTapListIcon,
  }) : super(key: key);

  final List vocab;
  final Function onTapListIcon;
  final controller = PageController();
  final  audioCache = AudioCache();

  @override
  Widget build(BuildContext context) {
    AudioPlayer audioPlayer;

    return PageView(
      controller: controller,
      children: vocab
          .map(
            (token) => Card(
              margin: EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Text(
                    token['lemma'],
                    style: TextStyle(
                      fontSize: 60.0,
                      fontFamily: 'RobotoSlab',
                      color: Colors.teal[400],
                    ),
                  ),
                  Text(
                    token['pos'],
                    style: TextStyle(
                      fontSize: 20.0,
                      fontFamily: 'RobotoSlab',
                      color: Colors.black38,
                    ),
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  Image.asset(
                    'assets/images/to-climb.jpeg',
                    width: 150,
                    height: 150,
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  ...(token['examples'] ?? []).map(
                    (example) => Stack(
                      children: <Widget>[
                        Positioned(
                          top: -9.0,
                          child: IconButton(
                            color: Colors.teal[200],
                            icon: Icon(Icons.volume_up),
                            onPressed: () async {
                              audioPlayer.stop();
                              audioPlayer =
                                  await audioCache.play('audio/intro.mp3');
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 40.0,
                            vertical: 5.0,
                          ),
                          child: Text(
                            example,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16.0,
                              fontStyle: FontStyle.italic,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: IconButton(
                        color: Colors.black54,
                        icon: Icon(Icons.list),
                        onPressed: onTapListIcon,
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}

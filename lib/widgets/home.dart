import 'package:flutter/material.dart';
import 'package:simply_news/widgets/logout_button.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Text('Home'),
          LogoutButton(),
        ],
      ),
    );
  }
}

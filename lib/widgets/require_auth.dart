import 'package:flutter/material.dart';
import 'package:simply_news/pages/auth_page.dart';
import 'package:simply_news/state/user_state.dart';
import 'package:provider/provider.dart';

class RequireAuth extends StatelessWidget {
  final Function widgetRequested;

  RequireAuth(this.widgetRequested);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserState>(context);
    final _ = ModalRoute.of(context).settings.arguments;
    
    return user.status == Auth.NotSignedIn ? AuthPage() : widgetRequested(_);
  }
}

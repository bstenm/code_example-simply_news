import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simply_news/services/auth_api.dart';
import 'package:simply_news/state/user_state.dart';

class LogoutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserState>(context);

    return IconButton(
      icon: Icon(Icons.power_settings_new),
      onPressed: () {
        // call authorization service
        AuthApi.signoutUser();
        // update global state
        user.logout();
      },
    );
  }
}

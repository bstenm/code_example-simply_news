import 'package:flutter/material.dart';
import 'package:simply_news/services/auth_api.dart';
import 'package:simply_news/widgets/form_generic_auth.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      vsync: this,
      length: 2,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screens = [
      GenericAuthForm(
        authenticate: AuthApi.loginUser,
        redirectButtonText: 'I don\'t have an account',
        submitButtonText: 'Log in',
        redirectButtonRoute: () {
          _tabController.index = 1;
        },
      ),
      GenericAuthForm(
        authenticate: AuthApi.registerUser,
        redirectButtonText: 'I already have an account',
        submitButtonText: 'Sign up',
        redirectButtonRoute: () {
          _tabController.index = 0;
        },
      ),
    ];
    return DefaultTabController(
      length: screens.length,
      child: Scaffold(
        body: Container(
          margin: EdgeInsets.all(25.0),
          child: TabBarView(
            controller: _tabController,
            children: screens,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:simply_news/pages/article_page.dart';
import 'package:simply_news/pages/tabbed_pages.dart';
import 'package:simply_news/services/auth_api.dart';
import 'package:simply_news/state/user_state.dart';
import 'package:simply_news/lib/report_error.dart';
import 'package:simply_news/widgets/require_auth.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final UserState user = UserState();

    void onAppLoad() async {
      try {
        final currentUser = await AuthApi.getCurrentUser();
        // check if user still logged in
        if (currentUser == null) return;
        // set user as signed in and get their data
        user.email = currentUser.email;
        user.status = Auth.SignedIn;
        await user.getData();
      } catch (error) {
        // silent error: if couldn't get the user data we'll 
        // try again when they navigate to their vocab page
        // and only display an error message if that fails then
        reportError(error);
      }
    }

    return ChangeNotifierProvider(
      builder: (_) {
        onAppLoad();
        return user;
      },
      child: MaterialApp(
        title: 'Simply News',
        theme: ThemeData(
          primarySwatch: Colors.teal,
        ),
        initialRoute: 'home',
        routes: {
          '/': (_) => TabbedPages(page: 'home'),
          '/article': (_) => RequireAuth((_) => ArticlePage(_)),
          '/articles': (_) => TabbedPages(page: 'articles'),
        },
      ),
    );
  }
}

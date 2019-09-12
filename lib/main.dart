import 'package:flutter/material.dart';

import './pages/user_home_page.dart';
import './pages/users_login_page.dart';

void main() => runApp(MainApp());

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'page nois',
      routes: {
        '/': (ctx) => UsersLoginPage(),
        UserHomePage.routeName: (ctx) => UserHomePage(),
      },
    );
  }
}

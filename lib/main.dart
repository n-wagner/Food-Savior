import 'package:flutter/material.dart';
import 'login_page.dart';
import 'signup.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final routes = <String, WidgetBuilder>{
    LoginPage.tag: (context) => LoginPage(),
    SignUp.tag: (context) => SignUp(),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'food savior',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      home: LoginPage(),
      routes: routes,
    );
  }
}

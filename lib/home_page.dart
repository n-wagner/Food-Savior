import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  static String tag = 'home-page';

  @override
  Widget build(BuildContext context) {
    final  logo = Hero(
      tag: 'home',
      child: CircleAvatar(
      backgroundColor: Colors.transparent,
      radius: 48.0,
      child: Image.asset('assets/images/logo1.jpg'),
      ),
    );
    return Scaffold(
      body: logo,
    );
  }
}
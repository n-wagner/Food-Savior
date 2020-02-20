import 'package:flutter/material.dart';
import 'package:food_savior/services/auth.dart';

class HomePage extends StatelessWidget {
  static String tag = 'home-page';

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final  logo = Hero(
      tag: 'home',
      child: CircleAvatar(
      backgroundColor: Colors.transparent,
      radius: 48.0,
      child: Image.asset('assets/images/logo.jpg'),
      ),
    );
    return Scaffold(
      backgroundColor: Colors.orange[100],
      appBar: AppBar(   //Basically a top menu/bar thing
        title: Text('Food Savior'),
        backgroundColor: Colors.orange[400],
        elevation: 0.0,   //Makes it flat against the bacground (no shadows)
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('logout'),
            onPressed: () async {
              await _auth.signOut();    //Don't need to save this value because we don't plan to use it, just need to wait until it finishes
            }
          )
        ],
      ),
      body: logo,
    );
  }
}
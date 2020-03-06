import 'package:flutter/material.dart';
import 'package:food_savior/services/auth.dart';
import 'package:food_savior/screens/home/main_menu_layout.dart';

class HomePage extends StatefulWidget {
  static String tag = 'home-page';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AuthService _auth = AuthService();
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    // final  logo = Hero(
    //   tag: 'home',
    //   child: CircleAvatar(
    //   backgroundColor: Colors.transparent,
    //   radius: 48.0,
    //   child: Image.asset('assets/images/logo.jpg'),
    //   ),
    // );
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.orange[100],
      // appBar: AppBar(   //Basically a top menu/bar thing
      //   title: Text('Food Savior'),
      //   backgroundColor: Colors.orange[400],
      //   elevation: 0.0,   //Makes it flat against the bacground (no shadows)
      //   actions: <Widget>[
      //     FlatButton.icon(
      //       icon: Icon(Icons.person),
      //       label: Text('logout'),
      //       onPressed: () async {
      //         await _auth.signOut();    //Don't need to save this value because we don't plan to use it, just need to wait until it finishes
      //       }
      //     )
      //   ],
      // ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget> [
            Expanded(
              child: FlatButton(
                color: Colors.lightBlue[100],
                child: Text(
                  'Give Food',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/new-food');
                },
              ),
            ),
            Expanded(
              child: FlatButton(
                color: Colors.blue[200],
                child: Text(
                  'Get Food',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/swipes');
                },
              ),
            ),
          ]
        ),
      ),
      drawer: MenuLayout(),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(top: 130),
        child: FloatingActionButton(
          onPressed: () {
            _scaffoldKey.currentState.openDrawer();
          },
          child: Icon(Icons.menu),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
    );
  }
}


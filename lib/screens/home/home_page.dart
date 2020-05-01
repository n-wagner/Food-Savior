import 'package:flutter/material.dart';
import 'package:food_savior/screens/mainmenu/main_menu_layout.dart';
import 'package:food_savior/services/size_config.dart';

class HomePage extends StatefulWidget {
  static String tag = 'home-page';
  // final User u;

  // const HomePage({ Key key, this.u }): super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //final AuthService _auth = AuthService();
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    SizeConfigService.init(context);
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.brown[50],
      body: Container(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget> [
              Expanded(
                  child: IconButton(
                      icon: Image.asset('assets/images/givelogo.JPG'),
                      iconSize: SizeConfigService.safeBlockHorizontal * 50,
                      onPressed: () {
                          Navigator.pushNamed(context, '/new-food');
                  },
                ),
              ),
               Container(
                height: 5,
                color: Colors.brown[100]),

              Expanded(
                child: IconButton(
                      icon: Image.asset(
                        'assets/images/getlogo.JPG',
                      ),
                      iconSize: SizeConfigService.safeBlockHorizontal * 50,
                      onPressed: () {
                      Navigator.pushNamed(context, '/swipes');
                    },
                ),
              ),
            ]
          ),
        ),
      ),
      drawer: MenuLayout(),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(top: SizeConfigService.safeBlockVertical * 25),
        child: FloatingActionButton(
          child: Icon(
            Icons.menu, 
            color: Colors.brown[50]),
          onPressed: () {
            _scaffoldKey.currentState.openDrawer();
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
    );
  }
}


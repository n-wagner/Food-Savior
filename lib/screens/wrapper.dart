import 'package:flutter/material.dart';
import 'package:food_savior/models/user.dart';
import 'package:food_savior/screens/authenticate/authenticate.dart';
import 'package:food_savior/screens/home/home_page.dart';
import 'package:food_savior/services/database.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    //Specifying that the provider should be giving us User data
    final user = Provider.of<User>(context);
    // return either authenticate or content portion of the app
    if (user == null) {
      return Authenticate();
    } else {
      // return HomePage();
      return StreamProvider<User>.value(
        value: DatabaseService(uid: user.uid).user,
        child: HomePage(),
      );
    }
  }
}
import 'package:flutter/material.dart';
import 'package:food_savior/models/user.dart';
import 'package:food_savior/screens/authenticate/authenticate.dart';
import 'package:food_savior/screens/home/home_page.dart';
import 'package:provider/provider.dart';

import 'authenticate/login_page.dart';
import 'package:food_savior/screens/authenticate/signup.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    //Specifying that the provider should be giving us User data
    final user = Provider.of<User>(context);
    // return either authenticate or content portion of the app
    if (user == null) {
      return Authenticate();
    } 
    else {
      return HomePage(u: user);
    }
  }
}
import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:food_savior/models/user.dart';
import 'package:food_savior/screens/givefood/camera_test.dart';
import 'package:food_savior/screens/home/home_page.dart';
import 'package:food_savior/screens/givefood/images_selection.dart';

import 'package:food_savior/screens/getfood/swipes.dart';
import 'package:food_savior/screens/mainmenu/main_menu_layout.dart';
import 'package:food_savior/screens/getfood/swipes_wrapper.dart';
import 'package:food_savior/screens/mainmenu/profile.dart';
import 'package:food_savior/screens/wrapper.dart';
import 'package:food_savior/services/auth.dart';
import 'package:food_savior/screens/authenticate/login_page.dart';
import 'package:food_savior/screens/home/home_page.dart';
import 'package:food_savior/screens/givefood/new_food_page.dart';
import 'screens/authenticate/signup.dart';
import 'package:provider/provider.dart';
import 'package:camera/camera.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final routes = <String, WidgetBuilder>{
    //LoginPage.tag: (context) => LoginPage(),
    //SignUp.tag: (context) => SignUp(),
      //NewFoodPage.tag: (context) => NewFoodPage(),
  };

  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value( // keeps  track of particular user
      value: AuthService().user,    //Creates an instance and listens to the stream here (provider makes it available to all its decendents)
      child: MaterialApp(
        title: 'food savior',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.lightGreen,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => Wrapper(),
          '/home': (context) => HomePage(),
          //'/swipes': (context) => SwipePage(),
           '/swipes': (context) => SwipesWrapper(),
          '/new-food': (context) => NewFoodPage(),
          '/main-menu': (context) => MenuLayout(),
          '/test': (context) => CameraTest(),
          '/sign-up': (context) => SignUp(),
          '/image-select': (context) => ImageSelect(),
          '/profile-page': (context) => ProfilePage(),
          
        },
      ),
    );
  }
}



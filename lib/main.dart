import 'package:flutter/material.dart';
import 'package:food_savior/models/user.dart';
import 'package:food_savior/screens/wrapper.dart';
import 'package:food_savior/services/auth.dart';
import 'screens/authenticate/login_page.dart';
import 'screens/authenticate/signup.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final routes = <String, WidgetBuilder>{
    LoginPage.tag: (context) => LoginPage(),
    //SignUp.tag: (context) => SignUp(),
  };

  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,    //Creates an instance and listens to the stream here (provider makes it available to all its decendents)
      child: MaterialApp(
        title: 'food savior',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.lime,
        ),
        home: Wrapper(),
        routes: routes,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:food_savior/models/user.dart';

import 'package:food_savior/screens/givefood/camera_test.dart';
import 'package:food_savior/screens/home/home_page.dart';
import 'package:food_savior/screens/givefood/images_selection.dart';

import 'package:food_savior/screens/mainmenu/main_menu_layout.dart';
import 'package:food_savior/screens/getfood/swipes_wrapper.dart';
import 'package:food_savior/screens/mainmenu/pastOrders/past_orders_wrapper.dart';
import 'package:food_savior/screens/mainmenu/FAQs.dart';
import 'package:food_savior/screens/mainmenu/profile/profile_wrapper.dart';
import 'package:food_savior/screens/wrapper.dart';
import 'package:food_savior/services/auth.dart';
import 'package:food_savior/screens/givefood/new_food_page.dart';
import 'screens/authenticate/signup.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:camera/camera.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:food_savior/screens/chat/service.dart';
import 'package:food_savior/screens/chat/messages.dart';

//import 'package:food_savior/screens/maps/map_wrapper.dart';
import 'package:food_savior/services/location_picker.dart';



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
          '/swipes': (context) => SwipesWrapper(),
          '/new-food': (context) => NewFoodPage(),
          '/main-menu': (context) => MenuLayout(),
          '/test': (context) => CameraTest(),
          '/sign-up': (context) => SignUp(),
          '/image-select': (context) => ImageSelect(),
          '/profile-page': (context) => ProfilePageWrapper(),
          '/chat': (context) => ChatAppHome(),
          '/questions': (context) => Questions(),
         // '/map': (context) => MapWrapper(),
          '/past-orders': (context) => PastOrdersWrapper(),
          '/location_picker' :(context) => LocationPicker()
          ,          
        },
      ),
    );
  }
}



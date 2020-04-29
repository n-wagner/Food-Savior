import 'package:flutter/material.dart';
import 'package:food_savior/models/user.dart';
import 'package:food_savior/screens/authenticate/forgot_pass.dart';

import 'package:food_savior/screens/givefood/camera_test.dart';
import 'package:food_savior/screens/home/home_page.dart';
import 'package:food_savior/screens/givefood/images_selection.dart';

import 'package:food_savior/screens/mainmenu/main_menu_layout.dart';
import 'package:food_savior/screens/getfood/swipes_wrapper.dart';

import 'package:food_savior/screens/mainmenu/FAQs.dart';
import 'package:food_savior/screens/mainmenu/profile/profile_wrapper.dart';
import 'package:food_savior/screens/wrapper.dart';
import 'package:food_savior/services/auth.dart';
import 'package:food_savior/screens/givefood/new_food_page_wrapper.dart';
import 'screens/authenticate/signup.dart';
import 'package:provider/provider.dart';
import 'package:food_savior/screens/chat/messages.dart';
import 'package:food_savior/services/location_picker.dart';

import 'package:food_savior/screens/mainmenu/waiting_pickup/waiting_pickup_wrapper.dart';
import 'package:food_savior/screens/mainmenu/food_recieved/food_recieved_wrapper.dart';
import 'package:food_savior/screens/mainmenu/waiting_orders/waiting_orders_wrapper.dart';
import 'package:food_savior/screens/mainmenu/donated_items/donated_items_wrapper.dart';


void main() => runApp(MyApp());

class MyCustomRoute<T> extends MaterialPageRoute<T> {
  MyCustomRoute({ WidgetBuilder builder, RouteSettings settings })
      : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    // Fades between routes. (If you don't want any animation, 
    // just return child.)
    return new FadeTransition(opacity: animation, child: child);
  }
}

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
          primaryTextTheme: Typography.whiteMountainView,
          floatingActionButtonTheme: FloatingActionButtonThemeData(

          ),
          buttonTheme: ButtonThemeData(
           )
        ),
        initialRoute: '/',
        routes: {
          '/': (context ) => Wrapper(),
          '/home': (context) => HomePage(),
          '/swipes': (context) => SwipesWrapper(),
          '/new-food': (context) => NewFoodPageWrapper(),
          '/main-menu': (context) => MenuLayout(),
          '/test': (context) => CameraTest(),
          '/sign-up': (context) => SignUp(),
          '/image-select': (context) => ImageSelect(),
          '/profile-page': (context) => ProfilePageWrapper(),
          '/chat': (context) => ChatAppHome(),
          '/questions': (context) => Questions(),
         // '/map': (context) => MapWrapper(),
          '/items-donated': (context) => DonatedOrdersWrapper(),
          '/items-received': (context) => FoodRecievedWrapper(),
          '/orders-waiting': (context) => WaitingOrdersWrapper(),
          '/pickup-waiting': (context) => WaitingPickupWrapper(),
          '/location_picker' :(context) => LocationPicker(),
          '/forgot_pass' :(context) => ForgotPass()
          ,          
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:food_savior/models/food_item.dart';
import 'package:food_savior/models/user.dart';
import 'package:food_savior/screens/mainmenu/profile/profile.dart';
import 'package:food_savior/services/database.dart';
import 'package:provider/provider.dart';

class ProfilePageWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    
    if (user == null) {
      return Container(
        color: Colors.white,
        child: Center( 
          child: 
            Text(
              'Loading...', 
              style: TextStyle(
              color: Colors.blueGrey, 
              fontSize: 26)
            )
          )  
        );
    } else {
      return StreamProvider<User>.value(
        value: DatabaseService(uid: user.uid).user,
        child: StreamProvider<List<FoodItem>>.value(
          value: DatabaseService(uid: user.uid).foodItems,
          child: ProfilePage(),
        ),
      );
    }
  }
}
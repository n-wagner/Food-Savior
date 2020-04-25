import 'package:flutter/material.dart';
import 'package:food_savior/models/user.dart';
import 'package:food_savior/screens/givefood/new_food_page.dart';
import 'package:food_savior/services/database.dart';
import 'package:provider/provider.dart';

class NewFoodPageWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    
    if (user == null) {
      return Text("Loading...");
      // StreamProvider<List<FoodItem>>.value(
      //   value: DatabaseService().foodItems,
      //   child: PastOrders(),
      // );
    } 
    else {
      return StreamProvider<User>.value(
        value: DatabaseService(uid: user.uid).user,
        child: NewFoodPage(),
      );
    }
  }
}
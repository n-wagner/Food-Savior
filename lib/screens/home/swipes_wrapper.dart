import 'package:flutter/material.dart';
import 'package:food_savior/screens/home/swipes.dart';
import 'package:food_savior/services/database.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_savior/models/food_item.dart';

class SwipesWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<FoodItem>>.value(
      value: DatabaseService().foodItems,
      child: SwipePage(),
    );
  }
}
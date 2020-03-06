import 'package:flutter/material.dart';
import 'package:food_savior/screens/home/swipes.dart';
import 'package:food_savior/services/database.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SwipesWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<QuerySnapshot>.value(
      value: DatabaseService().users,
      child: SwipePage(),
    );
  }
}
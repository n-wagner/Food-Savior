import 'package:flutter/material.dart';
import 'package:food_savior/models/food_item.dart';

class FoodItemCard extends StatelessWidget {

  final FoodItem foodItem;
  FoodItemCard({ this.foodItem });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(30.0),
      child: Container(
        width: 300.0,
        height: 500.0,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(foodItem.img),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: <Widget>[
            SizedBox(height: 10.0),
            Text(foodItem.name),
            SizedBox(height: 10.0),
            Text(foodItem.time.toLocal().toString())
          ],
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50)
      ),
    );
  }
}
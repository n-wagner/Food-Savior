import 'package:flutter/material.dart';
import 'package:food_savior/models/food_item.dart';
import 'package:food_savior/services/size_config.dart';

class FoodItemCard extends StatelessWidget {

  final FoodItem foodItem;
  FoodItemCard({ this.foodItem });

  @override
  Widget build(BuildContext context) {
    SizeConfigService.init(context);
    return Card(
      margin: EdgeInsets.all(30.0),
      child: Container(
        width: SizeConfigService.safeBlockHorizontal * 70, //3 00.0,
        height: SizeConfigService.safeBlockVertical * 90, // 500.0,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: Image.network(foodItem.img).image, //(foodItem.img),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: <Widget>[
            SizedBox(height: 10.0),
            Text(foodItem.name),
            SizedBox(height: 10.0),
            Text(foodItem.time.toLocal().toString()),
            SizedBox(height: 10.0),
            Text(foodItem.docID),
            SizedBox(height: 10.0),
            Text(foodItem.uid.toString()),
          ],
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50)
      ),
    );
  }
}
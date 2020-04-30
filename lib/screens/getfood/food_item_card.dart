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
        height: SizeConfigService.safeBlockVertical * 72, // 500.0,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: Image.network(foodItem.img).image, //(foodItem.img),
            fit: BoxFit.scaleDown,
          ),
        ),
        child: Column(
          children: <Widget>[
            SizedBox(height: SizeConfigService.blockSizeVertical * 5),
            Text(
              foodItem.name + "\nAvailable Until:\n" + foodItem.time.toLocal().toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                
                letterSpacing: 1.25,
                fontSize: 20,
                //backgroundColor: Colors.white,
              )
            ),
            SizedBox(height: SizeConfigService.blockSizeVertical * 10),
          ],
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50)
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:food_savior/models/food_item.dart';
import 'package:food_savior/models/user.dart';
import 'package:food_savior/screens/getfood/food_item_card.dart';
import 'package:provider/provider.dart';

class DonatedOrders extends StatefulWidget {
  @override
  _DonatedOrdersState createState() => _DonatedOrdersState();
  static const String title = "Donated Orders";
}

class _DonatedOrdersState extends State<DonatedOrders>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  User user;
  List<FoodItem> foodItems;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<FoodItem> providerFoodItems = Provider.of<List<FoodItem>>(context);
    user = Provider.of<User>(context);
    if (providerFoodItems != null && user != null && foodItems == null) {
      providerFoodItems.removeWhere((FoodItem item) {
        print("User " + user.toString());
        if (item.uid == null || item.swipers == null) throw new FormatException("item uid or swipers map was found null", item);
        // Keep only things you've swiped on that are still active
        if (item.closed == true && item.uid[0] == user.uid) {  // if (!user.matches.contains(item.docID)) {
          print(item);
          return false;
        } else {
          return true;
        }
      });
      foodItems = providerFoodItems;
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          DonatedOrders.title,
          textAlign: TextAlign.center,
        ),
        leading: MaterialButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.lightGreen,
      ),
      body: SafeArea(
        child: Center(
          child: ListView(
            children: foodItems == null ? [
              Container(
                color: Colors.white,
                child: Center( 
                  heightFactor: 17,
                  child: 
                    Text(
                      'Loading...', 
                      style: TextStyle(
                      color: Colors.blueGrey, 
                      fontSize: 26)
                    )
                  )
                )
              ]
              :
               foodItems.length == 0 ? [
                 Container(
                  color: Colors.white,
                  child: Center( 
                    heightFactor: 17,
                    child: 
                      Text(
                        'No donated items!', 
                        style: TextStyle(
                        color: Colors.blueGrey, 
                        fontSize: 26
                        )
                      )
                    )
                  )
                ] : foodItems.map((FoodItem foodItem) {
              return FoodItemCard(foodItem: foodItem);
            }).toList(),
          ),
        ),
      ),
    );
  }
}
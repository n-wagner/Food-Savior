import 'package:flutter/material.dart';
import 'package:food_savior/models/food_item.dart';
import 'package:food_savior/models/user.dart';
import 'package:food_savior/screens/getfood/food_item_card.dart';
import 'package:provider/provider.dart';

class WaitingOrders extends StatefulWidget {
  @override
  _WaitingOrdersState createState() => _WaitingOrdersState();
  static const String title = "Past Orders";
}

class _WaitingOrdersState extends State<WaitingOrders>
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
        if (item.closed == false && item.swipers.containsKey(user.uid)) {  // if (!user.matches.contains(item.docID)) {
          return false;
        } else {
          return true;
        }
      });
      foodItems = providerFoodItems;
    }

    return Scaffold(
      appBar: AppBar( 
        title: Text(WaitingOrders.title),
        leading: MaterialButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.lightGreen,
      ),
      body: SafeArea(
        child: Center(
          child: ListView(
            children: foodItems == null ? [Text("Loading...")]: foodItems.length == 0 ? [Text("No orders waiting!")] : foodItems.map((FoodItem foodItem) {
              return Column(
                children: <Widget>[
                  FoodItemCard(foodItem: foodItem),
                  Row(
                    children: <Widget>[
                      RaisedButton(
                        onPressed: () {
                          //TODO: Juliana: Chat functionality
                          String phoneNumber = foodItem.uid[1];
                        },
                        child: Text("Chat"),
                      ),
                      RaisedButton(
                        onPressed: foodItem.accepted != user.uid ? null : () {
                          //TODO: Morina: Here is where you call your map
                          List<double> latitudeLongitudeList = foodItem.latitudeLongitude;
                        },
                        child: Text("Take me there!"),
                      )
                    ],
                  ),
                ]
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
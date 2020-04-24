import 'package:flutter/material.dart';
import 'package:food_savior/models/food_item.dart';
import 'package:food_savior/models/user.dart';
import 'package:food_savior/screens/getfood/food_item_card.dart';
import 'package:food_savior/screens/mainmenu/waiting_pickup/acceptance_choice.dart';
import 'package:food_savior/services/database.dart';
import 'package:provider/provider.dart';

class WaitingPickup extends StatefulWidget {
  @override
  _WaitingPickupState createState() => _WaitingPickupState();
  static const String title = "Waiting Pick Up Orders";
}

class _WaitingPickupState extends State<WaitingPickup>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  User user;
  List<FoodItem> foodItems;
  DatabaseService _db;

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

  Future<void> _navigateAndDisplaySelection(BuildContext context, String foodID, Map<String, String> swipers) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    String result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AcceptanceChoice(swipers: swipers)),
    );
    if (result != null) {
      _db.updateAcceptedForFoodItem(foodID: foodID, accepted: result);
    }
  }

  @override
  Widget build(BuildContext context) {
    List<FoodItem> providerFoodItems = Provider.of<List<FoodItem>>(context);
    user = Provider.of<User>(context);
    if (user != null) {
      _db = DatabaseService(uid: user.uid);
    }
    if (providerFoodItems != null && user != null && foodItems == null) {
      providerFoodItems.removeWhere((FoodItem item) {
        print("User " + user.toString());
        if (item.uid == null || item.swipers == null) throw new FormatException("item uid or swipers map was found null", item);
        // Keep only things you've swiped on that are still active
        if (item.closed == false && item.uid[0] == user.uid) {  // if (!user.matches.contains(item.docID)) {
          return false;
        } else {
          return true;
        }
      });
      foodItems = providerFoodItems;
    }

    return Scaffold(
      appBar: AppBar( 
        title: Text(WaitingPickup.title),
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
            children: foodItems == null ? [Text("Loading...")]: foodItems.length == 0 ? [Text("No orders waiting to be picked up!")] : foodItems.map((FoodItem foodItem) {
              return Column(
                children: <Widget>[
                  FoodItemCard(foodItem: foodItem),
                  Row(
                    children: <Widget>[
                      RaisedButton(
                        onPressed: () {
                          //TODO: Take me to a page where I can do drop downs with the phone numbers of the people
                          Map<String, String> swipers = foodItem.swipers;
                          _navigateAndDisplaySelection(context, foodItem.docID, swipers);
                        },
                        child: Text("Accept"),
                      ),
                      RaisedButton(
                        onPressed: foodItem.accepted == null || foodItem.accepted == '' ? null : () {
                          _db.setClosedForFoodItem(foodID: foodItem.docID);
                        },
                        child: Text("Close Order"),
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
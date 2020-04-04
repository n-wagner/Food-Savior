import 'package:flutter/material.dart';
import 'package:food_savior/models/food_item.dart';
import 'package:food_savior/models/user.dart';
import 'package:food_savior/screens/getfood/food_item_card.dart';
import 'package:food_savior/services/database.dart';
import 'package:provider/provider.dart';

class SwipePage extends StatefulWidget {
  @override
  _SwipePageState createState() => _SwipePageState();
}

class _SwipePageState extends State<SwipePage> {
  List<FoodItem> foodItems;
  // List<FoodItem> foodItems = [
  //   FoodItem(name: 'Burger', time: DateTime(2020, 4, 20, 16, 37), img: 'assets/images/burger.jpeg'),
  //   FoodItem(name: 'Pasta', time: DateTime(2020, 3, 6, 8, 2), img: 'assets/images/pasta.jpg'),
  //   FoodItem(name: 'Pizza', time: DateTime(2020, 3, 8, 12, 20), img: 'assets/images/pizza.jpg'),
  // ];
  User user;
  DatabaseService _databaseService;

  // Future<void> setUser () async {
  //   await _ds.user.then((User u) {
  //     setState(() {
  //       user = u;
  //     });
  //   });
  // }
  
  // @override
  // Future<void> initState () async {
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    List<FoodItem> providerFoodItems = Provider.of<List<FoodItem>>(context);
    user = Provider.of<User>(context);
    if (user != null) {
      print("User was not null before");
      print(user);
    } else {
      print("User was null before");
    }
    if (_databaseService == null && user != null) {
      _databaseService = DatabaseService(uid: user.uid);
    }
    if (providerFoodItems != null && user != null && foodItems == null) {
      providerFoodItems.removeWhere((FoodItem item) {
        print("User " + user.toString());
        if (item.docID == null) return true;
        // If you made the food Item or already swiped right on it, strip it out
        if (user.foodItems.contains(item.docID) || user.matches.contains(item.docID)) {
          return true;
        } else {
          return false;
        }
      });
    }
    if (foodItems == null) {
      foodItems = providerFoodItems;
    } else {
      // Compare whats in local food items to provider? to strip out what was swiped left?
    }
    //setUser();
    //user = _ds.user;
    // if (user != null) {
    //   print("User was not null");
    //   print(user);
    // } else {
    //   print("User was null");
    // }
    //foodItems.remove(null);
    print('food items $foodItems');
    if (foodItems != null) {
      print('not null');
      //print('docs ${foodItems2.}');
      foodItems.forEach((item) {
        print('docID ${item.docID} item ${item.name}');
      });
      //print('det = ${foodItems2.documents.forEach(}')
    } else {
      print('very much null');
    }
    // foodItems.forEach((item) {
    //   print(item.name);
    //   print(item.img);
    //   print(item.time);
    // });

    return Scaffold(
      body: SafeArea(
        child: Center(
        //child: Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            // TODO: Here (or below) we need to put a loading screen for when foodItems == null
            children: <Widget> [
              Container(
                height: 2.0,
                width: 25.0,
                color: Colors.lightGreen,
                child: DragTarget<String>(
                  builder: (BuildContext context, List<String> candidateData, List rejectedData) {
                    return Container();
                  },
                  onWillAccept: (data) => true,
                  onAccept: (String docID) {
                    print("Rejected: docID $docID");
                    // FoodItem foundItem;
                    setState(() {
                      foodItems.removeWhere((FoodItem item) {
                        if (docID == item.docID) {
                          print(item);
                          // foundItem = item;
                          return true;
                        } else {
                          return false;
                        }
                      });
                    });
                    // foodItems.removeWhere((FoodItem item) {
                    //   if (docID == item.docID) {
                    //     print(item);
                    //     // foundItem = item;
                    //     return true;
                    //   } else {
                    //     return false;
                    //   }
                    // });
                    // foodItems.add(foundItem);
                    // foodItems[docID] = item;
                  }
                )
              ),
              Expanded(
                child: Stack(
                  // TODO: Here we need to put a loading screen for when foodItems == null
                  children: foodItems == null ? [Container()] : foodItems.length == 0 ? [Text("No new Items!")] : foodItems.map((FoodItem foodItem) {
                    // if (foodItem != null) {
                    return Draggable(
                      onDragCompleted: null,
                      // onDragEnd: (dragDetails) {
                      //   setState(() {
                      //     foodItems.remove(foodItem.docID);
                      //   });
                      // },
                      child: FoodItemCard(foodItem: foodItem),
                      childWhenDragging: Container(
                        
                      ),
                      feedback: FoodItemCard(foodItem: foodItem),
                      data: foodItem.docID,
                    );
                    // } else {
                    //   return Container();
                    // }
                  }).toList(),
                ),
              ),
              Container(
                height: 2.0,
                width: 25.0,
                color: Colors.lightGreen,
                child: DragTarget<String>(
                  builder: (BuildContext context, List<String> candidateData, List rejectedData) {
                    return Container();
                  },
                  onWillAccept: (data) => true,
                  onAccept: (String docID) {
                    print("Accepted: docID $docID");
                    // FoodItem foundItem;
                    _databaseService.updateMatchForUser(reference: docID);
                    setState(() {
                      foodItems.removeWhere((FoodItem item) {
                        if (docID == item.docID) {
                          print(item);
                          // foundItem = item;
                          return true;
                        } else {
                          return false;
                        }
                      });
                    });
                    // foodItems.add(foundItem);
                    // foodItems[docID] = item;
                  }
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}

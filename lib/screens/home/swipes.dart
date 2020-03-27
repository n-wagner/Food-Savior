import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_savior/models/food_item.dart';
import 'package:food_savior/screens/home/food_item_card.dart';
import 'package:provider/provider.dart';

class SwipePage extends StatefulWidget {
  @override
  _SwipePageState createState() => _SwipePageState();
}

class _SwipePageState extends State<SwipePage> {
  // List<FoodItem> foodItems = [
  //   FoodItem(name: 'Burger', time: DateTime(2020, 4, 20, 16, 37), img: 'assets/images/burger.jpeg'),
  //   FoodItem(name: 'Pasta', time: DateTime(2020, 3, 6, 8, 2), img: 'assets/images/pasta.jpg'),
  //   FoodItem(name: 'Pizza', time: DateTime(2020, 3, 8, 12, 20), img: 'assets/images/pizza.jpg'),
  // ];

  
  @override
  Widget build(BuildContext context) {

    final foodItems = Provider.of<List<FoodItem>>(context);
    foodItems.remove(null);
    print('food items 2 $foodItems');
    if (foodItems != null) {
      print('not null');
      //print('docs ${foodItems2.}');
      foodItems.forEach((item) {
        print('item ${item.name}');
      });
      //print('det = ${foodItems2.documents.forEach(}')
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
            children: <Widget> [
              Container(
                height: 2.0,
                width: 5.0,
                color: Colors.lightGreen,
              ),
              Expanded(
                child: Stack(
                  children: foodItems.map((foodItem) {
                    if (foodItem != null) {
                      return Draggable(
                        onDragEnd: (dragDetails) {
                          setState(() {
                            foodItems.remove(foodItem);
                          });
                        },
                        child: FoodItemCard(foodItem: foodItem),
                        childWhenDragging: Container(
                          
                        ),
                        feedback: FoodItemCard(foodItem: foodItem),
                      );
                    } else {
                      return Container();
                    }
                  }).toList(),
                ),
              ),
              Container(

                        height: 2.0,
                        width: 5.0,
                        color: Colors.lightGreen,
                
                
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}

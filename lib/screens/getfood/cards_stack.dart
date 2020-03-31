// import 'package:flutter/material.dart';
// import 'package:food_savior/screens/home/food_item_card.dart';
// import 'package:food_savior/services/database.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class CardStack extends StatefulWidget {
//   @override
//   _CardStackState createState() => _CardStackState();
// }

// class _CardStackState extends State<CardStack> {
//   final DatabaseService _db = DatabaseService();
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<QuerySnapshot>(
//       stream: _db.foodItems,
//       builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//         if (!snapshot.hasData) return Text("Loading...");
//         return Stack(
//           children: _db.foodItemListFromSnapshot(snapshot.data).map((foodItem) {
//             return Draggable(
//               onDragEnd: (dragDetails) {
//                 setState(() {
//                   foodItems.remove(foodItem);
//                 });
//               },
//               child: FoodItemCard(foodItem: foodItem),
//               childWhenDragging: Container(
                
//               ),
//               feedback: FoodItemCard(foodItem: foodItem),
//             );
//           }).toList(),
//         );
//       }
//     );
//   }
// }
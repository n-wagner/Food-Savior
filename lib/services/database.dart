import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_savior/models/food_item.dart';

class DatabaseService {

  // final String uid;

  // DatabaseService({ this.uid });

  //Collection reference
  final CollectionReference userCollection = Firestore.instance.collection('users');
  final CollectionReference foodItemCollection = Firestore.instance.collection('foodItems');

  Future<void> updateUserData(String userID, String firstName, String lastName, String phoneNumber, String address) async {
    return await userCollection.document(userID).setData({
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'address': address
    });
  }

  Future<DocumentSnapshot> getUserData (String userID) async {
    return await userCollection.document(userID).get();
  }

  Future<void> updateFoodItemForUser(String userID, String reference) async {
    return await userCollection.document(userID).updateData({
      'foodItems': FieldValue.arrayUnion([reference]),
    });//, merge: true);
  }

  Future<DocumentReference> addFoodItem(String name, DateTime dateTime, String img) async {
    return await foodItemCollection.add({
      'name': name,
      'time': dateTime,
      'img': img,
    });
  }

  //Food Items list from snapshot
  List<FoodItem> _foodItemListFromSnapshot (QuerySnapshot snapshot) {
    // Timestamp t = Timestamp();
    // t.millisecondsSinceEpoch;
    return snapshot.documents.map((item) {
      return FoodItem(
        name: item.data['name'] ?? '',
        time: DateTime.fromMillisecondsSinceEpoch(item.data['time'].millisecondsSinceEpoch) ?? DateTime.fromMillisecondsSinceEpoch(0),
        img: item.data['img'] ?? '',
      );
    }).toList();
  }

  //Get user stream
  Stream<QuerySnapshot> get users {
    return userCollection.snapshots();
  }

  //Get foodItem Stream
  Stream<List<FoodItem>> get foodItems {
    return foodItemCollection.snapshots().map(_foodItemListFromSnapshot);
  }

}
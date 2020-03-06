import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_savior/models/food_item.dart';

class DatabaseService {

  final String uid;

  DatabaseService({ this.uid });

  //Collection reference
  final CollectionReference userCollection = Firestore.instance.collection('users');
  final CollectionReference foodItemCollection = Firestore.instance.collection('foodItems');

  Future updateUserData(String fname, String lname) async {
    return await userCollection.document(uid).setData({
      'fname': fname,
      'lname': lname,
    });
  }

  Future updateFoodItemForUser(String userID, String reference) async {
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
    return snapshot.documents.map((doc) {
      return FoodItem(
        name: doc.data['name'] ?? '',
        time: doc.data['time'] ?? '',
        img: doc.data['img'] ?? '',
      );
    }).toList();
  }

  //Get user stream
  Stream<QuerySnapshot> get users {
    return userCollection.snapshots();
  }

}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_savior/models/food_item.dart';
import 'package:food_savior/models/user.dart';

class DatabaseService {

  String uid;

  DatabaseService({ this.uid });

  //Collection reference
  final CollectionReference userCollection = Firestore.instance.collection('users');
  final CollectionReference foodItemCollection = Firestore.instance.collection('foodItems');

  Future<void> updateUserData(String firstName, String lastName, String phoneNumber, String address, {String userID}) async {
    if (userID != null) {
      uid = userID;
    }
    return await userCollection.document(uid).setData({
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'address': address
    });
  }

  Future<DocumentSnapshot> getUserData ({String userID}) async {
    if (userID != null) {
      uid = userID;
    }
    return await userCollection.document(uid).get();
  }

  Future<void> updateFoodItemForUser(String reference, {String userID}) async {
    if (userID != null) {
      uid = userID;
    }
    return await userCollection.document(uid).updateData({
      'foodItems': FieldValue.arrayUnion([reference]),
    });//, merge: true);
  }

  Future<String> addFoodItem({String name, DateTime dateTime, String img}) async {
    return foodItemCollection.add({
      'name': name,
      'time': dateTime,
      'img': img,
    }).then((DocumentReference doc) {
      if (doc != null) {
        print("Document ID ${doc.documentID}");
        return doc.documentID;
      } else {
        print("Doc is null");
        return null;
      }
    });
  }

  //Food Items list from snapshot
  List<FoodItem> _foodItemListFromSnapshot (QuerySnapshot snapshot) {
    // Timestamp t = Timestamp();
    // t.millisecondsSinceEpoch;
    return snapshot.documents.map((item) {
      return item == null ? 
        FoodItem(
          name: '', 
          time: DateTime.fromMillisecondsSinceEpoch(0), 
          img: '',
          docID: ''
        ) : FoodItem(
          name: item.data['name'] ?? '',
          time: DateTime.fromMillisecondsSinceEpoch(
            (
              item.data['time'] ?? Timestamp.fromMillisecondsSinceEpoch(0)
            ).millisecondsSinceEpoch
          ),
          img: item.data['img'] ?? '',
          docID: item.documentID ?? '',
        );
    }).toList();
  }

  Future<User> get user async {
    DocumentSnapshot ds = await userCollection.document(uid).get();
    return ds == null ? User(uid: uid) : User (
      uid: uid,
      firstName: ds.data['firstName'] ?? "",
      lastName: ds.data['lastName'] ?? "",
      phone: ds.data['phoneNumber'] ?? "",
      address: ds.data['address'] ?? "",
    );
  }

  //Get user stream
  // Stream<QuerySnapshot> get users {
  //   return userCollection.snapshots();
  // }

  //Get foodItem Stream
  Stream<List<FoodItem>> get foodItems {
    return foodItemCollection.snapshots()
      .map((QuerySnapshot qs) => _foodItemListFromSnapshot(qs));
  }

}
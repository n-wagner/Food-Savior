import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_savior/models/food_item.dart';
import 'package:food_savior/models/user.dart';
import 'package:googleapis/datastore/v1.dart';

class DatabaseService {

  final String uid;

  DatabaseService({ @required this.uid });

  //Collection reference
  final CollectionReference userCollection = Firestore.instance.collection('users');
  //final DocumentReference loggedDocument = Firestore.instance.collection('users').document(uid);
  final CollectionReference foodItemCollection = Firestore.instance.collection('foodItems');
  // final CollectionReference chatCollection = Firestore.instance.collection('chats');

  Future<void> updateUserData({@required String firstName, @required String lastName, @required String phoneNumber, @required String address}) async {
    return userCollection.document(uid).setData({
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'address': address
    });
  }

  Future<DocumentSnapshot> getUserData () async {
    return await userCollection.document(uid).get();
  }

  Future<void> updateFoodItemForUser({@required String reference}) async {
    return userCollection.document(uid).updateData({
      'foodItems': FieldValue.arrayUnion([reference]),
    });//, merge: true);
  }

  Future<void> updateMatchForUser({@required String reference}) async {
    return userCollection.document(uid).updateData({
      'matches': FieldValue.arrayUnion([reference]),
    });//, merge: true);
  }

  // Future<String> addChat (String uid_1, String uid_2) async {
  //   return chatCollection.add({
  //     'uid_1': uid_1,
  //     'uid_2': uid_2,
  //   }).then((DocumentReference doc) {
  //     if (doc != null) {
  //       print("Document ID ${doc.documentID}");
  //       return doc.documentID;
  //     } else {
  //       print("Doc is null");
  //       return null;
  //     }
  //   });
  // }

  Future<String> addFoodItem({@required String name, @required DateTime dateTime, @required String img, @required List<double> location}) async {
    return foodItemCollection.add({
      'name':     name,
      'time':     dateTime,
      'img':      img,
      'uid':      uid,
      'location': location,
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
          docID: '',
          uid: '',
        ) : FoodItem(
          name: item.data['name'] ?? '',
          time: DateTime.fromMillisecondsSinceEpoch(
            (
              item.data['time'] ?? Timestamp.fromMillisecondsSinceEpoch(0)
            ).millisecondsSinceEpoch
          ),
          img: item.data['img'] ?? '',
          docID: item.documentID ?? '',
          uid: item['uid'] ?? '',

        );
    }).toList();
  }

  // Future<User> _userDelegation () async {
  //   DocumentSnapshot ds = await userCollection.document(uid).get();
  //   // if (ds != null) {
  //   //   print('foodItems: ${ds.data['foodItems']}');
  //   // }
  //   return (ds == null) ? User(uid: uid) : User (
  //     uid: uid,
  //     firstName: ds.data['firstName'] ?? "",
  //     lastName: ds.data['lastName'] ?? "",
  //     phone: ds.data['phoneNumber'] ?? "",
  //     address: ds.data['address'] ?? "",
  //     foodItems: (ds.data['foodItems'] as List).cast<String>().toSet() ?? Set(),
  //   );
  // }

  // Future<User> get user async {
  //   DocumentSnapshot ds = await userCollection.document(uid).get();
  //   // if (ds != null) {
  //   //   print('foodItems: ${ds.data['foodItems']}');
  //   // }
  //   // userCollection.getDocuments()
  //   return (ds == null) ? User(uid: uid) : User (
  //     uid: uid,
  //     firstName: ds.data['firstName'] ?? "",
  //     lastName: ds.data['lastName'] ?? "",
  //     phone: ds.data['phoneNumber'] ?? "",
  //     address: ds.data['address'] ?? "",
  //     foodItems: (ds.data['foodItems'] as List).cast<String>().toSet() ?? Set(),
  //   );
  // }


  // Future<User> get user async {
  //   DocumentSnapshot ds = await userCollection.document(uid).get();
  //   return ds == null ? User(uid: uid) : User (
  //     uid: uid,
  //     firstName: ds.data['firstName'] ?? "",
  //     lastName: ds.data['lastName'] ?? "",
  //     phone: ds.data['phoneNumber'] ?? "",
  //     address: ds.data['address'] ?? "",
  //   );
  // }

  //Get user stream
  // Stream<QuerySnapshot> get users {
  //   return userCollection.snapshots();
  // }

  // 'firstName': firstName,
  // 'lastName': lastName,
  // 'phoneNumber': phoneNumber,
  // 'address': address

  User _userFromDocument (DocumentSnapshot ds) {
    print("DocumentSnapshot " + ds.documentID + " " + ds.data.toString());
    return ds == null ? null : ds.data == null ? null : User(
      uid: ds.documentID ?? uid,
      firstName: ds.data['firstName'] ?? '',
      lastName: ds.data['lastName'] ?? '',
      phone: ds.data['phoneNumber'] ?? '',
      address: ds.data['address'] ?? '',
      foodItems: ds.data['foodItems'] == null ? Set() : (ds.data['foodItems'] as List).cast<String>().toSet(),
      matches: ds.data['matches'] == null ? Set() : (ds.data['matches'] as List).cast<String>().toSet(),
    );
  }

  Stream<User> get user {
    return userCollection.document(uid).snapshots()
      .map((DocumentSnapshot ds) => _userFromDocument(ds));
  }

  //Get foodItem Stream
  Stream<List<FoodItem>> get foodItems {
    return foodItemCollection.snapshots()
      .map((QuerySnapshot qs) => _foodItemListFromSnapshot(qs));
  }

}
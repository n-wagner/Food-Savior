import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_savior/models/food_item.dart';
import 'package:food_savior/models/user.dart';

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

  // Future<void> updateFoodItemForUser({@required String reference}) async {
  //   return userCollection.document(uid).updateData({
  //     'foodItems': FieldValue.arrayUnion([reference]),
  //   });//, merge: true);
  // }

  // Future<void> updateMatchForUser({@required String reference}) async {
  //   return userCollection.document(uid).updateData({
  //     'matches': FieldValue.arrayUnion([reference]),
  //   });//, merge: true);
  // }

  Future<void> updateSwipesForFoodItem ({@required String foodID, @required Map<String, String> swiper}) async {
    return foodItemCollection.document(foodID).setData({
      'swipers': swiper,
    }, merge: true);
  }

  Future<void> updateAcceptedForFoodItem ({@required String foodID, @required String accepted}) async {
    return foodItemCollection.document(foodID).setData({
      'accepted': accepted,
    });
  }

  Future<void> setClosedForFoodItem ({@required String foodID, bool closed = true}) async {
    return foodItemCollection.document(foodID).setData({
      'closed': closed,
    });
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

  Future<String> addFoodItem({@required String name, @required DateTime dateTime, @required String img, @required String phoneNumber, @required List<double> location}) async {
    return foodItemCollection.add({
      'name':     name,
      'time':     dateTime,
      'img':      img,
      'uid':      [uid, phoneNumber],
      'location': location,
      'swipers':  Map<String, String>(),  //No swipers yet, so an empty map
      'accepted': null,                   //No one accepted yet so null
      'closed':   false,                  //Not closed so false
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

  //TODO: update this to reflect model
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
          uid: <String>['', ''],
          latitudeLongitude: [double.nan, double.nan],
          swipers: Map<String, String>(),
          accepted: '',
          closed: true,
        ) : FoodItem(
          name: item.data['name'] ?? '',
          time: DateTime.fromMillisecondsSinceEpoch(
            (
              item.data['time'] ?? Timestamp.fromMillisecondsSinceEpoch(0)
            ).millisecondsSinceEpoch
          ),
          img: item.data['img'] ?? '',
          docID: item.documentID ?? '',
          uid: item.data['uid'] == null ? <String>['', ''] : (item.data['uid'] as List).cast<String>(),
          latitudeLongitude: item.data['location'] == null ? [0, 0] : (item.data['location'] as List).cast<double>(),
          swipers: item.data['swipers'] == null ? Map<String, String>() : (item.data['swipers'] as Map).cast<String, String>(),
          accepted: item.data['accepted'] ?? '',
          closed: item.data['closed'] ?? false,     //TODO: Make this true, don't show items that aren't properly formatted
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
      //foodItems: ds.data['foodItems'] == null ? Set() : (ds.data['foodItems'] as List).cast<String>().toSet(),
      //matches: ds.data['matches'] == null ? Set() : (ds.data['matches'] as List).cast<String>().toSet(),
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
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String uid;

  DatabaseService({ this.uid });

  //Collection reference
  final CollectionReference userCollection = Firestore.instance.collection('users');

  Future updateUserData(String fname, String lname) async {
    return await userCollection.document(uid).setData({
      'fname': fname,
      'lname': lname,
    });
  }

  //Get user stream
  Stream<QuerySnapshot> get users {
    return userCollection.snapshots();
  }

}
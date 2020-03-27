import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_savior/models/user.dart';
import 'package:food_savior/services/database.dart';

class AuthService {
  //final implies the value won't change in the future, _auth implies the value is private to the class, FirebaseAuth.instance gets thee singular instance of the Auth to work with
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Create user obj based on FirebaseUser, private function due to the underscore in the name
  User _userFromFirebaseUser (FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged
      .map((FirebaseUser user) => _userFromFirebaseUser(user));
      // Map the stream of FirebaseUsers to our Users, each FbU becomes a User
      
      // shorthand:
      //.map(_userFromFirebaseUser);
  }


  //sign in anon
  Future signInAnon() async {
    //try catch in case there is an error along the way
    try {
      // takes some time to happen so need to await it, knows what backend to connect with due to google-services.json among other additions made (see branch #2)
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);    // Late ron the plan is to use this elsewhere in the program
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign in with email & password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //register with email & password
  Future<User> registerWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;

      // Create a new document for the user with a uid
      // await DatabaseService(uid: user.uid).updateUserData('fname', 'lname');

      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

}
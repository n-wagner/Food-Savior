import 'package:flutter/foundation.dart';

class User {

  final String uid;
  final String firstName;
  final String lastName;
  final String phone;
  final String address;
  //final Set<String> foodItems;
  //final Set<String> matches;

  User ({
    @required this.uid, 
    @required this.firstName, 
    @required this.lastName, 
    @required this.phone, 
    @required this.address
  }); //, this.foodItems, this.matches });

  String toString () {
    String result = "User:\n\tuid: $uid, firstName: $firstName, lastName: $lastName, phone: $phone, address: $address\n";
    //result += "  foodItems: " + foodItems.toString() + "\n  matches: " + matches.toString();
    return result;
  }
}
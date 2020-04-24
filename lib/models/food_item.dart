import 'package:flutter/foundation.dart';

class FoodItem {
  String name, img, docID;
  List<String> uid;
  DateTime time;
  List<double> latitudeLongitude;
  Map<String, String> swipers;
  String accepted;
  bool closed;

  FoodItem({ 
    @required this.name, 
    @required this.time, 
    @required this.img, 
    @required this.docID, 
    @required this.uid, 
    @required this.latitudeLongitude, 
    @required this.swipers, 
    @required this.accepted, 
    @required this.closed
  });

  @override
  String toString () {
    String result = "FoodItem: name: $name, docID: $docID\n";
    result += "\timageURL: $img\n";
    result += "\tDate Time: ${time.toString()}\n";
    result += "\tuid: ${uid.toString()}\n";  
    result += "\tLocation: ( " + (latitudeLongitude == null ? 'null' : latitudeLongitude[0].toString()) + ", " + (latitudeLongitude == null ? 'null' : latitudeLongitude[1].toString()) + " )";
    result += "\tSwipers: ${swipers.toString()}\n";
    result += "\tAccepted: $accepted\n";
    result += "\tClosed: $closed\n";
    return result;
  }
}
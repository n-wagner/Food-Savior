class FoodItem {
  String name, img, docID, uid;
  DateTime time;
  List<double> latitudeLongitude;

  FoodItem({ this.name, this.time, this.img, this.docID, this.uid,
             this.latitudeLongitude });

  @override
  String toString () {
    String result = "name: $name, docID: $docID";
    result += "imageURL: $img";
    result += "Date Time: ${time.toString()}";
    result += "uid: $uid";  
    result += "Location: ( " + latitudeLongitude[0].toString() + ", " + latitudeLongitude[1].toString() + " )";
    return result;
  }
}
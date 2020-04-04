class FoodItem {
  String name, img, docID, uid;
  DateTime time;

  FoodItem({ this.name, this.time, this.img, this.docID, this.uid });

  @override
  String toString () {
    String result = "name: $name, docID: $docID";
    result += "imageURL: $img";
    result += "Date Time: ${time.toString()}";
    result += "uid: $uid";
    return result;
  }
}
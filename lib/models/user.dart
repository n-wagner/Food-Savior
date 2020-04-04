class User {

  final String uid;
  final String firstName;
  final String lastName;
  final String phone;
  final String address;
  final Set<String> foodItems;
  final Set<String> matches;

  User ({ this.uid, this.firstName, this.lastName, this.phone, this.address, this.foodItems, this.matches });

  String toString () {
    String result = "uid: $uid, firstName: $firstName, lastName: $lastName, phone: $phone, address: $address\n";
    result += "  foodItems: " + foodItems.toString() + "\n  matches: " + matches.toString();
    return result;
  }
}
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:food_savior/services/database.dart';
import 'package:food_savior/services/image.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:food_savior/models/user.dart';
import 'package:flutter/services.dart';

import 'package:geolocator/geolocator.dart';

class NewFoodPage extends StatefulWidget {
  //static const String tag = 'new-food';
  static const String title = "New Food";

  @override
  _NewFoodPageState createState() => new _NewFoodPageState();
  
}

class _NewFoodPageState extends State<NewFoodPage> {
  String foodName = '';
  String timeLeft = '';
  String description = '';
  String error = '';
  DateTime dt;
  bool dairy = false;
  bool nuts = false;
  bool pork = false;
  bool shellFish = false;
  bool beef = false;
  bool gluten = false;
  bool vegan = false;
  bool vegetarian = false;
  bool sugarFree = false;
  LocationData currentLocation;


  bool loading = true;
  List<double> targetCoordinates = [0, 0];
  List<Placemark> placemark;
  
  var address;
  DatabaseService _db;
  final ImageService _img = ImageService();
  //Use this key to ID the form and associate with the global form state key
  final _formKey = GlobalKey<FormState>();

   void initState() {    
    super.initState();
    getLocationWrapper();
  }

 _getLocation() async {
    Location location = Location();
    if ( await location.hasPermission() != null ) {
      final LocationData pos = await location.getLocation();
      setState(() {
            print(pos.runtimeType);
            targetCoordinates = [pos.latitude, pos.longitude];
            loading = false;
            return targetCoordinates;
        });
    } 
    else {
        await location.requestPermission();
    }
}

  getLocationWrapper() async {
    try {
       targetCoordinates = (await _getLocation()).timeout(const Duration(seconds: 1));
       print('loaded location');
       if(loading == true) 
       {
          build(context);
          loading = false;
       }
       else 
       {
         targetCoordinates = await Navigator.pushNamed(context,'/location_picker');
         loading = false;
       }
    } 
    on TimeoutException {
      targetCoordinates = await Navigator.pushNamed(context,'/location_picker');
      loading = false;
      return false;
    } 
    on Error {
     print('Error');
    }
  }


  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    if (user != null) {
      _db = DatabaseService(uid: user.uid);
    } 
    
    else {
      print("*********************USER NOT LOGGED IN*********************");
      //_db = DatabaseService();
    }

    final foodNameBar = TextFormField(
      //Validates input, returns null if valid, helper text if not
      validator: (val) => val.isEmpty ? 'Enter a name for your food' : null,
      //Track the value of email whenever the field is changed (same done for password)
      onChanged: (val) {
        setState(() =>  foodName = val);
      },
      keyboardType: TextInputType.text,
      autofocus: false,
      initialValue: '',
      decoration: InputDecoration(
        hintText: 'ex: Tuna Sandwich with Pesto Sauce',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final createNewFoodButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 4.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        //Disable button if _db is null
        onPressed: _db == null ? null : () async {
          // Runs each validator from the Form Fields, only if all return null is this true
          if (_formKey.currentState.validate()) {
            String imageUrl = await _img.uploadFoodItemImage();
            //return;
            if (imageUrl != null) {
              print(user);
              String referenceID = await _db.addFoodItem(name: foodName, dateTime: dt, img: imageUrl, phoneNumber: user.phone, location: targetCoordinates);
              if (referenceID != null) {
                print('user ${user.uid} with docID $referenceID');
                //await _db.updateFoodItemForUser(reference: referenceID);
                Navigator.pop(context);
              } else {
                //error - failed to create food iteam
                print("Failed to create food item - referenceID is null");
              }
            } 
            
            else {
              //error - failed to upload image to storage
              print("Failed to upload image - imageURL is null");
            }
          } 
          
          else {
            //error - invalid form fields
            print("Not all form fields are valid");
          }
        },
        padding: EdgeInsets.all(8),
        color: Colors.lightGreen,
        child: Text('Post New Food', style: TextStyle(color: Colors.white)),
      ),
    );

    final imageButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 4.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () async {
          _img.getImage(fromGallery: false);
          
        },
        padding: EdgeInsets.all(8),
        color: Colors.lightGreen,
        child: Text('Take a Picture', style: TextStyle(color: Colors.white)),
      ),
    );

    final cancelButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 4.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () {
          Navigator.pop(context);
        },
        padding: EdgeInsets.all(8),
        color: Colors.lightGreen,
        child: Text('Cancel', style: TextStyle(color: Colors.white)),
      ),
    );

    final pickLocationButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 4.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () {
          _navigateAndDisplaySelection(context, targetCoordinates[0], targetCoordinates[1]);
        },
        padding: EdgeInsets.all(8),
        color: Colors.lightGreen,
        child: Text('Pick Location', style: TextStyle(color: Colors.white)),
        ),
      ); 

    final format = DateFormat("yyyy-MM-dd HH:mm");

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar( 
        centerTitle: true,
        title: Text(
          NewFoodPage.title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white, 
          )
        ),
        backgroundColor: Colors.lightGreen,
        leading: MaterialButton (
          onPressed: () {
            Navigator.pop(context);
          },
          child: Icon (
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
      ),

      body: 
      
      loading 
      ? 
      Container(color: Colors.white,
        child: Center( 
          heightFactor: 17,
          child: 
            Text(
              'Getting Your Location...', 
              style: TextStyle(
                color: Colors.blueGrey, 
                fontSize: 26
              )
            )
        )
      )
          :
        Form(
          key: _formKey,
          child: Center(
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.only(left: 24.0, right: 24.0),
              children: <Widget>[
                _img.getImageForDisplay(), //Image.asset(_image.path, height: 150),
                imageButton,
                SizedBox(
                  height: 20,
                ),
                foodNameBar,
                //ingredients_warnings,
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Available Until:',
                  style: TextStyle(fontSize: 15)
                  ),
                DateTimeField(
                  format: format,
                  validator: (val) {
                    if (val != null && val.isAfter(DateTime.now())) {
                      return null;
                    } else {
                      return "Please select a valid date/time";
                    }
                  },
                  onShowPicker: (context, currentValue) async {
                    final date = await showDatePicker(
                        context: context,
                        firstDate: DateTime(1900),
                        initialDate: currentValue ?? DateTime.now(),
                        lastDate: DateTime(2100));
                    if (date != null) {
                      final time = await showTimePicker(
                        context: context,
                        initialTime:
                            TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                      );
                      return DateTimeField.combine(date, time);
                    } else {
                      return currentValue;
                    }
                  },
                  onChanged: (val) {
                    setState(() {
                      dt = val;
                    });
                  },
                ),
                Text('${format.pattern}',
                  style: TextStyle(fontSize: 15)
                  ),
                
                pickLocationButton,
                //Text( targetCoordinates.toString()),
                /*SizedBox(
                  height: 20,
                ),*/

                createNewFoodButton,
                cancelButton,
              ],
            ),
          ),
        ),
    );
  }
}

_navigateAndDisplaySelection(BuildContext context, double lat, double long) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    return await Navigator.pushNamed(
      context,
      // Create the SelectionScreen in the next step.
      '/location_picker');
}
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

import 'package:nominatim_location_picker/nominatim_location_picker.dart';
import 'package:geolocator/geolocator.dart';

class NewFoodPage extends StatefulWidget {
  //static const String tag = 'new-food';
  static const String title = "New Food";

  @override
  _NewFoodPageState createState() => new _NewFoodPageState();
  
}
// TODO: figure out why there are TWO back arrows
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
  Timer _timer; 
  //File _image;  // = File('assets/images/noImage.jpg');

  // final user = Provider.of<User>(context);
  // final AuthService _auth = AuthService();
  DatabaseService _db;
  // final StorageService _stor = StorageService();
  final ImageService _img = ImageService();
  //Use this key to ID the form and associate with the global form state key
  final _formKey = GlobalKey<FormState>();
  
  // Future<File> loadImage () async {
  //   ByteData image =  await rootBundle.load('assets/images/noImage.jpg');
  //   String name = '${(await getTemporaryDirectory()).path}/noImage.jpg';
  //   print('name $name');
  //   final file = File(name);
  //   await file.writeAsBytes(image.buffer.asUint8List(image.offsetInBytes, image.lengthInBytes));
  //   _image = file;
  //   return file;
  //   // print('imageName = $imageName');    //for debug
  //   // return imageName;
  // }

  // Future chooseFile() async {    
  //   await ImagePicker.pickImage(source: ImageSource.gallery).then((image) {    
  //     setState(() {    
  //       _image = image;    
  //     });    
  //   });    
  // }

  Widget checkbox(String title, bool boolValue) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          title, 
          style: TextStyle(
            color: Colors.white, 
            )
          ),
        Checkbox(
          value: boolValue,
          onChanged: (bool value) {
            /// manage the state of each value
            setState(() {
              switch (title) {
                case "Dairy":
                  dairy = value;
                  break;
                case "Nuts":
                  nuts = value;
                  break;
                case "Pork":
                  pork = value;
                  break;
                case "Shellfish":
                  shellFish = value;
                  break;
                case "Beef":
                  beef = value;
                  break;
                case "Gluten-Free":
                  gluten = value;
                  break;
                case "Vegan":
                  vegan = value;
                  break;
                case "Vegetarian":
                  vegetarian = value;
                  break;
                case "Sugar Free":
                  sugarFree = value;
                  break;
              }
            });
          },
        )
      ],
    );
  }
 
  Widget pickLocation() {
    child:  MapBoxLocationPicker(
      popOnSelect: true,
      apiKey: "pk.eyJ1IjoibWFyaXptaWV2YSIsImEiOiJjazhqZnd1anAwZ2s4M21tdmk2eG05c3dtIn0.yLfRxI4__alVuC14pIlHXg",
      limit: 10,
      searchHint: 'Search',
      awaitingForLocation: "Pick location",
      onSelected: (place) {
        setState(() {
          targetCoordinates = place.geometry.coordinates; 
          //Navigator.pop(context);
          return targetCoordinates;
          }
        );
      },
      context: context,
    );
  }

  @override
  void initState() {
    getLocationWrapper();
    loading = true;
    super.initState();
  }

  getLocation() async{
    var location = new Location();
    location.onLocationChanged.listen(
      (currentLocation) {

        print(currentLocation.latitude);
        print(currentLocation.longitude);
        setState(() {

        targetCoordinates =  [currentLocation.latitude, currentLocation.longitude];
        });

        print("getLocation:$targetCoordinates");
        
      }
    );
    return true;
  }

  getLocationWrapper() async {
    try {
       bool loaded = await getLocation().timeout(const Duration(milliseconds: 1));
       if(loaded == true) 
       {
          build(context);
          loading = false;
          return;
       }
    } 
    on TimeoutException {
     Navigator.push(context, MaterialPageRoute(builder: (context) => pickLocation()),);
     loading = false;
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

    // final descriptionField = TextFormField(
    //   //Validates input, returns null if valid, helper text if not
    //   validator: (val) => val.isEmpty ? 'add a few words to describe your food' : null,
    //   //Track the value of email whenever the field is changed (same done for password)
    //   onChanged: (val) {
    //     setState(() =>  description = val);
    //   },
    //   keyboardType: TextInputType.text,
    //   autofocus: false,
    //   initialValue: '',
    //   decoration: InputDecoration(
    //     hintText: 'ex. Fried tuna salad with watermelon and pickled apples',
    //     contentPadding: EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 30.0),
    //     border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
    //   ),
    // );

    // final ingredientsWarnings = Center(
    //   child: Column(
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     children: <Widget>[
    //       Row(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         children: <Widget>[
    //           checkbox( "Dairy", dairy),
    //           checkbox("Nuts", nuts),
    //           checkbox("Sugar-Free", sugarFree)
    //         ],
    //       ),
    //       SizedBox(height: 12.0),
    //       Row(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         children: <Widget>[
    //           checkbox( "Pork", pork),
    //           checkbox("Shellfish", shellFish),
    //           checkbox("Beef", beef)
    //         ],
    //       ),
    //       SizedBox(height: 12.0),
    //       Row(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         children: <Widget>[
    //           checkbox( "Vegan", vegan),
    //           checkbox("Vegetarian", vegetarian),
    //           checkbox("Gluten-Free", gluten)
    //         ],
    //       ),
    //     ],
    //   ),
    // );

    // final timerBar =  TextFormField(
    //   //Validates input, returns null if valid, helper text if not
    //   validator: (val) => val.isEmpty ? 'available until...' : null,
    //   //Track the value of email whenever the field is changed (same done for password)
    //   onChanged: (val) {
    //     setState(() =>  timeLeft = val);
    //   },
    //   keyboardType: TextInputType.datetime ,
    //   autofocus: false,
    //   initialValue: '',
    //   decoration: InputDecoration(
    //     hintText: 'ex: Tuna Sandwich with Pesto Sauce',
    //     contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
    //     border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
    //   ),
    // );
    


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


    // final errorMessage = Text(
    //   error,
    //   style: TextStyle(color: Colors.red, fontSize: 14.0),
    // );

    // final checkboxes = Center(
    //     child: Column(
    //       children: <Widget>[
    //         appBar,
    //         SizedBox(height: 20.0),
    //         //SizedBox(height: 48.0),
    //         foodNameBar,
    //         ingredientsWarnings,
    //         //SizedBox(height: 24.0),
    //         timerBar,
    //         //SizedBox(height: 8.0),
    //         createNewFoodButton,
    //         //SizedBox(height: 8.0),
    //         cancelButton
    //       ],
    //     ),
    //   );


    final pickLocationButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 4.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () {
          // Runs each validator from the Form Fields, only if all return null is this true
          //if (_formKey.currentState.validate()) {
            /*dynamic result = await _auth.registerWithEmailAndPassword(emailVal, passwordVal);
            // Null back means something went wrong with registering, no need to do something otherwise as we are listening for user changes and make things happen based off that
            if (result == null) {
              setState(() => error = 'please supply a valid email');
            }
          }*/
          return Navigator.push(context, MaterialPageRoute(builder: (context) => pickLocation()),);
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
        title: Row(
          children: [
            MaterialButton(

              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context,);
                }, 
              ),
            Text(
              NewFoodPage.title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white, 
              )
            )
          ]
        ),
        backgroundColor: Colors.lightGreen,
      ),

      body: 
      
      loading 
      ? 
      Container(color: Colors.white,
                child: Center( 
                  child: 
                      Text(
                        'Getting Your Location...', 
                        style: TextStyle(
                        color: Colors.blueGrey, 
                        fontSize: 26)
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


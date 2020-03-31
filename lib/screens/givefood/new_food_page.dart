import 'dart:io';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_savior/services/auth.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:flutter_tagging/flutter_tagging.dart';
import 'package:flutter_syntax_view/flutter_syntax_view.dart';
import 'package:food_savior/services/database.dart';
import 'package:food_savior/services/storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../home/home_page.dart';

import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:food_savior/models/user.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class NewFoodPage extends StatefulWidget {
  //static const String tag = 'new-food';
  static const String title = "New Food";

  @override
  _NewFoodPageState createState() => new _NewFoodPageState();
}

class _NewFoodPageState extends State<NewFoodPage> {
  String food_name = '';
  String time_left = '';
  String description = '';
  String error = '';
  DateTime dt;
  bool dairy = false;
  bool nuts = false;
  bool pork = false;
  bool shell_fish = false;
  bool beef = false;
  bool gluten = false;
  bool vegan = false;
  bool vegetarian = false;
  bool sugar_free = false;
  File _image;  // = File('assets/images/noImage.jpg');

  // final user = Provider.of<User>(context);
  final AuthService _auth = AuthService();
  DatabaseService _db = DatabaseService();
  StorageService _stor = StorageService();
  //Use this key to ID the form and associate with the global form state key
  final _formKey = GlobalKey<FormState>();
  
  Future<File> loadImage () async {
    ByteData image =  await rootBundle.load('assets/images/noImage.jpg');
    String name = '${(await getTemporaryDirectory()).path}/noImage.jpg';
    print('name $name');
    final file = File(name);
    await file.writeAsBytes(image.buffer.asUint8List(image.offsetInBytes, image.lengthInBytes));
    _image = file;
    return file;
    // print('imageName = $imageName');    //for debug
    // return imageName;
  }

  Future chooseFile() async {    
    await ImagePicker.pickImage(source: ImageSource.gallery).then((image) {    
      setState(() {    
        _image = image;    
      });    
    });    
  }

  Image getImage () {
    if (_image == null) {
      return Image.asset('assets/images/noImage.jpg', height: 150);
    } else {
      return Image.asset(_image.path, height: 150);
    }
  }

  Widget checkbox(String title, bool boolValue) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(title),
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
                  shell_fish = value;
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
                  sugar_free = value;
                  break;
              }
            });
          },
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    loadImage();

    final appBar = AppBar(
        title: Text(NewFoodPage.title),
        leading: MaterialButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.lightGreen
      );

    final food_name_bar = TextFormField(
      //Validates input, returns null if valid, helper text if not
      validator: (val) => val.isEmpty ? 'Enter a name for your food' : null,
      //Track the value of email whenever the field is changed (same done for password)
      onChanged: (val) {
        setState(() =>  food_name = val);
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

    final description_field = TextFormField(
      //Validates input, returns null if valid, helper text if not
      validator: (val) => val.isEmpty ? 'add a few words to describe your food' : null,
      //Track the value of email whenever the field is changed (same done for password)
      onChanged: (val) {
        setState(() =>  description = val);
      },
      keyboardType: TextInputType.text,
      autofocus: false,
      initialValue: '',
      decoration: InputDecoration(
        hintText: 'ex. Fried tuna salad with watermelon and pickled apples',
        contentPadding: EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 30.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final ingredients_warnings = Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              checkbox( "Dairy", dairy),
              checkbox("Nuts", nuts),
              checkbox("Sugar-Free", sugar_free)
            ],
          ),
          SizedBox(height: 12.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              checkbox( "Pork", pork),
              checkbox("Shellfish", shell_fish),
              checkbox("Beef", beef)
            ],
          ),
          SizedBox(height: 12.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              checkbox( "Vegan", vegan),
              checkbox("Vegetarian", vegetarian),
              checkbox("Gluten-Free", gluten)
            ],
          ),
        ],
      ),
    );

    final timer_bar =  TextFormField(
      //Validates input, returns null if valid, helper text if not
      validator: (val) => val.isEmpty ? 'available until...' : null,
      //Track the value of email whenever the field is changed (same done for password)
      onChanged: (val) {
        setState(() =>  time_left = val);
      },
      keyboardType: TextInputType.datetime ,
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
        onPressed: () async {
          // Runs each validator from the Form Fields, only if all return null is this true
          if (_formKey.currentState.validate()) {
            /*dynamic result = await _auth.registerWithEmailAndPassword(emailVal, passwordVal);
            // Null back means something went wrong with registering, no need to do something otherwise as we are listening for user changes and make things happen based off that
            if (result == null) {
              setState(() => error = 'please supply a valid email');
            }
          }*/
            //Navigator.pushNamed(context, '/map_page');
            String image_url = await _stor.uploadFoodItemImage(_image.path);
            //return;
            if (image_url != null) {
              DocumentReference result = await _db.addFoodItem(food_name, dt, image_url);
              if (result != null) {
                print('user ${user.uid} with docID ${result.documentID}');
                await _db.updateFoodItemForUser(user.uid, result.documentID);
                Navigator.pop(context);
              } else {
                //error - failed to create food iteam
                print("Failed to create food item");
              }
            } else {
              //error - failed to upload image to storage
              print("Failed to upload image");
            }
          } else {
            //error - invalid form fields
            print("Not all form fields are valid");
          }
        },
        padding: EdgeInsets.all(8),
        color: Colors.lightGreen,
        child: Text('Post New Food', style: TextStyle(color: Colors.white)),
      ),
    );

    final image_button = Padding(
      padding: EdgeInsets.symmetric(vertical: 4.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () async {
          await ImagePicker.pickImage(source: ImageSource.gallery).then((image) {    
            setState(() {    
              _image = image;    
            });    
          }); 
          //Navigator.pushNamed(context, '/image-select');
        },
        padding: EdgeInsets.all(8),
        color: Colors.lightGreen,
        child: Text('Select a Picture', style: TextStyle(color: Colors.white)),
      ),
    );

    final cancel_button = Padding(
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
          Navigator.pop(context);
          //Navigator.pushNamed(context, '/home'); 
          //}
        },
        padding: EdgeInsets.all(8),
        color: Colors.lightGreen,
        child: Text('Cancel', style: TextStyle(color: Colors.white)),
      ),
    );


    final errorMessage = Text(
      error,
      style: TextStyle(color: Colors.red, fontSize: 14.0),
    );

    final checkboxes = Center(
        child: Column(
          children: <Widget>[
            appBar,
            SizedBox(height: 20.0),
            //SizedBox(height: 48.0),
            food_name_bar,
            ingredients_warnings,
            //SizedBox(height: 24.0),
            timer_bar,
            //SizedBox(height: 8.0),
            createNewFoodButton,
            //SizedBox(height: 8.0),
            cancel_button
          ],
        ),
      );

    final format = DateFormat("yyyy-MM-dd HH:mm");

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar( 
        title:  Text(NewFoodPage.title),
          leading: MaterialButton(
            onPressed: () {
              Navigator.pop(context,);
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.lime,
          ),
      body: Form(
        key: _formKey,
        child: Center(
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(left: 24.0, right: 24.0),
            children: <Widget>[
              getImage(), //Image.asset(_image.path, height: 150),
              image_button,
              SizedBox(
                height: 20,
              ),
              food_name_bar,
              //ingredients_warnings,
              SizedBox(
                height: 20,
              ),
              Text('Basic date & time field (${format.pattern})'),
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
              SizedBox(
                height: 20,
              ),
              createNewFoodButton,
              cancel_button,
            ],
          ),
        ),
      ),
    );
  }
}


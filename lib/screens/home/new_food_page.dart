import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_savior/services/auth.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:flutter_tagging/flutter_tagging.dart';
import 'package:flutter_syntax_view/flutter_syntax_view.dart';
import 'package:food_savior/services/database.dart';

import '../home/home_page.dart';

import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:food_savior/models/user.dart';

class NewFoodPage extends StatefulWidget {
  //static const String tag = 'new-food';
  static const String title = "New Food";
  final User u;

  NewFoodPage({Key key, this.u }) : super(key: key);

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
  final AuthService _auth = AuthService();
  final DatabaseService _db = DatabaseService();
  //Use this key to ID the form and associate with the global form state key
  final _formKey = GlobalKey<FormState>();

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
    final appBar = AppBar(
        title: Text(NewFoodPage.title),
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
        hintText: 'ex: Tuna Sandwish with Pesto Sauce',
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
              DocumentReference result = await _db.addFoodItem(food_name, dt, "");
              if (result != null) {
                await _db.updateFoodItemForUser(widget.u.uid, result.documentID);
              }
              Navigator.pop(context);
            }
        },
        padding: EdgeInsets.all(8),
        color: Colors.lime[700],
        child: Text('Post New Food', style: TextStyle(color: Colors.white)),
      ),
    );

    final camera_button = Padding(
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
          //Navigator.pop(context,);
          //Navigator.pushNamed(context, '/home'); 
          //}
        },
        padding: EdgeInsets.all(8),
        color: Colors.lime[700],
        child: Text('Take a Picture', style: TextStyle(color: Colors.white)),
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
          Navigator.pop(context,);
          //Navigator.pushNamed(context, '/home'); 
          //}
        },
        padding: EdgeInsets.all(8),
        color: Colors.lime[700],
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
              camera_button,
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
                  return null;
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


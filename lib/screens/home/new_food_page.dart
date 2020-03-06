import 'package:flutter/material.dart';
import 'package:food_savior/services/auth.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:flutter_tagging/flutter_tagging.dart';

import '../home/home_page.dart';

class NewFoodPage extends StatefulWidget {
  static const String tag = 'new-food-page';
  static const String title = "New Food";
  @override
  _NewFoodPageState createState() => new _NewFoodPageState();
}

class _NewFoodPageState extends State<NewFoodPage> {

  final AuthService _auth = AuthService();
  //Use this key to ID the form and associate with the global form state key
  final _formKey = GlobalKey<FormState>();

  // text field state
  String food_name = '';
  String passwordVal = '';
  String error = '';
  List<String> ingredients = [];

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
        hintText: 'ex: Tuna Sandwish with Pesto Sauce',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final ingredients = FlutterTagging(
     textFieldDecoration: InputDecoration(
         border: OutlineInputBorder(),
         hintText: "Tags",
         labelText: "Enter tags"),
     addButtonWidget: _buildAddButton(),
     chipsColor: Colors.pinkAccent,
     chipsFontColor: Colors.white,
     deleteIcon: Icon(Icons.cancel,color: Colors.white),
     chipsPadding: EdgeInsets.all(2.0),
     chipsFontSize: 14.0,
     chipsSpacing: 5.0,
     chipsFontFamily: 'helvetica_neue_light',
     suggestionsCallback: (pattern) async {
       return await TagSearchService.getSuggestions(pattern);
       },
     onChanged: (result) {
       setState(() {
         text = result.toString();
         });
       },
),

    final newFoodButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 4.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        // contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        color: Colors.lime[700],
        child: Text(
          'Create Food',
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () async {
          //dynamic result = await _auth.signInEmailPassword();     // dynamic because it can be a user or null
          // Runs each validator from the Form Fields, only if all return null is this true
          if (_formKey.currentState.validate()) {
            dynamic result = await _auth.signInWithEmailAndPassword(emailVal, passwordVal);
            // Null back means something went wrong with registering, no need to do something otherwise as we are listening for user changes and make things happen based off that
            if (result == null) {
              setState(() => error = 'please supply a valid email');
            }
          }
          //Navigator.of(context).pushNamed(HomePage.tag);
        }
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
            Navigator.pushNamed(context, '/map_page'); 
            }
        },
        padding: EdgeInsets.all(8),
        color: Colors.lime[700],
        child: Text('Sign up', style: TextStyle(color: Colors.white)),
      ),
    );

    final errorMessage = Text(
      error,
      style: TextStyle(color: Colors.red, fontSize: 14.0),
    );

    final body = Container(
      width: MediaQuery
          .of(context)
          .size
          .width,
      padding: EdgeInsets.all(28.0),
      decoration: BoxDecoration(
//        gradient: LinearGradient(colors: [
//          Colors.pink[400],
//          Colors.lime[200],
//        ])
      ),
      child: Center(
        child: Column(
          children: <Widget>[
            appBar,
            SizedBox(height: 20.0),
            //SizedBox(height: 48.0),
            food_name_bar,
            ingredients_tags_bar,
            //SizedBox(height: 24.0),
            timer_bar,
            //SizedBox(height: 8.0),
            createNewFoodButton,
            //SizedBox(height: 8.0),
            cancelButton
          ],
        ),
      ),
    );


    return Scaffold(
      backgroundColor: Colors.white,
      // Form associated with global key, allows for future validation of the form
      body: Form(
        key: _formKey,
        child: Center(
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(left: 24.0, right: 24.0),
            children: <Widget>[
              logo,
              SizedBox(height: 48.0),
              email,
              SizedBox(height: 8.0),
              password,
              SizedBox(height: 24.0),
              loginButton,
              signupButton,
              forgotLabel
            ],
          ),
        ),
      ),
    );
  }
}


List<Ingredient> _selectedIngredients = [];

FlutterTagging<Ingredient>(
    initialItems: _selectedIngredients,
    textFieldConfiguration: TextFieldConfiguration(
        decoration: InputDecoration(
            border: InputBorder.none,
            filled: true,
            fillColor: Colors.lime.withAlpha(200),
            hintText: 'Search Tags',
            labelText: 'Select Tags',
        ),
    ),
    findSuggestions: IngredientService.getIngredients,
    additionCallback: (value) {
        return Ingredient(
                name: value,
                position: 0,
        );
    },
    onAdded: (ingredient){
        return Ingredient();
    },
    configureSuggestion: (ing) {
        return SuggestionConfiguration(
            title: Text(lang.name),
            subtitle: Text(lang.position.toString()),
            additionWidget: Chip(
                avatar: Icon(
                    Icons.add_circle,
                    color: Colors.white,
                ),
                label: Text('Add New Ingredient'),
                labelStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w300,
                ),
                backgroundColor: Colors.green,
            ),
        );
    },
    configureChip: (lang) {
        return ChipConfiguration(
            label: Text(lang.name),
            backgroundColor: Colors.green,
            labelStyle: TextStyle(color: Colors.white),
            deleteIconColor: Colors.white,
        );
    },
    onChanged: () {
      print();
    }
);

/// LanguageService
class LanguageService {
    /// Mocks fetching Ingredient from network API with delay of 500ms.
    static Future<List<Ingredient>> getIngredients(String query) async {
          await Future.delayed(Duration(milliseconds: 500), null);
          return <Ingredient>[
            Ingredient(name: 'JavaScript', position: 1),
            Ingredient(name: 'Python', position: 2),
            Ingredient(name: 'Java', position: 3),
            Ingredient(name: 'PHP', position: 4),
            Ingredient(name: 'C#', position: 5),
            Ingredient(name: 'C++', position: 6),
          ].where((lang) => lang.name.toLowerCase().contains(query.toLowerCase())).toList();
    }
}
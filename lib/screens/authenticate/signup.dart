
import 'package:flutter/material.dart';
import 'package:food_savior/models/user.dart';
import 'package:food_savior/services/auth.dart';
import 'package:food_savior/services/database.dart';
import 'signup.dart';
import '../home/home_page.dart';


class SignUp extends StatefulWidget {
  static String tag = 'SignUp';

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final AuthService _auth = AuthService();
  final DatabaseService _db = DatabaseService();
  //Use this key to ID the form and associate with the global form state key
  final _formKey = GlobalKey<FormState>();

  // text field state
  String emailVal = '';
  String passwordVal = '';
  String firstNameVal = '';
  String lastNameVal = '';
  String phoneVal = '';
  String addressVal = '';
  String confirmpassVal = '';
  String error = '';
  @override

  Widget build(BuildContext context) {
    final  logo = Hero(
      tag: 'logo',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 150.0,
        child: Image.asset('assets/images/logo.JPG'),
      ),
    );

    /*
    final signup = Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        'Sign Up',
        style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w600, color: Colors.deepPurple),
      ),
    );
    */


    final first_name = TextFormField(
      keyboardType: TextInputType.text,
      autofocus: false,
      validator: (val) => val.isEmpty ? 'Enter a first name' : null,
      onChanged: (val) {
        setState(() => firstNameVal = val);
      },
      //initialValue: 'First name',
      decoration: InputDecoration(
        icon: Icon(Icons.person),
        hintText: 'First Name',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final last_name = TextFormField(
      autofocus: false,
      //initialValue: 'Last name',
      //obscureText: true,
      validator: (val) => val.isEmpty ? 'Enter a last name' : null,
      onChanged: (val) {
        setState(() => lastNameVal = val);
      },
      decoration: InputDecoration(
        icon: Icon(Icons.person),
        hintText: 'Last Name',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

  final address = TextFormField(
      autofocus: false,
      //initialValue: 'Last name',
      //obscureText: true,
      validator: (val) => val.isEmpty ? 'Enter an address' : null,
      onChanged: (val) {
        setState(() => addressVal = val);
      },
      decoration: InputDecoration(
        icon: Icon(Icons.home),
        hintText: 'Address',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );
   


    final phoneNumber = TextFormField(
      keyboardType: TextInputType.phone,
      autofocus: false,
      validator: (val) {
        if (val.length < 10) {
          return 'Enter a full phone number';
        } else {
          try {
            int.parse(val);
            return null;
          } catch (e) {
            return 'Enter a valid phone number';
          }
        }
        // ? 'Enter a phone number' : null,
      },
      onChanged: (val) {
        setState(() => phoneVal = val);
      },
      decoration: InputDecoration(
        icon: Icon(Icons.phone),
        hintText: 'Phone Number',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );


    final password = TextFormField(
      keyboardType: TextInputType.visiblePassword,
      autofocus: false,
      validator: (val) => val.length < 6 ? 'Enter a password 6+ characters long' : null,
      onChanged: (val) {
        setState(() => passwordVal = val);
      },
      obscureText: true,
      decoration: InputDecoration(
        icon: Icon(Icons.lock),
        hintText: 'password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final confirmPassword = TextFormField(
      keyboardType: TextInputType.visiblePassword,
      autofocus: false,
      validator: (val) => val != passwordVal ? 'passwords do not match' : null,
      onChanged: (val) {
        setState(() => confirmpassVal = val);
      },
      obscureText: true,
      decoration: InputDecoration(
        icon: Icon(Icons.lock),
        hintText: 'Confirm Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final createAccount = Padding(
      padding: EdgeInsets.symmetric(vertical: 4.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        
        onPressed: () async {
          // Runs each validator from the Form Fields, only if all return null is this true
          if (_formKey.currentState.validate()) {
            User result = await _auth.registerWithEmailAndPassword(emailVal, passwordVal);

            // Null back means something went wrong with registering, no need to do something otherwise as we are listening for user changes and make things happen based off that
            if (result == null) {
              setState(() => error = 'please supply a valid email');
            } else {
              await _db.updateUserData(result.uid, firstNameVal, lastNameVal, phoneVal, addressVal);
              Navigator.pop(context);
            }
          }
        
          //Navigator.of(context).pushNamed(SignUp.tag);
        },
        // contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        color: Colors.lightGreen[700],
        child: Text('Sign Up', style: TextStyle(color: Colors.white)),
      ),
    );

    final email = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      validator: (val) => val.isEmpty ? 'Enter an email' : null,
      onChanged: (val) {
        setState(() => emailVal = val);
      },
      decoration: InputDecoration(
        icon: Icon(Icons.mail),
        hintText: 'E-mail',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final body = Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(28.0),
      //decoration: BoxDecoration(
       // gradient: LinearGradient(colors: [
         // Colors.brown[50],
        //  Colors.brown[50],
       // ]),
      //),
      child: Column(
        children: <Widget>[ first_name, last_name,
          address, phoneNumber,
          password, confirmPassword,
          createAccount],
      ),
    );

    return Scaffold(
      body: Form(
        key: _formKey,
        child: Center(
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(left: 24.0, right: 24.0),
            children: <Widget>[
              logo,
              SizedBox(height: 48.0),
              first_name,
              SizedBox(height: 8.0),
              last_name,
              SizedBox(height: 8.0),
              email,
              SizedBox(height: 8.0),
              phoneNumber,
              SizedBox(height: 8.0),
              address,
              SizedBox(height: 8.0),
              password,
              SizedBox(height: 8.0),
              confirmPassword,
              SizedBox(height: 24.0),
              createAccount
            ],
          ),
        ),
      ),
    );
  }
}



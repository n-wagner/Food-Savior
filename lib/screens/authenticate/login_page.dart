import 'package:flutter/material.dart';
import 'package:food_savior/services/auth.dart';
import 'signup.dart';
import '../home/home_page.dart';

class LoginPage extends StatefulWidget {
  static String tag = 'login-page';
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final AuthService _auth = AuthService();
  //Use this key to ID the form and associate with the global form state key
  final _formKey = GlobalKey<FormState>();

  // text field state
  String emailVal = '';
  String passwordVal = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    final logo = Hero(
      tag: 'food savior',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 100.0,
        child: Image.asset('assets/images/logo.jpg'),
      ),
    );

    final email = TextFormField(
      //Validates input, returns null if valid, helper text if not
      validator: (val) => val.isEmpty ? 'Enter an email' : null,
      //Track the value of email whenever the field is changed (same done for password)
      onChanged: (val) {
        setState(() => emailVal = val);
      },
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      initialValue: '',
      decoration: InputDecoration(
        hintText: 'Email',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final password = TextFormField(
      validator: (val) => val.length < 6 ? 'Enter a password 6+ characters long' : null,
      onChanged: (val) {
        setState(() => passwordVal = val);
      },
      keyboardType: TextInputType.visiblePassword,
      autofocus: false,
      initialValue: '',
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 4.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        // contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        color: Colors.lime[700],
        child: Text(
          'Log In',
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

    final signupButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 4.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () async {
          // Runs each validator from the Form Fields, only if all return null is this true
          if (_formKey.currentState.validate()) {
            dynamic result = await _auth.registerWithEmailAndPassword(emailVal, passwordVal);
            // Null back means something went wrong with registering, no need to do something otherwise as we are listening for user changes and make things happen based off that
            if (result == null) {
              setState(() => error = 'please supply a valid email');
            }
          }
          //Navigator.of(context).pushNamed(SignUp.tag);
        },
        padding: EdgeInsets.all(8),
        color: Colors.lime[700],
        child: Text('Sign up', style: TextStyle(color: Colors.white)),
      ),
    );

    final forgotLabel = FlatButton(
      child: Text(
        'Forgot password?',
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: () {},
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
            logo,
            SizedBox(height: 48.0),
            email,
            SizedBox(height: 8.0),
            password,
            //SizedBox(height: 24.0),
            loginButton,
            //SizedBox(height: 8.0),
            signupButton,
            //SizedBox(height: 8.0),
            forgotLabel,
            errorMessage
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
import 'package:flutter/material.dart';
import 'package:food_savior/services/auth.dart';
import 'package:food_savior/services/size_config.dart';

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
    SizeConfigService.init(context);
    final logo = Hero(
      tag: 'food savior',
      child: CircleAvatar(
        backgroundColor: Colors.brown[50],
        radius: SizeConfigService.blockSizeHorizontal * 40,
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
        contentPadding: EdgeInsets.fromLTRB(SizeConfigService.blockSizeHorizontal * 3.0, SizeConfigService.blockSizeVertical * 0.05, SizeConfigService.blockSizeHorizontal * 3.0, SizeConfigService.blockSizeVertical * 0.05),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            SizeConfigService.blockSizeHorizontal * 10
          )
        ),
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
        contentPadding: EdgeInsets.fromLTRB(SizeConfigService.blockSizeHorizontal * 3.0, SizeConfigService.blockSizeVertical * 0.05, SizeConfigService.blockSizeHorizontal * 3.0, SizeConfigService.blockSizeVertical * 0.05),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(SizeConfigService.blockSizeHorizontal * 10)),
      ),
    );

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: SizeConfigService.blockSizeHorizontal * 1),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(SizeConfigService.blockSizeHorizontal * 10),
        ),
        // contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        padding: EdgeInsets.fromLTRB(SizeConfigService.blockSizeHorizontal * 3.0, SizeConfigService.blockSizeVertical * 0.05, SizeConfigService.blockSizeHorizontal * 3.0, SizeConfigService.blockSizeVertical * 0.05),
        color: Colors.lightGreen[700],
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
              setState(() => error = 'please supply a valid email or password');
            }
          }
        }
      ),
    );

    final signupButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 4.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(SizeConfigService.blockSizeHorizontal * 10),
        ),
        onPressed: () {
          Navigator.pushNamed(context, '/sign-up');
        },
        padding: EdgeInsets.all(SizeConfigService.blockSizeHorizontal * 1),
        color: Colors.lightGreen[700],
        child: Text('Sign up', style: TextStyle(color: Colors.white)),
      ),
    );

    final forgotLabel = FlatButton(
      child: Text(
        'Forgot password?',
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: () {
        Navigator.pushNamed(context, '/forgot_pass');
      },
    );

    return Scaffold(
      backgroundColor: Colors.brown[50],
      // Form associated with global key, allows for future validation of the form
      body: Form(
        key: _formKey,
        child: Center(
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(
              left: SizeConfigService.blockSizeHorizontal * 10, 
              right: SizeConfigService.blockSizeHorizontal * 10
              ),
            children: <Widget>[
              logo,
              error == null ? Container() : Text(error),
              //SizedBox(height: 10.0),
              email,
              SizedBox(height: SizeConfigService.blockSizeVertical * 2),
              password,
              SizedBox(height: SizeConfigService.blockSizeVertical * 5),
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

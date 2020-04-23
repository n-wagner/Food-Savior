import 'package:flutter/material.dart';

class ForgotPass extends StatefulWidget {
  static String tag = 'login-page';
  @override
  _ForgotPassState createState() => new _ForgotPassState ();
}

class _ForgotPassState extends State<ForgotPass> {

  //final AuthService _auth = AuthService();
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
        backgroundColor: Colors.brown[50],
        radius: 250.0,
        child: Image.asset('assets/images/logo.JPG'),
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
        hintText: 'New Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final confirmNewPass = TextFormField(
      validator: (val) => val.length < 6 ? 'Enter a password 6+ characters long' : null,
      onChanged: (val) {
        setState(() => passwordVal = val);
      },
      keyboardType: TextInputType.visiblePassword,
      autofocus: false,
      initialValue: '',
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Confirm New Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

  

    final changePass = Padding(
      padding: EdgeInsets.symmetric(vertical: 4.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () {
         // Navigator.pushNamed(context, '/sign-up');
        },
        padding: EdgeInsets.all(8),
        color: Colors.lightGreen[700],
        child: Text('Change Password', style: TextStyle(color: Colors.white)),
      ),
    );

  

    // final errorMessage = Text(
    //   error,
    //   style: TextStyle(color: Colors.red, fontSize: 14.0),
    // );

    // final body = Container(
    //   width: MediaQuery
    //       .of(context)
    //       .size
    //       .width,
    //   padding: EdgeInsets.all(28.0),
    //   decoration: BoxDecoration(
    //     //gradient: LinearGradient(colors: [
    //       // Colors.brown[50],
    //       // Colors.lime[200],
    //    // ])
    //   ),
    //   child: Center(
    //     child: Column(
    //       children: <Widget>[
    //         logo,
    //         //SizedBox(height: 48.0),
    //         email,
    //         SizedBox(height: 8.0),
    //         password,
    //         //SizedBox(height: 24.0),
    //         loginButton,
    //         //SizedBox(height: 8.0),
    //         signupButton,
    //         //SizedBox(height: 8.0),
    //         forgotLabel,
    //         errorMessage
    //       ],
    //     ),
    //   ),
    // );


    return Scaffold(
      
      backgroundColor: Colors.brown[50],
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
              SizedBox(height: 8.0),
              confirmNewPass,
              SizedBox(height: 24.0),
              changePass,
              
              
            ],
          ),
        ),
      ),
    );
  }
}

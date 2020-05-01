import 'package:flutter/material.dart';
import 'package:food_savior/models/user.dart';
import 'package:food_savior/services/auth.dart';
import 'package:food_savior/services/database.dart';
import 'package:food_savior/services/size_config.dart';

class SignUp extends StatefulWidget {
  static String tag = 'SignUp';

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final AuthService _auth = AuthService();
  DatabaseService _db;
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
    SizeConfigService.init(context);
    final  logo = Hero(
      tag: 'logo',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius:  SizeConfigService.safeBlockHorizontal * 30,
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


    final firstName = TextFormField(
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
        contentPadding: EdgeInsets.fromLTRB(
          SizeConfigService.safeBlockHorizontal * 3.0, 
          SizeConfigService.safeBlockVertical * 0.05, 
          SizeConfigService.safeBlockHorizontal * 3.0, 
          SizeConfigService.safeBlockVertical * 0.05
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(SizeConfigService.safeBlockHorizontal * 10)),
      ),
    );

    final lastName = TextFormField(
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
        contentPadding: EdgeInsets.fromLTRB(
          SizeConfigService.safeBlockHorizontal * 3.0, 
          SizeConfigService.safeBlockVertical * 0.05, 
          SizeConfigService.safeBlockHorizontal * 3.0, 
          SizeConfigService.safeBlockVertical * 0.05
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(SizeConfigService.safeBlockHorizontal * 10)),
        
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
        contentPadding: EdgeInsets.fromLTRB(
          SizeConfigService.safeBlockHorizontal * 3.0, 
          SizeConfigService.safeBlockVertical * 0.05, 
          SizeConfigService.safeBlockHorizontal * 3.0, 
          SizeConfigService.safeBlockVertical * 0.05),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(SizeConfigService.safeBlockHorizontal * 10)),
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
        contentPadding: EdgeInsets.fromLTRB(
          SizeConfigService.safeBlockHorizontal * 3.0, 
          SizeConfigService.safeBlockVertical * 0.05, 
          SizeConfigService.safeBlockHorizontal * 3.0, 
          SizeConfigService.safeBlockVertical * 0.05
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(SizeConfigService.safeBlockHorizontal * 10)),
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
        hintText: 'Password',
        contentPadding: EdgeInsets.fromLTRB(
          SizeConfigService.safeBlockHorizontal * 3.0, 
          SizeConfigService.safeBlockVertical * 0.05, 
          SizeConfigService.safeBlockHorizontal * 3.0, 
          SizeConfigService.safeBlockVertical * 0.05
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(SizeConfigService.safeBlockHorizontal * 10)),
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
        contentPadding: EdgeInsets.fromLTRB(
          SizeConfigService.safeBlockHorizontal * 3.0, 
          SizeConfigService.safeBlockVertical * 0.05, 
          SizeConfigService.safeBlockHorizontal * 3.0, 
          SizeConfigService.safeBlockVertical * 0.05
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(SizeConfigService.safeBlockHorizontal * 10)),
      ),
    );

    final createAccount = Padding(
      padding: EdgeInsets.symmetric(vertical: 4.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(SizeConfigService.safeBlockHorizontal * 10),
        ),
        
        onPressed: () async {
          // Runs each validator from the Form Fields, only if all return null is this true
          if (_formKey.currentState.validate()) {
            User result = await _auth.registerWithEmailAndPassword(emailVal, passwordVal);

            // Null back means something went wrong with registering, no need to do something otherwise as we are listening for user changes and make things happen based off that
            if (result == null) {
              setState(() => error = 'please supply a valid email');
            } 
            else {
              _db = DatabaseService(uid: result.uid);
              await _db.updateUserData(firstName: firstNameVal, lastName: lastNameVal, phoneNumber: phoneVal, address: addressVal);
              Navigator.pop(context);
            }
          }
        
          //Navigator.of(context).pushNamed(SignUp.tag);
        },
        // contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        padding: EdgeInsets.fromLTRB(
          SizeConfigService.safeBlockHorizontal * 3.0, 
          SizeConfigService.safeBlockVertical * 0.05, 
          SizeConfigService.safeBlockHorizontal * 3.0, 
          SizeConfigService.safeBlockVertical * 0.05
        ),
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
        contentPadding: EdgeInsets.fromLTRB(
          SizeConfigService.safeBlockHorizontal * 3.0, 
          SizeConfigService.safeBlockVertical * 0.05, 
          SizeConfigService.safeBlockHorizontal * 3.0, 
          SizeConfigService.safeBlockVertical * 0.05
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(SizeConfigService.safeBlockHorizontal * 10)),
      ),
    );

    final back = Padding(
      padding: EdgeInsets.symmetric(vertical: 1.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(SizeConfigService.safeBlockHorizontal * 10),
        ),
        
        onPressed: () async {
            Navigator.pop(context);
          },
        padding: EdgeInsets.fromLTRB(
          SizeConfigService.safeBlockHorizontal * 3.0, 
          SizeConfigService.safeBlockVertical * 0.05, 
          SizeConfigService.safeBlockHorizontal * 3.0, 
          SizeConfigService.safeBlockVertical * 0.05
        ),
        color: Colors.lightGreen[700],
        child: Text('Back', style: TextStyle(color: Colors.white)),
      ),
    );

    return Scaffold(
      body: Form(
        key: _formKey,
        child: SafeArea(
          child: Center(
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.only(left: SizeConfigService.safeBlockHorizontal * 5, right: SizeConfigService.safeBlockHorizontal * 5),
              children: <Widget>[
                logo,
                SizedBox(height: SizeConfigService.safeBlockVertical * 2),
                firstName,
                SizedBox(height: SizeConfigService.safeBlockVertical * 2),
                lastName,
                SizedBox(height: SizeConfigService.safeBlockVertical * 2),
                email,
                SizedBox(height: SizeConfigService.safeBlockVertical * 2),
                phoneNumber,
                SizedBox(height: SizeConfigService.safeBlockVertical * 2),
                address,
                SizedBox(height: SizeConfigService.safeBlockVertical * 2),
                password,
                SizedBox(height: SizeConfigService.safeBlockVertical * 2),
                confirmPassword,
                SizedBox(height: SizeConfigService.safeBlockVertical * 2),
                createAccount,
                back,
              ],
            ),
          ),
        ),
      ),
    );
  }
}



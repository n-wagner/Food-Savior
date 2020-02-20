import 'package:flutter/material.dart';
import 'home_page.dart';
class SignUp extends StatelessWidget {
  static String tag = 'SignUp';

  @override
  Widget build(BuildContext context) {
    final  logo = Hero(
      tag: 'logo',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 48.0,
        child: Image.asset('assets/images/logo.jpg'),
      ),
    );

    final signup = Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        'Sign Up:',
        style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w600, color: Colors.white),
      ),
    );


    final first_name = TextFormField(
      keyboardType: TextInputType.text,
      validator: (String firstNameValue)
      {
        if (firstNameValue.isEmpty)
        {  return 'Please enter some text'; }
        return null;
      },
      autofocus: false,
      initialValue: 'first name',
      decoration: InputDecoration(
        icon: Icon(Icons.person),
        hintText: 'name',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final last_name = TextFormField(
      autofocus: false,
      initialValue: 'last_name',
      //obscureText: true,
      decoration: InputDecoration(
        icon: Icon(Icons.person),
        hintText: 'surname',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final address = TextFormField(
      keyboardType: TextInputType.multiline,
      autofocus: false,
      initialValue: 'address',
      decoration: InputDecoration(
        hintText: 'name',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final phoneNumber = TextFormField(
      keyboardType: TextInputType.phone,
      autofocus: false,
      initialValue: '000-000-0000',
      //obscureText: true,
      decoration: InputDecoration(
        hintText: 'phone number',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );


    final password = TextFormField(
      keyboardType: TextInputType.visiblePassword,
      autofocus: false,
      initialValue: 'pwd',
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final confirmPassword = TextFormField(
      keyboardType: TextInputType.visiblePassword,
      autofocus: false,
      initialValue: 'pwd',
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'confirm password',
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
        onPressed: () {
          Navigator.of(context).pushNamed(HomePage.tag);
        },
        // contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        color: Colors.lime[700],
        child: Text('create account', style: TextStyle(color: Colors.white)),
      ),
    );

    final email = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      initialValue: '----@---.---',
      decoration: InputDecoration(
        hintText: 'Email',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final body = Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(28.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          Colors.lime[800],
          Colors.lime[200],
        ]),
      ),
      child: Column(
        children: <Widget>[ first_name, last_name,
          address, phoneNumber,
          password, confirmPassword,
          createAccount],
      ),
    );

    return Scaffold(
      body: Center(
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
            signup
          ],
        ),
      ),
    );
  }
}
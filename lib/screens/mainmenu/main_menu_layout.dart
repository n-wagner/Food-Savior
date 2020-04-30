import 'package:flutter/material.dart';
import 'package:food_savior/services/auth.dart';
import 'package:food_savior/services/size_config.dart';

//class MenuLayout extends StatelessWidget {
  class MenuLayout extends StatefulWidget {
  @override
   _MenuLayoutState createState() => _MenuLayoutState();
}
class _MenuLayoutState extends State<MenuLayout> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

    SizeConfigService.init(context);

    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[
                Colors.white,
                Colors.lightGreen[50],
                ]
              ),
              image: DecorationImage(
                image: AssetImage('assets/images/notextlogo.jpg'),
              )
            ),
            child: Container(),
          ),
          ListTile(
            dense: true,
            leading: Icon(Icons.person), 
            title: Text('Profile', style: TextStyle(fontSize: 17)), 
            onTap: () {
            Navigator.pushNamed(context, '/profile-page');
            }
          ),
          ListTile(
            dense: true,
            leading: Icon(Icons.history), 
            title: Text('Items Donated', style: TextStyle(fontSize: 17)), 
            onTap: () {
              Navigator.pushNamed(context, '/items-donated');
            }
          ),
          ListTile(
            dense: true,
            leading: Icon(Icons.history), 
            title: Text('Items Received', style: TextStyle(fontSize: 17)), 
            onTap:() {
              Navigator.pushNamed(context, '/items-received');
            }
          ),
          ListTile(
            dense: true,
            leading: Icon(Icons.history), 
            title: Text('Orders Waiting', style: TextStyle(fontSize: 17)), 
            onTap:() {
            Navigator.pushNamed(context, '/orders-waiting');
            }
          ),
          ListTile(
            dense: true,
            leading: Icon(Icons.history), 
            title: Text('Pickup Waiting', style: TextStyle(fontSize: 17)), 
            onTap:() {
            Navigator.pushNamed(context, '/pickup-waiting');
            }
          ),
          ListTile(
            dense: true,
            leading: Icon(Icons.attach_money), 
            title: Text('Donate', style: TextStyle(fontSize: 17)), 
            onTap:()=> {}
          ),
          ListTile(
            dense: true,
            leading: Icon(Icons.feedback), 
            title: Text('FAQ', style: TextStyle(fontSize: 17)), 
            onTap:() 
            {
              Navigator.pushNamed(context, '/questions');
            }
          ),
          ListTile(
            dense: true,
            leading: (Icon(Icons.settings)), 
            title: Text('Settings', style: TextStyle(fontSize: 17)), 
            onTap:()=> {}
            ),
          ListTile(
            dense: true,
            leading: Icon(Icons.lock), 
            title: Text('Log out', style: TextStyle(fontSize: 17)), 
            onTap:() async {
              await _auth.signOut();
              Navigator.pop(context);
            }
          ),
        ]
      ),
          
  );
}  

} // end class 

class CustomListTile extends StatelessWidget{
  
  final IconData icon;
  final String text;
  final Function onTap;

  CustomListTile(this.icon,this.text,this.onTap);
  @override 

Widget build(BuildContext context) {
return Padding(
  padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
  child: InkWell(
    splashColor: Colors.lightGreen,
    onTap: onTap,
    child: Container(
      height: 40,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget> [
            Row(
              children: <Widget>[
              Icon(icon),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(text, style: TextStyle(fontSize: 16.0)), 
                  )
            ],
            ),
            Icon(Icons.arrow_right),
          ]
        ),

    )
      
  ),
);


}



}

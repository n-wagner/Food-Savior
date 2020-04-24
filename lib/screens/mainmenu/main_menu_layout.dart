import 'package:flutter/material.dart';
import 'package:food_savior/services/auth.dart';

//class MenuLayout extends StatelessWidget {
  class MenuLayout extends StatefulWidget {
  @override
   _MenuLayoutState createState() => _MenuLayoutState();
}
class _MenuLayoutState extends State<MenuLayout> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
  //return Scaffold(
   // appBar: AppBar(
    //    title: Text('test'),
   //     backgroundColor: Colors.blueGrey,
    //    ),
  //  drawer: Drawer(

    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: <Color>[
                Colors.green,
                Colors.lightGreen,
              ])
              ),
            child: Center(
              child:Text(
                'Food Savior',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  ),
              ),
            ),
          ),
          CustomListTile(Icons.person, 'Profile', () {
            Navigator.pushNamed(context, '/profile-page');
          }),
          CustomListTile(Icons.history, 'Items Donated', () {
            Navigator.pushNamed(context, '/items-donated');
          }),
          CustomListTile(Icons.history, 'Items Received', () {
            Navigator.pushNamed(context, '/items-received');
          }),
          CustomListTile(Icons.history, 'Orders Waiting', () {
            Navigator.pushNamed(context, '/orders-waiting');
          }),
          CustomListTile(Icons.history, 'Pickup Waiting', () {
            Navigator.pushNamed(context, '/pickup-waiting');
          }),
          // '/items-donated': (context) => DonatedOrdersWrapper(),
          // '/items-received': (context) => FoodRecievedWrapper(),
          // '/orders-waiting': (context) => WaitingOrdersWrapper(),
          // '/pickup-waiting': (context) => WaitingPickupWrapper(),
          CustomListTile(Icons.chat, 'Chat', () {
            Navigator.pushNamed(context, '/chat');
          }),
          CustomListTile(Icons.attach_money, 'Donate', ()=> {}),
          CustomListTile(Icons.feedback, 'FAQ', () 
          {
            Navigator.pushNamed(context, '/questions');
          }),
          CustomListTile(Icons.settings, 'Settings', ()=> {}),
                    CustomListTile(Icons.lock, 'Log out', () async {
            await _auth.signOut();
            Navigator.pop(context);
          }),
            //ListTile(
           // title: Text('Log Out'),
            //onTap: () async {
             // await _auth.signOut();
             // Navigator.pop(context);
      
        ],
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

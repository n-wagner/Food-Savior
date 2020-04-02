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
                Colors.blue,
                Colors.lightBlue,
              ])
              ),
            child: Text('HEADER')),
          CustomListTile(Icons.person, 'Profile', () 
          {
            Navigator.pushNamed(context, '/profile-page');
          }),
          CustomListTile(Icons.history, 'Past Orders', ()=> {}),
          CustomListTile(Icons.chat, 'Chat', () 
          {
            Navigator.pushNamed(context, '/chat');
          }),
          CustomListTile(Icons.attach_money, 'Donate', ()=> {}),
          CustomListTile(Icons.info, 'About', ()=> {}),
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
  
  IconData icon;
  String text;
  Function onTap;

  CustomListTile(this.icon,this.text,this.onTap);
  @override 

Widget build(BuildContext context) {
return Padding(
  padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
  child: InkWell(
    splashColor: Colors.blueAccent,
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
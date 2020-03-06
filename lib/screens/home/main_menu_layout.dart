import 'package:flutter/material.dart';
import 'package:food_savior/services/auth.dart';

class MenuLayout extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
  return 
  // Scaffold(
  //   appBar: AppBar(
  //       title: Text('test'),
  //       backgroundColor: Colors.blueGrey,
  //       ),
  //   drawer: 
    Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[
                  Colors.blue,
                  Colors.lightBlue,
                ]
              )
            ),
            child: Text('HEADER')
          ),
          CustomListTile(),
          ListTile(
            title: Text('Donate')
            ),
          ListTile(
            title: Text('LogOut')
            ),
        ],
      ),
    //),
  );
}  

} // end class 

class CustomListTile extends StatelessWidget{
  @override 

Widget build(BuildContext context) {
return Padding(
  padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
  child: InkWell(
    splashColor: Colors.blueAccent,
    onTap: ()=>{},
    child: Container(
      height: 40,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget> [
            Row(
              children: <Widget>[
              Icon(Icons.person),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'profile', 
                  style: TextStyle(
                    fontSize: 16.0
                  )
                ), 
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

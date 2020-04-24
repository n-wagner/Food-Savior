import 'package:flutter/material.dart';

class AcceptanceChoice extends StatelessWidget {
  static const String title = "Takers";

  final Map<String, String> swipers;
  AcceptanceChoice({ this.swipers });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( 
        title: Text(AcceptanceChoice.title),
        leading: MaterialButton(
          onPressed: () {
            Navigator.pop(context, null);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.lightGreen,
      ),
      body: SafeArea(
        child: Center(
          child: ListView(
            children: swipers.map<Widget, Null>((String swiperID, String swiperPhone) {
              return MapEntry<ListTile, Null>(ListTile(
                onTap: () {
                  Navigator.pop(context, swiperID);
                },
                title: Text(swiperPhone),
              ), null);
            }).keys.toList(),
          ),
        ),
      ),
    );
  }
}
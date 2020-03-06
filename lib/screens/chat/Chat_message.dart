import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget{
  @override
  Widget build (BuildContext context){
    return new Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: new Row(
        children: <Widget>[
          new Container(
            margin: const EdgeInserts.only(right:16) 
          )
      ],),
    );
  }
}
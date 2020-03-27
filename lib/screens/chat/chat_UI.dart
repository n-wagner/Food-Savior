import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:food_savior/screens/chat/Charscreen.dart'; 


class ChatAppHome extends StatelessWidget {
  @override
  Widget build(BuildContext context)
  {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("chat"),
      ),
   
      body: new ChatScreen()
    );
    
  }
}


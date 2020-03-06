import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget{
@override
State createState() => new ChatScreenState(); 
}

class ChatScreenState  extends State <ChatScreen>{

final TextEditingController _textcontroller = new TextEditingController();

void _handleSubmitted(String text){
_textcontroller.clear();
}

Widget _textComposerWidget(){
  return new IconTheme(
    data: new IconThemeData( color: Colors.lightGreenAccent),
      child: new Container(
    margin: const EdgeInsets.symmetric(horizontal:8.0),
      child: new Row(
        children: <Widget>[
          new Flexible(
            child: new TextField(
              decoration: new InputDecoration.collapsed(hintText: "Send Message"),
              controller: _textcontroller,
              onSubmitted: _handleSubmitted,
              ),
          ),
          new Container(
            margin: const EdgeInsets.symmetric(horizontal: 4.0),
            child: new IconButton(
              icon: new Icon (Icons.send),
              onPressed: ()=>_handleSubmitted(_textcontroller.text),
              ),
          ),
        ],

      ),
    ),
  );
}

@override
Widget build(BuildContext context){
   return _textComposerWidget();
  }
}
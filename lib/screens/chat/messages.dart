import 'package:flutter/material.dart';
import 'package:food_savior/screens/chat/service.dart';



class ChatAppHome extends StatefulWidget {

  @override
  _ChatAppHome createState() => _ChatAppHome();
}



class _ChatAppHome extends State<ChatAppHome> {
  final CallsAndMessagesService _callsandmessagesservice = CallsAndMessagesService();
  
  final String number = "123456789";
  final String email = "dancamdev@example.com";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('dancamdev'),
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            // RaisedButton(
            //   child: Text(
            //     "call $number",
            //   ),
            //   onPressed: () => _callsandmessagesservice.call(number),
            // ),
            // SizedBox(height: 20),
            RaisedButton(
              child: Text(
                "message $number",
              ),
              onPressed: () => _callsandmessagesservice.sendSms(number),
            ),
            SizedBox(height: 20),
            // RaisedButton(
            //   child: Text(
            //     "email $email",
            //   ),
            //   onPressed: () => _callsandmessagesservice.sendEmail(email),
            // ),
          ],
        ),
      ),
    );
  }
}
// class ChatAppHome extends StatelessWidget {
// Widget build(BuildContext context)
//   {
//     return new Scaffold(
//     body: Center(
//       child: RaisedButton(
//         onPressed: _launchURL,
//         child: Text('Chat'),
//       ),
//     ),
//   );
// }

// // _launchURL() async {
// //   const url = 'https://flutter.dev';
// //   if (await canLaunch(url)) {
// //     await launch(url);
// //   } 
// //   else {
// //     throw 'Could not launch $url';
// //   }
// //  }
 
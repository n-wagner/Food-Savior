import 'package:flutter/material.dart';

class AcceptanceChoice extends StatelessWidget {

  final Map<String, String> swipers;
  AcceptanceChoice({ this.swipers });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: swipers.map<Widget, Null>((String swiperID, String swiperPhone) {
        return MapEntry<ListTile, Null>(ListTile(
          onTap: () {
            Navigator.pop(context, swiperID);
          },
          title: Text(swiperPhone),
        ), null);
      }).keys.toList(),
    );
  }
}
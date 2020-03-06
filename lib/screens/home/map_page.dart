import 'package:flutter/material.dart';
import 'package:food_savior/screens/home/index.dart';

class MapPage extends StatelessWidget {
  static const String routeName = '/map';

  @override
  Widget build(BuildContext context) {
    var _mapBloc = MapBloc();
    return Scaffold(
      appBar: AppBar(
        title: Text('Map'),
      ),
      body: MapScreen(mapBloc: _mapBloc),
    );
  }
}

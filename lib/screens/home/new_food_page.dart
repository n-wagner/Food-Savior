import 'package:flutter/material.dart';
import 'package:food_savior/screens/home/index.dart';

class NewFoodPage extends StatelessWidget {
  static const String routeName = '/newFood';

  @override
  Widget build(BuildContext context) {
    var _newFoodBloc = NewFoodBloc();
    return Scaffold(
      appBar: AppBar(
        title: Text('NewFood'),
      ),
      body: NewFoodScreen(newFoodBloc: _newFoodBloc),
    );
  }
}

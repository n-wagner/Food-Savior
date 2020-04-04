import 'package:flutter/material.dart';
import 'package:food_savior/services/location_service.dart';
import 'package:food_savior/screens/maps/map_page.dart';
import 'package:provider/provider.dart';
import 'package:food_savior/models/user_location.dart';


class MapWrapper extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserLocation>(
      create: (context) => LocationService().locationStream,
      child: MapView(),
    );
  }
}

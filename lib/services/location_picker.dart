import 'package:flutter/material.dart';
import 'package:nominatim_location_picker/nominatim_location_picker.dart';

class LocationPicker extends StatefulWidget {

  final String title = 'Pick Location';

  @override
  State<LocationPicker> createState() => new LocationPickerState();
}

class LocationPickerState extends State<LocationPicker> {
  //var _pickedLocationText;
  List<double> targetCoordinates;
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MapBoxLocationPicker(
        context: context,
        popOnSelect: true,
        apiKey: "pk.eyJ1IjoibWFyaXptaWV2YSIsImEiOiJjazhqZnd1anAwZ2s4M21tdmk2eG05c3dtIn0.yLfRxI4__alVuC14pIlHXg",
        limit: 10,
        searchHint: 'Search',
        awaitingForLocation: "Pick location",
        onSelected: (place) {
          setState(() {
            targetCoordinates = place.geometry.coordinates; 
            print(targetCoordinates);
            Navigator.pop(context, targetCoordinates);
          });
        }
      ),
    );
  }

}
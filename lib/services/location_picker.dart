import 'package:flutter/material.dart';
import 'package:nominatim_location_picker/nominatim_location_picker.dart';
import 'package:flutter_map/flutter_map.dart';


class LocationPicker extends StatelessWidget {
  static const String title = "Location Picker";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primarySwatch: Colors.lightGreen, primaryColorBrightness: Brightness.dark),
      home: LocationPickerPage(title: 'Location Picker'),
    );
  }
}

class LocationPickerPage extends StatefulWidget {
  LocationPickerPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LocationPickerPageState createState() => _LocationPickerPageState();
}

class _LocationPickerPageState extends State<LocationPickerPage> {
  var _pickedLocationText;
  List<double> targetCoordinates;

  Widget getLocation() {
    return MapBoxLocationPicker(
      popOnSelect: true,
      apiKey: "pk.eyJ1IjoibWFyaXptaWV2YSIsImEiOiJjazhqZnd1anAwZ2s4M21tdmk2eG05c3dtIn0.yLfRxI4__alVuC14pIlHXg",
      limit: 10,
      searchHint: 'Search',
      awaitingForLocation: "Pick location",
      onSelected: (place) {
        setState(() {
          targetCoordinates = place.geometry.coordinates; 
          print(targetCoordinates);
          //Navigator.pop(context);
          return targetCoordinates;
        });
      },
      context: context,
    );
  }

//   Widget appBar() {
//     return AppBar(
//       centerTitle: true,
//       title: Text('How to use'),
//     );
//   }

//   Widget body(BuildContext context) {
//     //List <double> coordinates;
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: <Widget>[
//         Padding(
//           padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
//           child: Center(child: Text("Latitude: " + (targetCoordinates[0].toString()) + " Longitude: " + (targetCoordinates[1].toString())))
//         ),
//         Padding(
//           padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
//           child: (mapBoxButton(Colors.green, 'MapBox Location Picker'))
//            )
//       ],
//     );
//   }

  @override

  Widget build(BuildContext context) {
    return getLocation ();
  }
}
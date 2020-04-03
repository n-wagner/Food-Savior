import 'package:flutter/material.dart';
import 'package:food_savior/models/user_location.dart';
import 'package:food_savior/services/location_service.dart';
import 'package:provider/provider.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
 
// class HomeView extends StatelessWidget {
//   const HomeView({Key key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     var userLocation = Provider.of<UserLocation>(context);
//     return Scaffold(
//       body: Center(
//         child: Text(
//             'Location: Lat:${userLocation.latitude}, Long: ${userLocation.longitude}'),
//       ),
//     );
//   }
// }



class MapView extends StatefulWidget {
  @override
  _MapViewState createState() => new _MapViewState();
}
 
class _MapViewState extends State<MapView> {
 
  @override
  Widget build(BuildContext context) {
    var userLocation = Provider.of<UserLocation>(context);
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('Map View'),
          leading: IconButton(icon:Icon(Icons.arrow_back),
            onPressed:() {
                Navigator.pop(context);
              }
          ),
          backgroundColor: Colors.lightGreen,
        ),
        body: new FlutterMap(
            options: new MapOptions(
                center: LatLng(userLocation.latitude, userLocation.longitude), minZoom: 5.0),
            layers: [
              new TileLayerOptions(
                  urlTemplate:
                      "https://api.mapbox.com/styles/v1/marizmieva/ck7fz6cs60cnt1jlicrxdl0vn/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoibWFyaXptaWV2YSIsImEiOiJjazhqZnd1anAwZ2s4M21tdmk2eG05c3dtIn0.yLfRxI4__alVuC14pIlHXg",
                  additionalOptions: {
                    'accessToken':
                        'pk.eyJ1IjoibWFyaXptaWV2YSIsImEiOiJjazhqZnd1anAwZ2s4M21tdmk2eG05c3dtIn0.yLfRxI4__alVuC14pIlHXg',
                    'id': 'mapbox.mapbox-streets-v8'
                  }),
              new MarkerLayerOptions(markers: [
                new Marker(
                    width: 45.0,
                    height: 45.0,
                    point: LatLng(userLocation.latitude, userLocation.longitude),
                    builder: (context) => new Container(
                          child: IconButton(
                            icon: Icon(Icons.location_on),
                            color: Colors.blue,
                            iconSize: 45.0,
                            onPressed: () {
                              print('Marker tapped');
                            },
                          ),
                        ))
              ])
            ]));
  }
}
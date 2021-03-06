import 'dart:async';
import 'package:flutter/material.dart';
import 'package:food_savior/screens/navigation/map_request.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapRouting extends StatefulWidget {
  final double latitude;
  final double longitude;
  const MapRouting(this.latitude, this.longitude);
  @override
  State<MapRouting> createState() => MapRoutingState();

}

class MapRoutingState extends State<MapRouting> {

  bool loading = true;
  final Set<Marker> _markers = {};
  final Set<Polyline> _polyLines = {};
  GoogleMapsServices _googleMapsServices = GoogleMapsServices();
  Set<Polyline> get polyLines => _polyLines;
  Completer<GoogleMapController> _controller = Completer();
  static LatLng latLng;
  LocationData currentLocation;


  @override
  void initState(){
    getLocation();
    loading = true;
    super.initState();
  }

   getLocation() async {

    var location = new Location();
    location.onLocationChanged.listen((  currentLocation) {

      print(currentLocation.latitude);
      print(currentLocation.longitude);
      if (!mounted) {
        return;
      }
      setState(() {

        latLng =  LatLng(currentLocation.latitude, currentLocation.longitude);
       });

      print("getLocation:$latLng");
      _onAddMarkerButtonPressed();
      loading = false;
    });

  }

  void _onAddMarkerButtonPressed() {
    if (!mounted) {
      return;
    }
     setState(() {
      _markers.add(Marker(
         markerId: MarkerId("111"),
        position: latLng,
        icon: BitmapDescriptor.defaultMarker,
      ));
    });
   }


  void onCameraMove(CameraPosition position) {
    latLng = position.target;
   }

  List<LatLng> _convertToLatLng(List points) {
    List<LatLng> result = <LatLng>[];
    for (int i = 0; i < points.length; i++) {
      if (i % 2 != 0) {
        result.add(LatLng(points[i - 1], points[i]));
      }
    }
    return result;
  }

  void sendRequest() async {
    LatLng destination = LatLng(widget.latitude, widget.longitude);
    String route = await _googleMapsServices.getRouteCoordinates(
        latLng, destination);
    createRoute(route);
    _addMarker(destination,"Food to Pickup");
  }

  void createRoute(String encondedPoly) {
    _polyLines.add(Polyline(
        polylineId: PolylineId(latLng.toString()),
        width: 4,
        points: _convertToLatLng(_decodePoly(encondedPoly)),
        color: Colors.green[900],
        startCap: Cap.roundCap,
        endCap: Cap.roundCap,
        )
      );
  }

  void _addMarker(LatLng location, String address) {
    _markers.add(Marker(
      markerId: MarkerId("112"),
        position: location,
        infoWindow: InfoWindow(title: address, snippet: "go here"),
        icon: BitmapDescriptor.defaultMarker));
  }

  List _decodePoly(String poly) {
    var list = poly.codeUnits;
    var lList = new List();
    int index = 0;
    int len = poly.length;
    int c = 0;
     do {
      var shift = 0;
      int result = 0;

      do {
        c = list[index] - 63;
        result |= (c & 0x1F) << (shift * 5);
        index++;
        shift++;
      } while (c >= 32);
       if (result & 1 == 1) {
        result = ~result;
      }
      var result1 = (result >> 1) * 0.00001;
      lList.add(result1);
    } while (index < len);

     for (var i = 2; i < lList.length; i++) lList[i] += lList[i - 2];

    print(lList.toString());

    return lList;
  }

  @override
  Widget build(BuildContext context) {
    print("getLocation111:$latLng");
    return new Scaffold(
      appBar: AppBar( 
        title: Text(
          'Get Food',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white, 
            )
          ),
      ),
      body:
      loading
          ?
      Container(color: Colors.white,
                child: Center(
                  child: Text(
                    'Loading page...', 
                    style: TextStyle(
                    color: Colors.blueGrey, 
                    fontSize: 26)
                  )
                )
              )
          :
      GoogleMap(
        polylines: polyLines,
         markers: _markers,
         mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: latLng,
          zoom: 15,
        ),
        onCameraMove:  onCameraMove,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),

      floatingActionButton: FloatingActionButton.extended(
        label: Text('GO'),
        //icon: Icon(Icons.directions_boat),
        onPressed: (){
          sendRequest();
        },
      ),
    );
  }
}







import 'dart:async';
import "package:flutter/material.dart";
import 'package:flutter_redux/flutter_redux.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import "package:location/location.dart";
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  @override
  State<MapScreen> createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen> {
  Completer<GoogleMapController> mapController = Completer();
  LatLng center = LatLng(44.435075, 26.101195);
  var location = new Location();
  LocationData userLocation;

  Set<Marker> markers = Set();
  MapType _currentMapType = MapType.normal;
  LatLng centerPosition;
// Geoflutterfire geo = Geoflutterfire();
  final databaseReference = FirebaseDatabase.instance.reference();
  Firestore _firestore = Firestore.instance;
//  CollectionReference collectionReference = Firestore.instance.collection("news");
  Marker marker;

  void getData() {
    Firestore.instance.collection('news').getDocuments().then((docs) {
      if (docs.documents.isNotEmpty) {
        for (int i = 0; i < docs.documents.length; i++) {
          //clients.add(docs.documents[i].data);
          initMarker(docs.documents[i].data, docs.documents[i].documentID);
        }
      }
    });
  }

  void initMarker(client, markerRef) {
    var markerIDVal = markerRef;
    final MarkerId markerId = MarkerId(markerIDVal);

    InfoWindow infoWindow = InfoWindow(
      onTap: (){

      },
      title: client['title'],
    );
    final Marker marker = Marker(
      position:
          LatLng(client['geopoints'].latitude, client['geopoints'].longitude),
      markerId: markerId,
      infoWindow: infoWindow,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),

    );

    setState(() {
      markers.add(marker);
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController.complete(controller);
  }

  void _onMapTypeButtonPressed() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
     // print("dddd" + _currentMapType.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    getData();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
      ),
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: (){
            Navigator.pop(context);
          }),

          title: Text(
            'News Map',
            style: TextStyle(color: Colors.white),
          ),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.refresh),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/map');
                },
              ),
            ]
        ),
        body: Stack(
          children: <Widget>[
            GoogleMap(
              onMapCreated: _onMapCreated,
              mapType: _currentMapType,
              myLocationEnabled: true,
              markers: markers,
              onCameraMove: _onCameraMove,
              initialCameraPosition: CameraPosition(
                target: center,
                zoom: 11.0,
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: new FloatingActionButton(
                  onPressed: _onMapTypeButtonPressed,
                  child: new Icon(
                    Icons.map,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onCameraMove(CameraPosition position) {
    centerPosition = position.target;
  }

  Future<LocationData> _getLocation() async {
    LocationData currentLocation;
    try {
      currentLocation = await location.getLocation();
    } catch (e) {
      currentLocation = null;
    }
    return currentLocation;
  }
}

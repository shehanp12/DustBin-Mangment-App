import 'dart:async';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:firebase_database/firebase_database.dart';

class DriverMap extends StatefulWidget {
  @override
  _DriverMapState createState() => _DriverMapState();
}

class _DriverMapState extends State<DriverMap> {
  StreamSubscription _locationSubscription;
  Location _locationTracker = Location();
  Marker marker;
  Circle circle;
  GoogleMapController _controller;
  String uid;
  var name;

  static final CameraPosition initialLocation = CameraPosition(
    target: LatLng(6.8211, 80.0409),
    zoom: 14.4746,
  );

  final DatabaseReference database =
      FirebaseDatabase.instance.reference().child("drivertest");

  Future<String> inputData(LocationData newLocalData) async {
    User user = FirebaseAuth.instance.currentUser;
    uid = user.uid.toString();

    LatLng latlng = LatLng(newLocalData.latitude, newLocalData.longitude);
    database.child(uid).set({
      "latitude": latlng.latitude,
      "longitude": latlng.longitude,
      "id": name,
    });
    print(name);

    return uid;
  }

  void updateMarkerAndCircle(LocationData newLocalData, Uint8List imageData) {
    LatLng latlng = LatLng(newLocalData.latitude, newLocalData.longitude);
    print(uid);
    this.setState(() {
      marker = Marker(
          markerId: MarkerId("home"),
          position: latlng,
          rotation: newLocalData.heading,
          draggable: false,
          zIndex: 2,
          flat: true,
          anchor: Offset(0.5, 0.5),
          icon: BitmapDescriptor.fromBytes(imageData));
      circle = Circle(
          circleId: CircleId("car"),
          radius: newLocalData.accuracy,
          zIndex: 1,
          strokeColor: Colors.blue,
          center: latlng,
          fillColor: Colors.blue.withAlpha(70));
    });
  }

  void getCurrentLocation() async {
    try {
      Uint8List imageData = await getMarker();
      var location = await _locationTracker.getLocation();

      updateMarkerAndCircle(location, imageData);

      if (_locationSubscription != null) {
        _locationSubscription.cancel();
      }

      _locationSubscription =
          _locationTracker.onLocationChanged.listen((newLocalData) {
        if (_controller != null) {
          _controller.animateCamera(CameraUpdate.newCameraPosition(
              new CameraPosition(
                  bearing: 192.8334901395799,
                  target: LatLng(newLocalData.latitude, newLocalData.longitude),
                  tilt: 0,
                  zoom: 14.00)));
          updateMarkerAndCircle(newLocalData, imageData);
          inputData(newLocalData);
        }
      });
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        debugPrint("Permission Denied");
      }
    }
  }

  Future<Uint8List> getMarker() async {
    ByteData byteData =
        await DefaultAssetBundle.of(context).load("assets/images/car.png");
    return byteData.buffer.asUint8List();
  }

  Future<String> setname() async {
    final User user = FirebaseAuth.instance.currentUser;
    uid = user.uid.toString();

    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("Drivers").doc(uid);
    documentReference.get().then((dataSnapshot) {
      if (dataSnapshot.exists) {
        // print(dataSnapshot.data['Bus Name'].toString());
        // name=dataSnapshot.data['Bus Name'].toString();
        getCurrentLocation();
      } else {
        print('loading');
      }
    });
    return name;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:GoogleMap(
          mapType: MapType.normal,
          compassEnabled: true,
          initialCameraPosition: initialLocation,
          markers: Set.of((marker != null) ? [marker] : []),
          circles: Set.of((circle != null) ? [circle] : []),
          onMapCreated: (GoogleMapController controller) {
            _controller = controller;
          }
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.location_searching),
          onPressed: () {
            setname();
          }),

    );
  }
}

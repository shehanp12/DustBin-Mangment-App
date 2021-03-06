import 'dart:async';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dustbin_mangment/screens/auth/authenticate.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:dustbin_mangment/utils/auth_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:dustbin_mangment/models/driver.dart';
import 'package:dustbin_mangment/utils/notifcation.dart';

class DriverMap extends StatefulWidget {

  @override

  _DriverMapState createState() => _DriverMapState();

}

class _DriverMapState extends State<DriverMap> {
  Driver driver;
  final AuthService _auth = AuthService();
  final NotifcationService _notifcationService = NotifcationService();
  StreamSubscription _locationSubscription;
  Location _locationTracker = Location();
  Marker marker;
  Circle circle;
  GoogleMapController _controller;
  String uid;
  var name;
  final User user = FirebaseAuth.instance.currentUser;
  // uid = user.uid.toString();


  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  @override
  void initState(){
   super.initState();

   _firebaseMessaging.configure(

     onMessage: (Map<String, dynamic> message) async {
       print("onMessage: $message");
       showDialog(
         context: context,
         builder: (context) => AlertDialog(
           content: ListTile(
             title: Text(message['notification']['title']),
             subtitle: Text(message['notification']['body']),
           ),
           actions: <Widget>[
             FlatButton(
               child: Text('Accepted'),
               onPressed: () => onAccepted(),
             ),
             FlatButton(
               child: Text('Rejected'),
               onPressed: () => onDeclined(),
             ),
           ],
         ),
       );
     },
   );

  }

  static final CameraPosition initialLocation = CameraPosition(
    target: LatLng(6.8211, 80.0409),
    zoom: 14.4746,
  );

  final DatabaseReference database =
      FirebaseDatabase.instance.reference().child("DriverLocation");

  Future<String> inputData(LocationData newLocalData) async {
    User user = FirebaseAuth.instance.currentUser;
    uid = user.uid.toString();

    LatLng latlng = LatLng(newLocalData.latitude, newLocalData.longitude);
    database.child(uid).set({
      "latitude": latlng.latitude,
      "longitude": latlng.longitude

    });

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

   void onAccepted(){
     Navigator.of(context).pop();
     _notifcationService.onAcceptNotifcation();


   }

   void onDeclined(){
    Navigator.of(context).pop();
    _notifcationService.onDeclineNotifcation();
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
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        elevation: 0,
        actions: <Widget>[
          FlatButton.icon(
            onPressed: () async {
              String uid =FirebaseAuth.instance.currentUser.uid.toString();
              print(uid);


              await _auth.signOut();



              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => Authenticate()));
            },
            icon: Icon(Icons.lock),
            label: Text('Logout',style: TextStyle(
              fontSize: 18,
              fontFamily: 'times-new-roman',
            ),),
          )
        ],
      ),
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
            getCurrentLocation();
          }),

    );
  }
}

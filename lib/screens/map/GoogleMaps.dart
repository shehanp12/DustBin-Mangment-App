// import 'dart:typed_data';
//
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:geoflutterfire/geoflutterfire.dart';
// import 'package:rxdart/rxdart.dart';
// import 'dart:async';
//
// class GoogleMaps extends StatefulWidget {
//   @override
//   _GoogleMapsState createState() => _GoogleMapsState();
// }
//
// class _GoogleMapsState extends State<GoogleMaps> {
//
//
//   static final CameraPosition _kInitialPosition = const CameraPosition(
//     target: LatLng(24.150, -110.32),
//     zoom: 10,
//   );
//
//   GoogleMapController mapController;
//   FirebaseFirestore firestore = FirebaseFirestore.instance;
//   Geoflutterfire geo = Geoflutterfire();
//   CameraPosition position = _kInitialPosition;
//   Location location = new Location();
//   // Stateful Data
//   BehaviorSubject<double> radius = BehaviorSubject.seeded(100);
//   Stream<dynamic> query;
//
//   // Subscription
//   StreamSubscription subscription;
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//         children: [
//           GoogleMap(
//               initialCameraPosition: CameraPosition(target: LatLng(24.150, -110.32), zoom: 8),
//               onMapCreated: _onMapCreated,
//               myLocationEnabled: true, // Add little blue dot for device location, requires permission from user
//               mapType: MapType.normal,
//               onCameraMove: _updateCameraPosition,
//           ),
//           Positioned(
//               bottom: 100,
//               right: 10,
//               child:
//               FlatButton(
//                   child: Icon(Icons.pin_drop),
//                   color: Colors.green,
//                   onPressed: () => _addGeoPoint()
//               )
//           )
//         ]
//
//     );
//   }
//
//   Future<Uint8List> getMarker() async {
//     ByteData byteData =
//     await DefaultAssetBundle.of(context).load("images/car.png");
//     return byteData.buffer.asUint8List();
//   }
//
//   Future<String> inputData(LocationData newLocalData) async {
//     final FirebaseUser user = await FirebaseAuth.instance.currentUser();
//     uid = user.uid.toString();
//
//
//
//     LatLng latlng = LatLng(newLocalData.latitude, newLocalData.longitude);
//     database.child(uid).set({
//       "latitude":latlng.latitude,
//       "longitude":latlng.longitude,
//       "id":name,
//     });
//     print(name);
//
//     return uid;
//   }
//
//
//   _addMarker(){
//     var marker = Marker(
//       position:_kInitialPosition.target, markerId: null,
//       icon:BitmapDescriptor.defaultMarker,
//       infoWindow: InfoWindow()
//     );
//
//   }
//
//   void _updateCameraPosition(CameraPosition position) {
//     setState(() {
//       position = position;
//     });
//   }
//
//   void _onMapCreated(GoogleMapController controller) {
//     setState(() {
//       mapController = controller;
//     });
//   }
//
//   _startQuery() async {
//
//     //Get users Location
//     var pos = await location.getLocation();
//     double lat = pos.latitude;
//     double lng = pos.longitude;
//
//
//     // Make a referece to firestore
//     var ref = firestore.collection('locations');
//     GeoFirePoint center = geo.point(latitude: lat, longitude: lng);
//
//     // subscribe to query
//     // subscription = radius.switchMap((rad) {
//     //   return geo.collection(collectionRef: ref).within(
//     //       center: center,
//     //       radius: rad,
//     //       field: 'position',
//     //       strictMode: true
//     //   );
//     // }).listen(_updateMarkers);
//
//   }
//
//
//
//   // Set GeoLocation Data
//   Future<DocumentReference> _addGeoPoint() async {
//     var pos = await location.getLocation();
//     GeoFirePoint point = geo.point(latitude:pos.latitude, longitude: pos.longitude);
//     return firestore.collection('locations').add({
//       'position': point.data,
//       'name': 'Yay I can be queried!'
//     });
//   }
//
//
//
//
//
// }
//
//

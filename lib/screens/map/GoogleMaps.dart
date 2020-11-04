import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:map_controller/map_controller.dart';

class GoogleMaps extends StatefulWidget {
  @override
  _GoogleMapsState createState() => _GoogleMapsState();
}

class _GoogleMapsState extends State<GoogleMaps> {


  static final CameraPosition _kInitialPosition = const CameraPosition(
    target: LatLng(24.150, -110.32),
    zoom: 10,
  );

  GoogleMapController mapController;
  CameraPosition position = _kInitialPosition;
  Location location = new Location();
  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
          GoogleMap(
              initialCameraPosition: CameraPosition(target: LatLng(24.150, -110.32), zoom: 10),
              onMapCreated: _onMapCreated,
              myLocationEnabled: true, // Add little blue dot for device location, requires permission from user
              mapType: MapType.normal,
              onCameraMove: _updateCameraPosition,
          ),
          Positioned(
              bottom: 100,
              right: 10,
              child:
              FlatButton(
                  child: Icon(Icons.pin_drop),
                  color: Colors.green,
                  onPressed: () => _addMarker()
              )
          )
        ]

    );
  }


  _addMarker(){
    var marker = Marker(
      position:_kInitialPosition.target, markerId: null,
      icon:BitmapDescriptor.defaultMarker,
      infoWindow: InfoWindow()
    );

  }








  void _updateCameraPosition(CameraPosition position) {
    setState(() {
      position = position;
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
  }


}



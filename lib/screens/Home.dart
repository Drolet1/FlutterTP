import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  GoogleMapController? mapController;
  final LatLng _center = const LatLng(45.521563, -122.677433);
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Set<Marker> _createMarker(){
    return <Marker>[
      Marker(
          markerId: MarkerId('home'),
          position: LatLng(45.521563, -122.677433),
          icon: BitmapDescriptor.defaultMarker,
          infoWindow: InfoWindow(title: 'Current Location')
      )
    ].toSet();
  }

  Set<Circle> _circles = Set.from([Circle(
    circleId: CircleId('Infection'),
    center: LatLng(45.521563, -122.677433),
    radius: 450,
    strokeColor: Colors.pinkAccent
  )]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map COVID-19 Tracker'),
      ),
      body: GoogleMap(
        markers: _createMarker(),
        circles: _circles,
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 14.0
        ),
      ),
    );
  }
}

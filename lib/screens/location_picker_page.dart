import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationPickerPage extends StatefulWidget {
  const LocationPickerPage({super.key});
  @override
  _LocationPickerPageState createState() => _LocationPickerPageState();
}

class _LocationPickerPageState extends State<LocationPickerPage> {
  static const LatLng _schoolLocation = LatLng(24.0071748, 38.2086885);
  final Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(
          target: _schoolLocation, zoom: 21
        ),
        minMaxZoomPreference: const MinMaxZoomPreference(21, 21),
        markers: {
          Marker(
            markerId: const MarkerId('school'),
            position: _schoolLocation,
            infoWindow: const InfoWindow(
              title: 'مدرسة دار البلاغة الأهلية',
            ),
          ),
        },
        onMapCreated: (ctrl) {
          _controller.complete(ctrl);
          // After 10 seconds, move to video page
          Timer(const Duration(seconds: 10), () {
            Navigator.pushReplacementNamed(context, '/video');
          });
        },
      ),
    );
  }
}

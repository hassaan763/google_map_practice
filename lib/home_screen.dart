import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  Completer<GoogleMapController> _controller=Completer();
  static final CameraPosition _kGooglePlex=CameraPosition(
      target:LatLng(33.9787977, 71.4263946
        ),
      zoom: 14.4746);

  List <Marker> _markers=[];
  final List<Marker> _Markerlist=[
    Marker(
      infoWindow: InfoWindow(
        title: 'Your Location',

      ),
        markerId: MarkerId('1'),
      position: LatLng(
          33.9787977,
          71.4263946
      ),
    ),
    Marker(
      infoWindow: InfoWindow(
        title: 'marker2',

      ),
      markerId: MarkerId('2'),
      position: LatLng(
          33.9787979,
          71.4263945
      ),
    )
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _markers.addAll(_Markerlist);
  }


  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GoogleMap(
          initialCameraPosition: _kGooglePlex,
          mapType: MapType.normal,
          zoomControlsEnabled: true,
          myLocationButtonEnabled: true,
          markers: Set<Marker>.of(_markers),
          onMapCreated: (GoogleMapController controller)
          {
            _controller.complete(controller);
          },
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 100),
          child: FloatingActionButton(
            child: Icon(
                Icons.my_location
            ),
            onPressed: ()async{
              setState(() {});
              GoogleMapController controller = await _controller.future;
              controller.animateCamera(
                  CameraUpdate.newCameraPosition(
                      CameraPosition(
                        target: LatLng(33.9787979, 71.4263945),
                        zoom: 14,
                      )));}
      ),
        ), //get location button

      ),
    );
  }
}

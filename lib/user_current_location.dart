import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class UserCurrentLocation extends StatefulWidget {
  const UserCurrentLocation({super.key});

  @override
  State<UserCurrentLocation> createState() => _UserCurrentLocationState();
}

class _UserCurrentLocationState extends State<UserCurrentLocation> {

  final Completer<GoogleMapController> _controller =Completer();

  loadData(){getUserCurrentLocation().then((value)async {
    print(value.accuracy.toString());
    print(value.latitude.toString());
    print(value.longitude.toString());

    _markers.add(
        Marker(
            position: LatLng(value.latitude,value.longitude),
            infoWindow: InfoWindow(
                title: 'My current Location'
            ),
            markerId: MarkerId('1')
        )
    );
    CameraPosition cameraPosition =CameraPosition(
        zoom: 14,
        target: LatLng(value.latitude, value.longitude));

    final GoogleMapController controller= await _controller.future;

    controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

    setState(() {});

  });}
  Future<Position>getUserCurrentLocation()async{
   await Geolocator.requestPermission().then((value) {

   }).onError((error, stackTrace) {
     print('error'+error.toString());
   });
  return await Geolocator.getCurrentPosition();
  }

  static const CameraPosition _kGoogleplex = CameraPosition(
      target: LatLng(
          33.9787977, 71.4263946
      )
  );

  final List<Marker>_markers=  <Marker>[
    Marker(
        infoWindow: InfoWindow(
            title: 'my location'),
        position: LatLng(33.9787977, 71.4263946),
        markerId: MarkerId('1')
    )
    

  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: _kGoogleplex,
        markers: Set<Marker>.of(_markers),
        onMapCreated: (GoogleMapController controller){
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: (){
            getUserCurrentLocation().then((value)async {
              print(value.accuracy.toString());
              print(value.latitude.toString());
              print(value.longitude.toString());

              _markers.add(
                  Marker(
                      position: LatLng(value.latitude,value.longitude),
                      infoWindow: InfoWindow(
                          title: 'My current Location'
                      ),
                      markerId: MarkerId('1')
                  )
              );
              CameraPosition cameraPosition =CameraPosition(
                  zoom: 14,
                  target: LatLng(value.latitude, value.longitude));

              final GoogleMapController controller= await _controller.future;

              controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

              setState(() {});

            });
          },
              child: Icon(Icons.location_searching),
      ),
    );
  }
}

import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class CustomWindowScreen extends StatefulWidget {
  const CustomWindowScreen({super.key});
  @override
  State<CustomWindowScreen> createState() => _CustomWindowScreenState();
}

class _CustomWindowScreenState extends State<CustomWindowScreen> {

  CustomInfoWindowController _customInfoWindowController =CustomInfoWindowController();
  final List<Marker> _markers = <Marker>[];
  final List<LatLng> _latlong= <LatLng>[
    LatLng(37.7749, -122.4194), LatLng(34.0522, -118.2437), LatLng(36.1699, -115.1398),
    LatLng(36.1069, -112.1129), LatLng(34.8697, -111.7610),LatLng(35.1983, -111.6513)];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  loadData(){
    for(int i=0;i< _latlong.length;i++){
      _markers.add(
          Marker(
            onTap: (){
              _customInfoWindowController.addInfoWindow!(
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                    ],
                  ),
                  height: 200,
                  width: 300,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white)
                  ),
                ),
                _latlong[i]
              );
            },
            position: _latlong[i],
            icon: BitmapDescriptor.defaultMarker,
              markerId: MarkerId(i.toString())
          )
      );
    }
    setState(() {

    });

  }



  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Custom info screen'),
        backgroundColor: Colors.red,
      ),
      body: Stack(
        children: [
          GoogleMap(
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            zoomControlsEnabled: true,
            initialCameraPosition: CameraPosition(
                zoom: 14,
                target: LatLng(37.7749, -122.4194)
            ),
            markers: Set.of(_markers),
              onTap: (position){
              _customInfoWindowController.hideInfoWindow!();

              },
            onCameraMove: (position){
              _customInfoWindowController.onCameraMove!();
            },
              onMapCreated: (GoogleMapController controller){
              _customInfoWindowController.googleMapController=controller;
              },

          ),
          CustomInfoWindow(

            offset: 35,
            width: 100,
            height: 100,
              controller: _customInfoWindowController
          )
        ],
      ),
    );
  }
}

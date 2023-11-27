import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';


class CustomMarkersScreen extends StatefulWidget {
  const CustomMarkersScreen({super.key});

  @override
  State<CustomMarkersScreen> createState() => _CustomMarkersScreenState();
}

class _CustomMarkersScreenState extends State<CustomMarkersScreen> {

  Uint8List? markerImage;
  final Completer<GoogleMapController>_controller=Completer();
  List<String> images = ['assets/pictures/car.png', 'assets/pictures/car (1).png', 'assets/pictures/car (2).png',
    'assets/pictures/cargo-truck.png','assets/pictures/delivery-truck.png','assets/pictures/sports-car.png'];
  final List<Marker> _markers =<Marker>[];
  final List<LatLng> _latlong= <LatLng>[
    LatLng(37.7749, -122.4194), LatLng(34.0522, -118.2437), LatLng(36.1699, -115.1398),
    LatLng(36.1069, -112.1129), LatLng(34.8697, -111.7610),LatLng(35.1983, -111.6513)];
  static const CameraPosition _kGooglePlex = CameraPosition(
      zoom: 14,
      target: LatLng(37.7749, -122.4194)
  );

  Future<Uint8List> getBytesFromAssets(String path,int width)async{
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),targetHeight: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();

  }
  void initState() {
    // TODO: implement initState
    super.initState();

    loadData();
  }
  loadData()async {
    for (int i = 0; i < images.length; i++) {
      final Uint8List markerIcon = await getBytesFromAssets(
          images[i].toString(), 100);
      _markers.add
        (Marker(
          icon: BitmapDescriptor.fromBytes(markerIcon),
          infoWindow: InfoWindow(title: 'marker number is ' + i.toString()),
          position: _latlong[i],
          markerId: MarkerId(i.toString())
      ));
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        
        body:GoogleMap(
          zoomControlsEnabled: true,
          mapType: MapType.normal,
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            initialCameraPosition: _kGooglePlex,
          markers: Set.of(_markers),
          onMapCreated: (GoogleMapController controller){
            _controller.complete(controller);
      },
            
        )
      ),
    );
  }
}

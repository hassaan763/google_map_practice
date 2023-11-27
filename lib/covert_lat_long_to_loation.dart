import 'package:flutter/material.dart';
import 'package:geocoder2/geocoder2.dart';

class ConverLatLongScreen extends StatefulWidget {
  const ConverLatLongScreen({super.key});

  @override
  State<ConverLatLongScreen> createState() => _ConverLatLongScreenState();
}

class _ConverLatLongScreenState extends State<ConverLatLongScreen> {

  String address='';
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('check your location'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          Text(address),
          GestureDetector(
            onTap: ()async{
              GeoData coordinates = await Geocoder2.getDataFromCoordinates(
                  latitude: 33.9787977,
                  longitude: 71.4263946,
                  googleMapApiKey: "AIzaSyBNuQaqHFYOQzZkJ9Q1VH7e3zIbLov5TaY");
              setState(() {
                address= coordinates.address.toString();
              });

              },
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.green
                ),
                height: 50,
                child: Center(
                  child: Text('Convert'),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

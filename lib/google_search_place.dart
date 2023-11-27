import 'dart:convert';
import 'package:geocoder2/geocoder2.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart'as http;
class GoogleSearchLocation extends StatefulWidget {
  const GoogleSearchLocation({super.key});

  @override
  State<GoogleSearchLocation> createState() => _GoogleSearchLocationState();
}

class _GoogleSearchLocationState extends State<GoogleSearchLocation> {

  TextEditingController _textcontoller = TextEditingController();
  var uuid=Uuid();
  String _sessionToken = '12234';
  List<dynamic> _placeslist= [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _textcontoller.addListener(() {
      onchange();
    });
  }
  void onchange(){
    if(_sessionToken==null){
      setState(() {
        _sessionToken=uuid.v4();
      });
    }else{
      getSuggestion(_textcontoller.text);
    }
  }
  void getSuggestion(String input)async{
    String gPlaces_Api_key = "AIzaSyBNuQaqHFYOQzZkJ9Q1VH7e3zIbLov5TaY";
    String baseURL = 'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request = '$baseURL?input=$input&key=$gPlaces_Api_key&sessiontoken=$_sessionToken';

    var response = await http.get(Uri.parse(request));
    var data = response.body.toString();

    print(data);
    if(response.statusCode==200){
      setState(() {
        _placeslist=jsonDecode(response.body.toString())['predictions'];
      });
    }else{
      throw Exception('failed to load data');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('search your place'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Column(
          children: [
            TextFormField(
              controller: _textcontoller,
              decoration: InputDecoration(
                hintText: 'search places with names',

              ),
            ),
            Expanded(child: ListView.builder(
                itemCount: _placeslist.length,
                itemBuilder: (context,index){
                  return ListTile(
                    onTap: ()async{
                      GeoData coordinates = await Geocoder2.getDataFromAddress(address: _placeslist[index]['description'], googleMapApiKey: 'AIzaSyBNuQaqHFYOQzZkJ9Q1VH7e3zIbLov5TaY');
                      print(coordinates.longitude);
                      print(coordinates.latitude);
                    },
                    title: Text(_placeslist[index]['description']),
                  );
                }
                )
            )
          ],
        ),
      ),
    );
  }
}

import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:google_map_practice/covert_lat_long_to_loation.dart';
import 'package:google_map_practice/custom_info_window.dart';
import 'package:google_map_practice/custom_markers_on_map.dart';
import 'package:google_map_practice/google_search_place.dart';
import 'package:google_map_practice/home_screen.dart';
import 'package:google_map_practice/user_current_location.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'practice',
      theme: ThemeData(),
      home: CustomWindowScreen(),
    );
  }
}

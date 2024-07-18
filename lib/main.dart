import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:map_application/GoogleMap/G_Map.dart';
import 'package:map_application/GoogleMap/map.dart';

import 'package:map_application/GoogleMap/google_map.dart';
import 'package:map_application/GoogleMap/map_inAppWebview.dart';
import 'package:map_application/homescreen.dart';
import 'package:map_application/mapscreen.dart';
import 'package:map_application/vehicle_routes/mini_bus_routes.dart';

import 'package:map_application/view/SplashScreen.dart';

void main() {
  runApp(MyApp());
}



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Mini_busRoutes(),
    );
  }
}





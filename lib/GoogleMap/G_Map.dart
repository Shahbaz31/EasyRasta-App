import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class G_map extends StatefulWidget {
  @override
  _G_mapState createState() => _G_mapState();
}

class _G_mapState extends State<G_map> {



  late GoogleMapController _controller;
  final Set<Marker> _markers = {
    Marker(
      markerId: MarkerId('KARACHI'),
      position: LatLng(24.8607, 67.0011),
      infoWindow: InfoWindow(
        title: 'KARACHI',
        snippet: 'City of Lights',
      ),
    ),
    Marker(
      markerId: MarkerId('ISLAMABAD'),
      position: LatLng(33.6844, 73.0479),
      infoWindow: InfoWindow(
        title: 'ISLAMABAD',
        snippet: 'Beauty of Pakistan',
      ),
    ),
    Marker(
      markerId: MarkerId('QUETTA'),
      position: LatLng(30.1798, 66.9750),
      infoWindow: InfoWindow(
        title: 'QUETTA',
        snippet: 'Fruit Garden of Pakistan',
      ),
    ),
    Marker(
      markerId: MarkerId('LAHORE'),
      position: LatLng(31.5497, 74.3436),
      infoWindow: InfoWindow(

        title: 'LAHORE',
        snippet: 'The Heart of Punjab',
        onTap: (){},
      )
    ),
    Marker(
      markerId: MarkerId('PESHAWAR'),
      position: LatLng(30.3753, 69.3451),
      infoWindow: InfoWindow(
        title: 'PESHAWAR',
        snippet: 'City of Fragrances and Spices',
        onTap: (){

        }
      ),
    ),
  };

  void _onMapCreated(GoogleMapController controller) {
    _controller = controller;
  }

  void _zoomIn() {
    _controller.animateCamera(CameraUpdate.zoomIn());
  }

  void _zoomOut() {
    _controller.animateCamera(CameraUpdate.zoomOut());
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Google Map',style: TextStyle(color: Colors.black,fontSize: 20),),
      backgroundColor: Colors.white,

      elevation: 0,
      ),
      body: GoogleMap(
        zoomControlsEnabled: false,
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: LatLng(30.3753, 69.3451),
          zoom: 7.0,
        ),
        markers: _markers,
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: _zoomIn,
            tooltip: 'Zoom In',
            child: Icon(Icons.add, color: Colors.white),
            backgroundColor: Colors.blue,
          ),
          SizedBox(height: 7
          ),
          FloatingActionButton(
            onPressed: _zoomOut,
            tooltip: 'Zoom Out',
            child: Icon(Icons.remove ,color: Colors.white

              , ),
            backgroundColor: Colors.blue
            ,
          ),
        ],

      ),
    );
  }
}


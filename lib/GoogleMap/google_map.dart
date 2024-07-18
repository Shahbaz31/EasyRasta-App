import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GMap extends StatefulWidget {
  @override
  _GMapState createState() => _GMapState();
}

class _GMapState extends State<GMap> {
  late GoogleMapController _controller;
  TextEditingController _sourceController = TextEditingController();
  TextEditingController _destinationController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller = controller;
  }

  void _zoomIn() {
    _controller.animateCamera(CameraUpdate.zoomIn());
  }

  void _zoomOut() {
    _controller.animateCamera(CameraUpdate.zoomOut());
  }

  void _showRoute() {
    // Implement code to show route between source and destination
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Track The Route',
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _sourceController,
                    decoration: InputDecoration(
                      labelText: 'Source',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _destinationController,
                    decoration: InputDecoration(
                      labelText: 'Destination',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white// Background color
                  ),
                  onPressed: _showRoute,
                  child: IconButton(onPressed: (){
                    print('Going hahaha');
                  }, icon: Icon(Icons.arrow_forward,)),
                ),
              ),
            ],
          ),
          Expanded(
            child: GoogleMap(
              zoomControlsEnabled: false,
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: LatLng(30.3753, 69.3451),
                zoom: 7.0,
              ),
              markers: Set<Marker>(),
            ),
          ),
        ],
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
          SizedBox(height: 7),
          FloatingActionButton(
            onPressed: _zoomOut,
            tooltip: 'Zoom Out',
            child: Icon(
              Icons.remove,
              color: Colors.white,
            ),
            backgroundColor: Colors.blue,
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';


void main() => runApp(MapScreen());

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;
  TextEditingController sourceController = TextEditingController();
  TextEditingController destinationController = TextEditingController();
  late LocationData currentLocation;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Google Maps with Route Planning'),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () async {
                Prediction p = await PlacesAutocomplete.show(
                  context: context,
                  apiKey: "YOUR_GOOGLE_MAPS_API_KEY",
                  language: "en",
                );
                if (p != null) {
                  // Handle selected place from search
                  _handleSelectedPlace(p);
                }
              },
            ),
          ],
        ),
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: LatLng(currentLocation.latitude, currentLocation.longitude),
            zoom: 15.0,
          ),
          myLocationEnabled: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _drawRoute();
          },
          child: Icon(Icons.directions),
        ),
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
  }

  void _getCurrentLocation() async {
    var location = Location();
    currentLocation = await location.getLocation();
    setState(() {});
  }

  void _searchLocation(String textController) async {
    List<Location> locations = await locationFromAddress(textController);
    if (locations.isNotEmpty) {
      mapController.animateCamera(CameraUpdate.newLatLng(LatLng(locations.first.latitude, locations.first.longitude)));
      mapController.addMarker(Marker(
        markerId: MarkerId(textController),
        position: LatLng(locations.first.latitude, locations.first.longitude),
        infoWindow: InfoWindow(title: textController),
      ));
    }
  }

  void _handleSelectedPlace(Prediction p) async {
    PlacesDetailsResponse detail = await PlacesApiProvider(
      'Google-API-Key',
    ).getDetailsByPlaceId(p.placeId);

    double latitude = detail.result.geometry.location.lat;
    double longitude = detail.result.geometry.location.lng;

    mapController.animateCamera(CameraUpdate.newLatLng(LatLng(latitude, longitude)));

    mapController.addMarker(Marker(
      markerId: MarkerId(p.placeId),
      position: LatLng(latitude, longitude),
      infoWindow: InfoWindow(title: p.description),
    ));
  }

  void _drawRoute() async {
    List<Location> sourceLocations = await locationFromAddress(sourceController.text);
    List<Location> destLocations = await locationFromAddress(destinationController.text);

    // Add markers for source and destination
    mapController.clearMarkers();
    mapController.addMarker(Marker(
      markerId: MarkerId('source'),
      position: LatLng(sourceLocations.first.latitude, sourceLocations.first.longitude),
      infoWindow: InfoWindow(title: 'Source'),
    ));
    mapController.addMarker(Marker(
      markerId: MarkerId('destination'),
      position: LatLng(destLocations.first.latitude, destLocations.first.longitude),
      infoWindow: InfoWindow(title: 'Destination'),
    ));

    // Get directions using a service like Google Directions API
    // Extract the polyline points from the result

    // Add a Polyline to the map
    mapController.addPolyline(Polyline(
      polylineId: PolylineId('route'),
      points: polylinePoints.map((point) => LatLng(point.latitude, point.longitude)).toList(),
      color: Colors.blue,
      width: 5,
    ));
  }
}

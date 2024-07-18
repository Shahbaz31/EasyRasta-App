// import 'package:flutter_map/flutter_map.dart';
// import 'package:latlong2/latlong.dart';
// import 'package:autocomplete_textfield/autocomplete_textfield.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
//
// import 'package:flutter/material.dart';
//
// class Product {
//   final String name;
//   final String description;
//   final double price;
//
//   Product({required this.name, required this.description, required this.price});
// }
//
// class MapScreen extends StatefulWidget {
//   @override
//   _MapScreenState createState() => _MapScreenState();
// }
//
// class _MapScreenState extends State<MapScreen> {
//   final MapController mapController = MapController();
//   TextEditingController searchController = TextEditingController();
//
//   List<Product> products = [
//     Product(name: 'Karachi', description: 'City in Pakistan', price: 10.0),
//     Product(name: 'Lahore', description: 'City in Pakistan', price: 20.0),
//     Product(name: 'Islamabad', description: 'City in Pakistan', price: 30.0),
//     Product(name: 'Quetta', description: 'City in Pakistan', price: 30.0),
//     Product(name: 'Faisalabad', description: 'City in Pakistan', price: 30.0),
//     Product(name: 'Rawal Pindi', description: 'City in Pakistan', price: 30.0),
//   ];
//
//   Product? selectedProduct;
//
//   Future<LatLng?> _getCoordinates(String cityName) async {
//     final response = await http.get(Uri.parse(
//         'https://nominatim.openstreetmap.org/search?format=json&q=$cityName'));
//
//     if (response.statusCode == 200) {
//       final List<dynamic> data = json.decode(response.body);
//
//       if (data.isNotEmpty) {
//         return LatLng(
//           double.parse(data[0]['lat']),
//           double.parse(data[0]['lon']),
//         );
//       }
//     }
//
//     return null;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(4.0),
//             child: AutoCompleteTextField<Product>(
//               key: GlobalKey(),
//               clearOnSubmit: false,
//               suggestions: products,
//               itemBuilder: (context, suggestion) => ListTile(
//                 title: Text(suggestion.name),
//                 subtitle: suggestion.description != null
//                     ? Text(
//                   '${suggestion.description!} - \$${suggestion.price}',
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                 )
//                     : Text('\$${suggestion.price}'),
//               ),
//               itemFilter: (suggestion, query) =>
//                   suggestion.name.toLowerCase().contains(query.toLowerCase()),
//               itemSorter: (a, b) => a.name.compareTo(b.name),
//               itemSubmitted: (item) async {
//                 LatLng? coordinates = await _getCoordinates(item.name);
//                 if (coordinates != null) {
//                   setState(() {
//                     selectedProduct = item;
//                     mapController.move(coordinates, 13.0);
//                   });
//                 }
//               },
//               decoration: InputDecoration(
//                 hintText: 'Search for a city...',
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(20)
//                 ),
//               ),
//             ),
//           ),
//           Expanded(
//             flex: 3,
//             child: FlutterMap(
//               mapController: mapController,
//               options: MapOptions(
//                 initialCenter: LatLng(24.8607, 67.0011), // Default to Karachi's coordinates
//                 initialZoom: 5.0,
//               ),
//               children: [
//                 TileLayer(
//                   urlTemplate:
//                   "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
//                   subdomains: ['a', 'b', 'c'],
//                 ),
//                 if (selectedProduct != null)
//                   MarkerLayer(
//                     markers: [
//                       Marker(
//                         width: 30.0,
//                         height: 30.0,
//                         point: mapController.camera.center,
//                         child: Container(
//                           child: Icon(
//                             Icons.location_pin,
//                             color: Colors.red,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
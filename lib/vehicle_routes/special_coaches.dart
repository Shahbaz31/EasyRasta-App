import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../GoogleMap/google_map.dart';


class Special_Coaches_Route extends StatefulWidget {
  const Special_Coaches_Route({super.key});

  @override
  State<Special_Coaches_Route> createState() => _Special_Coaches_RouteState();
}

class _Special_Coaches_RouteState extends State<Special_Coaches_Route> {

  List _items = [];
  TextEditingController _sourceController = TextEditingController();
  TextEditingController _destinationController = TextEditingController();
  List<String>? output;
  String errorMessage = '';

  Future<void> findBusRoutes() async {
    String source = _sourceController.text.toLowerCase().trim();
    String destination = _destinationController.text.toLowerCase().trim();

    final String response =
    await rootBundle.loadString('jsondata/Special_Coaches_Routes.json');
    final data = json.decode(response);

    setState(() {
      _items = data["items"];
      output = null; // Reset output
      errorMessage = ''; // Reset error message
    });

    if (source.isEmpty || destination.isEmpty) {
      setState(() {
        errorMessage = 'Please enter both source and destination.';
      });
      return;
    }

    bool routeFound = false;

    for (var item in _items) {
      String itemSource = item["SOURCE"].toLowerCase();
      String itemDestination = item["DESTINATION"].toLowerCase();

      // Check if the entered text is contained in the source and destination
      if (itemSource.contains(source) && itemDestination.contains(destination)) {
        setState(() {
          output = List<String>.from(item["OUTPUT"]);
          errorMessage = ''; // Reset error message
        });
        routeFound = true;
        break; // Exit the loop once a match is found
      }
    }

    if (!routeFound) {
      setState(() {
        output = null;
        errorMessage = 'No matching route found.';
      });
    }

    // Unfocus the text fields after finding bus routes
    FocusScope.of(context).unfocus();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        title: Text('Special Coaches Routes'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: ListView(
          children: [
            TextField(
              controller: _sourceController,
              decoration: InputDecoration(
                labelText: 'Enter Source',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 30),
            TextField(
              controller: _destinationController,
              decoration: InputDecoration(
                labelText: 'Enter Destination',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                ),
                onPressed: findBusRoutes,
                child: const Text('Find Bus Routes'),
              ),
            ),
            if (errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  errorMessage,
                  style: TextStyle(color: Colors.red),
                ),
              ),
            const SizedBox(height: 30),
            if (output != null)
              Column(
                children: output!.map((bus) {
                  return Card(
                    margin: const EdgeInsets.all(10),
                    color: Colors.amber.shade100,
                    child: ListTile(
                      title: Text(
                        bus,
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: IconButton(onPressed: (){
                        Navigator.push((context),MaterialPageRoute(builder: (context)=>GMap()));
                      },
                        icon: Icon(Icons.call_made_sharp,color: Colors.blue,size: 30,),
                      ),
                    ),
                  );
                }).toList(),
              ),
          ],
        ),
      ),
    );;
  }
}

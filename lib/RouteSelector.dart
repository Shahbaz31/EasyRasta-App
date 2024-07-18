import 'package:flutter/material.dart';
import 'package:map_application/GoogleMap/G_Map.dart';
import 'package:map_application/vehicle_routes/GreenBuses.dart';
import 'package:map_application/vehicle_routes/RED%20Line%20BusRoutes.dart';
import 'package:map_application/vehicle_routes/mini_bus_routes.dart';
import 'package:map_application/vehicle_routes/operative_bus.dart';
import 'package:map_application/vehicle_routes/special_coaches.dart';


class selectroutes extends StatefulWidget {
  const selectroutes({super.key});

  @override
  State<selectroutes> createState() => _selectroutesState();
}

class _selectroutesState extends State<selectroutes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 15,
            ),
            Text(
              'Select any route',
              style: TextStyle(

                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> HomePage()));
                },
                child: buildContainer('Red line Bus Routes', Colors.amber.shade100)),
            SizedBox(
              height: 15,
            ),
            GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> Greenline_route()));
                },
                child: buildContainer('Green line Bus Routes', Colors.amber.shade200)),
            SizedBox(
              height: 15,
            ),
            GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> Mini_busRoutes()));
                },
                child: buildContainer('Mini Bus Routes', Colors.amber.shade300,)),
            // Add more containers as needed
            SizedBox(
              height: 15,
            ),
            GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> Operative_buses()));
                },
                child: buildContainer('Operative Bus Routes', Colors.amber.shade400,)),

            SizedBox(
              height: 15,
            ),
            GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> Special_Coaches_Route()));
                },
                child: buildContainer('Special Coaches Routes', Colors.amber.shade400,)),
          ],
        ),
      ),
    );
  }

  Widget buildContainer(String routeName, Color color) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        title: Text(routeName),
      ),
    );
  }
}

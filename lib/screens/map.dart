import 'package:countries_world_map/data/maps/world_map.dart';
import 'package:flutter/material.dart';
import 'package:countries_world_map/countries_world_map.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: IntrinsicWidth(
                child: Row(
                  children: [
                    Container(
                      color: const Color(0xFF3A7BD5),
                      height: 800,
                      width: 320,
                      child: const Center(
                          child: Text("Swipe left to View Culinary Compass",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600))),
                    ),
                    const SizedBox(width: 60),
                    InteractiveViewer(
                      child: SimpleMap(
                        countryBorder:
                            const CountryBorder(color: Color(0xFF14213D)),
                        instructions: SMapWorld.instructions,
                        defaultColor: Colors.blue.shade100,
                        callback: (id, name, tapDetails) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Tapped on: $id'),
                              duration: const Duration(seconds: 1),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

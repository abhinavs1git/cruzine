import 'package:countries_world_map/data/maps/world_map.dart';
import 'package:flutter/material.dart';
import 'package:countries_world_map/countries_world_map.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  String? selectedCountry;
  List<Map<String, String>> dishes = [];

  // Mock API response (replace this with your API integration)
  final Map<String, List<Map<String, String>>> countryDishes = {
    "us": [
      {"name": "Burger", "image": "https://via.placeholder.com/150"},
      {"name": "Hot Dog", "image": "https://via.placeholder.com/150"},
      {"name": "Pani Puri", "image": "https://via.placeholder.com/150"},
      {"name": "Butter Chicken", "image": "https://via.placeholder.com/150"},
      {"name": "Rasgulla", "image": "https://via.placeholder.com/150"},
      {"name": "Gulab Jamun", "image": "https://via.placeholder.com/150"},
    ],
    "in": [
      {"name": "Biriyani", "image": "https://via.placeholder.com/150"},
      {"name": "Dosa", "image": "https://via.placeholder.com/150"},
      {"name": "Pani Puri", "image": "https://via.placeholder.com/150"},
      {"name": "Butter Chicken", "image": "https://via.placeholder.com/150"},
      {"name": "Rasgulla", "image": "https://via.placeholder.com/150"},
      {"name": "Gulab Jamun", "image": "https://via.placeholder.com/150"},
    ],
  };

  void fetchDishes(String id) {
    setState(() {
      selectedCountry = id;
      dishes = countryDishes[id] ?? [];
    });
  }

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
                          fetchDishes(id);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (selectedCountry != null)
            Expanded(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    color: const Color(0xFF14213D),
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        'Dishes from $selectedCountry',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GridView.builder(
                      padding: const EdgeInsets.all(18),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 0.8,
                      ),
                      itemCount: dishes.length.clamp(0, 6),
                      itemBuilder: (context, index) {
                        final dish = dishes[index];
                        return Card(
                          elevation: 4,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Image.network(
                                  dish["image"]!,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  dish["name"]!,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            )
        ],
      ),
    );
  }
}

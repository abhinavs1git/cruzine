import 'package:cruzine/api_manager/api_manager.dart';
import 'package:flutter/material.dart';
import '../widgets/flipcard.dart'; // Import your FlippableCard widget

class VaultPage extends StatefulWidget {
  final bool isPro;

  const VaultPage({super.key, required this.isPro});

  @override
  _VaultPageState createState() => _VaultPageState();
}

class _VaultPageState extends State<VaultPage> {
  List<Map<String, String>> dishes = [];

  List<String> dishOfTheDay = [];

  Future<void> dotd() async {
    try {
      List<dynamic> rawDishes = await rotd();  // Fetch the raw data

      // Print the raw data to inspect the structure
      print("Raw Dishes: $rawDishes");

      // Safely check if the data is a List of Lists
      if (rawDishes is List) {
        List<String> fetchedDishes = [];
        for (var item in rawDishes) {
          fetchedDishes.add(item.toString());
        }
        setState(() {
          dishOfTheDay = fetchedDishes; // Update the state with the correctly typed data
        });
      } else {
        print("Expected a List but got: ${rawDishes.runtimeType}");
      }
    } catch (error) {
      print("Error fetching dishes: $error");
      // Handle the error, e.g., show a message to the user
    }
  }

  Future<void> fetchDishes() async {
    try {
      List<dynamic> rawDishes = await getDishs();  // Fetch the raw data

      // Convert rawDishes to List<List<String>>
      List<List<String>> fetchedDishes = rawDishes.map((item) {
        return (item as List<dynamic>).map((subItem) => subItem.toString()).toList();
      }).toList();

      setState(() {
        // Convert List<List<String>> to List<Map<String, String>> for your grid display
        dishes = fetchedDishes.map((dish) {
          return {
            'id': dish[3],
            'image': dish[1],  // Assuming image is at index 0
            'name': dish[0],   // Assuming name is at index 1
            'type': dish[2],   // Assuming type is at index 2
          };
        }).toList();
      });
    } catch (error) {
      print("Error fetching dishes: $error");
      // Handle the error, e.g., show a message to the user
    }
  }

  void _showFlippableCard(BuildContext context, String dishID) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: FlippableCard(
            dishID: dishID,
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    fetchDishes();  // Fetch the dishes when the page is initialized
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  hintText: 'Search dishes...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade200,
                ),
              ),
            ),
            const SizedBox(height: 10),
            // Dish of the Day Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GestureDetector(
                onTap: () async {
                  await dotd(); // Fetch the Dish of the Day by ID
                  if (dishOfTheDay.isNotEmpty) {
                    _showFlippableCard(context, dishOfTheDay[0]);
                  }
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 3,
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.horizontal(left: Radius.circular(10.0)),
                        child: Image.network(
                          dishOfTheDay.isNotEmpty ? dishOfTheDay[1] : 'https://via.placeholder.com/150',
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                dishOfTheDay.isNotEmpty ? dishOfTheDay[2] : "Loading...",
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                dishOfTheDay.isNotEmpty ? dishOfTheDay[3] : "Loading...",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            // Grid of Dishes Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  if (dishes.isEmpty) Text(''),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: dishes.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 3 / 4,
                    ),
                    itemBuilder: (context, index) {
                      final dish = dishes[index];
                      return GestureDetector(
                        onTap: () {
                          // Use a dish ID here based on the data
                          _showFlippableCard(context, dish['id']!);
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.vertical(top: Radius.circular(10.0)),
                                child: Image.network(
                                  dish['image']!,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      dish['name']!,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      dish['type']!,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../api_manager/api_manager.dart';

class ComparePage extends StatefulWidget {
  const ComparePage({super.key});

  @override
  _ComparePageState createState() => _ComparePageState();
}

class _ComparePageState extends State<ComparePage> {
  final TextEditingController _dishOneController = TextEditingController();
  final TextEditingController _dishTwoController = TextEditingController();

  String? dishOneImage;
  String? dishOneName;

  String? dishTwoImage;
  String? dishTwoName;

  String? dishOneProtein;
  String? dishTwoProtein;

  String? dishOnefats;
  String? dishTwofats;

  String? dishOnecarbs;
  String? dishTwocarbs;

  String? dishOnecals;
  String? dishTwocals;

  String? dishOnenrg;
  String? dishTwonrg;

  bool showComparison = false;

  Future<void> fetchDishDetails(
      String dishTitle, Function(String, String) updateDish) async {
    // Simulate an API call
    await Future.delayed(const Duration(seconds: 2));
    if (dishTitle.isNotEmpty) {
      // Mock response: name and image
      final response = ['Sample Dish', 'https://via.placeholder.com/150'];
      updateDish(response[0], response[1]);
    }
  }


  Widget _buildNutritionRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(
            Icons.fastfood, // Use an icon that matches the content
            size: 18,
            color: Colors.orange,
          ),
          const SizedBox(width: 8),
          Text(
            "$label: ",
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            value ?? "Loading...",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }


  void showDishSelectionDialog(String dishNumber) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 16),
              Text(
                'Enter $dishNumber Dish Title',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: dishNumber == "First"
                    ? _dishOneController
                    : _dishTwoController,
                decoration: InputDecoration(
                  hintText: 'Enter dish name...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  final query = dishNumber == "First"
                      ? _dishOneController.text
                      : _dishTwoController.text;

                  var dish = await search(query);

                  await fetchDishDetails(query, (name, image) {
                    setState(() {
                      if (dishNumber == "First") {
                        dishOneName = dish[2];
                        dishOneImage = dish[1];
                        dishOnecals = dish[3];
                        dishOneProtein = dish[4];
                        dishOnecarbs = dish[5];
                        dishOnefats = dish[6];
                      } else {
                        dishTwoName = dish[2];
                        dishTwoImage = dish[1];
                        dishTwocals = dish[3];
                        dishTwoProtein = dish[4];
                        dishTwocarbs = dish[5];
                        dishTwofats = dish[6];

                      }
                    });
                  });

                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Search',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Compare Dishes'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () => showDishSelectionDialog("First"),
                    child: Container(
                      height: 120,
                      width: 120,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.blueGrey, width: 2),
                      ),
                      child: dishOneImage == null
                          ? const Icon(Icons.add,
                              size: 40, color: Colors.blueAccent)
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                dishOneImage!,
                                fit: BoxFit.cover,
                              ),
                            ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => showDishSelectionDialog("Second"),
                    child: Container(
                      height: 120,
                      width: 120,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.blueGrey, width: 2),
                      ),
                      child: dishTwoImage == null
                          ? const Icon(Icons.add,
                              size: 40, color: Colors.blueAccent)
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                dishTwoImage!,
                                fit: BoxFit.cover,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: dishOneName != null && dishTwoName != null
                    ? () {
                        setState(() {
                          showComparison = true;
                        });
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: dishOneName != null && dishTwoName != null
                      ? Colors.blueAccent
                      : Colors.grey,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Compare',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
              const SizedBox(height: 20),
              if (showComparison)
                Center(
                  child: Row(
                    children: [
                      Container(
                        height: 200,
                        width: 160,
                        margin: const EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          color: Colors.blue[100],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            "\nProtein: $dishOneProtein\nCarbs: $dishOnecarbs\nCals: $dishOnecals\nFats: $dishOnefats",
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const SizedBox(width: 40,),
                      Container(
                        height: 200,
                        width: 160,
                        decoration: BoxDecoration(
                          color: Colors.green[100],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child:  Text(
                            "\nProtein: $dishTwoProtein\nCarbs: $dishTwocarbs\nCals: $dishTwocals\nFats: $dishTwofats",
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),

                          ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

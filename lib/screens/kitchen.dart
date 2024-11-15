import 'package:flutter/material.dart';

class KitchenPage extends StatefulWidget {
  
  const KitchenPage({super.key, required bool isPro});

  @override
  _KitchenPageState createState() => _KitchenPageState();
}

class _KitchenPageState extends State<KitchenPage> {
  final List<String> availableIngredients = [
    'Tomato', 'Onion', 'Garlic', 'Cucumber', 'Carrot', 'Lettuce', 'Potato', 'Spinach', 'Cabbage', 'Pepper'
  ];

  List<String> selectedIngredients = [];
  bool isPro = false; // Assume a Pro status
  bool isSearchDisabled = false;
  String searchQuery = "";

  final List<Map<String, String>> similarDishes = [
    {'name': 'Dish 1', 'image': 'https://via.placeholder.com/100'},
    {'name': 'Dish 2', 'image': 'https://via.placeholder.com/100'},
    {'name': 'Dish 3', 'image': 'https://via.placeholder.com/100'},
    {'name': 'Dish 4', 'image': 'https://via.placeholder.com/100'},
  ];

  void addIngredient(String ingredient) {
    if (selectedIngredients.length < 8) {
      setState(() {
        selectedIngredients.add(ingredient);
        if (selectedIngredients.length == 8) {
          isSearchDisabled = true; // Disable search when max ingredients are reached
        }
      });
    }
  }

  void removeIngredient(String ingredient) {
    setState(() {
      selectedIngredients.remove(ingredient);
      if (selectedIngredients.length < 8) {
        isSearchDisabled = false; // Re-enable search if there are less than 4 ingredients
      }
    });
  }

  void showDishes() {
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
              const Text(
                'Select a Dish',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              GridView.builder(
                shrinkWrap: true,
                itemCount: isPro ? similarDishes.length : 4,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 1,
                ),
                itemBuilder: (context, index) {
                  final dish = similarDishes[index];
                  bool isLocked = !isPro && index >= 2;

                  return Column(
                    children: [
                      Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.blueGrey),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 5,
                              offset: Offset(2, 2),
                            ),
                          ],
                        ),
                        child: isLocked
                            ? const Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.lock, color: Colors.grey, size: 30),
                                  ],
                                ),
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  dish['image']!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        isLocked ? 'Premium' : dish['name']!,
                        style: TextStyle(
                          fontSize: 14,
                          color: isPro ? Colors.grey : Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  );
                },
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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              TextField(
                enabled: !isSearchDisabled,
                decoration: InputDecoration(
                  hintText: 'Search Ingredients...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
                onChanged: (query) {
                  setState(() {
                    searchQuery = query;
                  });
                },
              ),
              const SizedBox(height: 20),
              if (isSearchDisabled)
                const Text(
                  'Max Ingredients Reached',
                  style: TextStyle(color: Colors.red, fontSize: 14),
                ),
              const SizedBox(height: 20),
              Wrap(
                spacing: 5,
                alignment: WrapAlignment.center,
                runSpacing: 5,
                children: selectedIngredients
                    .map((ingredient) => Chip(
                          backgroundColor: Colors.blue,
                          label: Text(ingredient,style: const TextStyle(color: Colors.white),),
                          deleteIcon: const Icon(Icons.close),
                          onDeleted: () => removeIngredient(ingredient),
                        ))
                    .toList(),
              ),
              const SizedBox(height: 20),
              if (selectedIngredients.length < 8)
                Expanded(
                  child: ListView.builder(
                    itemCount: availableIngredients.length,
                    itemBuilder: (context, index) {
                      final ingredient = availableIngredients[index];
                      if (searchQuery.isNotEmpty &&
                          !ingredient.toLowerCase().contains(searchQuery.toLowerCase())) {
                        return Container();
                      }
                      return ListTile(
                        title: Text(ingredient),
                        onTap: () => addIngredient(ingredient),
                      );
                    },
                  ),
                ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: selectedIngredients.isEmpty ? null : showDishes,
                 style: ElevatedButton.styleFrom(
                  fixedSize: const Size.fromWidth(240),
                  backgroundColor: const Color(0xFF14213D),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  textStyle: const TextStyle(fontSize: 16, color: Colors.white),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text('Find Dish',style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
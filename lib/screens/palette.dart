// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class PalettePage extends StatefulWidget {
  final bool isPro;

  const PalettePage({super.key, required this.isPro});

  @override
  _PalettePageState createState() => _PalettePageState();
}

class _PalettePageState extends State<PalettePage> {
  String? selectedDishImage;
  String? selectedDishName;
  bool showIngredients = false;
  bool showSubstitutes = false;
  String? selectedIngredient;
  String searchQuery = "";

  final List<Map<String, String>> dishes = [
    {'name': 'Dish 1', 'image': 'https://via.placeholder.com/150'},
    {'name': 'Dish 2', 'image': 'https://via.placeholder.com/150'},
    {'name': 'Dish 3', 'image': 'https://via.placeholder.com/150'},
    {'name': 'Dish 4', 'image': 'https://via.placeholder.com/150'},
    {'name': 'Dish 5', 'image': 'https://via.placeholder.com/150'},
  ];

  final List<String> ingredients = ['Salt', 'Sugar', 'Butter', 'Flour', 'Oil'];
  final Map<String, List<String>> substitutes = {
    'Salt': ['Soy Sauce', 'Celery Salt', 'Seaweed'],
    'Sugar': ['Honey', 'Stevia', 'Maple Syrup'],
    'Butter': ['Margarine', 'Coconut Oil', 'Avocado'],
    'Flour': ['Cornmeal', 'Almond Flour', 'Coconut Flour'],
    'Oil': ['Ghee', 'Vegetable Shortening', 'Unsweetened Applesauce'],
  };

  void showDishSelection() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 32),
                  const Text(
                    'Select a Dish',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Search dishes...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                    onChanged: (query) {
                      setModalState(() {
                        searchQuery = query;
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      itemCount: dishes.length,
                      itemBuilder: (context, index) {
                        final dish = dishes[index];
                        final name = dish['name']!.toLowerCase();
                        if (searchQuery.isNotEmpty &&
                            !name.contains(searchQuery.toLowerCase())) {
                          return Container();
                        }
                        return ListTile(
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              dish['image']!,
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Text(dish['name']!,
                              style: const TextStyle(fontSize: 16)),
                          onTap: () {
                            setState(() {
                              selectedDishImage = dish['image'];
                              selectedDishName = dish['name'];
                              showIngredients = false;
                              showSubstitutes = false;
                              selectedIngredient = null;
                            });
                            Navigator.pop(context);
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
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
              const SizedBox(height: 30),
              GestureDetector(
                onTap: showDishSelection,
                child: Container(
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.blueGrey, width: 2),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 8,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                  child: selectedDishImage == null
                      ? const Icon(Icons.add,
                          size: 40, color: Colors.blueAccent)
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            selectedDishImage!,
                            fit: BoxFit.cover,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 10),
              if (selectedDishName != null)
                Text(
                  selectedDishName!,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w500),
                )
              else
                const Text(
                  "Select a Dish",
                  style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w500),
                ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size.fromWidth(240),
                  backgroundColor: const Color(0xFF14213D),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  textStyle: const TextStyle(fontSize: 16, color: Colors.white),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  setState(() {
                    showIngredients = true;
                    showSubstitutes = false;
                    selectedIngredient = null;
                  });
                },
                child: const Text('Get Ingredients',style:TextStyle(fontSize: 16, color: Colors.white),),
              ),
              const SizedBox(height: 20),
              if (showIngredients)
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: ingredients.map((ingredient) {
                    return ChoiceChip(
                      selectedColor: Colors.lightBlueAccent,
                      label: Text(ingredient),
                      selected: selectedIngredient == ingredient,
                      onSelected: (bool selected) {
                        setState(() {
                          selectedIngredient =
                              selected ? ingredient : null;
                        });
                      },
                    );
                  }).toList(),
                ),
              const SizedBox(height: 20),
              if (selectedIngredient != null)
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                  fixedSize: const Size.fromWidth(240),
                  backgroundColor: const Color(0xFF14213D),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                  onPressed: () {
                    setState(() {
                      showSubstitutes = true;
                    });
                  },
                  child: const Text('Get Substitute',style:TextStyle(fontSize: 16, color: Colors.white)),
                ),
              const SizedBox(height: 20),
              if (showSubstitutes)
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: substitutes[selectedIngredient]!
                      .map((substitute) {
                    return Chip(
                      label: Text(substitute),
                    );
                  }).toList(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

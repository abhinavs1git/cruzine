import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class FlippableCard extends StatefulWidget {
  final String dishID;

  const FlippableCard({
    super.key,
    required this.dishID,
  });

  @override
  _FlippableCardState createState() => _FlippableCardState();
}

class _FlippableCardState extends State<FlippableCard> with SingleTickerProviderStateMixin {
  bool isFlipped = false;
  late AnimationController _controller;
  late Animation<double> _animation;

  String? name;
  String? imageUrl;
  String? type;
  String? recipe;
  String? recipeUrl;
  String? protein;
  String? fats;
  String? carbs;
  String? cals;
  String? nrg;
  bool isLoading = true;

  var headers = {
  'Authorization' : 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6ImFkbWluIn0.x6OxH120iJxLyxEliEXXCocDk5pHxR38PjdCmUJfayQ'
};
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    // Fetch dish details from API
    fetchDishDetails();
  }

  Future<void> fetchDishDetails() async {
    setState(() {
      isLoading = true;
    });

    try {
      var response = await Dio().get(
        'http://10.0.2.2:5000/recipe/${widget.dishID}',
        options: Options(headers: headers),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.data);

        setState(() {
          name = data[1] ?? "Unknown Dish";
          imageUrl = data[0] ?? "https://via.placeholder.com/150";
          type = data[2] ?? "Unknown Type";
          recipeUrl = data[3] ?? "Unknown URL";
          recipe = data[4] ?? "No recipe available";
          protein = data[5] ?? "Unknown protein";
          carbs = data[6] ?? "Unknown carbs";
          fats = data[7] ?? "Unknown fats";
          cals = data[8] ?? "Unknown calories";
          nrg = data[9] ?? "Unknown energy";
        });
      } else {
        setState(() {
          recipe = 'Error: Failed to fetch recipe';
        });
      }
    } catch (e) {
      setState(() {
        recipe = 'Error: $e';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _flipCard() {
    setState(() {
      isFlipped = !isFlipped;
      isFlipped ? _controller.forward() : _controller.reverse();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildFrontSide() {
    return Container(
      height: 440,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 15,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image, Name, Type
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  imageUrl ?? "https://via.placeholder.com/150",
                  width: 90,
                  height: 90,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.error, size: 90);
                  },
                ),
              ),
              const SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width:160,
                    child: Text(
                      name ?? "Loading...",
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        
                      ),
                      
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    type ?? "Loading...",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Recipe Description
          Text(
            recipe ?? "Loading recipe...",
            style: TextStyle(
              fontSize: 14,
              color: Colors.black.withOpacity(0.7),
            ),
            maxLines: 10,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 10),
          // Recipe URL
          GestureDetector(
            onTap: () {
              if (recipeUrl != null && recipeUrl != "Unknown URL") {
                // Open the URL in a web browser
              }
            },
            child: Text(
              recipeUrl ?? "No recipe URL available",
              style: TextStyle(
                fontSize: 14,
                color: Colors.blueAccent,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackSide() {
    return Container(
      height: 440,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 15,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Nutrition Info Title
          Text(
            "Nutrition Info",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 20),
          // Display nutritional data
          _buildNutritionRow("Calories", cals),
          _buildNutritionRow("Energy", nrg),
          _buildNutritionRow("Protein", protein),
          _buildNutritionRow("Carbs", carbs),
          _buildNutritionRow("Fats", fats),
        ],
      ),
    );
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _flipCard,
      child: isLoading
          ? const Center(child: CircularProgressIndicator())
          : AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                final angle = _animation.value * 3.14159;
                return Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateY(angle),
                  child: angle < 1.57
                      ? _buildFrontSide()
                      : Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.identity()..rotateY(3.14159),
                          child: _buildBackSide(),
                        ),
                );
              },
            ),
    );
  }
}

// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class FlippableCard extends StatefulWidget {
  final String imageUrl;
  final String name;
  final String type;

  const FlippableCard({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.type,
  });

  @override
  _FlippableCardState createState() => _FlippableCardState();
}

class _FlippableCardState extends State<FlippableCard>
    with SingleTickerProviderStateMixin {
  bool isFlipped = false;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
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

  Widget _buildCardSide({required Color color, required Widget content}) {
    return Container(
      height: 550,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.grey,
        border: Border.all(color: Colors.white.withOpacity(0.3), width: 2),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Dish details row
          Row(
            children: [
              Image.network(widget.imageUrl, width: 70, height: 70),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.type,
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

          // Editable container section
          content,
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _flipCard,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          final angle = _animation.value * 3.14159;
          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(angle),
            child: angle < 1.57
                ? _buildCardSide(
                    color: Colors.grey,
                    content: Container(
                      height: 390,
                      color: Colors.blue,
                      child: const Center(
                        child: Text(
                          "Front Side Content",
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  )
                : Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()..rotateY(3.14159),
                    child: _buildCardSide(
                      color: Colors.grey,
                      content: Container(
                        height: 390,
                        color: Colors.blue,
                        child: const Center(
                          child: Text(
                            "Back Side Content",
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
          );
        },
      ),
    );
  }
}

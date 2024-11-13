// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:timelines/timelines.dart';

class PalettePage extends StatefulWidget {
  const PalettePage({super.key});

  @override
  _PalettePageState createState() => _PalettePageState();
}

class _PalettePageState extends State<PalettePage> {
  int _currentStep = 0;

  void _nextStep() {
    if (_currentStep < 1) {
      setState(() {
        _currentStep += 1;
      });
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep -= 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 80, child: Container(color: Colors.blue,),),
          Padding(
            padding: const EdgeInsets.all(16), // Align timeline to the left
            child: FixedTimeline.tileBuilder(
              theme: TimelineThemeData(
                color: const Color(0xFF14213D),
                indicatorPosition: 0.1,
              ),
              builder: TimelineTileBuilder.connected(
                itemCount: 2,
                connectorBuilder: (_, index, __) => const DashedLineConnector(color: Colors.grey),
                indicatorBuilder: (_, index) => const DotIndicator(
                  color: Color(0xFF14213D),
                  size: 20,
                ),
                contentsBuilder: (context, index) {
                  // Show specific content based on the active step and index
                  if (index == 0 && _currentStep == 0) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        height: 300,
                        color: Colors.blue,
                        alignment: Alignment.center,
                        child: const Text(
                          'aalo',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  } 
                  else if (index == 1 && _currentStep == 0) {
                    return const Padding(
                      padding: EdgeInsets.fromLTRB(12, 0, 4, 0),
                      child: Text(
                        'Get your Palette',
                        style: TextStyle(color: Colors.grey, fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                    );
                  }
                  else if (index == 0 && _currentStep == 1) {
                    return const Padding(
                      padding: EdgeInsets.fromLTRB(24, 0, 4, 0),
                      child: Text(
                        'Dish Selected',
                        style: TextStyle(color: Colors.grey, fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                    );
                  } else if (index == 1 && _currentStep == 1) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        height: 300,
                        color: Colors.blue,
                        alignment: Alignment.center,
                        child: const Text(
                          'bhalo',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ),
          const SizedBox(height: 20),
          // Display buttons based on the step
          if (_currentStep == 0)
            ElevatedButton(
              onPressed: _nextStep,
              child: const Text('Next'),
            )
          else if (_currentStep == 1)
            ElevatedButton(
              onPressed: _previousStep,
              child: const Text('Back'),
            ),
        ],
      ),
    );
  }
}

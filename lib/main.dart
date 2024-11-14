// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import '../screens/kitchen.dart';
import '../screens/map.dart';
import '../screens/vault.dart';
import '../screens/palette.dart';
import '../screens/profile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cruzine',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 2;
  bool isPro = false; // New boolean for Pro mode

  // List of pages to display based on selected index
  List<Widget> get _pages => [
    KitchenPage(),
    const MapPage(),
    VaultPage(isPro: isPro), // Pass isPro to VaultPage
    PalettePage(isPro: isPro), // Pass isPro to PalettePage
    ProfilePage(onProToggle: (value) { // ProfilePage toggle for Pro mode
      setState(() {
        isPro = value;
      });
    }),
  ];

  // List of BottomNavigationBarItem for the bar with label and icon
  List<BottomNavigationBarItem> _navBarItems() {
    return [
      const BottomNavigationBarItem(
        icon: Icon(Icons.kitchen),
        label: 'Kitchen',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.map),
        label: 'Map',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.lock),
        label: 'Vault',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.palette),
        label: 'Palette',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.person),
        label: 'Profile',
      ),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _navBarItems()[_selectedIndex].label!,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF14213D), // AppBar color
        toolbarHeight: 80,
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: _navBarItems(),
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 10,
        unselectedFontSize: 6,
        showUnselectedLabels: false,
        backgroundColor: const Color(0xFF14213D), // Bottom nav bar color
      ),
    );
  }
}

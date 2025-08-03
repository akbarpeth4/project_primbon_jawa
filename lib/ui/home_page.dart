import 'package:flutter/material.dart';
import '../ui/selametan_page.dart';
import '../ui/weton_page.dart';
import 'beranda_page.dart';
import '../ui/bantuan_page.dart'; // <- tambahkan
import '../widgets/top_nav_menu.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0; // Default ke Home

  final List<Widget> _pages = const [
    BerandaPage(),
    HitungSelametanPage(),
    WetonPage(),
    BantuanPage(),
  ];

  void _onNavItemTapped(int index) {
    setState(() => selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kalkulator Primbon Jawa"),
        backgroundColor: Colors.purple.shade100,
        actions: [
          TopNavMenu(
            selectedIndex: selectedIndex,
            onItemSelected: _onNavItemTapped,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(child: _pages[selectedIndex]),
          Container(
            color: Colors.grey.shade200,
            padding: const EdgeInsets.all(8),
            child: const Text("Created by Akbarpeth"),
          ),
        ],
      ),
    );
  }
}

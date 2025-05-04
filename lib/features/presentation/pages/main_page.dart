import 'package:flutter/material.dart';
import 'package:mobile_alumunium/features/presentation/pages/home/home_page.dart';
import 'package:mobile_alumunium/features/presentation/pages/incoming_item_pages/incoming_item_page.dart';
import 'package:mobile_alumunium/features/presentation/pages/outgoing_item_pages/outgoing_item_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    HomePage(),
    IncomingItemPage(),
    OutgoingItemPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: 'Incoming'),
          BottomNavigationBarItem(
              icon: Icon(Icons.miscellaneous_services), label: 'Outgoing'),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:mobile_alumunium/common/theme/app_colors.dart';
import 'package:mobile_alumunium/features/presentation/pages/account_pages/account_page.dart';
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

  final List<Widget> _pages = [
    HomePage(),
    IncomingItemPage(),
    OutgoingItemPage(),
    AccountPage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: _buildModernNavBar(),
    );
  }

  Widget _buildModernNavBar() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.navBarBackground,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: [
            BottomNavigationBarItem(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _selectedIndex == 0
                      ? AppColors.primaryColor.withOpacity(0.2)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.home_outlined,
                  size: 24,
                  color: _selectedIndex == 0
                      ? AppColors.primaryColor
                      : AppColors.navBarUnselectedItem,
                ),
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _selectedIndex == 1
                      ? AppColors.primaryColor.withOpacity(0.2)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.inventory_rounded,
                  size: 24,
                  color: _selectedIndex == 1
                      ? AppColors.primaryColor
                      : AppColors.navBarUnselectedItem,
                ),
              ),
              label: 'Stock Masuk',
            ),
            BottomNavigationBarItem(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _selectedIndex == 2
                      ? AppColors.primaryColor.withOpacity(0.2)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.local_shipping_rounded,
                  size: 24,
                  color: _selectedIndex == 2
                      ? AppColors.primaryColor
                      : AppColors.navBarUnselectedItem,
                ),
              ),
              label: 'Stock Keluar',
            ),
            BottomNavigationBarItem(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _selectedIndex == 3
                      ? AppColors.primaryColor.withOpacity(0.2)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.person_2_outlined,
                  size: 24,
                  color: _selectedIndex == 3
                      ? AppColors.primaryColor
                      : AppColors.navBarUnselectedItem,
                ),
              ),
              label: 'Akun',
            ),
          ],
        ),
      ),
    );
  }
}

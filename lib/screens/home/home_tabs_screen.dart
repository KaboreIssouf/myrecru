import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../widgets/CustomBottomNavBar.dart';
import '../contacts/contact_favorites_screen.dart';
import '../contacts/contact_list_screen.dart';
import '../contacts/contact_recent_screen.dart';

class HomeTabsScreen extends StatefulWidget {
  const HomeTabsScreen({super.key});
  @override
  State<HomeTabsScreen> createState() => _HomeTabsScreenState();
}

class _HomeTabsScreenState extends State<HomeTabsScreen> {
  int _selectedIndex = 2;

  final List<Widget> _pages = [
    ContactFavoritesScreen(),
    ContactRecentScreen(),
    ContactListScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 52),
        child: SafeArea(
          child: CustomBottomNavBar(
            selectedIndex: _selectedIndex,
            onTap: (index) => setState(() => _selectedIndex = index),
          ),
        ),
      ),
    );
  }
}
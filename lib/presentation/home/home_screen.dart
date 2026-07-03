import 'package:archive_secure/presentation/home/data.dart';
import 'package:archive_secure/presentation/home/widgets/menu_bar.dart';
import 'package:archive_secure/presentation/home/widgets/navigation_bar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
     final currentRoute = menuRoutes[selectedIndex];

    return  Scaffold(
 body: menuWidgets[currentRoute],
  bottomNavigationBar: NavigationBarCustom(
        selectedIndex: selectedIndex,
        onItemTapped: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        menus: menus,
      ),
    );
  }
}
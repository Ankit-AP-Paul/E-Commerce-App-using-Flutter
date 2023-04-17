import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart';

import 'homepage.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return SlidingClippedNavBar(
      barItems: [
        BarItem(title: "Home", icon: Icons.home),
        BarItem(title: "Categories", icon: Icons.category),
        BarItem(title: "Favourites", icon: Icons.favorite),
        BarItem(title: "My Cart", icon: Icons.shopping_cart),
      ],
      selectedIndex: navIndex.value,
      onButtonPressed: (currIndex) {
        setState(() {
          navIndex.value = currIndex;
        });
      },
      activeColor: Colors.white,
      backgroundColor: Colors.blue,
    );
  }
}

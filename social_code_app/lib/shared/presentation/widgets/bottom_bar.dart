import 'package:flutter/material.dart';
import 'package:social_code_app/config/routes/routes.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({super.key, required this.starterIndex});
  final int starterIndex;
  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: starterIndex,
      destinations: const [
        NavigationDestination(
            icon: Icon(
              Icons.person,
              color: Colors.blue,
            ),
            label: "Profile"),
        NavigationDestination(
            icon: Icon(
              Icons.home,
              color: Colors.white,
            ),
            label: "Home"),
        NavigationDestination(
            icon: Icon(
              Icons.favorite,
              color: Colors.red,
            ),
            label: "Popular")
      ],
      onDestinationSelected: (value) {
        if (value == starterIndex) {
          return;
        }
        if (value == 1) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => routes["/home"]!,
              settings: const RouteSettings(name: "/home")));
        } else if (value == 0) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => routes["/profile"]!,
              settings: const RouteSettings(name: "/profile")));
        } else if (value == 2) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => routes["/popular"]!,
              settings: const RouteSettings(name: "/popular")));
        }
      },
    );
  }
}

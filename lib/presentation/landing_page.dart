import 'package:adminpanel/presentation/home_view.dart';
import 'package:adminpanel/presentation/plantEncyclopedia/plant_encyclopedia_view.dart';
import 'package:adminpanel/presentation/products/product_view.dart';
import 'package:adminpanel/presentation/services/service_view.dart';
import 'package:adminpanel/presentation/widgets/pop_up_menu.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final screens = [
    const HomeView(),
    const ProductView(),
    const ServiceView(),
    const PlantEncyclopediaView(),
  ];

  int selectedIndex = 0;

  // changeDestination(int index) {
  //   setState(() {
  //     selectedIndex = index;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              "assets/logo1.png",
              height: 50,
            ),
            const SizedBox(width: 20),
            const Text(
              "Grow It Green",
              style: TextStyle(
                fontSize: 37,
                color: Colors.white,
              ),
            ),
          ],
        ),
        // ignore: prefer_const_literals_to_create_immutables
        actions: [
          const PopUpMenu(),
        ],
      ),
      body: Row(
        children: [
          NavigationRail(
            // useIndicator: true,
            indicatorColor: Colors.white,
            selectedIconTheme: const IconThemeData(
              color: Colors.white,
              size: 40,
            ),
            selectedLabelTextStyle: const TextStyle(
              color: Colors.white,
            ),
            backgroundColor: Colors.green,
            labelType: NavigationRailLabelType.all,
            onDestinationSelected: (int index) {
              setState(() {
                selectedIndex = index;
              });
            },
            selectedIndex: selectedIndex,
            // ignore: prefer_const_literals_to_create_immutables
            destinations: [
              const NavigationRailDestination(
                selectedIcon: Icon(
                  Icons.home_filled,
                ),
                icon: Icon(
                  Icons.home,
                  size: 30,
                ),
                label: Text(
                  "Home",
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
              ),
              const NavigationRailDestination(
                selectedIcon: Icon(
                  Icons.shopping_bag_rounded,
                ),
                icon: Icon(
                  Icons.shopping_bag,
                  size: 30,
                ),
                label: Text(
                  "Product",
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
              ),
              const NavigationRailDestination(
                selectedIcon: Icon(
                  Icons.cleaning_services_rounded,
                ),
                icon: Icon(
                  Icons.cleaning_services,
                  size: 30,
                ),
                label: Text(
                  "Services",
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
              ),
              const NavigationRailDestination(
                selectedIcon: Icon(
                  Icons.book_rounded,
                ),
                icon: Icon(
                  Icons.book,
                  size: 30,
                ),
                label: Text(
                  "Encyclopedia",
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ),
            ],
          ),
          Expanded(child: screens[selectedIndex]),
        ],
      ),
    );
  }
}

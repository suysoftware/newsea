import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import 'core/constants/app_colors.dart';
import 'feature/screens/home/presentation/home_screen.dart';

Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with TickerProviderStateMixin {
  var _selectedTab = _SelectedTab.home;

  void _handleIndexChanged(int i) {
    setState(() {
      _selectedTab = _SelectedTab.values[i];
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            backgroundColor: AppColors.themeWhite,
            body: [
              HomeScreen(),
              Container(
                color: Colors.pink,
              ),
              Container(
                color: Colors.orange,
              ),
              Container(
                color: Colors.teal,
              ),
            ][_SelectedTab.values.indexOf(_selectedTab)],
            bottomNavigationBar: DotNavigationBar(
              currentIndex: _SelectedTab.values.indexOf(_selectedTab),
              onTap: _handleIndexChanged,
              // dotIndicatorColor: Colors.black,
              items: [
                /// Home
                DotNavigationBarItem(
                  icon: Icon(Icons.home),
                  selectedColor: Colors.purple,
                ),

                /// Likes
                DotNavigationBarItem(
                  icon: Icon(Icons.favorite_border),
                  selectedColor: Colors.pink,
                ),

                /// Search
                DotNavigationBarItem(
                  icon: Icon(Icons.search),
                  selectedColor: Colors.orange,
                ),

                /// Profile
                DotNavigationBarItem(
                  icon: Icon(Icons.person),
                  selectedColor: Colors.teal,
                ),
              ],
            ),
          ));
    });
  }
}

enum _SelectedTab { home, favorite, search, person }

import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:newsea/core/services/firebase/firebase_options.dart';
import 'package:newsea/feature/screens/profile/presentation/profile_screen.dart';
import 'package:newsea/feature/screens/readlist/presentation/bookmark_screen.dart';
import 'package:newsea/feature/screens/search/presentation/search_screen.dart';
import 'package:sizer/sizer.dart';

import 'core/constants/app_colors.dart';
import 'core/services/firebase/firebase_auth_service.dart';
import 'feature/screens/home/controller/home_controller.dart';
import 'feature/screens/home/presentation/home_screen.dart';

var nsUser;
Future<void> main() async {
  await init();
  runApp(const MyApp());
}

Future<void> init() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(options: FirebaseOptionsClass.firebaseConfig);
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with TickerProviderStateMixin {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: MainWidget(),
      );
    });
  }
}

class MainWidget extends StatefulWidget {
  MainWidget({super.key});

  @override
  State<MainWidget> createState() => _MainWidgetState();
  final HomeController homeController = Get.put(HomeController());
}

class _MainWidgetState extends State<MainWidget> {
  var _selectedTab = _SelectedTab.home;
  late HomeController homeController;
  void _handleIndexChanged(int i) {
    setState(() {
      _selectedTab = _SelectedTab.values[i];
    });
  }

  @override
  void initState() {
    super.initState();
    homeController = Get.put(HomeController());
    FirebaseAuthService.loggedCheck();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.themeWhite,
      body: [HomeScreen(), BookmarkScreen(), SearchScreen(), ProfileScreen()][_SelectedTab.values.indexOf(_selectedTab)],
      bottomNavigationBar: DotNavigationBar(
        marginR: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
        paddingR: const EdgeInsets.only(bottom: 0, top: 0),
        currentIndex: _SelectedTab.values.indexOf(_selectedTab),
        onTap: _handleIndexChanged,
        // dotIndicatorColor: Colors.black,
        items: [
          /// Home
          DotNavigationBarItem(
            icon: Icon(Icons.home),
            selectedColor: AppColors.green,
          ),

          /// Likes
          DotNavigationBarItem(
            icon: Icon(CupertinoIcons.bookmark),
            selectedColor: AppColors.green,
          ),

          /// Search
          DotNavigationBarItem(
            icon: Icon(Icons.search),
            selectedColor: AppColors.green,
          ),

          /// Profile
          DotNavigationBarItem(
            icon: Icon(Icons.person),
            selectedColor: AppColors.green,
          ),
        ],
      ),
    );
  }
}

enum _SelectedTab { home, favorite, search, person }

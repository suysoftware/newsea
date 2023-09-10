import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newsea/core/constants/app_colors.dart';
import '../controller/home_controller.dart';
import 'widgets/category_list.dart';
import 'widgets/feed_list.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Newsea",
          style: TextStyle(color: AppColors.softBlack),
        ),
        backgroundColor: AppColors.themeWhite,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 15.0,
          ),
          CategoryList(),
          FeedList()
        ],
      ),
    );
  }
}

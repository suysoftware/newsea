import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newsea/core/constants/app_colors.dart';
import 'package:newsea/feature/screens/home/controller/home_controller.dart';


import 'feed_card.dart';

class FeedList extends StatefulWidget {
  const FeedList({super.key});

  @override
  State<FeedList> createState() => _FeedListState();
}

class _FeedListState extends State<FeedList> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: HomeController(),
        builder: (homeController) {

 return Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Container(
                  decoration: const BoxDecoration(border: Border(top: BorderSide(width: 1.0, color: AppColors.mainListBorderStroke))),
                  child: ListView.builder(
                      reverse: false,
                      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.values.last,
                      itemCount: homeController.feeds.length,
                      itemBuilder: (context, index) {
                        return homeController.feeds.isNotEmpty ? FeedCard(feed: homeController.feeds[index]) : const SizedBox();
                      }),
                ),
              ),
            );

    





    });
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newsea/core/constants/app_colors.dart';
import 'package:newsea/core/models/feed_model.dart';
import 'package:newsea/core/services/firebase/rest_api_requests.dart';
import 'package:newsea/core/utils/basic_functions.dart';
import 'package:newsea/feature/screens/home/controller/home_controller.dart';
import 'package:newsea/feature/screens/home/presentation/widgets/feed_card.dart';
import 'package:sizer/sizer.dart';

import 'language_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Profile",
          style: TextStyle(color: AppColors.softBlack),
        ),
        backgroundColor: AppColors.themeWhite,
      ),
      body: GetBuilder(
          init: HomeController(),
          builder: (homeController) {
            return Container(
              child: Column(
                children: [
                  SizedBox(
                    height: 5.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: CachedNetworkImage(
                          imageUrl: homeController.nsUser.userAvatar,
                          height: 15.h,
                          width: 15.h,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(),
                          errorWidget: (context, url, error) => Icon(Icons.error),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        homeController.nsUser.userName,
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: AppColors.themeWhite,
                          border: Border.all(color: AppColors.softBlack),
                        ),
                        child: CupertinoButton(
                            padding: EdgeInsets.all(8),
                            child: Row(
                              children: [
                                CountryFlag.fromCountryCode(
                                  BasicFunctions.getCountryCodeByLanguage(homeController.nsUser.userLanguage).toUpperCase(),
                                  height: 48 * 0.7,
                                  width: 62 * 0.7,
                                  borderRadius: 8,
                                ),
                                SizedBox(
                                  width: 2.w,
                                ),
                                Text(
                                  homeController.nsUser.userLanguage,
                                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.softBlack),
                                ),
                              ],
                            ),
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => LanguageScreen()));
                            }),
                      )
                    ],
                  ),
                ],
              ),
            );
          }),
    );
  }
}

convert(List<FeedModel> feeds, List<String> categories, List<String> countries) {
  List<FeedModel> categoryFilteredFeeds = [];
  List<FeedModel> filteredFeeds = [];

  if (categories.contains("all")) {
    return feeds;
  }
  for (var feed in feeds) {
    for (var category in categories) {
      if (feed.categories!.contains(category.capitalizeFirst)) {
        categoryFilteredFeeds.add(feed);
      }
    }
  }

  if (countries.contains("all")) {
    return categoryFilteredFeeds;
  }

  for (var feed in categoryFilteredFeeds) {
    for (var country in countries) {
      if (feed.country == country.capitalizeFirst) {
        filteredFeeds.add(feed);
      }
    }
  }

  return filteredFeeds;
}

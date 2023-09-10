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

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Explore",
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
                  Flexible(
                      child: ListView.builder(
                    itemCount: BasicFunctions.getExploreItems().length,
                    itemBuilder: (context, index) {
                      return ListTile(
                          hoverColor: AppColors.textLightBlue,
                          onTap: () async {
                            //  await homeController.changeLanguage(BasicFunctions.getCountryCodesWithNames()[index]["name"]);

                            Get.back();
                          },
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  exploreItemSwitch(BasicFunctions.getExploreItems()[index]["name"], BasicFunctions.getExploreItems()[index]["image"],
                                      BasicFunctions.getExploreItems()[index]["type"]),
                                ],
                              ),
                              Column(
                                children: [
                                  homeController.checkExploreItems(BasicFunctions.getExploreItems()[index]["name"])
                                      ? CupertinoButton(
                                          child: Text(
                                            "Following",
                                            style: TextStyle(color: AppColors.green),
                                          ),
                                          onPressed: () async {
                                            homeController.removeFollowingItem(BasicFunctions.getExploreItems()[index]["name"]);
                                          })
                                      : CupertinoButton(
                                          child: Text(
                                            "Follow",
                                            style: TextStyle(color: AppColors.themeDarkBlue),
                                          ),
                                          onPressed: () async {
                                            homeController.addFollowingItem(BasicFunctions.getExploreItems()[index]["name"], BasicFunctions.getExploreItems()[index]["type"]);
                                          },
                                        ),
                                ],
                              )
                            ],
                          ));
                    },
                  ))
                ],
              ),
            );
          }),
    );
  }

  Widget countryItemConverter(String image, String name) {
    return Row(
      children: [
        CountryFlag.fromCountryCode(
          image.toUpperCase(),
          height: 48 * 0.7,
          width: 62 * 0.7,
          borderRadius: 100,
        ),
        SizedBox(
          width: 12,
        ),
        Text(
          name,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget sourceItemConverter(String image, String name) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: CachedNetworkImage(
            imageUrl: image,
            height: 48 * 0.7,
            width: 62 * 0.7,
            fit: BoxFit.cover,
            placeholder: (context, url) => Container(),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
        ),
        SizedBox(
          width: 12,
        ),
        Text(
          name,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget categoryConverter(String image, String name) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: BasicFunctions.categoryIconEnum.entries.firstWhere((element) => element.key == image).value,
        ),
        SizedBox(
          width: 12,
        ),
        Text(
          name,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget exploreItemSwitch(String name, String image, String type) {
    switch (type) {
      case "country":
        return countryItemConverter(image, name);
      case "source":
        return sourceItemConverter(image, name);
      case "category":
        return categoryConverter(image, name);
      default:
        return Container();
    }
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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newsea/core/constants/app_colors.dart';
import 'package:newsea/core/models/feed_model.dart';
import 'package:newsea/core/services/firebase/rest_api_requests.dart';
import 'package:newsea/feature/screens/home/controller/home_controller.dart';

import 'feed_card.dart';

class FeedList extends StatefulWidget {
  const FeedList({super.key});

  @override
  State<FeedList> createState() => _FeedListState();
}

class _FeedListState extends State<FeedList> {
  final HomeController homeController = Get.find();
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: HomeController(),
        builder: (homeController) {
          if (homeController.nsUser.userLanguage == "") {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return FutureBuilder<List<FeedModel>?>(
              future: RestApiRequests.getFilteredFeeds(homeController.getCountries(), homeController.getCategories(), homeController.nsUser.userLanguage),
              //        future: RestApiRequests.getFeeds("https://us-central1-newsea-project.cloudfunctions.net/appRequest/getTrendFeeds?userUid=${homeController.nsUser.userUid}"),
              //  future: RestApiRequests.getFeeds(
              //     "https://us-central1-newsea-project.cloudfunctions.net/appRequest/getTranslatedFeed?userLanguage=AmericanEnglish&filteredCountries=United States"),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  var dataCome = snapshot.data; //convert(snapshot.requireData.docs.map((e) => e.data()).toList(), homeController.categories, homeController.countries);

                  return Flexible(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: ListView.builder(
                          reverse: false,
                          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.values.last,
                          itemCount: dataCome!.length,
                          itemBuilder: (context, index) {
                            return dataCome.isNotEmpty ? FeedCard(feed: dataCome[index]) : const SizedBox();
                          }),
                    ),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              });
        });
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

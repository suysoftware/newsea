import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newsea/core/models/feed_model.dart';
import 'package:newsea/core/models/ns_user.dart';

class HomeController extends GetxController {
  //observer - gozlemleyici
  // var count = 0.obs;
  // increment() => count++;

  List<FeedModel> feeds = <FeedModel>[];
  NsUser nsUser = NsUser(
      userName: "",
      userUid: "",
      userLanguage: "",
      targetCountries: [],
      targetCategories: [],
      userReadlist: [],
      userAvatar: "",
      userMessageToken: "",
      userNotificationSettings: false);
  List<String> categories = <String>["all"];
  List<String> countries = <String>["all"];

  void updateUser(NsUser newUser) {
    nsUser = newUser;
    update();
  }

  void setFeeds(List<FeedModel> newFeeds) {
    feeds = newFeeds;
    update();
  }

  void changeFilteredCategories(String category) {
    var categoryLowerCase = category.toLowerCase();

    if (categoryLowerCase == "all") {
      cleanCategories();
      categories.add(categoryLowerCase);
      update();
      return;
    } else {
      if (!isCategoryActive(categoryLowerCase)) {
        categories.remove("all");
      }
    }

    if (isCategoryActive(categoryLowerCase)) {
      categories.remove(categoryLowerCase);

      if (categories.isEmpty) {
        categories.add("all");
      }
      update();
    } else {
      categories.add(categoryLowerCase);
      update();
    }
  }

  void changeFilteredCountries(String country) {
    var countryLowerCase = country.toLowerCase();

    if (countryLowerCase == "all") {
      cleanCountries();
      countries.add(countryLowerCase);
      update();
      return;
    } else {
      if (!isCountryActive(countryLowerCase)) {
        countries.remove("all");
      }
    }

    if (isCountryActive(countryLowerCase)) {
      countries.remove(countryLowerCase);
      if (countries.isEmpty) {
        countries.add("all");
      }
      update();
    } else {
      countries.add(countryLowerCase);
      update();
    }
  }

  void cleanCategories() {
    categories.clear();
    update();
  }

  void cleanCountries() {
    countries.clear();
    update();
  }

  bool isCategoryActive(String category) {
    if (categories.contains(category.toLowerCase())) {
      return true;
    } else {
      return false;
    }
  }

  bool isCountryActive(String country) {
    if (countries.contains(country.toLowerCase())) {
      return true;
    } else {
      return false;
    }
  }

void getFeedFromDatabase() async {
  
   await FirebaseFirestore.instance
        .collection('translated_feeds')
        .doc(nsUser.userLanguage)
        .collection("feeds")
        .withConverter(fromFirestore: (snapshot, _) => FeedModel.fromJson(snapshot.data()!), toFirestore: (feed, _) => feed.toJson())
        .get()
        .then((comingFeeds) {
      feeds .addAll(comingFeeds.docs.map((e) => e.data()).toList());
    });

  }
}

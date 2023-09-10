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
  List<dynamic> categories = <String>["All"];
  List<dynamic> countries = <String>["All"];
  bool isHomePageTrending = true;

  List<dynamic> countryList = <String>[
    "All",
    "United Arab Emirates",
    "Argentina",
    "Austria",
    "Australia",
    "Bulgaria",
    "Brazil",
    "China",
    "Colombia",
    "Cuba",
    "Czech Republic",
    "Germany",
    "Egypt",
    "France",
    "United Kingdom",
    "Greece",
    "Hungary",
    "Indonesia",
    "Italy",
    "Japan",
    "South Korea",
    "Lithuania",
    "Latvia",
    "Mexico",
    "Malaysia",
    "Nigeria",
    "Netherlands",
    "Norway",
    "Poland",
    "Portugal",
    "Romania",
    "Serbia",
    "Russia",
    "Saudi Arabia",
    "Sweden",
    "Slovenia",
    "Slovakia",
    "Thailand",
    "Turkey",
    "Ukraine",
    "United States",
    "Venezuela"
  ];
  List<dynamic> categoryList = <String>["All", "Business", "Entertainment", "Health", "Science", "Sports", "Technology", "Weather"];

  void updateUser(NsUser newUser) {
    nsUser = newUser;
    update();
  }

  void setFeeds(List<FeedModel> newFeeds) {
    feeds = newFeeds;
    update();
  }

  void changeFilteredCategories(String category) {
    if (category == "All") {
      cleanCategories();
      categories.add(category);

      update();
      return;
    } else {
      if (!isCategoryActive(category)) {
        categories.remove("All");
        update();
      }
    }

    if (isCategoryActive(category)) {
      categories.remove(category);

      if (categories.isEmpty) {
        categories.add("All");
      }

      update();
    } else {
      categories.add(category);

      update();
    }
  }

  void changeFilteredCountries(String country) {
    if (country == "All") {
      cleanCountries();
      countries.add(country);

      update();
      return;
    } else {
      if (!isCountryActive(country)) {
        countries.remove("All");

        update();
      }
    }

    if (isCountryActive(country)) {
      countries.remove(country);
      if (countries.isEmpty) {
        countries.add("All");
      }

      update();
    } else {
      countries.add(country);

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
    if (categories.contains(category)) {
      return true;
    } else {
      return false;
    }
  }

  bool isCountryActive(String country) {
    if (countries.contains(country)) {
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
      feeds.addAll(comingFeeds.docs.map((e) => e.data()).toList());
    });
  }

  void updateHomePageTrending(bool isTrending) {
    isHomePageTrending = isTrending;
    update();
  }

  List<dynamic> getCountries() {
    return isHomePageTrending ? countryList : nsUser.targetCountries;
  }

  List<dynamic> getCategories() {
    return isHomePageTrending ? categoryList : nsUser.targetCategories;
  }

  Future<void> saveFeedToBookmarks(FeedModel feed) async {
    await FirebaseFirestore.instance.collection('users').doc(nsUser.userUid).update({
      "userReadlist": FieldValue.arrayUnion([feed.subReferenceNo])
    });

    nsUser.userReadlist.add(feed.subReferenceNo);
    update();
  }

  Future<void> removeFeedFromBookmarks(FeedModel feed) async {
    await FirebaseFirestore.instance.collection('users').doc(nsUser.userUid).update({
      "userReadlist": FieldValue.arrayRemove([feed.subReferenceNo])
    });

    nsUser.userReadlist.remove(feed.subReferenceNo);
    update();
  }

  Future<void> changeLanguage(String language) async {
    await FirebaseFirestore.instance.collection('users').doc(nsUser.userUid).update({"userLanguage": language});

    nsUser.userLanguage = language;
    update();
  }

  bool checkExploreItems(String item) {
    for (var i = 0; i < nsUser.targetCategories.length; i++) {
      if (nsUser.targetCategories[i] == item) {
        return true;
      }
    }

    for (var i = 0; i < nsUser.targetCountries.length; i++) {
      if (nsUser.targetCountries[i] == item) {
        return true;
      }
    }

    return false;
  }

  removeFollowingItem(String item) async {
    //remove where
    //remove from database

    nsUser.targetCategories.removeWhere((element) => element == item);
    nsUser.targetCountries.removeWhere((element) => element == item);

    await FirebaseFirestore.instance.collection('users').doc(nsUser.userUid).update({
      "targetCategories": nsUser.targetCategories,
      "targetCountries": nsUser.targetCountries,
    });

    update();
  }

  addFollowingItem(String item, String type) async {
    //add where
    //add to database

    if (type == "category") {
      nsUser.targetCategories.add(item);
    } else if (type == "country") {
      nsUser.targetCountries.add(item);
    }

    await FirebaseFirestore.instance.collection('users').doc(nsUser.userUid).update({
      "targetCategories": nsUser.targetCategories,
      "targetCountries": nsUser.targetCountries,
    });

    update();
  }
}

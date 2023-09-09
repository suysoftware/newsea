import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newsea/core/models/feed_model.dart';


class HomeController extends GetxController {
  //observer - gozlemleyici
  // var count = 0.obs;
  // increment() => count++;

  List<FeedModel> feeds = <FeedModel>[];
  List<String> categories = <String>["all"];
  List<String> countries = <String>["all"];

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
      categories.remove("all");
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
      cleanCategories();
      countries.add(countryLowerCase);
      update();
      return;
    } else {
      countries.remove("all");
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
}

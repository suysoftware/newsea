import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:newsea/core/models/feed_model.dart';

class RestApiRequests {
  static Future<List<FeedModel>?> getFeeds(String apiLink) async {
    var client = http.Client();
    var uriIE = Uri.parse(apiLink);
    var response = await client.get(
      uriIE,
    );

    if (response.statusCode == 200) {
      print("200");
//parse the json and return the list of feeds
      List<dynamic> responseBody = json.decode(response.body);
      List<FeedModel> feeds = responseBody.map((item) => FeedModel.fromJson(item as Map<String, dynamic>)).toList();
      return feeds;
    } else if (response.statusCode == 909) {
      return [];
    }
  }

  static Future<List<FeedModel>?> getFilteredFeeds(List<dynamic> countries, List<dynamic> categories, String userLanguage) async {
    print(categories);
    print(countries);
    print(userLanguage);
    var client = http.Client();
    var uriIE = Uri.parse("https://us-central1-newsea-project.cloudfunctions.net/appRequest/getFilteredFeeds");

    // Convert lists to JSON arrays
    String countriesJson = jsonEncode(countries);
    String categoriesJson = jsonEncode(categories);

    // Construct the payload
    Map<String, dynamic> payload = {
      'countries': countriesJson,
      'categories': categoriesJson,
      'userLanguage': userLanguage,
    };

    //var payload = jsonEncode({"countries": countries, "categories": categories, "userLanguage": userLanguage});
    var response = await client.put(
      uriIE,
      body: payload,
    );

    if (response.statusCode == 200) {
      print("200");
      List<dynamic> responseBody = json.decode(response.body);
      List<FeedModel> feeds = responseBody.map((item) => FeedModel.fromJson(item as Map<String, dynamic>)).toList();
      print(feeds.length);
      return feeds;
    }
  }
}

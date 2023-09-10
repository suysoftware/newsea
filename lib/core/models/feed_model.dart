// To parse this JSON data, do
//
//     final feedModel = feedModelFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

FeedModel feedModelFromJson(String str) => FeedModel.fromJson(json.decode(str));

String feedModelToJson(FeedModel data) => json.encode(data.toJson());

class FeedModel {
  String? title;
  String? author;
  String? source;
  String? country;
  String? description;
  String? url;
  String? urlToImage;
  Timestamp? publishedAt;
  String? content;
  List<String>? categories;
  String? referenceNo;
  String? subReferenceNo;
  List<dynamic>? likes;

  FeedModel({
    required this.title,
    required this.author,
    required this.source,
    required this.country,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
    required this.categories,
    required this.referenceNo,
    required this.subReferenceNo,
    required this.likes,
  });

  factory FeedModel.fromJson(Map<String, dynamic> json) => FeedModel(
        title: json["title"],
        author: json["author"],
        source: json["source"],
        country: json["country"],
        description: json["description"],
        url: json["url"],
        urlToImage: json["urlToImage"],
        publishedAt: Timestamp(json["publishedAt"]["_seconds"], json["publishedAt"]["_nanoseconds"]),
        content: json["content"],
        categories: List<String>.from(json["categories"].map((x) => x)),
        referenceNo: json["referenceNo"],
        subReferenceNo: json["subReferenceNo"],
        likes: List<dynamic>.from(json["likes"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "author": author,
        "source": source,
        "country": country,
        "description": description,
        "url": url,
        "urlToImage": urlToImage,
        "publishedAt": publishedAt!.millisecondsSinceEpoch,
        "content": content,
        "categories": List<dynamic>.from(categories!.map((x) => x)),
        "referenceNo": referenceNo,
        "subReferenceNo": subReferenceNo,
        "likes": List<dynamic>.from(likes!.map((x) => x)),
      };
}

// To parse this JSON data, do
//
//     final nsUser = nsUserFromJson(jsonString);

import 'dart:convert';

NsUser nsUserFromJson(String str) => NsUser.fromJson(json.decode(str));

String nsUserToJson(NsUser data) => json.encode(data.toJson());

class NsUser {
    String userName;
    String userUid;
    String userLanguage;
    List<dynamic> targetCountries;
    List<dynamic> targetCategories;
    List<dynamic> userReadlist;
    String userAvatar;
    String userMessageToken;
    bool userNotificationSettings;

    NsUser({
        required this.userName,
        required this.userUid,
        required this.userLanguage,
        required this.targetCountries,
        required this.targetCategories,
        required this.userReadlist,
        required this.userAvatar,
        required this.userMessageToken,
        required this.userNotificationSettings,
    });

    factory NsUser.fromJson(Map<String, dynamic> json) => NsUser(
        userName: json["userName"],
        userUid: json["userUid"],
        userLanguage: json["userLanguage"],
        targetCountries: List<dynamic>.from(json["targetCountries"].map((x) => x)),
        targetCategories: List<dynamic>.from(json["targetCategories"].map((x) => x)),
        userReadlist: List<dynamic>.from(json["userReadlist"].map((x) => x)),
        userAvatar: json["userAvatar"],
        userMessageToken: json["userMessageToken"],
        userNotificationSettings: json["userNotificationSettings"],
    );

    Map<String, dynamic> toJson() => {
        "userName": userName,
        "userUid": userUid,
        "userLanguage": userLanguage,
        "targetCountries": List<dynamic>.from(targetCountries.map((x) => x)),
        "targetCategories": List<dynamic>.from(targetCategories.map((x) => x)),
        "userReadlist": List<dynamic>.from(userReadlist.map((x) => x)),
        "userAvatar": userAvatar,
        "userMessageToken": userMessageToken,
        "userNotificationSettings": userNotificationSettings,
    };
}

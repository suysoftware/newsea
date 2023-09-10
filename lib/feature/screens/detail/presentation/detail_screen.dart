import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsea/core/constants/app_colors.dart';
import 'package:newsea/core/models/feed_model.dart';
import 'package:newsea/core/utils/basic_functions.dart';
import 'package:newsea/feature/screens/home/controller/home_controller.dart';

class DetailScreen extends StatelessWidget {
  FeedModel feed;
  DetailScreen({required this.feed});
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: HomeController(),
        builder: (homeController) {
          return Scaffold(
              appBar: AppBar(
                elevation: 0,
                centerTitle: true,
                leadingWidth: double.maxFinite,
                backgroundColor: AppColors.themeWhite,
                leading: Row(
                  children: [
                    SizedBox(
                      width: 12,
                    ),
                    CupertinoButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: Icon(
                        CupertinoIcons.arrow_left,
                        color: AppColors.softBlack,
                      ),
                    ),
                    Spacer(),
                    CupertinoButton(
                        onPressed: () async {
                          if (homeController.nsUser.userReadlist.contains(feed.subReferenceNo)) {
                            await homeController.removeFeedFromBookmarks(feed);
                          } else {
                            await homeController.saveFeedToBookmarks(feed);
                          }
                        },
                        child: homeController.nsUser.userReadlist.contains(feed.subReferenceNo)
                            ? Icon(CupertinoIcons.bookmark_fill, color: AppColors.softBlack, size: 20)
                            : Icon(CupertinoIcons.bookmark, color: AppColors.softBlack, size: 20)),
                    CupertinoButton(
                      onPressed: () {},
                      child: Icon(
                        CupertinoIcons.share,
                        color: AppColors.softBlack,
                        size: 20,
                      ),
                    ),
                    SizedBox(width: 42),
                  ],
                ),
              ),
              body: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    children: [
                      if (feed.urlToImage != null)
                        ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: CachedNetworkImage(
                              imageUrl: feed.urlToImage!,
                              fit: BoxFit.cover,
                              filterQuality: FilterQuality.low,
                              height: 200,
                              width: double.maxFinite,
                            )),
                      SizedBox(
                        height: 24,
                      ),
                      Container(
                        child: AutoSizeText(
                          feed.title!,
                          style: GoogleFonts.cormorantSc(
                            fontSize: 30,
                            fontWeight: FontWeight.w800,
                            color: AppColors.softBlack,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child: BasicFunctions.getLinkFromName(feed.source!) != "error"
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(25),
                                    child: CachedNetworkImage(
                                      imageUrl: BasicFunctions.getLinkFromName(feed.source!),
                                      width: 20,
                                      height: 20,
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) => Container(),
                                      errorWidget: (context, url, error) => Icon(Icons.error),
                                    ))
                                : Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(25), color: Colors.grey),
                                    child: Center(
                                      child: Text(
                                        feed.source.toString()[0],
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(feed.source!,
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.textGrey,
                              )),
                          SizedBox(
                            width: 12,
                          ),
                          Text(
                            "·",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w900,
                              color: AppColors.textGrey,
                            ),
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          Text(
                            "Following",
                            style: TextStyle(fontSize: 12, color: AppColors.green, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 2,
                          ),
                          Text(
                            BasicFunctions.timeAgo(feed.publishedAt!.toDate()),
                            style: TextStyle(fontSize: 12, color: AppColors.textGrey),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      Container(
                        child: AutoSizeText(
                          feed.content!,
                          style: GoogleFonts.cormorant(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: AppColors.black,
                          ),
                        ),
                      ),
                    ],
                  )));
        });
  }
}

import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:newsea/core/constants/app_colors.dart';
import 'package:newsea/core/constants/app_styles.dart';
import 'package:newsea/core/models/feed_model.dart';
import 'package:newsea/core/utils/basic_functions.dart';
import 'package:newsea/core/widgets/line_widget.dart';

import 'package:newsea/feature/screens/detail/presentation/detail_screen.dart';
import 'package:sizer/sizer.dart';

class FeedCard extends StatelessWidget {
  FeedModel feed;
  FeedCard({required this.feed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DetailScreen(
                        feed: feed,
                      )));
        },
        child: Card(
          elevation: 0.0,
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 240,
                          child: AutoSizeText(
                            feed.title!,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                            maxLines: 3,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        BasicFunctions.getLinkFromName(feed.source!) != "error"
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
                        SizedBox(width: 6),
                        Text(
                          feed.source!,
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              BasicFunctions.timeAgo(feed.publishedAt!.toDate()),
                              style: TextStyle(fontSize: 12, color: AppColors.textGrey),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Icon(Icons.thumb_up, size: 16),
                            SizedBox(width: 4),
                            Text(
                              feed.likes!.length.toString(),
                              style: TextStyle(fontSize: 12, color: AppColors.textGrey),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Icon(Icons.comment, size: 16),
                            SizedBox(width: 4),
                            Text(
                              Random.secure().nextInt(100).toString(),
                              style: TextStyle(fontSize: 12, color: AppColors.textGrey),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    CachedNetworkImage(
                      imageUrl: feed.urlToImage ?? "https://picsum.photos/110/80",
                      placeholder: (context, url) => Container(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      width: 120,
                      height: 100,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget feedResourceTextBuild(String feedResource) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          feedResource,
          style: AppStyles.mainScreenTitleStyle,
        ),
      ],
    );
  }

  Widget feedDescriptionTextBuild(String description) {
    return RichText(text: TextSpan(text: description, style: AppStyles.mainScreenBodyStyle));
  }
}

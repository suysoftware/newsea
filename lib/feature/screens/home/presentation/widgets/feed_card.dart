
import 'package:flutter/material.dart';
import 'package:newsea/core/constants/app_colors.dart';
import 'package:newsea/core/constants/app_styles.dart';
import 'package:newsea/core/models/feed_model.dart';
import 'package:sizer/sizer.dart';

class FeedCard extends StatelessWidget {
  FeedModel feed;
  FeedCard({required this.feed});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          elevation: 0.0,
          surfaceTintColor: Colors.transparent,
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
          //    Navigator.pushNamed(context, "/Source",
            //      arguments: widget.source.id);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 1.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 80.w,
                    child: Column(
                      children: [
                        feedResourceTextBuild(feed.source.toString()),
                        SizedBox(
                          height: 10.0,
                        ),
                        feedDescriptionTextBuild(
                            feed.description.toString()),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                  SizedBox(
                      height: 16.0,
                      width: 16.0,
                      child: Icon(
                        Icons.keyboard_arrow_right,
                      ))
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 15.0,
        ),
        Text(
          "------------------------------------------------------",
          style: TextStyle(color: AppColors.mainListBorderStroke),
        )
      ],
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
    return RichText(
        text: TextSpan(
            text: description, style: AppStyles.mainScreenBodyStyle));
  }
}

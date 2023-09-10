import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsea/core/constants/app_colors.dart';
import 'package:newsea/core/models/feed_model.dart';
import 'package:newsea/core/utils/basic_functions.dart';
import 'package:newsea/feature/screens/home/controller/home_controller.dart';

class LanguageScreen extends StatelessWidget {
  LanguageScreen();
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
                    SizedBox(
                      width: 70,
                    ),
                    Text(
                      "Choose Language",
                      style: GoogleFonts.roboto(color: AppColors.softBlack, fontSize: 20, fontWeight: FontWeight.w200),
                    ),
                  ],
                ),
              ),
              body: Container(
                child: Column(
                  children: [
                    Flexible(
                        child: ListView.builder(
                      itemCount: BasicFunctions.getCountryCodesWithNames().length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          hoverColor: AppColors.textLightBlue,
                          onTap: () async {
                            await homeController.changeLanguage(BasicFunctions.getCountryCodesWithNames()[index]["name"]);

                            Get.back();
                          },
                          title: Row(
                            children: [
                              SizedBox(
                                width: 20,
                              ),
                              CountryFlag.fromCountryCode(
                                BasicFunctions.getCountryCodesWithNames()[index]["code"].toUpperCase(),
                                height: 48 * 0.7,
                                width: 62 * 0.7,
                                borderRadius: 8,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(BasicFunctions.getCountryCodesWithNames()[index]["name"]),
                            ],
                          ),
                        );
                      },
                    ))
                  ],
                ),
              ));
        });
  }
}

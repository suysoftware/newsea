import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newsea/core/constants/app_colors.dart';
import 'package:newsea/core/constants/app_styles.dart';
import 'package:newsea/core/widgets/conditional_widget.dart';
import 'package:newsea/feature/screens/home/controller/home_controller.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({super.key});

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  var countryList = <String>["All",   "United Arab Emirates",
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
  "Venezuela"];
  var categoryList = <String>["All", "Business", "Entertainment", "Health", "Science", "Sports", "Technology", "Weather"];

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: HomeController(),
        builder: (homeController) {
          return Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: Column(
              children: [
                /// Country List
                SizedBox(
                  height: 47,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: countryList.length,
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      return ConditionalWidget(
                        widget1: categoryButton(
                          countryList[index],
                          homeController.isCountryActive(
                            countryList[index],
                          ),
                          () {
                            homeController.changeFilteredCountries(
                              countryList[index],
                            );
                          },
                        ),
                        widget2: ConditionalWidget(
                          widget1: categoryButton(
                            countryList[index],
                            homeController.isCountryActive(
                              countryList[index],
                            ),
                            () {
                              homeController.changeFilteredCountries(
                                countryList[index],
                              );
                            },
                          ),
                          widget2: const SizedBox(),
                          condition: homeController.countries.isNotEmpty,
                        ),
                        condition: countryList[index] != "All",
                      );
                    },
                  ),
                ),

                const SizedBox(
                  height: 15.0,
                ),

                // CategoryList
                SizedBox(
                  height: 47,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categoryList.length,
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      return ConditionalWidget(
                        widget1: categoryButton(
                          categoryList[index],
                          homeController.isCategoryActive(
                            categoryList[index],
                          ),
                          () {
                            homeController.changeFilteredCategories(
                              categoryList[index],
                            );
                          },
                        ),
                        widget2: ConditionalWidget(
                          widget1: categoryButton(
                            categoryList[index],
                            homeController.isCategoryActive(
                              categoryList[index],
                            ),
                            () {
                              homeController.changeFilteredCategories(
                                categoryList[index],
                              );
                            },
                          ),
                          widget2: const SizedBox(),
                          condition: homeController.categories.isNotEmpty,
                        ),
                        condition: categoryList[index] != "All",
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        });
  }

  Widget categoryButton(
    String categoryName,
    bool buttonIsActive,
    Function() onPressed,
  ) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: ButtonTheme(
        child: OutlinedButton(
          style: ButtonStyle(
            backgroundColor: buttonIsActive ? MaterialStateProperty.all(AppColors.green) : MaterialStateProperty.all(AppColors.themeWhite),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(32.0))),
          ),
          onPressed: onPressed,
          child: Row(
            children: [
              Text(
                categoryName,
                style: buttonIsActive ? AppStyles.headlineWhite : AppStyles.headlineBlack,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

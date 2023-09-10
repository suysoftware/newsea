import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newsea/core/constants/app_colors.dart';
import 'package:newsea/core/constants/app_styles.dart';
import 'package:newsea/core/widgets/conditional_widget.dart';
import 'package:newsea/core/widgets/line_widget.dart';
import 'package:newsea/feature/screens/home/controller/home_controller.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({super.key});

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  /* var countryList = <String>[
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
  var categoryList = <String>["All", "Business", "Entertainment", "Health", "Science", "Sports", "Technology", "Weather"];
*/
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: HomeController(),
        builder: (homeController) {
          return Padding(
            padding: EdgeInsets.only(left: 12.0, bottom: homeController.getCategories().isNotEmpty || homeController.getCountries().isNotEmpty ? 15 : 0),
            child: Column(
              children: [
                /// Country List
                ///
                ///
                ///
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    mainCategoryButton(
                      "Trends",
                      homeController.isHomePageTrending,
                      () {
                        homeController.updateHomePageTrending(true);
                      },
                    ),
                    mainCategoryButton("Following", !homeController.isHomePageTrending, () {
                      homeController.updateHomePageTrending(false);
                    }),
                  ],
                ),

                SizedBox(
                  height: 15,
                ),
                if (homeController.getCountries().isNotEmpty)
                  SizedBox(
                    height: 47,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: homeController.getCountries().length,
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                        return ConditionalWidget(
                          widget1: subCategoryButton(
                            homeController.getCountries()[index],
                            homeController.isCountryActive(
                              homeController.getCountries()[index],
                            ),
                            () {
                              homeController.changeFilteredCountries(
                                homeController.getCountries()[index],
                              );
                            },
                          ),
                          widget2: ConditionalWidget(
                            widget1: subCategoryButton(
                              homeController.getCountries()[index],
                              homeController.isCountryActive(
                                homeController.getCountries()[index],
                              ),
                              () {
                                homeController.changeFilteredCountries(
                                  homeController.getCountries()[index],
                                );
                              },
                            ),
                            widget2: const SizedBox(),
                            condition: homeController.countries.isNotEmpty,
                          ),
                          condition: homeController.getCountries()[index] != "All",
                        );
                      },
                    ),
                  ),

                if (homeController.getCategories().isNotEmpty && homeController.getCountries().isNotEmpty) LineWidget(paddingValue: 12),

                // CategoryList
                if (homeController.getCategories().isNotEmpty)
                  SizedBox(
                    height: 47,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: homeController.getCategories().length,
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                        return ConditionalWidget(
                          widget1: subCategoryButton(
                            homeController.getCategories()[index],
                            homeController.isCategoryActive(
                              homeController.getCategories()[index],
                            ),
                            () {
                              homeController.changeFilteredCategories(
                                homeController.getCategories()[index],
                              );
                            },
                          ),
                          widget2: ConditionalWidget(
                            widget1: subCategoryButton(
                              homeController.getCategories()[index],
                              homeController.isCategoryActive(
                                homeController.getCategories()[index],
                              ),
                              () {
                                homeController.changeFilteredCategories(
                                  homeController.getCategories()[index],
                                );
                              },
                            ),
                            widget2: const SizedBox(),
                            condition: homeController.categories.isNotEmpty,
                          ),
                          condition: homeController.getCategories()[index] != "All",
                        );
                      },
                    ),
                  ),
              ],
            ),
          );
        });
  }

  Widget subCategoryButton(
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

  Widget mainCategoryButton(
    String categoryName,
    bool buttonIsActive,
    Function() onPressed,
  ) {
    return SizedBox(
      height: 50,
      width: 120,
      child: Padding(
        padding: const EdgeInsets.only(right: 10.0),
        child: ButtonTheme(
          child: OutlinedButton(
            style: ButtonStyle(
              backgroundColor: buttonIsActive ? MaterialStateProperty.all(AppColors.green) : MaterialStateProperty.all(AppColors.themeWhite),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))),
            ),
            onPressed: onPressed,
            child: Text(
              categoryName,
              style: buttonIsActive ? AppStyles.headlineWhite : AppStyles.headlineBlack,
            ),
          ),
        ),
      ),
    );
  }
}

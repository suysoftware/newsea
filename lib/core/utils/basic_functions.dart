import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BasicFunctions {
  static Map<String, String> sources = {
    'ABC News': 'https://w7.pngwing.com/pngs/142/945/png-transparent-abc-news-radio-new-york-city-breaking-news-others-text-logo-united-states-thumbnail.png',
    'ABC News (AU)': 'https://w7.pngwing.com/pngs/142/945/png-transparent-abc-news-radio-new-york-city-breaking-news-others-text-logo-united-states-thumbnail.png',
    'Aftenposten':
        'https://substackcdn.com/image/fetch/f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fbucketeer-e05bbc84-baa3-437e-9518-adb32be77984.s3.amazonaws.com%2Fpublic%2Fimages%2F163bfa9b-82a2-49f0-abdc-40467595ac21_512x512.png',
    'Al Jazeera English': 'https://w7.pngwing.com/pngs/230/966/png-transparent-al-jazeera-english-logo-al-jazeera-america-calligraphy-others-television-food-logo-thumbnail.png',
    'Argaam': 'https://www.argaam.com/content/ar/images/logos-05102015.png',
    'NBC News': 'https://i2.sdacdn.com/haber/2013/08/27/nbc-news-suriye-ye-en-erken-mudahale-persembe-gunu-4989458_4160_amp.jpg',
    'BBC News': 'https://upload.wikimedia.org/wikipedia/commons/thumb/e/ea/BBC_World_News_2022_%28Boxed%29.svg/800px-BBC_World_News_2022_%28Boxed%29.svg.png',
    'Bloomberg': 'https://cdn.icon-icons.com/icons2/2699/PNG/512/bloomberg_logo_icon_168504.png',
    'CBS News': 'https://upload.wikimedia.org/wikipedia/commons/thumb/2/29/CBC_News_Logo.svg/1200px-CBC_News_Logo.svg.png',
    'CNN': 'https://upload.wikimedia.org/wikipedia/commons/thumb/6/66/CNN_International_logo.svg/2048px-CNN_International_logo.svg.png',
    'Google News': 'https://cdn-1.webcatalog.io/catalog/google-news/google-news-icon-filled-256.png?v=1692505602976',
    'Google News (Argentina)': 'https://cdn-1.webcatalog.io/catalog/google-news/google-news-icon-filled-256.png?v=1692505602976',
    'Google News (Australia)': 'https://cdn-1.webcatalog.io/catalog/google-news/google-news-icon-filled-256.png?v=1692505602976',
    'Google News (Brasil)': 'https://cdn-1.webcatalog.io/catalog/google-news/google-news-icon-filled-256.png?v=1692505602976',
    'Google News (Canada)': 'https://cdn-1.webcatalog.io/catalog/google-news/google-news-icon-filled-256.png?v=1692505602976',
    'Google News (France)': 'https://cdn-1.webcatalog.io/catalog/google-news/google-news-icon-filled-256.png?v=1692505602976',
    'Google News (India)': 'https://cdn-1.webcatalog.io/catalog/google-news/google-news-icon-filled-256.png?v=1692505602976',
    'Google News (Israel)': 'https://cdn-1.webcatalog.io/catalog/google-news/google-news-icon-filled-256.png?v=1692505602976',
    'Google News (Italy)': 'https://cdn-1.webcatalog.io/catalog/google-news/google-news-icon-filled-256.png?v=1692505602976',
    'Google News (Russia)': 'https://cdn-1.webcatalog.io/catalog/google-news/google-news-icon-filled-256.png?v=1692505602976',
    'Google News (Saudi Arabia)': 'https://cdn-1.webcatalog.io/catalog/google-news/google-news-icon-filled-256.png?v=1692505602976',
    'Google News (UK)': 'https://cdn-1.webcatalog.io/catalog/google-news/google-news-icon-filled-256.png?v=1692505602976',
    'Reuters': 'https://cdn.icon-icons.com/icons2/2699/PNG/512/reuters_logo_icon_170782.png',
    'USA Today': 'https://seeklogo.com/images/U/usa-today-logo-808B312E91-seeklogo.com.png',
    'The Washington Post': 'https://upload.wikimedia.org/wikipedia/commons/b/bf/Washington_Post_favicon.png',
    'The Washington Times': 'https://frontgatemedia.com/wp-content/uploads/2014/02/logo_washintontimes.png',
    'The Wall Street Journal': 'https://w7.pngwing.com/pngs/169/181/png-transparent-the-wall-street-journal-logo-others-miscellaneous-company-text.png',
    'YouTube': 'https://e7.pngegg.com/pngimages/208/269/png-clipart-youtube-play-button-computer-icons-youtube-youtube-logo-angle-rectangle-thumbnail.png',
    'Politico': 'https://upload.wikimedia.org/wikipedia/commons/3/34/LOGO-POLITICO.png',
    'CBS Sports': 'https://seeklogo.com/images/C/cbs-sports-logo-5DF461F39C-seeklogo.com.png',
    'Texas Public Radio': 'https://m.media-amazon.com/images/I/6124vERf1RL.png',
    'Thenationaldesk.com': 'https://okcfox.com/resources/media/f5300a3b-c795-45e5-9161-976015d1a45e-full16x9_TND_letters_blk1.png?1611848598416'
  };

  static String getLinkFromName(String name) {
    return sources[name] ?? 'error';
  }

  static String timeAgo(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inSeconds < 60) {
      return '${difference.inSeconds} seconds ago';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} mins ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hours ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      return DateFormat('yMMMd').format(date);
    }
  }

  // Create Dart Maps to represent enums
  static const Map<String, String> countryLanguageEnum = {
    "ae": "UnitedArabEmiratesArabic",
    "ar": "ArgentinaSpanish",
    "at": "AustriaGerman",
    "au": "AustraliaEnglish",
    "bg": "Bulgarian",
    "br": "BrazilPortugue",
    "cn": "Mandarin",
    "co": "ColombiaSpanish",
    "cu": "CubaSpanish",
    "cz": "Czech",
    "de": "German",
    "eg": "EgyptArabic",
    "fr": "French",
    "gb": "BritishEnglish",
    "gr": "Greek",
    "hu": "Hungarian",
    "id": "Indonesian",
    "it": "Italian",
    "jp": "Japanese",
    "kr": "Korean",
    "lt": "Lithuanian",
    "lv": "Latvian",
    "mx": "MexicoSpanish",
    "my": "Malay",
    "ng": "NigeriaEnglish",
    "nl": "Dutch",
    "no": "Norwegian",
    "pl": "Polish",
    "pt": "Portuguese",
    "ro": "Romanian",
    "rs": "Serbian",
    "ru": "Russian",
    "sa": "SaudiArabiaArabic",
    "se": "Swedish",
    "si": "Slovenian",
    "sk": "Slovak",
    "th": "Thai",
    "tr": "Turkish",
    "ua": "Ukrainian",
    "us": "AmericanEnglish",
    "ve": "VenezuelaSpanish",
  };

  static const Map<String, String> countryCodeEnum = {
    "ae": "United Arab Emirates",
    "ar": "Argentina",
    "at": "Austria",
    "au": "Australia",
    "bg": "Bulgaria",
    "br": "Brazil",
    "cn": "China",
    "co": "Colombia",
    "cu": "Cuba",
    "cz": "Czech Republic",
    "de": "Germany",
    "eg": "Egypt",
    "fr": "France",
    "gb": "United Kingdom",
    "gr": "Greece",
    "hu": "Hungary",
    "id": "Indonesia",
    "it": "Italy",
    "jp": "Japan",
    "kr": "South Korea",
    "lt": "Lithuania",
    "lv": "Latvia",
    "mx": "Mexico",
    "my": "Malaysia",
    "ng": "Nigeria",
    "nl": "Netherlands",
    "no": "Norway",
    "pl": "Poland",
    "pt": "Portugal",
    "ro": "Romania",
    "rs": "Serbia",
    "ru": "Russia",
    "sa": "Saudi Arabia",
    "se": "Sweden",
    "si": "Slovenia",
    "sk": "Slovakia",
    "th": "Thailand",
    "tr": "Turkey",
    "ua": "Ukraine",
    "us": "United States",
    "ve": "Venezuela"
  };

  static const Map<String, String> languageCountryEnum = {
    "UnitedArabEmiratesArabic": "United Arab Emirates",
    "ArgentinaSpanish": "Argentina",
    "AustriaGerman": "Austria",
    "AustraliaEnglish": "Australia",
    "Bulgarian": "Bulgaria",
    "BrazilPortugue": "Brazil",
    "Mandarin": "China",
    "ColombiaSpanish": "Colombia",
    "CubaSpanish": "Cuba",
    "Czech": "Czech Republic",
    "German": "Germany",
    "EgyptArabic": "Egypt",
    "French": "France",
    "BritishEnglish": "United Kingdom",
    "Greek": "Greece",
    "Hungarian": "Hungary",
    "Indonesian": "Indonesia",
    "Italian": "Italy",
    "Japanese": "Japan",
    "Korean": "South Korea",
    "Lithuanian": "Lithuania",
    "Latvian": "Latvia",
    "MexicoSpanish": "Mexico",
    "Malay": "Malaysia",
    "NigeriaEnglish": "Nigeria",
    "Dutch": "Netherlands",
    "Norwegian": "Norway",
    "Polish": "Poland",
    "Portuguese": "Portugal",
    "Romanian": "Romania",
    "Serbian": "Serbia",
    "Russian": "Russia",
    "SaudiArabiaArabic": "Saudi Arabia",
    "Swedish": "Sweden",
    "Slovenian": "Slovenia",
    "Slovak": "Slovakia",
    "Thai": "Thailand",
    "Turkish": "Turkey",
    "Ukrainian": "Ukraine",
    "AmericanEnglish": "United States",
    "VenezuelaSpanish": "Venezuela"
  };

  static const Map<String, Icon> categoryIconEnum = {
    "Business": Icon(
      Icons.business,
      size: 62 * 0.7,
    ),
    "Entertainment": Icon(
      Icons.movie,
      size: 62 * 0.7,
    ),
    "Health": Icon(
      Icons.health_and_safety,
      size: 62 * 0.7,
    ),
    "Science": Icon(
      Icons.science,
      size: 62 * 0.7,
    ),
    "Sports": Icon(
      Icons.sports,
      size: 62 * 0.7,
    ),
    "Technology": Icon(
      Icons.computer,
      size: 62 * 0.7,
    ),
    "Weather": Icon(
      Icons.wb_sunny,
      size: 62 * 0.7,
    )
  };
// Function to get country code by language
  static String getCountryCodeByLanguage(String language) {
    final String? countryCode = countryLanguageEnum.entries
        .firstWhere(
          (entry) => entry.value == language,
          orElse: () => MapEntry("Unknown", "Unknown"),
        )
        ?.key;
    return countryCode ?? 'Unknown';
  }

// Function to get language by country code
  static String getLanguageByCountryCode(String code) {
    return countryLanguageEnum[code.toLowerCase()] ?? 'Unknown';
  }

// Function to get country name by code
  static String getCountryNameByCode(String code) {
    return countryCodeEnum[code.toLowerCase()] ?? 'Unknown';
  }

// Function to get country by language
  String getCountryByLanguage(String language) {
    return languageCountryEnum[language] ?? 'Unknown';
  }

  static List<dynamic> getCountryCodesWithNames() {
    List<dynamic> countryCodesWithNames = [];

    for (var i = 0; i < countryCodeEnum.length; i++) {
      countryCodesWithNames.add({'code': countryLanguageEnum.keys.elementAt(i), 'name': countryLanguageEnum.values.elementAt(i)});
    }

    return countryCodesWithNames;
  }

  static List<dynamic> getExploreItems() {
    List<dynamic> exploreItems = [];

    for (var i = 0; i < sources.length; i++) {
      exploreItems.add({'name': sources.keys.elementAt(i), 'image': sources.values.elementAt(i), 'type': "source"});
    }

    for (var i = 0; i < countryCodeEnum.length; i++) {
      exploreItems.add({'name': countryCodeEnum.values.elementAt(i), 'image': countryCodeEnum.keys.elementAt(i), 'type': "country"});
    }

    for (var i = 0; i < categoryIconEnum.length; i++) {
      exploreItems.add({'name': categoryIconEnum.keys.elementAt(i), 'image': categoryIconEnum.keys.elementAt(i), 'type': "category"});
    }

    return exploreItems;
  }
// You can also export these functionalities if you are using them across multiple Dart files.
}

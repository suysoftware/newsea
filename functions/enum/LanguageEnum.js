const countryLanguageEnum = {
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





function getLanguageByCountryCode(code) {
    return countryLanguageEnum[code.toLowerCase()] || 'Unknown';
}








const countryCodeEnum = {
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

function getCountryNameByCode(code) {
    return countryCodeEnum[code.toLowerCase()] || 'Unknown';
  }
// Test the function
//console.log(getLanguageByCountryCode('ae'));  // Output: "Arabic"
const languageCountryEnum = {
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
  
  function getCountryByLanguage(language) {
    return languageCountryEnum[language] || 'Unknown';
  }





module.exports = {getLanguageByCountryCode, getCountryNameByCode, getCountryByLanguage};
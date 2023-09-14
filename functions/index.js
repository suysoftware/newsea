const functions = require("firebase-functions");
const admin = require("firebase-admin");
const express = require('express');
const cors = require('cors')({ origin: true });



const app = express();
app.use(cors);


admin.initializeApp(functions.config().firestore);
const db = admin.firestore();


const { getNews, getNewsFunction } = require('./GetNews/GetNews');
const translateFeed = require('./TranslateFeed/TranslateFeed');
const { getLanguageByCountryCode, getCountryNameByCode, getCountryByLanguage } = require('./enum/LanguageEnum');
const translatedFeedToDatabase = require('./TriggeredFunctions/TranslatedFeedToDatabase');
const getTranslatedFeed = require('./TranslateFeed/TranslatedFeedGet');
const getBookmarkFeeds = require('./FirestoreOperations/GetBookmarkFeeds');
const getFilteredFeeds = require('./FirestoreOperations/GetFilteredFeeds');

app.put('/getNews', getNews);

app.get('/getTranslatedFeed', getTranslatedFeed);

app.get('/getBookmarkFeeds', getBookmarkFeeds)

app.put('/getFilteredFeeds', getFilteredFeeds)




/*{
"source": {
"id": "the-washington-post",
"name": "The Washington Post"
},
"author": "Henrik Bahlmann",
"title": "Was lange wäscht…",
"description": "Gute Spülmaschinen sind leider teuer, stellt die Stiftung Warentest fest und gibt einer Kategorie durchweg mäßige Noten. Am meisten spart, wer einen simplen Tipp beherzigt.",
"url": "https://www.washingtonpost.com/wellness/2023/09/10/grandfather-post-polio-syndrome/",
"urlToImage": "https://firebasestorage.googleapis.com/v0/b/newsea-project.appspot.com/o/Screenshot%202023-09-10%20at%2016.37.11.png?alt=media&token=58db26af-486a-42e9-8e25-4782c79b5deb",
"publishedAt": "2023-09-10T15:31:34Z",
"content": "Was teil- und vollintegrierte Spüler unterscheidet, ist die Lage der Bedienelemente: Bei den vollintegrierten stecken sie in der Oberseite der Tür. Dadurch kann die Gehäusefront komplett dem Design der Küche angepasst werden. Teilintegrierte Geräte hingegen haben eine Bedienblende auf der Vorderseite, sodass nur der untere Teil mit einer Frontplatte im Look der Küchenmöbel versehen werden kann. Eine dritte Variante sind frei stehende Maschinen, die bei diesem Test aber nicht berücksichtigt wurden."
}

 */
app.put('/addManuelFeed', async (req, res, next) => {

    const fromLanguage = req.query.fromLanguage;
    const feedSourceId = req.query.id;
    const feedSourceName = req.query.name;
    const feedAuthor = req.query.author;
    const feedTitle = req.query.title;
    const feedDescription = req.query.description;
    const feedUrl = req.query.url;
    const feedUrlToImage = req.query.urlToImage;
    const feedPublishedAt = req.query.publishedAt;
    const feedContent = req.query.content;






    const articleRef = db.collection('manuel_feeds').doc(fromLanguage).collection("feeds");

    try {
        await articleRef.add({
            "source": {
            "id": feedSourceId,
            "name": feedSourceName
            },
            "author": feedAuthor,
            "title": feedTitle,
            "description": feedDescription,
            "url": feedUrl,
            "urlToImage": feedUrlToImage,
            "publishedAt": feedPublishedAt,
            "content": "Was teil- und vollintegrierte Spüler unterscheidet, ist die Lage der Bedienelemente: Bei den vollintegrierten stecken sie in der Oberseite der Tür. Dadurch kann die Gehäusefront komplett dem Design der Küche angepasst werden. Teilintegrierte Geräte hingegen haben eine Bedienblende auf der Vorderseite, sodass nur der untere Teil mit einer Frontplatte im Look der Küchenmöbel versehen werden kann. Eine dritte Variante sind frei stehende Maschinen, die bei diesem Test aber nicht berücksichtigt wurden."
            });
        res.status(200).send('Successfully added article');
    } catch (error) {
        console.error("Error adding article: ", error);
        res.status(500).send('Internal Server Error');
    }
});



/*
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
    "VenezuelaSpanish": "Venezuela" */


/*
exports.createdFeedToArabic = functions.firestore.document('original_feeds/{feedLanguage}/feeds/{feedId}').onCreate(async (snap, context) => {

    const toLanguage = "UnitedArabEmiratesArabic";

    await translatedFeedToDatabase(snap.data(), toLanguage, context.params.feedLanguage, context.params.feedId);

});

exports.createdFeedToArgentinaSpanish = functions.firestore.document('original_feeds/{feedLanguage}/feeds/{feedId}').onCreate(async (snap, context) => {

    const toLanguage = "ArgentinaSpanish";

    await translatedFeedToDatabase(snap.data(), toLanguage, context.params.feedLanguage, context.params.feedId);
});

exports.createdFeedToAustriaGerman = functions.firestore.document('original_feeds/{feedLanguage}/feeds/{feedId}').onCreate(async (snap, context) => {

    const toLanguage = "AustriaGerman";

    await translatedFeedToDatabase(snap.data(), toLanguage, context.params.feedLanguage, context.params.feedId);
});

exports.createdFeedToAustralianEnglish = functions.firestore.document('original_feeds/{feedLanguage}/feeds/{feedId}').onCreate(async (snap, context) => {

    const toLanguage = "AustralianEnglish";

    await translatedFeedToDatabase(snap.data(), toLanguage, context.params.feedLanguage, context.params.feedId);
});


exports.createdFeedToBulgarian = functions.firestore.document('original_feeds/{feedLanguage}/feeds/{feedId}').onCreate(async (snap, context) => {

    const toLanguage = "Bulgarian";

    await translatedFeedToDatabase(snap.data(), toLanguage, context.params.feedLanguage, context.params.feedId);

});

exports.createdFeedToBrazilPortugue = functions.firestore.document('original_feeds/{feedLanguage}/feeds/{feedId}').onCreate(async (snap, context) => {

    const toLanguage = "BrazilPortugue";

    await translatedFeedToDatabase(snap.data(), toLanguage, context.params.feedLanguage, context.params.feedId);

});

exports.createdFeedToMandarin = functions.firestore.document('original_feeds/{feedLanguage}/feeds/{feedId}').onCreate(async (snap, context) => {

    const toLanguage = "Mandarin";

    await translatedFeedToDatabase(snap.data(), toLanguage, context.params.feedLanguage, context.params.feedId);

});


exports.createdFeedToColombiaSpanish = functions.firestore.document('original_feeds/{feedLanguage}/feeds/{feedId}').onCreate(async (snap, context) => {

    const toLanguage = "ColombiaSpanish";

    await translatedFeedToDatabase(snap.data(), toLanguage, context.params.feedLanguage, context.params.feedId);

});


exports.createdFeedToCubaSpanish = functions.firestore.document('original_feeds/{feedLanguage}/feeds/{feedId}').onCreate(async (snap, context) => {

    const toLanguage = "CubaSpanish";

    await translatedFeedToDatabase(snap.data(), toLanguage, context.params.feedLanguage, context.params.feedId);

});


exports.createdFeedToCzech = functions.firestore.document('original_feeds/{feedLanguage}/feeds/{feedId}').onCreate(async (snap, context) => {

    const toLanguage = "Czech";

    await translatedFeedToDatabase(snap.data(), toLanguage, context.params.feedLanguage, context.params.feedId);

});


exports.createdFeedToGerman = functions.firestore.document('original_feeds/{feedLanguage}/feeds/{feedId}').onCreate(async (snap, context) => {

    const toLanguage = "German";

    await translatedFeedToDatabase(snap.data(), toLanguage, context.params.feedLanguage, context.params.feedId);

});


exports.createdFeedToEgyptArabic = functions.firestore.document('original_feeds/{feedLanguage}/feeds/{feedId}').onCreate(async (snap, context) => {

    const toLanguage = "EgyptArabic";

    await translatedFeedToDatabase(snap.data(), toLanguage, context.params.feedLanguage, context.params.feedId);

});


exports.createdFeedToFrench = functions.firestore.document('original_feeds/{feedLanguage}/feeds/{feedId}').onCreate(async (snap, context) => {

    const toLanguage = "French";

    await translatedFeedToDatabase(snap.data(), toLanguage, context.params.feedLanguage, context.params.feedId);

});


exports.createdFeedToBritishEnglish = functions.firestore.document('original_feeds/{feedLanguage}/feeds/{feedId}').onCreate(async (snap, context) => {

    const toLanguage = "BritishEnglish";

    await translatedFeedToDatabase(snap.data(), toLanguage, context.params.feedLanguage, context.params.feedId);

});


exports.createdFeedToGreek = functions.firestore.document('original_feeds/{feedLanguage}/feeds/{feedId}').onCreate(async (snap, context) => {

    const toLanguage = "Greek";

    await translatedFeedToDatabase(snap.data(), toLanguage, context.params.feedLanguage, context.params.feedId);

});


exports.createdFeedToHungarian = functions.firestore.document('original_feeds/{feedLanguage}/feeds/{feedId}').onCreate(async (snap, context) => {

    const toLanguage = "Hungarian";

    await translatedFeedToDatabase(snap.data(), toLanguage, context.params.feedLanguage, context.params.feedId);

});


exports.createdFeedToIndonesian = functions.firestore.document('original_feeds/{feedLanguage}/feeds/{feedId}').onCreate(async (snap, context) => {

    const toLanguage = "Indonesian";

    await translatedFeedToDatabase(snap.data(), toLanguage, context.params.feedLanguage, context.params.feedId);

});


exports.createdFeedToItalian = functions.firestore.document('original_feeds/{feedLanguage}/feeds/{feedId}').onCreate(async (snap, context) => {

    const toLanguage = "Italian";

    await translatedFeedToDatabase(snap.data(), toLanguage, context.params.feedLanguage, context.params.feedId);

});


exports.createdFeedToJapanese = functions.firestore.document('original_feeds/{feedLanguage}/feeds/{feedId}').onCreate(async (snap, context) => {

    const toLanguage = "Japanese";

    await translatedFeedToDatabase(snap.data(), toLanguage, context.params.feedLanguage, context.params.feedId);

});


exports.createdFeedToKorean = functions.firestore.document('original_feeds/{feedLanguage}/feeds/{feedId}').onCreate(async (snap, context) => {

    const toLanguage = "Korean";

    await translatedFeedToDatabase(snap.data(), toLanguage, context.params.feedLanguage, context.params.feedId);

});


exports.createdFeedToLithuanian = functions.firestore.document('original_feeds/{feedLanguage}/feeds/{feedId}').onCreate(async (snap, context) => {

    const toLanguage = "Lithuanian";

    await translatedFeedToDatabase(snap.data(), toLanguage, context.params.feedLanguage, context.params.feedId);

});


exports.createdFeedToLatvian = functions.firestore.document('original_feeds/{feedLanguage}/feeds/{feedId}').onCreate(async (snap, context) => {

    const toLanguage = "Latvian";

    await translatedFeedToDatabase(snap.data(), toLanguage, context.params.feedLanguage, context.params.feedId);

});


exports.createdFeedToMexicoSpanish = functions.firestore.document('original_feeds/{feedLanguage}/feeds/{feedId}').onCreate(async (snap, context) => {

    const toLanguage = "MexicoSpanish";

    await translatedFeedToDatabase(snap.data(), toLanguage, context.params.feedLanguage, context.params.feedId);

});


exports.createdFeedToMalay = functions.firestore.document('original_feeds/{feedLanguage}/feeds/{feedId}').onCreate(async (snap, context) => {

    const toLanguage = "Malay";

    await translatedFeedToDatabase(snap.data(), toLanguage, context.params.feedLanguage, context.params.feedId);

});


exports.createdFeedToNigeriaEnglish = functions.firestore.document('original_feeds/{feedLanguage}/feeds/{feedId}').onCreate(async (snap, context) => {

    const toLanguage = "NigeriaEnglish";

    await translatedFeedToDatabase(snap.data(), toLanguage, context.params.feedLanguage, context.params.feedId);

});


exports.createdFeedToDutch = functions.firestore.document('original_feeds/{feedLanguage}/feeds/{feedId}').onCreate(async (snap, context) => {

    const toLanguage = "Dutch";

    await translatedFeedToDatabase(snap.data(), toLanguage, context.params.feedLanguage, context.params.feedId);

});


exports.createdFeedToNorwegian = functions.firestore.document('original_feeds/{feedLanguage}/feeds/{feedId}').onCreate(async (snap, context) => {

    const toLanguage = "Norwegian";

    await translatedFeedToDatabase(snap.data(), toLanguage, context.params.feedLanguage, context.params.feedId);

});


exports.createdFeedToPolish = functions.firestore.document('original_feeds/{feedLanguage}/feeds/{feedId}').onCreate(async (snap, context) => {

    const toLanguage = "Polish";

    await translatedFeedToDatabase(snap.data(), toLanguage, context.params.feedLanguage, context.params.feedId);

});


exports.createdFeedToPortuguese = functions.firestore.document('original_feeds/{feedLanguage}/feeds/{feedId}').onCreate(async (snap, context) => {

    const toLanguage = "Portuguese";

    await translatedFeedToDatabase(snap.data(), toLanguage, context.params.feedLanguage, context.params.feedId);

});


exports.createdFeedToRomanian = functions.firestore.document('original_feeds/{feedLanguage}/feeds/{feedId}').onCreate(async (snap, context) => {

    const toLanguage = "Romanian";

    await translatedFeedToDatabase(snap.data(), toLanguage, context.params.feedLanguage, context.params.feedId);

});


exports.createdFeedToSerbian = functions.firestore.document('original_feeds/{feedLanguage}/feeds/{feedId}').onCreate(async (snap, context) => {

    const toLanguage = "Serbian";

    await translatedFeedToDatabase(snap.data(), toLanguage, context.params.feedLanguage, context.params.feedId);

});


exports.createdFeedToRussian = functions.firestore.document('original_feeds/{feedLanguage}/feeds/{feedId}').onCreate(async (snap, context) => {

    const toLanguage = "Russian";

    await translatedFeedToDatabase(snap.data(), toLanguage, context.params.feedLanguage, context.params.feedId);

});


exports.createdFeedToSaudiArabiaArabic = functions.firestore.document('original_feeds/{feedLanguage}/feeds/{feedId}').onCreate(async (snap, context) => {

    const toLanguage = "SaudiArabiaArabic";

    await translatedFeedToDatabase(snap.data(), toLanguage, context.params.feedLanguage, context.params.feedId);

});


exports.createdFeedToSwedish = functions.firestore.document('original_feeds/{feedLanguage}/feeds/{feedId}').onCreate(async (snap, context) => {

    const toLanguage = "Swedish";

    await translatedFeedToDatabase(snap.data(), toLanguage, context.params.feedLanguage, context.params.feedId);

});


exports.createdFeedToSlovenian = functions.firestore.document('original_feeds/{feedLanguage}/feeds/{feedId}').onCreate(async (snap, context) => {

    const toLanguage = "Slovenian";

    await translatedFeedToDatabase(snap.data(), toLanguage, context.params.feedLanguage, context.params.feedId);

});


exports.createdFeedToSlovak = functions.firestore.document('original_feeds/{feedLanguage}/feeds/{feedId}').onCreate(async (snap, context) => {

    const toLanguage = "Slovak";

    await translatedFeedToDatabase(snap.data(), toLanguage, context.params.feedLanguage, context.params.feedId);

});


exports.createdFeedToThai = functions.firestore.document('original_feeds/{feedLanguage}/feeds/{feedId}').onCreate(async (snap, context) => {

    const toLanguage = "Thai";

    await translatedFeedToDatabase(snap.data(), toLanguage, context.params.feedLanguage, context.params.feedId);

});

*/
exports.createdFeedToTurkish = functions.firestore.document('original_feeds/{feedLanguage}/feeds/{feedId}').onCreate(async (snap, context) => {

    const toLanguage = "Turkish";

    await translatedFeedToDatabase(snap.data(), toLanguage, context.params.feedLanguage, context.params.feedId);

});
/*

exports.createdFeedToUkrainian = functions.firestore.document('original_feeds/{feedLanguage}/feeds/{feedId}').onCreate(async (snap, context) => {

    const toLanguage = "Ukrainian";



    await translatedFeedToDatabase(snap.data(), toLanguage, context.params.feedLanguage, context.params.feedId);

});


exports.createdFeedToAmericanEnglish = functions.firestore.document('original_feeds/{feedLanguage}/feeds/{feedId}').onCreate(async (snap, context) => {

    const toLanguage = "AmericanEnglish";

    await translatedFeedToDatabase(snap.data(), toLanguage, context.params.feedLanguage, context.params.feedId);

});


exports.createdFeedToVenezuelaSpanish = functions.firestore.document('original_feeds/{feedLanguage}/feeds/{feedId}').onCreate(async (snap, context) => {

    const toLanguage = "VenezuelaSpanish";

    await translatedFeedToDatabase(snap.data(), toLanguage, context.params.feedLanguage, context.params.feedId);

});
*/
exports.createNewUser = functions.auth.user().onCreate(async (user) => {
    const newUserUid = user.uid;
    const usersRef = db.collection('users').doc(newUserUid);

    await usersRef.set({

        "userName": "",
        "userUid": newUserUid,
        "userLanguage": "AmericanEnglish",
        "targetCountries": [],
        "targetCategories": [],
        "userReadlist": [],
        "userAvatar": "",
        "userMessageToken": "",
        "userNotificationSettings": false,
    });
});

exports.manuelFeedToTurkish = functions.firestore.document('manuel_feeds/{feedLanguage}/feeds/{feedId}').onCreate(async (snap, context) => {

    const toLanguage = "Turkish";

    await translatedFeedToDatabase(snap.data(), toLanguage, context.params.feedLanguage, context.params.feedId);

});








/*
    "ae": "UnitedArabEmiratesArabic","ar": "ArgentinaSpanish",
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
    "ve": "VenezuelaSpanish", */
//schule function
/*exports.scheduledUsFunction = functions.pubsub.schedule('every 240 minutes').onRun(async (context) => {
    const languageCountryArray = ["ae", "ar", "at", "au", "bg", "br", "cn", "co", "cu", "cz", "de", "eg", "fr", "gb", "gr", "hu", "id", "it", "jp", "kr", "lt", "lv", "mx", "my", "ng", "nl", "no", "pl", "pt", "ro", "rs", "ru", "sa", "se", "si", "sk", "th", "tr", "ua", "us", "ve"];

    for (let index = 0; index < languageCountryArray.length; index++) {
        await getNewsFunction(languageCountryArray[index]);
    }


});*/

/*exports.scheduledUsFunction = functions.pubsub.schedule('every 10 minutes').onRun(async (context) => {
    await getNewsFunction('us');


});*/


exports.appRequest = functions.https.onRequest(app);
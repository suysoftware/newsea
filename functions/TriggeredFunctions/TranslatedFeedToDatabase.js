
const functions = require("firebase-functions");
const admin = require("firebase-admin");
const db = admin.firestore();
const translateFeed = require('../TranslateFeed/TranslateFeed');
const { getLanguageByCountryCode, getCountryNameByCode, getCountryByLanguage } = require('../enum/LanguageEnum');


const translatedFeedToDatabase = async (feedData, toLanguage, fromLanguage, feedId) => {
    try {
        var translatedData = await translateFeed(feedData, fromLanguage, toLanguage);
        var translatedFeedReference = db.collection('translated_feeds').doc(toLanguage).collection("feeds").doc();
        var date = new Date(feedData.publishedAt);

        if (translatedData.categories.length == 0 || translatedData.categories == null || translatedData.categories == undefined || translatedData.content == undefined || translatedData.content == "" || translatedData.description == undefined || translatedData.description == "" || translatedData.title == "" || translatedData.title == undefined) {
            translatedData.content = "haber apisi tarafından veri yok content";
            translatedData.description = "haber apisi tarafından veri yok description";
        }
        await translatedFeedReference.set(
            {
                title: translatedData.title,
                author: feedData.author,
                source: feedData.source["name"],
                country: getCountryByLanguage(fromLanguage),
                description: translatedData.description,
                url: feedData.url,
                urlToImage: feedData.urlToImage,
                publishedAt: date,
                content: translatedData.content,
                categories: translatedData.categories,
                referenceNo: feedId,
                subReferenceNo: translatedFeedReference.id,
                likes: []
            }
            
        );



    } catch (error) {
        console.error("Error fetching news or writing to Firestore: ", error);

    }
};


module.exports = translatedFeedToDatabase;
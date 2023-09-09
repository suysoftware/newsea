const functions = require("firebase-functions");
const admin = require("firebase-admin");
const express = require('express');
const cors = require('cors')({ origin: true });



const app = express();
app.use(cors);


admin.initializeApp(functions.config().firestore);
const db = admin.firestore();


const getNews = require('./GetNews/GetNews');
const translateFeed = require('./TranslateFeed/TranslateFeed');



app.put('/getNews', getNews);


exports.createdFeedToTurkish = functions.firestore.document('original_feeds/{feedId}').onCreate(async (snap, context) => {
    console.log("tetiklendi");
    var feedData = snap.data();

    var translatedData = await translateFeed(feedData, "English", "Turkish");
    //
    var translatedFeedReference = db.collection('translated_feeds').doc("turkish").collection("feeds").doc();

    await translatedFeedReference.set(
        {
            title: translatedData,
            author: snap.data().author,
            source: snap.data().source["name"],
            country: "USA",
            description: snap.data().description,
            url: snap.data().url,
            urlToImage: snap.data().urlToImage,
            publishedAt: snap.data().publishedAt,
            content: snap.data().content,
            categories: [],
            referenceNo: context.params.feedId,
            subReferenceNo: translatedFeedReference.id,
            likes: []
        }
    );



});


exports.appRequest = functions.https.onRequest(app);
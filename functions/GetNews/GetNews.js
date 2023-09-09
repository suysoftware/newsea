const admin = require("firebase-admin");
const db = admin.firestore();
const auth = admin.auth();
const storage = admin.storage();
const NewsAPI = require('newsapi');
require('dotenv').config()
const newsapi = new NewsAPI(process.env.NEWS_API_KEY);
const Levenshtein = require('fast-levenshtein');
const THRESHOLD = 5;
const { getLanguageByCountryCode, getCountryNameByCode, getCountryByLanguage } = require('../enum/LanguageEnum');
const isSimilarArticle = (newArticle, existingArticles) => {
    for (const existingArticle of existingArticles) {
        const distance = Levenshtein.get(newArticle.title, existingArticle.title);
        if (distance < THRESHOLD) {
            return true;
        }
    }
    return false;
};



const getNews = async (req, res, next) => {
    try {
        const response = await newsapi.v2.topHeadlines({
            country: req.query.country
        });

        const existingArticlesSnapshot = await db.collection('original_feeds').get();
        const existingArticles = existingArticlesSnapshot.docs.map(doc => doc.data());

        const articlePromises = response.articles.map(async (article) => {
            console.log(article);

            if (!isSimilarArticle(article, existingArticles) || existingArticles.length === 0) {
                return db.collection('original_feeds').doc(getLanguageByCountryCode(req.query.country)).collection("feeds").add(article);
            } else {
                console.log(`Article '${article.title}' is similar to existing one. Skipping.`);
                return null;
            }
        });

        await Promise.all(articlePromises);

        res.status(200).send('Successfully processed articles');

    } catch (error) {
        console.error("Error fetching news or writing to Firestore: ", error);
        res.status(500).send('Internal Server Error');
    }
};
const getNewsFunction = async (country) => {
    try {
        const response = await newsapi.v2.topHeadlines({
            country: country
        });

        const existingArticlesSnapshot = await db.collection('original_feeds').get();
        const existingArticles = existingArticlesSnapshot.docs.map(doc => doc.data());

        const articlePromises = response.articles.map(async (article) => {
            console.log(article);

            if (!isSimilarArticle(article, existingArticles) || existingArticles.length === 0) {
                return db.collection('original_feeds').doc(getLanguageByCountryCode(country)).collection("feeds").add(article);
            } else {
                console.log(`Article '${article.title}' is similar to existing one. Skipping.`);
                return null;
            }
        });

        await Promise.all(articlePromises);

        res.status(200).send('Successfully processed articles');

    } catch (error) {
        console.error("Error fetching news or writing to Firestore: ", error);
        res.status(500).send('Internal Server Error');
    }
};
module.exports = { getNews, getNewsFunction };
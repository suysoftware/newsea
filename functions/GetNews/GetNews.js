const admin = require("firebase-admin");
const db = admin.firestore();
const auth = admin.auth();
const storage = admin.storage();
const NewsAPI = require('newsapi');
const newsapi = new NewsAPI('f91c240eaaf24a308d753c8aac799dbb');
const Levenshtein = require('fast-levenshtein');
const THRESHOLD = 5;

const isSimilarArticle = (newArticle, existingArticles) => {
    for (const existingArticle of existingArticles) {
        const distance = Levenshtein.get(newArticle.title, existingArticle.title);
        if (distance < THRESHOLD) {
            return true;
        }
    }
    return false;
};



/*const getNews = async (req, res, next) => {
    try {
        const response = await newsapi.v2.topHeadlines({
            //    q: 'trump',
            //  category: 'politics',
            // language: 'en',
            country: 'us'
        });

        const articlePromises = response.articles.map(async (article) => {
            console.log(article.title);
            return db.collection('articles').add(article);
        });

        await Promise.all(articlePromises);

        res.status(200).send('Successfully added articles to Firestore');
    } catch (error) {
        console.error("Error fetching news or writing to Firestore: ", error);
        res.status(500).send('Internal Server Error');
    }
};*/

const getNews = async (req, res, next) => {
    try {
        const response = await newsapi.v2.topHeadlines({
            country: 'us'
        });

        const existingArticlesSnapshot = await db.collection('original_feeds').get();
        const existingArticles = existingArticlesSnapshot.docs.map(doc => doc.data());

        const articlePromises = response.articles.map(async (article) => {
            console.log(article.title);

            if (!isSimilarArticle(article, existingArticles) || existingArticles.length === 0) {
                return db.collection('original_feeds').add(article);
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
module.exports = getNews;
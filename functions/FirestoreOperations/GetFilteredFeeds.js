const admin = require("firebase-admin");
const db = admin.firestore();
const auth = admin.auth();
const storage = admin.storage();



const checkArticleObjects = (article) => {
    if (
        !article.title || article.title === '[Removed]' ||
        !article.description || article.description === '[Removed]' ||
        !article.content || article.content === '[Removed]' ||
        !article.publishedAt || article.publishedAt === '[Removed]'

    ) {
        return false;
    }
    return true;
};





const getFilteredFeeds = async (req, res, next) => {
    const { countries, categories, userLanguage } = req.body;


    let filteredFeeds = [];

    try {

        const existingArticlesSnapshot = await db.collection('translated_feeds').doc(userLanguage).collection("feeds").get();

        const existingArticles = existingArticlesSnapshot.docs.map(doc => doc.data());


        filteredFeeds = existingArticles.filter(article => {


            const includeCategory = (categories.includes('All')) ? true : article.categories.some(cat => categories.includes(cat));
            const includeCountry = (countries.includes('All')) ? true : countries.includes(article.country);
            return includeCategory && includeCountry;
            //   return includeCountry && checkArticleObjects(article);

            // return includeCountry;
        });


        res.json(filteredFeeds);
    } catch (error) {
        console.log(error);
        res.status(400).json({ error: "hatali ceviri" });
    }
};

module.exports = getFilteredFeeds;

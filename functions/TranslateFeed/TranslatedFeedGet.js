
const admin = require("firebase-admin");
const db = admin.firestore();
const auth = admin.auth();
const storage = admin.storage();




const checkArticleObjects = (article) => {

    // or article.author == undefined or article.author == [Removed] or article.title == [Removed] or article.description == [Removed] or article.content == [Removed] or article.url == [Removed] or article.urlToImage == [Removed] or article.publishedAt == [Removed] or article.source == [Removed] or article.source.name == [Removed]
    if (article.title == undefined || article.description == undefined || article.content == undefined || article.url == undefined || article.urlToImage == undefined || article.publishedAt == undefined || article.source == undefined || article.source.name == undefined || article.author == undefined,
        article.author == "[Removed]" || article.title == "[Removed]" || article.description == "[Removed]" || article.content == "[Removed]" || article.url == "[Removed]" || article.urlToImage == "[Removed]" || article.publishedAt == "[Removed]" || article.source == "[Removed]" || article.source.name == "[Removed]") {
        return false;
    }
    else {
        return true;
    }
}
const getTranslatedFeed = async (req, res, next) => {
    const language = req.query.userLanguage;
    const country = req.query.filteredCountries;
    const category = req.query.filteredCategories;

    let filteredFeeds = [];

    try {
        const existingArticlesSnapshot = await db.collection('translated_feeds').doc(language).collection("feeds").get();
        const existingArticles = existingArticlesSnapshot.docs.map(doc => doc.data());

        filteredFeeds = existingArticles.filter(article => {
            const includeCategory = category ? article.categories.includes(category) : true;
            const includeCountry = country ? article.country === country : true;
            return includeCategory && includeCountry && checkArticleObjects(article);
        });

        res.json(filteredFeeds);
    } catch (error) {
        console.log(error);
        res.status(400).json({ error: "hatali ceviri" });
    }

};


module.exports = getTranslatedFeed;
const admin = require("firebase-admin");
const db = admin.firestore();
const auth = admin.auth();
const storage = admin.storage();

const getBookmarkFeeds = async (req, res, next) => {
    const userUid = req.query.userUid;
    const userRef = db.collection('users').doc(userUid);


    try {
        const userData = await userRef.get();

        if (!userData.exists) {
            res.status(404).send("User not found");
            return;
        }

        const bookmarkFeeds = userData.data().userReadlist;
        const userLanguage = userData.data().userLanguage;
        const feedsCollectionRef = db.collection('translated_feeds').doc(userLanguage).collection("feeds");

        // Fetch all feeds where the document ID is in the bookmarkFeeds array
        const feedsQuery = feedsCollectionRef.where(admin.firestore.FieldPath.documentId(), 'in', bookmarkFeeds);

        const feedsQuerySnapshot = await feedsQuery.get();

        const fetchedBookmarkFeeds = feedsQuerySnapshot.docs.map(doc => doc.data());

        res.status(200).json(fetchedBookmarkFeeds);


    } catch (error) {
        console.log(error);
        res.status(500).send("Internal Server Error");
    }
};

module.exports = getBookmarkFeeds;

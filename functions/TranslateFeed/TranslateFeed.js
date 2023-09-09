const admin = require("firebase-admin");
const db = admin.firestore();
const auth = admin.auth();
const storage = admin.storage();
const OpenAIApi = require("openai");
const { ChatMessage, chatMessageFromJson, chatMessageToJson } = require('../models/ChatMessage');
require('dotenv').config()


const openai = new OpenAIApi({
    apiKey: process.env.OPEN_AI_API_KEY,
});

const translateFeed = async (originalFeed, languageFrom, languageTo) => {

    var promptTitle = originalFeed.title;
    var promptDescription = originalFeed.description;
    var promptContent = originalFeed.content;



    var systemMessage = 'Translate the following "' + languageFrom + " text to " + languageTo + ' and understand these texts which categories only in these categories ["Business", "Entertainment", "Health", "Science", "Sports", "Technology","Weather"] (but dont translate these categories and choose maximum 2 category )  format the output as a JSON object';

    // var promptGeneral = "Title: " + promptTitle + "\nDescription: " + promptDescription + "\nContent: " + promptContent + '\n\n Format: {"title": "translatedTitleText","description": "translatedDescriptionText","content": "translatedContentText"}'
    const promptGeneral = `
      Title: ${promptTitle}
      Description: ${promptDescription}
      Content: ${promptContent}
      
      Translation Format: 
      {
        "title": "translatedTitleText",
        "description": "translatedDescriptionText",
        "content": "translatedContentText",
        "categories": categoriesList
      }`;

    try {

        const completion = await openai.chat.completions.create({
            messages: [

                { role: 'system', content: systemMessage },
                { role: 'user', content: promptGeneral }],
            model: 'gpt-3.5-turbo',
        });

        console.log(completion.choices[0].message.content);
        console.log("buradan sorna json");
        const resultJSON = JSON.parse(completion.choices[0].message.content);

        console.log(resultJSON.title);
        console.log(resultJSON.description);
        console.log(resultJSON.content);






        return resultJSON;

    } catch (error) {
        console.log(error);
        return "hatali ceviri"
    }


};


module.exports = translateFeed;
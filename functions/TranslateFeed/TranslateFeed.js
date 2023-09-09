const admin = require("firebase-admin");
const db = admin.firestore();
const auth = admin.auth();
const storage = admin.storage();
const OpenAIApi = require("openai");
const { ChatMessage, chatMessageFromJson, chatMessageToJson } = require('../models/ChatMessage');


const openai = new OpenAIApi({
    apiKey: "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",
});

const translateFeed = async (originalFeed, languageFrom, languageTo) => {
    console.log("girdik");

    var promptText = originalFeed.title;
    console.log(promptText);

    var myChatMessage = new ChatMessage("user", promptText);

    try {

        const completion = await openai.chat.completions.create({
            messages: [

                { role: 'system', content: "You will be provided with a sentence in " + languageFrom + " , and your task is to translate it into " + languageTo + "." },
                { role: 'user', content: promptText }],
            model: 'gpt-3.5-turbo',
        });


        console.log(completion.choices);
        console.log(completion.choices[0].message.content);






        return completion.choices[0].message.content;

    } catch (error) {
        console.log(error);
        return "hatali ceviri"
    }


};


module.exports = translateFeed;
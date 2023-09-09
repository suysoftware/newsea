
const chatMessageFromJson = (str) => JSON.parse(str).map((x) => ChatMessage.fromJson(x));

const chatMessageToJson = (data) => JSON.stringify(data.map((x) => x.toJson()));

class ChatMessage {
    constructor(role, content) {
        this.role = role;
        this.content = content;
    }

    static fromJson(json) {
        return new ChatMessage(json.role, json.content);
    }

    toJson() {
        return {
            role: this.role,
            content: this.content
        };
    }
}

module.exports = { ChatMessage, chatMessageFromJson, chatMessageToJson };
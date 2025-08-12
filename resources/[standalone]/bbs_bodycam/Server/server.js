const { AccessToken } = require('livekit-server-sdk');
const Config = {
    "LiveKit": {
        "url": "PUT YOUR URL HERE", // YOUR LIVEKIT URL
        "apiKey": "PUT YOUR APIKEY HERE", // YOUR Livekit API key
        "apiSecret": "PUT YOUR APISECRET HERE" // Your Livekit apiSecret
    }
}

function getLivekitToken(roomName, participantName) {
    const apiKey = Config.LiveKit.apiKey;
    const apiSecret = Config.LiveKit.apiSecret;
    const at = new AccessToken(apiKey, apiSecret, {
        identity: participantName,

    });
    at.addGrant({
        roomJoin: true,
        room: roomName,
        canPublish: true,
        canPublishVideo: true, 
        canSubscribe: true
    });

    const token = at.toJwt();
    return token
}
function getLivekitServer() {
    return Config.LiveKit.url
}
exports('getLivekitToken', getLivekitToken)
exports('getLivekitServer', getLivekitServer)

// A Test command to ensure livekit generates correct token
/* RegisterCommand("testToken", (source, args, rawCommand) => {
    const src = source || 1
    const token = getLivekitToken('default', 'testing4')
    console.log(token)
}, false) */


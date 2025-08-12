const QBCore = exports['qb-core'].GetCoreObject();

NPX.Procedures.register("emotes:getMeta", function () {
    var emoteMeta = {
        animSet: "default",
        expression: "default",
        quickEmotes: ["sit"]
    };
    return emoteMeta;
});

NPX.Procedures.register("emotes:setFavorite", function (pSrc, pFavorite) {
    let user = QBCore.Functions.GetPlayer(pSrc);
    let characterId = user.PlayerData.citizenid;

    const { category, index, type, value } = pFavorite;

    exports["oxmysql"].execute("SELECT id, emote_value FROM player_emotes WHERE player_id = ? AND emote_category = ? AND emote_index = ? AND emote_type = ?", [characterId, category, index, type], function (result) {
        if (result && result.length > 0) {
            if (result[0].emote_value === value) {
                exports["oxmysql"].execute("DELETE FROM player_emotes WHERE id = ?", [result[0].id], function () {
                    // console.log("Deleted emote entry");
                });
            } else {
                exports["oxmysql"].execute("UPDATE player_emotes SET emote_value = ? WHERE id = ?", [value, result[0].id], function () {
                    // console.log("Updated emote entry");
                });
            }
        } else {
            exports["oxmysql"].execute("INSERT INTO player_emotes (player_id, emote_category, emote_index, emote_type, emote_value) VALUES (?, ?, ?, ?, ?)", [characterId, category, index, type, value], function () {
                // console.log("Inserted new emote entry");
            });
        }
    });

    return true;
});

function checkExistenceEmote(citizenId, cb) {
    exports["oxmysql"].execute("SELECT id FROM player_emotes WHERE player_id = ?", [citizenId], function (result) {
        let exists = result && result.length > 0;
        cb(exists);
    });
}

NPX.Procedures.register("emotes:getFavorites", function (pSrc) {
    let user = QBCore.Functions.GetPlayer(pSrc);
    let characterId = user.PlayerData.citizenid;

    if (!characterId) return null;

    return new Promise((resolve, reject) => {
        checkExistenceEmote(characterId, function (exists) {
            if (exists) {
                exports["oxmysql"].execute("SELECT * FROM player_emotes WHERE player_id = ?", [characterId], function (result) {
                    let emotesData = result.map(row => ({
                        category: row.emote_category,
                        index: row.emote_index,
                        type: row.emote_type,
                        value: row.emote_value
                    }));
                    resolve(emotesData);
                });
            } else {
                resolve([]);
            }
        });
    });
});



NPX.Procedures.register("emotes:setQuickEmote", function (pSrc, { _0x3b923e: keybinds, _0x4ccf1e: { category, index, value } }) {
    let user = QBCore.Functions.GetPlayer(pSrc);
    let characterId = user.PlayerData.citizenid;

    // console.log(`Received quick emote to set: Keybinds - ${keybinds}, Category - ${category}, Index - ${index}, Value - ${value}`);

    exports["oxmysql"].execute("SELECT id, pQuickEmote FROM player_quick_emotes WHERE player_id = ? AND keybinds = ?", [characterId, keybinds], function (result) {
        if (result && result.length > 0) {
            exports["oxmysql"].execute("UPDATE player_quick_emotes SET pQuickEmote = ?, emote_index = ?, category = ? WHERE id = ?", [value, index, category, result[0].id], function () {
                // console.log(`Updated quick emote entry: Keybinds - ${keybinds}, Category - ${category}, Index - ${index}, Value - ${value}`);
            });
        } else {
            exports["oxmysql"].execute("INSERT INTO player_quick_emotes (player_id, keybinds, category, emote_index, pQuickEmote) VALUES (?, ?, ?, ?, ?)", [characterId, keybinds, category, index, value], function () {
                // console.log(`Inserted new quick emote entry: Keybinds - ${keybinds}, Category - ${category}, Index - ${index}, Value - ${value}`);
            });
        }
    });

    return true;
});


NPX.Procedures.register("emotes:getQuickEmotes", function (pSrc) {
    let user = QBCore.Functions.GetPlayer(pSrc);
    let characterId = user.PlayerData.citizenid;

    if (!characterId) return null;

    return new Promise((resolve, reject) => {
        exports["oxmysql"].execute("SELECT * FROM player_quick_emotes WHERE player_id = ?", [characterId], function (result) {
            if (result && result.length > 0) {
                let quickEmotesData = result.map(row => ({
                    keybinds: row.keybinds,
                    category: row.category,
                    index: row.emote_index,
                    value: row.pQuickEmote
                }));
                TriggerClientEvent('emotes:sendQuickEmotes', pSrc, quickEmotesData);
                resolve(quickEmotesData);
            } else {
                TriggerClientEvent('emotes:sendQuickEmotes', pSrc, []);
                resolve([]);
            }
        });
    });
});

NPX.Procedures.register("emotes:triggerQuickEmote", function (pSrc, index) {
    let user = QBCore.Functions.GetPlayer(pSrc);
    let characterId = user.PlayerData.citizenid;

    if (!characterId) return null;

    exports["oxmysql"].execute("SELECT pQuickEmote, category, emote_index FROM player_quick_emotes WHERE player_id = ? AND keybinds = ?", [characterId, index], function (result) {
        if (result && result.length > 0) {
            TriggerClientEvent('emotes:playEmote', pSrc, result[0].pQuickEmote, result[0].category, result[0].emote_index);
        }
    });
});



onNet('emotes:set:animSet', (pAnimSet) => {
    // console.log("pAnimSet: ", pAnimSet)
});

onNet('emotes:set:expression', (pExpression) => {
    // console.log("pExpression: ", pExpression)
});

onNet('emotes:set:quickEmote', (pQuick, pQuickEmote) => {
    // console.log("pQuick, pQuickEmote: ", pQuick, pQuickEmote)
});

onNet('emotes:synced:initialize', (emoteData, entity) => {
    emitNet('emotes:synced:play', -1, emoteData, entity);
});

onNet('emotes:synced:disable', (targetPlayerId) => {
    emitNet('emotes:synced:disable', targetPlayerId);
});

// Event handler to forward the request to the target player
onNet('emotes:sendRequest', (targetPlayerId, emoteName) => {
    const senderId = global.source;
    emitNet('emotes:receiveRequest', targetPlayerId, senderId, emoteName);
});

// Event handler to receive the response from the target player and forward it to the sender
onNet('emotes:sendResponse', (senderId, response) => {
    emitNet('emotes:receiveResponse', senderId, response);
});

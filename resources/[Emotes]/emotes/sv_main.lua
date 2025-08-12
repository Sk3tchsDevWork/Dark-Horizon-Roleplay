local QBCore = exports['qb-core']:GetCoreObject()

local defaultEmotes = {
    { keybinds = 0, category = 'emotes', index = 399, value = 'wait' },
    { keybinds = 1, category = 'emotes', index = 393, value = 'bow' },
    { keybinds = 2, category = 'emotes', index = 386, value = 'flip' },
    { keybinds = 3, category = 'emotes', index = 387, value = 'slide' },
    { keybinds = 4, category = 'emotes', index = 380, value = 'passout3' },
    { keybinds = 5, category = 'emotes', index = 368, value = 'whistle' },
    { keybinds = 6, category = 'emotes', index = 362, value = 'wave' }
}

-- Function to insert default emotes
local function insertDefaultEmotes(characterId, emotesToInsert)
    for _, emote in ipairs(emotesToInsert) do
        exports["oxmysql"]:execute(
            "INSERT INTO player_quick_emotes (player_id, keybinds, category, emote_index, pQuickEmote) VALUES (?, ?, ?, ?, ?)",
            { characterId, emote.keybinds, emote.category, emote.index, emote.value },
            function(result)
                if result then
                    print(string.format("Inserted default emote: Keybinds - %d, Category - %s, Index - %d, Value - %s", emote.keybinds, emote.category, emote.index, emote.value))
                end
            end
        )
    end
end

-- Function to check if default emotes are available and insert if not
local function ensureDefaultEmotes(characterId)
    exports["oxmysql"]:execute(
        "SELECT keybinds FROM player_quick_emotes WHERE player_id = ?",
        { characterId },
        function(result)
            local existingKeybinds = {}
            for _, row in ipairs(result) do
                table.insert(existingKeybinds, row.keybinds)
            end
            local missingEmotes = {}
            for _, emote in ipairs(defaultEmotes) do
                local exists = false
                for _, existingKeybind in ipairs(existingKeybinds) do
                    if existingKeybind == emote.keybinds then
                        exists = true
                        break
                    end
                end
                if not exists then
                    table.insert(missingEmotes, emote)
                else
                    -- print(string.format("Skipping default emote %s for character ID %s - already exists", emote.value, characterId))
                end
            end
            if #missingEmotes > 0 then
                insertDefaultEmotes(characterId, missingEmotes)
            end
        end
    )
end

-- Register event to ensure default emotes when a player is loaded using QBCore
RegisterNetEvent('QBCore:Server:OnPlayerLoaded')
AddEventHandler('QBCore:Server:OnPlayerLoaded', function()
    local player = QBCore.Functions.GetPlayer(source)
    local characterId = player.PlayerData.citizenid
    ensureDefaultEmotes(characterId)
end)


QBCore.Commands.Add("senddecision", "Send a decision offer to a player", {{name="id", help="Player ID"}, {name="decision", help="Decision (accept/decline)"}}, true, function(source, args)
    local targetPlayer = tonumber(args[1])
    local decision = args[2]

    TriggerClientEvent('showDecisionPrompt', targetPlayer, decision)
end)

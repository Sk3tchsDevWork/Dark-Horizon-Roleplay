---@type 'discord' | 'custom'
Config.Logging = 'discord'

-- You can ignore this if you use discord logging, preconfigured for fivemanage
---@param player Player
---@param resourceName string
---@param message string
function CustomLogging(player, resourceName, message)
    exports.fmsdk:LogMessage("info", message, {
        playerSource = player.source
    })
end
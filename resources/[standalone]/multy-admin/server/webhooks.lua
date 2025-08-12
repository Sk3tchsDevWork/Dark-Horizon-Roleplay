local QBCore = exports['qb-core']:GetCoreObject()

-- Discord webhook URLs - CHANGE THESE TO YOUR WEBHOOKS
Config.Webhooks = {
    -- Main admin action webhook - Replace with your Discord webhook URL
    main = "https://discord.com/api/webhooks/1394806920317112380/W8KvOMDJEi5o-X3midK7ktn-kqyUbi0jMbsrW7luR3R5jy2YFDv3Z9nbcKtA8ys19cqJ",
    -- Screenshot webhook - Replace with your Discord webhook URL (can be same as main)
    screenshot = "https://discord.com/api/webhooks/1394807094464745624/4PlUCHQOBVEQH_y8oOH9HyXFoTE1z0A41sT5u8wco1PN0ZW451BoXnDCRCBsPEetHu3O"
}

local WEBHOOK_URL = Config.Webhooks.main -- Default to main webhook

-- Webhook colors
local COLORS = {
    RED = 16711680,
    GREEN = 65280,
    BLUE = 3447003,
    ORANGE = 16753920,
    PURPLE = 8388736,
    YELLOW = 16776960
}

-- Send webhook with retry logic
local function SendWebhook(data)
    if not Config.Logging.enabled then
        return
    end
    
    local webhook = WEBHOOK_URL
    
    PerformHttpRequest(webhook, function(err, text, headers)
        if err == 200 or err == 204 then
            print("^2[Multy-Admin] Webhook sent successfully^7")
        else
            print("^1[Multy-Admin] Webhook error: " .. err .. "^7")
            print("^1[Multy-Admin] Response: " .. tostring(text) .. "^7")
        end
    end, 'POST', json.encode(data), {['Content-Type'] = 'application/json'})
end

-- Format admin action for logging
local function LogAdminAction(adminId, action, details, color)
    if not Config.Logging.logActions[action] then
        return
    end
    
    local admin = QBCore.Functions.GetPlayer(adminId)
    if not admin then return end
    
    local adminName = admin.PlayerData.charinfo.firstname .. ' ' .. admin.PlayerData.charinfo.lastname
    local adminSteam = admin.PlayerData.name
    local timestamp = os.date('%Y-%m-%d %H:%M:%S')
    
    -- Console logging
    if Config.Logging.logToConsole then
        print(string.format("^3[Multy-Admin] %s - %s (%s) %s^7", timestamp, adminName, adminSteam, details))
    end
    
    -- Discord webhook logging
    if WEBHOOK_URL and WEBHOOK_URL ~= "" then
        print("^2[Multy-Admin] Sending webhook for action: " .. action .. "^7")
        local embed = {
            title = "🛡️ Admin Action Log",
            color = color or COLORS.BLUE,
            fields = {
                {
                    name = "👮 Admin",
                    value = string.format("%s\n`%s`", adminName, adminSteam),
                    inline = true
                },
                {
                    name = "⚡ Action",
                    value = action:upper(),
                    inline = true
                },
                {
                    name = "📝 Details",
                    value = details,
                    inline = false
                }
            },
            footer = {
                text = "Multy Admin Menu",
                icon_url = "https://cdn3.emoji.gg/emojis/5314-blue-shield.png"
            },
            timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ")
        }
        
        SendWebhook({
            username = "Multy Admin",
            avatar_url = "https://cdn3.emoji.gg/emojis/5314-blue-shield.png",
            embeds = {embed}
        })
    end
end

-- Export logging functions
exports('LogAdminAction', LogAdminAction)

-- Specific logging functions for different actions
function LogTeleport(adminId, details)
    LogAdminAction(adminId, 'teleport', details, COLORS.BLUE)
end

function LogKick(adminId, targetName, reason)
    local details = string.format("Kicked **%s**\nReason: %s", targetName, reason or "No reason provided")
    LogAdminAction(adminId, 'kick', details, COLORS.ORANGE)
end

function LogBan(adminId, targetName, reason, duration)
    local durationText = duration and string.format(" for %s hours", duration) or " permanently"
    local details = string.format("Banned **%s**%s\nReason: %s", targetName, durationText, reason or "No reason provided")
    LogAdminAction(adminId, 'ban', details, COLORS.RED)
end

function LogUnban(adminId, targetName, banId)
    local details = string.format("Unbanned **%s** (Ban ID: #%s)", targetName or "Unknown", banId or "N/A")
    LogAdminAction(adminId, 'unban', details, COLORS.GREEN)
end

function LogSpawn(adminId, item, amount)
    local details = string.format("Spawned **%s** (Amount: %s)", item, amount or "1")
    LogAdminAction(adminId, 'spawn', details, COLORS.GREEN)
end

function LogGive(adminId, targetName, item, amount)
    local details = string.format("Gave **%s** to **%s** (Amount: %s)", item, targetName, amount or "1")
    LogAdminAction(adminId, 'give', details, COLORS.GREEN)
end

function LogRevive(adminId, targetName)
    local details = string.format("Revived **%s**", targetName or "themselves")
    LogAdminAction(adminId, 'revive', details, COLORS.GREEN)
end

function LogSpectate(adminId, targetName, action)
    local details = string.format("%s spectating **%s**", action, targetName)
    LogAdminAction(adminId, 'spectate', details, COLORS.PURPLE)
end

function LogNoclip(adminId, state)
    local details = string.format("Noclip %s", state and "enabled" or "disabled")
    LogAdminAction(adminId, 'noclip', details, COLORS.BLUE)
end

function LogGodmode(adminId, state)
    local details = string.format("Godmode %s", state and "enabled" or "disabled")
    LogAdminAction(adminId, 'godmode', details, COLORS.YELLOW)
end

function LogAnnouncement(adminId, message)
    local details = string.format("Server announcement: %s", message)
    LogAdminAction(adminId, 'announcement', details, COLORS.BLUE)
end

function LogVehicleSpawn(adminId, model)
    local details = string.format("Spawned vehicle: **%s**", model)
    LogAdminAction(adminId, 'spawn', details, COLORS.GREEN)
end

function LogWeatherChange(adminId, weather)
    local details = string.format("Changed weather to: **%s**", weather)
    LogAdminAction(adminId, 'weather', details, COLORS.BLUE)
end

function LogTimeChange(adminId, time)
    local details = string.format("Changed time to: **%s:00**", time)
    LogAdminAction(adminId, 'time', details, COLORS.BLUE)
end

function LogFreeze(adminId, targetName, action)
    local details = string.format("%s player **%s**", action, targetName)
    LogAdminAction(adminId, 'freeze', details, COLORS.ORANGE)
end

function LogKillPlayer(adminId, targetName)
    local details = string.format("Killed player **%s**", targetName)
    LogAdminAction(adminId, 'kill', details, COLORS.RED)
end

function LogSetJob(adminId, targetName, job, grade)
    local details = string.format("Set **%s** job to **%s** (Grade: %s)", targetName, job, grade)
    LogAdminAction(adminId, 'setjob', details, COLORS.BLUE)
end

function LogClearInventory(adminId, targetName)
    local details = string.format("Cleared **%s** inventory", targetName)
    LogAdminAction(adminId, 'clearinventory', details, COLORS.RED)
end

function LogVehicleAction(adminId, action, details)
    LogAdminAction(adminId, action, details, COLORS.ORANGE)
end

function LogClearArea(adminId, radius)
    local details = string.format("Cleared area with radius: **%s**", radius)
    LogAdminAction(adminId, 'cleararea', details, COLORS.ORANGE)
end

function LogServerAction(adminId, action, details)
    LogAdminAction(adminId, action, details, COLORS.RED)
end

function LogScreenshot(adminId, targetName)
    local details = string.format("Took screenshot of **%s**", targetName)
    LogAdminAction(adminId, 'screenshot', details, COLORS.PURPLE)
end

function LogWarn(adminId, targetName, message)
    local details = string.format("Warned **%s**\nMessage: %s", targetName, message)
    LogAdminAction(adminId, 'warn', details, COLORS.YELLOW)
end

function LogHeal(adminId, targetName)
    local details = string.format("Healed **%s**", targetName)
    LogAdminAction(adminId, 'heal', details, COLORS.GREEN)
end

function LogInvisible(adminId, state)
    local details = string.format("Invisibility %s", state and "enabled" or "disabled")
    LogAdminAction(adminId, 'invisible', details, COLORS.PURPLE)
end

function LogInfiniteAmmo(adminId, state)
    local details = string.format("Infinite ammo %s", state and "enabled" or "disabled")
    LogAdminAction(adminId, 'infiniteammo', details, COLORS.ORANGE)
end

function LogGiveMoney(adminId, targetName, amount, moneyType)
    local details = string.format("Gave **$%s** %s to **%s**", amount, moneyType or "cash", targetName)
    LogAdminAction(adminId, 'givemoney', details, COLORS.GREEN)
end

function LogGiveCar(adminId, targetName, vehicle)
    local details = string.format("Gave vehicle **%s** to **%s**", vehicle, targetName)
    LogAdminAction(adminId, 'givecar', details, COLORS.GREEN)
end

function LogUnban(adminId, identifier)
    local details = string.format("Unbanned player with identifier: **%s**", identifier)
    LogAdminAction(adminId, 'unban', details, COLORS.GREEN)
end

-- Export all logging functions
exports('LogTeleport', LogTeleport)
exports('LogKick', LogKick)
exports('LogBan', LogBan)
exports('LogUnban', LogUnban)
exports('LogSpawn', LogSpawn)
exports('LogGive', LogGive)
exports('LogRevive', LogRevive)
exports('LogSpectate', LogSpectate)
exports('LogNoclip', LogNoclip)
exports('LogGodmode', LogGodmode)
exports('LogAnnouncement', LogAnnouncement)
exports('LogVehicleSpawn', LogVehicleSpawn)
exports('LogWeatherChange', LogWeatherChange)
exports('LogTimeChange', LogTimeChange)
exports('LogFreeze', LogFreeze)
exports('LogKillPlayer', LogKillPlayer)
exports('LogSetJob', LogSetJob)
exports('LogClearInventory', LogClearInventory)
exports('LogVehicleAction', LogVehicleAction)
exports('LogClearArea', LogClearArea)
exports('LogServerAction', LogServerAction)
exports('LogScreenshot', LogScreenshot)
exports('LogWarn', LogWarn)
exports('LogHeal', LogHeal)
exports('LogInvisible', LogInvisible)
exports('LogInfiniteAmmo', LogInfiniteAmmo)
exports('LogGiveMoney', LogGiveMoney)
exports('LogGiveCar', LogGiveCar)
exports('LogUnban', LogUnban)
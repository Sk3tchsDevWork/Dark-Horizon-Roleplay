local discordColors = {
    info = tonumber("3498DB", 16),
    warning = tonumber("F1C40F", 16),
    error = tonumber("E74C3C", 16)
}

local avatars = {}

local function GetAvatar(source)
    if not Config.Logs.Avatar then
        debugprint("GetAvatar: Config.Logs.Avatar is set to false, returning random avatar")

        return "https://cdn.discordapp.com/embed/avatars/" .. math.random(0, 5) .. ".png"
    end

    if avatars[source] then
        debugprint("GetAvatar: using cached avatar for source", source)

        return avatars[source]
    end

    ---@type string | nil
    local avatar
    local fetchedAvatar = false
    local timeout = GetGameTimer() + 10000
    local discord = GetPlayerIdentifierByType(source, "discord")
    local steam = GetPlayerIdentifierByType(source, "steam")
    local fivem = GetPlayerIdentifierByType(source, "fivem")

    discord = discord and discord:sub(9)
    steam = steam and steam:sub(7)
    fivem = fivem and fivem:sub(7)

    if discord and DISCORD_TOKEN then
        debugprint("GetAvatar: fetching discord avatar for source", source)

        PerformHttpRequest("https://discord.com/api/v9/users/" .. discord, function(status, response)
            if status == 200 then
                local data = json.decode(response)

                if data.avatar then
                    avatar = "https://cdn.discordapp.com/avatars/" .. discord .. "/" .. data.avatar .. ".png"
                end
            end

            fetchedAvatar = true
        end, "GET", "", { ["Authorization"] = "Bot " .. DISCORD_TOKEN })
    elseif steam then
        debugprint("GetAvatar: fetching steam avatar for source", source)

        PerformHttpRequest("https://steamcommunity.com/profiles/" .. tonumber(steam, 16), function(status, response)
            if status == 200 then
                avatar = response:match('<meta name="twitter:image" content="(.-)"')
            end

            fetchedAvatar = true
        end, "GET", "", {})
    elseif fivem then
        debugprint("GetAvatar: fetching fivem avatar for source", source)

        PerformHttpRequest("https://policy-live.fivem.net/api/getUserInfo/" .. fivem, function(statusCode, response, headers)
            if statusCode == 200 then
                local data = json.decode(response)

                if data.avatar_template then
                    avatar = "https://forum.cfx.re" .. data.avatar_template:gsub("{size}", "512")
                end
            end

            fetchedAvatar = true
        end, "GET", "", {["Content-Type"] = "application/json"})
    else
        debugprint("GetAvatar: no discord, steam or fivem identifier found for source", source)

        fetchedAvatar = true
    end

    while not fetchedAvatar do
        Wait(500)

        if GetGameTimer() > timeout then
            debugprint("GetAvatar: timed out when fetching avatar for source", source)
            break
        end
    end

    debugprint("GetAvatar: fetched avatar for source", source)

    avatars[source] = avatar

    return avatar or ("https://cdn.discordapp.com/embed/avatars/" .. math.random(0, 5) .. ".png")
end

---Get the current timestamp in ISO 8601 format
---@return string?
function GetTimestampISO()
    local timestamp = os.date("!%Y-%m-%dT%H:%M:%S.000Z") --[[@as string]]

    -- This is needed for newer FiveM artifacts
    if #timestamp < 24 then
        return
    elseif #timestamp > 24 then
        timestamp = timestamp:sub(1, 24)
    end

    if not timestamp:match("%d%d%d%d%-%d%d%-%d%dT%d%d%:%d%d%:%d%d%.%d%d%dZ") then
        debugprint("Invalid timestamp")
        return
    end

    return timestamp
end

---@param source? number
---@param action string
---@param level "info" | "warning" | "error"
---@param title string
---@param metadata? table<string, any>
---@param image? string
local function LogToDiscord(source, action, level, title, metadata, image)
    if not LOG_WEBHOOKS[action] and not LOG_WEBHOOKS.Default then
        infoprint("error", "No webhook set for action " .. action .. " and no default webhook set in lb-tablet/server/apiKeys.lua")
        return
    end

	local cleanedUpIdentifiers = {}
	local accounts = {}
	local description = metadata and json.encode(metadata, { indent = true }) .. "\n\n" or ""
	local accountsCount = 0

    if source then
        local identifiers = GetPlayerIdentifiers(source)

        for i = 1, #identifiers do
            local identifierTypeIndex = identifiers[i]:find(":")

            if not identifierTypeIndex then
                goto continue
            end

            local identifierType = identifiers[i]:sub(1, identifierTypeIndex - 1)
            local identifier = identifiers[i]:sub(identifierTypeIndex + 1)

            if identifierType == "steam" then
                accountsCount += 1
                accounts[accountsCount] = "- Steam: https://steamcommunity.com/profiles/" .. tonumber(identifier, 16)
            elseif identifierType == "discord" then
                accountsCount += 1
                accounts[accountsCount] = "- Discord: <@" .. identifier .. ">"
            end

            if identifierType ~= "ip" then
                cleanedUpIdentifiers[identifierType] = identifier
            end

            ::continue::
        end
    end

	if accountsCount > 0 then
		description = description .. "**Accounts:**\n"
		for i = 1, accountsCount do
			description = description .. accounts[i] .. "\n"
		end
	end

	description = description .. "**Identifiers:**"

	for identifierType in pairs(cleanedUpIdentifiers) do
		description = description .. "\n- **" .. identifierType .. ":** " .. cleanedUpIdentifiers[identifierType]
	end

	local embed = {
		title = title,
		description = description,
		color = discordColors[level],
		timestamp = GetTimestampISO(),
        image = image and { url = image } or nil,
		author = source and {
			name = GetPlayerName(source) .. " | " .. source,
			-- icon_url = "https://cdn.discordapp.com/embed/avatars/" .. math.random(0, 5) .. ".png"
            icon_url = GetAvatar(source)
		},
		footer = {
			text = "LB Tablet",
			icon_url = "https://docs.lbscripts.com/images/icons/icon.png"
		}
	}

    ---@diagnostic disable-next-line: param-type-mismatch
	PerformHttpRequest(LOG_WEBHOOKS[action] or LOG_WEBHOOKS.Default, function() end, "POST", json.encode({
		username = "LB Tablet",
        avatar_url = "https://docs.lbscripts.com/images/icons/icon.png",
		embeds = { embed }
	}), { ["Content-Type"] = "application/json" })
end

---@param source? number
---@param action string
---@param level "info" | "warning" | "error"
---@param title string
---@param metadata? table<string, any>
---@param image? string
function Log(source, action, level, title, metadata, image)
	if not Config.Logs?.Enabled or not Config.Logs.Actions[action] then
		return
	end

	if Config.Logs.Service == "ox_lib" then
        ---@diagnostic disable-next-line: undefined-global
        if not lib or GetResourceState("ox_lib") ~= "started" then
            infoprint("error", "Config.Logs.Service is set to 'ox_lib', but ox_lib is not started. To log using ox_lib, you need to install ox_lib from https://github.com/overextended/ox_lib/releases/latest.")
            return
        end

        ---@diagnostic disable-next-line: undefined-global
        lib.logger(source or -1, level, title)
    elseif Config.Logs.Service == "fivemanage" then
        if GetResourceState("fmsdk") ~= "started" then
            infoprint("error", "Config.Logs.Service is set to 'fivemanage', but fmsdk is not started. To log using Fivemanage, you need to install fmsdk from https://github.com/fivemanage/sdk/releases/latest.")
            return
        end

        if not metadata then
            metadata = {}
        end

        metadata.playerSource = source

        exports.fmsdk:Log(Config.Logs.Dataset or "default", level, title, metadata)
    elseif Config.Logs.Service == "discord" then
        if not LOG_WEBHOOKS?.Default then
            infoprint("error", "Config.Logs.Service is set to discord, but no default discord webhook has been set in lb-tablet/server/apiKeys.lua")
            return
        end

        Citizen.CreateThreadNow(function()
            LogToDiscord(source, action, level, title, metadata, image)
        end)
    else
        infoprint("error", "Config.Logs.Service is set to an invalid value")
		return
	end
end

if Config.Logs?.Enabled and Config.Logs?.Service == "ox_lib" then
	debugprint("Logs set to ox_lib, loading...")

	local oxInit = LoadResourceFile("ox_lib", "init.lua")

    if oxInit then
        load(oxInit)()
		debugprint("Loaded ox_lib")
	else
        Config.Logs.Enabled = false

        infoprint("error", "Failed to load ox_lib")
    end
end

AddEventHandler("playerDropped", function()
    avatars[source] = nil
end)

Wait(0) -- show the warnings in the server console instead of the chat

if Config.Logs.Enabled and Config.Logs.Service == "discord" then
    for k, webhook in pairs(LOG_WEBHOOKS) do
        if webhook and webhook == "https://discord.com/api/webhooks/" then
            infoprint("warning", "^3LOG_WEBHOOKS^5[\"" .. k .. "\"]^7 has not been set in lb-tablet/server/apiKeys.lua")
            LOG_WEBHOOKS[k] = nil
        end
    end
end

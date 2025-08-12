---@type { [string]: { [string]: boolean } }
local busyActions = {}

---@param event string
---@param callback fun(data: any) : ...
---@param defaultReturn any
---@param antiSpam? string[] | true
---@param ignoreAntiSpam? string[]
function ReactCallback(event, callback, defaultReturn, antiSpam, ignoreAntiSpam)
    if antiSpam then
        busyActions[event] = {}
    end

    if defaultReturn == nil then
        defaultReturn = false
    end

    RegisterNUICallback(event, function(data, nuiCallback)
        local eventTitle = event
        local isAntiSpam = false
        local action

        if type(data) == "table" then
            if data.action then
                action = data.action
                eventTitle = event .. ":" .. action

                if antiSpam and (antiSpam == true or table.contains(antiSpam, action)) and (not ignoreAntiSpam or not table.contains(ignoreAntiSpam, action)) then
                    isAntiSpam = true

                    if busyActions[event][action] then
                        debugprint("Ignoring NUI callback", eventTitle, "because it is already busy")
                        nuiCallback(defaultReturn)

                        return
                    else
                        busyActions[event][action] = true
                    end
                end
            end

            if data.data and type(data.data) == "table" then
                for k, v in pairs(data.data) do
                    data[k] = data[k] or v
                end
            end
        end

        local startTime = GetGameTimer()
        local success, result = pcall(callback, data)
        local finishTime = GetGameTimer()
        local ms = finishTime - startTime

        if result == nil then
            result = defaultReturn
        end

        if success then
            nuiCallback(result)
            debugprint(("NUI callback ^5%s^7 took %ims"):format(eventTitle, ms))
        else
            local stackTrace = Citizen.InvokeNative(`FORMAT_STACK_TRACE` & 0xFFFFFFFF, nil, 0, Citizen.ResultAsString())

            print(("^1SCRIPT ERROR: NUI Callback '%s' failed: %s^7\n%s"):format(eventTitle, result or "", stackTrace or ""))
            nuiCallback(defaultReturn)
        end

        if isAntiSpam and busyActions[event][action] then
            busyActions[event][action] = nil
        end
    end)
end

---@param action string
---@param data any
function SendReactMessage(action, data)
    SendNUIMessage({
        action = action,
        data = data
    })
end

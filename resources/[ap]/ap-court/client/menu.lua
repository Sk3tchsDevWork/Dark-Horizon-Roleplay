MyUI = {}
MyUI.currentOptions = {}
MyUI.dialogCallback = nil

RegisterNUICallback("menuSelect", function(data, cb)
    local eventName = data.event
    local args = data.args or {}
    local isServer = data.isServer
    SetNuiFocus(false, false)

    if not eventName then
        print("Invalid menu item: no event specified.")
        cb({})
        return
    end

    if isServer then
        TriggerServerEvent(eventName, args)
    else
        TriggerEvent(eventName, args)
    end

    cb({})
end)

RegisterNUICallback("dialogResult", function(data, cb)
    if MyUI.dialogCallback then
        MyUI.dialogCallback(data)
        MyUI.dialogCallback = nil
    end
    SetNuiFocus(false, false)
    cb({})
end)

RegisterNUICallback("cancel", function(data, cb)
    MyUI.dialogCallback = nil
    MyUI.currentOptions = {}
    SetNuiFocus(false, false)

    if data and data.returnAction and data.returnAction.event then
        if data.returnAction.isServer then
            TriggerServerEvent(data.returnAction.event, data.returnAction.args)
        else
            TriggerEvent(data.returnAction.event, data.returnAction.args)
        end
    end

    cb({})
end)

MyUI.showContext = function(id, options, returnAction, scroll, filter)
    MyUI.currentOptions = options

    local safeOptions = {}

    if #options == 0 then
        safeOptions[1] = {
            title = "No Options Available",
            icon = "fas fa-ban",
            description = "There are no options to display.",
            disabled = true
        }
    else
        for i, v in ipairs(options) do
            safeOptions[i] = {
                title = v.title or "",
                icon = v.icon or "",
                description = v.description or "",
                disabled = v.disabled or false,
                event = v.event,
                isServer = v.isServer,
                args = v.args
            }
        end
    end

    SendNUIMessage({
        action = "showContext",
        id = id,
        data = safeOptions,
        returnAction = returnAction or nil,
        scroll = scroll or nil,
        filter = filter or false
    })

    SetNuiFocus(true, true)
end

MyUI.inputDialog = function(title, fields, cb, returnAction)
    MyUI.dialogCallback = cb
    SetNuiFocus(true, true)

    SendNUIMessage({
        action = "showDialog",
        title = title,
        fields = fields,
        returnAction = returnAction or nil
    })
end

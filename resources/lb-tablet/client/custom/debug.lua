RegisterCommand("tabletdebug", function()
    Config.Debug = not Config.Debug

    SendReactMessage("toggleDebug", Config.Debug)
    infoprint("info", "Debug " .. (Config.Debug and "enabled" or "disabled"))
end, false)

local function RegisterDebugCommand(command, fn)
    if not Config.Debug then
        return
    end

    RegisterCommand("tablet" .. command, fn, false)
end

RegisterDebugCommand("adddispatch", function()
    ---@type NewDispatchOptions
    local policeData = {
        job = "police",
        priority = "high",
        title = "Bank robbery",
        description = "The Pacific Standard Bank is being robbed",
        code = "10-31",
        image = "https://r2.fivemanage.com/image/FQ6AXQrF7WNZ.webp",
        location = {
            label = "Pacific Standard Bank",
            coords = GenerateRandomCoords()
        },
        time = 600
    }

    ---@type NewDispatchOptions
    local ambulanceData = {
        job = "ambulance",
        priority = "high",
        title = "Car Crash",
        description = "There's been a car crash on the highway. 4 people involved.",
        code = "10-31",
        image = "https://r2.fivemanage.com/image/FQ6AXQrF7WNZ.webp",
        location = {
            label = "Highway",
            coords = GenerateRandomCoords()
        },
        time = 600
    }

    TriggerServerEvent("lb-tablet:addDispatch", policeData)
    TriggerServerEvent("lb-tablet:addDispatch", ambulanceData)
end)

RegisterDebugCommand("removedispatch", function(_, args)
    local id = args[1]

    if id and tonumber(id) then
        TriggerEvent("tablet:police:removeDispatch", tonumber(id))
    end
end)

RegisterDebugCommand("toggledispatch", function()
    local visible = exports["lb-tablet"]:IsDispatchVisible()

    exports["lb-tablet"]:ToggleDispatchVisible(not visible)
end)

function GenerateRandomCoords()
    local x = math.random(-4000, 4000)
    local y = math.random(-4000, 4000)

    return vector2(x, y)
end

AddEventHandler("tablet:notifications:debug", function(button)
    ---@type PopUpData
    local popUp = {
        title = "Notification",
        description = "You pressed '" .. button .. "'.",
        buttons = {
            {
                title = "OK",
            }
        },
    }

    exports["lb-tablet"]:SetPopUp(popUp)
end)

RegisterDebugCommand("notification", function()
    local description = { GenerateStringFromPattern("Aaaaa") }

    for i = 1, math.random(1, 5) do
        description[#description+1] = GenerateStringFromPattern(string.rep("a", math.random(3, 7)))
    end

    ---@type NewNotification
    local notification = {
        app = "Settings",
        title = "Test",
        content = table.concat(description, " ") .. ".",
        customData = {
            buttons = {
                {
                    title = "Cancel",
                    event = "tablet:notifications:debug",
                    data = "Cancel"
                },
                {
                    title = "OK",
                    event = "tablet:notifications:debug",
                    data = "OK"
                }
            }
        }
    }

    exports["lb-tablet"]:SendNotification(notification)
end)

RegisterDebugCommand("popup", function()
    exports["lb-tablet"]:SetPopUp({
        title = "title",
        description = "description",
        buttons = {
            {
                title = "OK",
                cb = function(data)
                    print("ok")
                    print("Input: " .. tostring(data.inputs[1]))
                    print("TextArea: " .. tostring(data.textareas[1]))
                end
            }
        },
        inputs = {
            {
                -- onChange = function(value)
                --     print(value)
                -- end
            }
        },
        textareas = {
            {
                -- onChange = function(value)
                --     print(value)
                -- end
            }
        },
        close = function()
            print("closed popup")
        end
    })
end)

RegisterDebugCommand("contextmenu", function()
    exports["lb-tablet"]:SetContextMenu({
        title = "test",
        buttons = {
            {
                title = "test",
                cb = function()
                    print("test")
                end
            },
            {
                title = "test 2",
                cb = function()
                    print("test 2")
                end
            }
        },
        close = function()
            print("closed context menu")
        end
    })
end)

RegisterDebugCommand("gallery", function()
    exports["lb-tablet"]:Gallery({
        includeVideos = true,
        includeImages = true,
        allowExternal = true,
        multiSelect = true,
        onSelect = function(data)
            debugprint(data)
        end,
        close = function()
            print("closed gallery")
        end
    })
end)

RegisterDebugCommand("colorpicker", function()
    exports["lb-tablet"]:ColorPicker({
        defaultColor = "#ff0000",
        onSelect = function(color)
            print(color)
        end,
        onClose = function(color)
            print("Selected color: " .. color)
        end,
        close = function()
            print("closed color picker")
        end
    })
end)

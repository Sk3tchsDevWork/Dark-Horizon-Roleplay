local QBCore = exports['qb-core']:GetCoreObject()
local PlayerData = QBCore.Functions.GetPlayerData()

local cfg = Config.Target
local drawPoints = Config.Target["DrawText"]["points"]
local systems = {
    qbTarget = "qb-target",
    qTarget = "qtarget",
    ox_target = "ox-target"
}

RegisterNetEvent('ap-court:notify', function(msg)
    QBCore.Functions.Notify(msg)
end)

RegisterNetEvent('ap-court:target:getAppStatus', function()
    TriggerServerEvent('ap-court:getAppStatus')
end)

RegisterNetEvent('ap-court:target:getJuryStatus', function()
    TriggerServerEvent('ap-court:getJuryStatus')
end)

RegisterNetEvent('ap-court:target:getBarStatus', function()
    TriggerServerEvent('ap-court:getBarStatus')
end)

function getJudgeOptions()
    options = {
        {
            event = "ap-court:client:judgeMenu",
            icon = "fas fa-gavel",
            label = "Judge Menu"
        }
    }
    return options
end

for configKey, cfgKey in pairs(systems) do
    if Config.Interactions[configKey] then
        for zoneName, data in pairs(cfg[cfgKey]) do
            if not data.active then goto continue end

            if data.ped then
                local coords = (type(data.coords) == "table") and vector4(data.coords.x, data.coords.y, data.coords.z, data.coords.h) or data.coords
                local model = type(data.ped) == "table" and data.ped.model or data.ped
                local ped = TargetUtils.spawnPed(model, coords, true, true)

                local options = {
                    {
                        event = "ap-court:target:getBarStatus",
                        icon = "fas fa-sign-in-alt",
                        label = zoneName == "bar" and "National Bar Association" or "Public Court Cases"
                    }
                }

                if zoneName == "court" then
                    options = {
                        {
                            event = "ap-court:client:publicServicesMenu",
                            icon = "fas fa-landmark",
                            label = "Open Court Services"
                        }
                    }
                end

                if cfgKey == "ox-target" and data.job then
                    for _, option in ipairs(options) do
                        if type(data.job) == "table" and data.job.name then
                            option.groups = { [data.job.name] = data.job.grade or 0 }
                        elseif type(data.job) == "string" then
                            option.groups = { [data.job] = 0 }
                        end
                    end
                elseif data.job then
                    for _, option in ipairs(options) do
                        option.job = data.job.name or data.job
                    end
                end

                if cfgKey == "qb-target" or cfgKey == "qtarget" then
                    exports[cfgKey]:AddTargetEntity(ped, {
                        options = options,
                        distance = 2.5,
                        job = data.job or nil
                    })
                elseif cfgKey == "ox-target" then
                    exports["ox_target"]:addLocalEntity(ped, options)
                end
            elseif data.boxzone or cfgKey == "ox-target" then
                local options = {
                    {
                        event = "ap-court:client:verdictMenu",
                        icon = "fas fa-sign-in-alt",
                        label = zoneName == "juryCourt" and "Give Verdict"
                    }
                }

                if zoneName == "tableCourt" then
                    options = {
                        {
                            event = "ap-court:client:proManagement",
                            icon = "fas fa-sign-in-alt",
                            label = "Case Management"
                        }
                    }
                end

                if zoneName == "judge" then
                    options = getJudgeOptions()
                end

                if cfgKey == "ox-target" and data.job then
                    for _, option in ipairs(options) do
                        if type(data.job) == "table" and data.job.name then
                            option.groups = { [data.job.name] = data.job.grade or 0 }
                        elseif type(data.job) == "string" then
                            option.groups = { [data.job] = 0 }
                        end
                    end
                elseif data.job then
                    for _, option in ipairs(options) do
                        option.job = data.job.name or data.job
                    end
                end

                if cfgKey == "ox-target" then
                    exports["ox_target"]:addBoxZone({
                        coords = data.coords,
                        size = data.size,
                        rotation = data.rotation,
                        debug = true,
                        drawSprite = true,
                        options = options
                    })
                else
                    exports[cfgKey]:AddBoxZone(
                        data.boxzone.name,
                        data.boxzone.coords,
                        data.boxzone.length,
                        data.boxzone.width,
                        {
                            name = data.boxzone.name,
                            heading = data.boxzone.heading,
                            debugPoly = data.boxzone.debugPoly,
                            minZ = data.boxzone.minZ,
                            maxZ = data.boxzone.maxZ
                        },
                        {
                            options = options,
                            distance = 2.5,
                            job = data.job or nil
                        }
                    )
                end
            end
            ::continue::
        end
    end
end

Citizen.CreateThread(function()
    if Config.Interactions.drawText then
        for key, v in pairs(drawPoints) do
            local zone = BoxZone:Create(vector3(v.pos.x, v.pos.y, v.pos.z), v.length, v.width, {
                name = 'court_'..key,
                heading = v.heading,
                minZ = v.pos.z - 1,
                maxZ = v.pos.z + 1,
                debugPoly = false
            })
            zone:onPlayerInOut(function(inside)
                if inside then
                    if v.enable and (not v.job.check or TargetUtils.hasJob(PlayerData.job, v.job)) then
                        exports['qb-core']:DrawText(v.text, 'left')
                        createDrawInteraction(v)
                    end
                else
                    exports['qb-core']:HideText()
                end
            end)
        end
    end
end)

function createDrawInteraction(data)
    CreateThread(function()
        while true do
            if IsControlPressed(0, 38) then
                exports['qb-core']:KeyPressed()
                if data.isServer then
                    TriggerServerEvent(data.trigger)
                else
                    TriggerEvent(data.trigger)
                end
                break
            end
            Wait(0)
        end
    end)
end

RegisterNetEvent("ap-court:client:publicServicesMenu", function()
    local entries = {
        {
            label = LangClient['public_menu_0_label'],
            description = LangClient['public_menu_0_description'],
            icon = "gavel",
            event = "ap-court:client:courtCases",
            isServer = false
        },
        {
            label = LangClient['public_menu_1_label'],
            description = LangClient['public_menu_1_description'],
            icon = "calendar-check",
            event = "ap-court:target:getAppStatus",
            isServer = false
        },
        {
            label = LangClient['public_menu_2_label'],
            description = LangClient['public_menu_2_description'],
            icon = "balance-scale",
            event = "ap-court:target:getJuryStatus",
            isServer = false
        }
    }

    local title = LangClient['public_menu_title']

    if Config.Context.QB then
        local qbMenu = {
            { header = title, isMenuHeader = true }
        }
        for _, entry in ipairs(entries) do
            table.insert(qbMenu, {
                header = entry.label,
                txt = entry.description,
                icon = "fas fa-" .. entry.icon,
                params = {
                    event = entry.event,
                    isServer = entry.isServer,
                    args = {}
                }
            })
        end
        ContextMenu(qbMenu)

    elseif Config.Context.OX then
        local oxOptions = {}
        for _, entry in ipairs(entries) do
            table.insert(oxOptions, {
                title = entry.label,
                description = entry.description,
                icon = "fas fa-" .. entry.icon,
                event = entry.event,
                args = {},
                disabled = false
            })
        end
        lib.registerContext({
            id = "publicCourtServices",
            title = title,
            options = oxOptions
        })
        ContextMenu("publicCourtServices")

    elseif Config.Context.AP then
        local apOptions = {}
        for _, entry in ipairs(entries) do
            table.insert(apOptions, {
                title = entry.label,
                description = entry.description,
                icon = "fas fa-" .. entry.icon,
                event = entry.event,
                args = {},
                isServer = entry.isServer
            })
        end
        MyUI.showContext(title, apOptions, nil, 10)
    end
end)

RegisterNetEvent("ap-court:client:judgeMenu", function()
    local entries = {
        {
            label = LangClient['judge_menu_0_label'],
            description = LangClient['judge_menu_0_description'],
            icon = "address-card",
            event = "ap-court:client:backgroundChecks",
            isServer = false
        },
        {
            label = LangClient['judge_menu_1_label'],
            description = LangClient['judge_menu_1_description'],
            icon = "user-tie",
            event = "ap-court:client:barMembers",
            isServer = false
        },
        {
            label = LangClient['judge_menu_2_label'],
            description = LangClient['judge_menu_2_description'],
            icon = "user-slash",
            event = "ap-court:client:barDecMembers",
            isServer = false
        },
        {
            label = LangClient['judge_menu_3_label'],
            description = LangClient['judge_menu_3_description'],
            icon = "book-open",
            event = "ap-court:client:judgeExamQuestions",
            isServer = false
        },
        {
            label = LangClient['judge_menu_4_label'],
            description = LangClient['judge_menu_4_description'],
            icon = "calendar-check",
            event = "ap-court:client:appointmentRequests",
            isServer = false
        },
        {
            label = LangClient['judge_menu_5_label'],
            description = LangClient['judge_menu_5_description'],
            icon = "calendar-alt",
            event = "ap-court:client:scheduledAppointments",
            isServer = false
        },
        {
            label = LangClient['judge_menu_6_label'],
            description = LangClient['judge_menu_6_description'],
            icon = "folder-plus",
            event = "ap-court:client:createCourtCase",
            isServer = false
        },
        {
            label = LangClient['judge_menu_7_label'],
            description = LangClient['judge_menu_7_description'],
            icon = "cogs",
            event = "ap-court:client:caseConfigureMenu",
            isServer = false
        }
    }

    if Config.CriminalRecordArchives then
        table.insert(entries, {
            label = LangClient['judge_menu_8_label'],
            description = LangClient['judge_menu_8_description'],
            icon = "archive",
            event = "ap-court:client:criminalRecordArc",
            isServer = false
        })
    end

    local menuTitle = LangClient['judge_menu_title']

    if Config.Context.QB then
        local qbMenu = {
            {
                header = menuTitle,
                isMenuHeader = true
            }
        }

        for _, entry in ipairs(entries) do
            table.insert(qbMenu, {
                header = entry.label,
                txt = entry.description,
                icon = "fas fa-" .. entry.icon,
                params = {
                    event = entry.event,
                    isServer = entry.isServer,
                    args = {}
                }
            })
        end

        ContextMenu(qbMenu)

    elseif Config.Context.OX then
        local oxOptions = {}
        for _, entry in ipairs(entries) do
            table.insert(oxOptions, {
                title = entry.label,
                description = entry.description,
                icon = "fas fa-" .. entry.icon,
                event = entry.event,
                args = {},
                disabled = false
            })
        end

        lib.registerContext({
            id = "judgeMenu",
            title = menuTitle,
            options = oxOptions
        })

        ContextMenu("judgeMenu")

    elseif Config.Context.AP then
        local apOptions = {}
        for _, entry in ipairs(entries) do
            table.insert(apOptions, {
                title = entry.label,
                description = entry.description,
                icon = "fas fa-" .. entry.icon,
                event = entry.event,
                args = {},
                isServer = entry.isServer
            })
        end

        MyUI.showContext(menuTitle, apOptions, nil, 10)
    end
end)

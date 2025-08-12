local slots = 60
local weight = 50000

local registeredStashes = {}
local stashGroups = {}

for job, permissions in pairs(Config.Police.Permissions) do
    if permissions.stash then
        stashGroups[job] = permissions.stash.view
    end
end

---@param stashId string
---@param label string
local function RegisterStash(stashId, label)
    if registeredStashes[stashId] then
        return
    end

    if GetResourceState("ox_inventory") == "started" then
        exports.ox_inventory:RegisterStash(stashId, label, slots, weight, nil, stashGroups)
    end

    debugprint("Registered stash:", stashId)

    registeredStashes[stashId] = true
end

---@param source number
---@param stashId string
---@param label string
function OpenStash(source, stashId, label)
    RegisterStash(stashId, label)

    if GetResourceState("ps-inventory") == "started" then
        exports["ps-inventory"]:OpenInventory(source, stashId, {
            maxweight = weight,
            slots = slots,
            label = label
        })
    elseif GetResourceState("ps-inventory") == "started" then
        exports["ps-inventory"]:OpenInventory(source, stashId, {
            maxweight = weight,
            slots = slots,
            label = label
        })
    end

    debugprint(source .. " opened stash: " .. stashId)

    TriggerClientEvent("tablet:police:openStash", source, stashId)
end

if Config.Framework ~= "qb" then
    return
end

while not QB do
    Wait(0)
end

---@param source number
---@param itemName string
---@return boolean
function HasItem(source, itemName)
    if GetResourceState("ox_inventory") == "started" then
        return (exports.ox_inventory:Search(source, "count", itemName) or 0) > 0
    elseif GetResourceState("qs-inventory") == "started" then
        return (exports["qs-inventory"]:GetItemTotalAmount(source, itemName) or 0) > 0
    end

    local qPlayer = QB.Functions.GetPlayer(tonumber(source))

    if not qPlayer then
        debugprint("HasItem: Failed to get player for source:", source)
        return false
    end

    return (qPlayer.Functions.GetItemByName(itemName)?.amount or 0) > 0
end

---@param item string
---@param cb function
function CreateUsableItem(item, cb)
    QB.Functions.CreateUseableItem(item, cb)
end

---@param weapon string
---@return string?
function GetWeaponName(weapon)
    weapon = weapon:lower()

    return QB.Shared.Items[weapon] and QB.Shared.Items[weapon].label or weapon
end

---@param weapon string
---@return string?
function GetWeaponImage(weapon)
    if GetResourceState("ox_inventory") == "started" then
        local fileName = "web/images/" .. weapon:upper() .. ".png"
        local fileExists = LoadResourceFile("ox_inventory", fileName)

        if fileExists then
            return "https://cfx-nui-ox_inventory/" .. fileName
        end
    end

    weapon = weapon:lower()

    local itemImage = QB.Shared.Items[weapon] and QB.Shared.Items[weapon].image

    if itemImage then
        return "https://cfx-nui-ps-inventory/html/images/" .. itemImage
    end
end

if Config.Framework ~= "esx" then
    return
end

while not ESX do
    Wait(500)
end

---@param source number
---@param itemName string
function HasItem(source, itemName)
    if GetResourceState("ox_inventory") == "started" then
        return (exports.ox_inventory:Search(source, "count", itemName) or 0) > 0
    elseif GetResourceState("qs-inventory") == "started" then
        return (exports["qs-inventory"]:GetItemTotalAmount(source, itemName) or 0) > 0
    end

    local xPlayer = ESX.GetPlayerFromId(source)

    return xPlayer.getInventoryItem(itemName).count > 0
end

---@param item string
---@param cb fun(source: number)
function CreateUsableItem(item, cb)
    ESX.RegisterUsableItem(item, cb)
end

---@param weapon string
---@return string?
function GetWeaponName(weapon)
    local success, label = pcall(ESX.GetWeaponLabel, weapon)

    if not success then
        debugprint("Failed to get weapon label", weapon)

        success, label = pcall(ESX.GetItemLabel, weapon)
    end

    if success then
        return label
    end
end

---@param weapon string
---@return string?
function GetWeaponImage(weapon)
    weapon = weapon:upper()

    if GetResourceState("ox_inventory") == "started" then
        local fileName = "web/images/" .. weapon .. ".png"
        local fileExists = LoadResourceFile("ox_inventory", fileName)

        if fileExists then
            return "https://cfx-nui-ox_inventory/" .. fileName
        end
    end
end

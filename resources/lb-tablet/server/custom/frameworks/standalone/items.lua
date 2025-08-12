if Config.Framework ~= "standalone" then
    return
end

---@param source number
---@param itemName string
function HasItem(source, itemName)
    if GetResourceState("ox_inventory") == "started" then
        return (exports.ox_inventory:Search(source, "count", itemName) or 0) > 0
    end

    return true
end

---@param item string
---@param cb fun(source: number)
function CreateUsableItem(item, cb)
end

---@param weapon string
---@return string?
function GetWeaponName(weapon)
    if not Weapons then
        return
    end

    for i = 1, #Weapons do
        if Weapons[i].model == weapon then
            return Weapons[i].label
        end
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

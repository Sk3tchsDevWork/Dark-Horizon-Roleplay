if not Config.LBPhone or Config.Item.Inventory ~= "ps-inventory" then
    return
end

---Function to get all items a player has with a specific name
---@param source number
---@param name string
---@return table items
local function GetItemsByName(source, name)
    local inventory = QB.Functions.GetPlayer(source).PlayerData.items
    local items = {}

    for _, item in pairs(inventory) do
        if item?.name == name then
            items[#items+1] = item
        end
    end

    return items
end

---@param source number
---@return { phoneNumber: string, phoneName?: string }[]
function GetPhones(source)
    local phones = {}
    local phoneItem = GetPhoneConfig().Item.Name --[[@as string]]
    local items = GetItemsByName(source, phoneItem)

    if not items or #items == 0 then
        return phones
    end

    for i = 1, #items do
        local item = items[i]

        if item and item.info and item.info.lbPhoneNumber then
            phones[#phones+1] = {
                phoneNumber = item.info.lbPhoneNumber,
                phoneName = item.info.lbPhoneName
            }
        end
    end

    return phones
end

---@param source number
---@param phoneNumber string
---@return boolean
function HasPhone(source, phoneNumber)
    local phoneItem = GetPhoneConfig().Item.Name --[[@as string]]
    local items = GetItemsByName(source, phoneItem)

    for i = 1, #items do
        local item = items[i]

        if item and item.info and item.info.lbPhoneNumber == phoneNumber then
            return true
        end
    end

    return false
end

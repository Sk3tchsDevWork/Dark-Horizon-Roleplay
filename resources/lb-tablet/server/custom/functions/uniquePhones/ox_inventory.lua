if not Config.LBPhone or Config.Item.Inventory ~= "ox_inventory" then
    return
end

---@param source number
---@return { phoneNumber: string, phoneName?: string }[]
function GetPhones(source)
    local phones = {}
    local phoneItem = GetPhoneConfig().Item.Name --[[@as string]]
    local items = exports.ox_inventory:Search(source, "slots", phoneItem)

    if not items or #items == 0 then
        return phones
    end

    for i = 1, #items do
        local item = items[i]

        if item and item.metadata and item.metadata.lbPhoneNumber then
            phones[#phones+1] = {
                phoneNumber = item.metadata.lbPhoneNumber,
                phoneName = item.metadata.lbPhoneName
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

    return exports.ox_inventory:Search(source, "count", phoneItem, {
        lbPhoneNumber = phoneNumber
    }) > 0
end

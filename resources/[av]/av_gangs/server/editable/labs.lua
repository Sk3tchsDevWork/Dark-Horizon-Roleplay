--[[ 
    Use this function to process your lab by running your own code
    Don't use this function if you aren't experienced enough because no support will be provided... 
        is your responsability to make it work the way you want, otherwise use the default method from the script
    identifier: string = Lab identifier
    lab: table = Lab info
    ingredientStash: string = Stash name for ingredients
    productStash: string = Stash name for product

    Important: 
    - Ingredients stash will NOT be wiped if you run customProcess, is on you to wipe it
    - Is on you to retrieve the stash items, use exports['av_laptop']:getStashItems(ingredientStash)
    - Is on you to add the final product to productStash use exports['av_laptop']:addToStash(productStash, itemName, amount, metadata)
    - processed should return true if the lab was processed by your code, otherwise return false and the default script process will run
]]--
function customProcess(identifier, lab, gang, ingredientStash, productStash)
    local processed = false
    local type = lab and lab['type'] or false
    -- This is just an EXAMPLE where we take the "worth" field from the metadata in the "markedbills" items, and we use that value to convert it into cash
    -- if type and type == "laundromat" then
    --     local items = exports['av_laptop']:getStashItems(ingredientStash)
    --     local toAdd = 0
    --     if items and next(items) then
    --         for _, v in pairs(items) do
    --             if v['name'] == "markedbills" then
    --                 local metadata = v['metadata'] or v['info'] or {}
    --                 local worth = metadata['worth'] or 0
    --                 toAdd += worth
    --             end
    --         end
    --         if toAdd > 0 then
    --             exports['av_laptop']:wipeStash(ingredientStash)
    --             exports['av_laptop']:addToStash(productStash, "cash", toAdd)
    --         end
    --     end
    --     processed = true
    -- end
    return processed
end

--[[
    Use this function to retrieve lab purity using your own code or leave it as it is
    Don't use this function if you aren't experienced enough because no support will be provided... 
        is your responsability to make it work the way you want, otherwise use the default method from the script
    identifier: string = Lab identifier
    lab: table = Lab info
    ingredientStash: string = Stash name for ingredients
    productStash: string = Stash name for product
    - There's no need to wipe the productStash, the script will wipe it after running this function
]]
function getPurity(identifier, lab, gang, ingredientStash, productStash)
    local purity = false
    local type = lab and lab['type'] or false
    -- This is an Example where we try to retrieve the field "purity" from the items metadata in the ingredients stash
    -- if type and type == "drugs" then
    --     local labSettings = Config.Products['labs'] and Config.Products['labs'][lab['shell']] or {}
    --     if not labSettings then
    --         dbug("labSettings is null for lab type and shell", lab['type'], lab['shell'])
    --         return purity
    --     end
    --     local items = exports['av_laptop']:getStashItems(ingredientStash)
    --     local currentPurity = 0
    --     if items and next(items) then
    --         for _, item in pairs(items) do
    --             if item['name'] == labSettings['ingredients'] then
    --                 local metadata = item['metadata'] or item['info'] or {}
    --                 local itemPurity = metadata[Config.PurityField] and removeSymbol(metadata[Config.PurityField]) -- removeSymbol returns the purity value without the % symbol or false
    --                 if itemPurity and tonumber(itemPurity) > currentPurity then
    --                     currentPurity = tonumber(itemPurity)
    --                 end
    --             end
    --         end
    --         if currentPurity > 0 then
    --             return currentPurity
    --         end
    --     end
    -- end
    return purity
end
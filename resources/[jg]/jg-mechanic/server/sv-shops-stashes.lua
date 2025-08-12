--
-- Shops
--

RegisterNetEvent("jg-mechanic:server:buy-item", function(shopIndex, itemIndex, qty, mechanicId)
  local src = source

  local mechanicConfig = Config.MechanicLocations[mechanicId]
  if not mechanicConfig then return end

  local convertedMechanicId = mechanicConfig and mechanicConfig.job or nil
  if not convertedMechanicId then
    Framework.Server.Notify(src, Locale.shopNameError, "error")
    return
  end

  local item = mechanicConfig.shops?[shopIndex]?.items?[itemIndex]
  if not item then
    Framework.Server.Notify(src, Locale.failedGiveItem, "error")
    return
  end

  local itemName = item.name;
  local totalCost = item.price * qty

  if Config.UseSocietyFund then
    local success = removeFromSocietyFund(src, mechanicId, totalCost)
    if not success then return end
  else
    local playerBalance = Framework.Server.GetPlayerBalance(src, Config.PlayerBalance or "bank")
    if playerBalance < totalCost then
      Framework.Server.Notify(src, Locale.notEnoughMoney, "error")
      return
    end

    Framework.Server.PlayerRemoveMoney(src, totalCost, Config.PlayerBalance or "bank")
  end

  local itemGiven = Framework.Server.GiveItem(src, itemName, qty)
  if not itemGiven then
    Framework.Server.Notify(src, Locale.failedGiveItem, "error")
    return
  end

  Framework.Server.Notify(src, Locale.purchaseSuccess:format(qty, itemName), "success")
end)

--
-- Stashes
--

CreateThread(function()
  if (Config.Inventory == "auto" and GetResourceState("ox_inventory") == "started") or Config.Inventory == "ox_inventory" then
    for name, shopData in pairs(Config.MechanicLocations) do
      if shopData.stashes then
        for index, stashData in ipairs(shopData.stashes) do
          local stashId = name .. "_" .. stashData.name:gsub(" ", "_"):lower() .. "_" .. index
          local label = stashData.name
          local slots = stashData.slots or 50
          local maxWeight = stashData.weight or 50000
          local coords = stashData.coords

          if stashId and coords then
            exports.ox_inventory:RegisterStash(stashId, label, slots, maxWeight, nil, nil, coords)
            debugPrint(("[ox_inventory] Registered stash: ID=%s, Label=%s, Slots=%d, Weight=%d, Coords=%s"):format(
              stashId,
              label,
              slots,
              maxWeight,
              coords
            ), "debug")
          end
        end
      end
    end
  end
end)
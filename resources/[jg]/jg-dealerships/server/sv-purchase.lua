---@param dealershipId string
---@param coords vector4
---@param purchaseType "personal"|"society"
---@param society string
---@param societyType "job"|"gang"
---@param model string
---@param colour string
---@param paymentMethod "bank"|"cash"
---@param financed boolean
---@param directSaleUuid? string
---@return boolean, integer?, integer?, string?, number?
local function purchaseVehicle(src, dealershipId, coords, purchaseType, society, societyType, model, colour, paymentMethod, financed, directSaleUuid)
  local dealership = Config.DealershipLocations[dealershipId]
  local pendingSale, sellerPlayer, sellerPlayerName = nil, nil, nil

  -- If directSaleUuid was provided, fetch info
  if directSaleUuid then
    pendingSale = PendingDirectSales[directSaleUuid]
    if not pendingSale then return false end
  
    -- Is the intended recipient accepting?
    if src ~= pendingSale.playerId then return false end

    if pendingSale.dealerPlayerId then
      sellerPlayer = Framework.Server.GetPlayerIdentifier(pendingSale.dealerPlayerId)
      sellerPlayerName = Framework.Server.GetPlayerInfo(pendingSale.dealerPlayerId)
      sellerPlayerName = sellerPlayerName and sellerPlayerName.name or nil
    end

    financed = pendingSale.finance -- In case this was somehow changed by in transit by manually firing the purchase-vehicle event
  end

  -- Financed but the dealership location doesn't allow that?
  if not dealership.enableFinance and financed then return false end

  -- Check if valid payment method
  local isValidPaymentMethod = lib.table.contains(dealership.paymentOptions or {"cash", "bank"}, paymentMethod)
  if not isValidPaymentMethod and paymentMethod ~= "societyFund" then
    Framework.Server.Notify(src, "INVALID_PAYMENT_METHOD", "error")
    DebugPrint(("%s attempted to purchase a vehicle with an invalid payment method: %s"):format(tostring(src), paymentMethod), "warning")
    return false
  end
  
  local plate = Framework.Server.VehicleGeneratePlate(Config.PlateFormat, true)
  if not plate then
    Framework.Server.Notify(src, "COULD_NOT_GENERATE_PLATE", "error")
    return false
  end
  
  -- Get vehicle data
  local vehicleData = MySQL.single.await("SELECT * FROM dealership_stock WHERE vehicle = ? AND dealership = ?", {model, dealershipId})
  if not vehicleData then
    DebugPrint("Vehicle not found in dealership(" .. dealershipId .. ") stock: " .. model, "warning")
    return false
  end

  -- Check stock level
  local vehicleStock = vehicleData.stock
  if dealership.type == "owned" and vehicleStock < 1 then
    Framework.Server.Notify(src, Locale.errorVehicleOutOfStock, "error")
    return false
  end

  local player = Framework.Server.GetPlayerIdentifier(src)
  local financeData = nil
  local amountToPay = Round(vehicleData.price)
  local accountBalance = Framework.Server.GetPlayerBalance(src, paymentMethod)
  local paymentType, paid, owed = "full", amountToPay, 0
  local downPayment, noOfPayments = Config.FinanceDownPayment, Config.FinancePayments

  if purchaseType == "society" and paymentMethod == "societyFund" then
    accountBalance = Framework.Server.GetSocietyBalance(society, societyType)
  end

  if financed and purchaseType == "personal" then
    amountToPay = Round(vehicleData.price * (1 + Config.FinanceInterest) * downPayment) -- down payment

    if pendingSale then
      downPayment, noOfPayments = pendingSale.downPayment, pendingSale.noOfPayments
      amountToPay = Round(vehicleData.price * (1 + Config.FinanceInterest) * downPayment)
    end

    financeData = {
      total = Round(vehicleData.price * (1 + Config.FinanceInterest)),
      paid = amountToPay,
      recurring_payment = Round((vehicleData.price * (1 + Config.FinanceInterest) * (1 - downPayment)) / noOfPayments),
      payments_complete = 0,
      total_payments = noOfPayments,
      payment_interval = Config.FinancePaymentInterval,
      payment_failed = false,
      seconds_to_next_payment = Config.FinancePaymentInterval * 3600,
      seconds_to_repo = 0,
      dealership_id = dealershipId,
      vehicle = model
    }

    local vehiclesOnFinance = MySQL.scalar.await("SELECT COUNT(*) as total FROM " .. Framework.VehiclesTable .. " WHERE financed = 1 AND " .. Framework.PlayerId .. " = ?", {player})
    
    if vehiclesOnFinance >= (Config.MaxFinancedVehiclesPerPlayer or 999999) then
      Framework.Server.Notify(src, "TOO_MANY_FINANCED_VEHICLES", "error")
      return false
    end

    paymentType = "finance"
    owed = financeData.total - financeData.paid
  end

  if amountToPay > accountBalance then
    Framework.Server.Notify(src, Locale.errorCannotAffordVehicle, "error")
    return false
  end

  -- Pre check func in config-sv.lua
  if not PurchaseVehiclePreCheck(src, dealershipId, plate, model, purchaseType, amountToPay, paymentMethod, society, societyType, financed, noOfPayments, downPayment, (not not directSaleUuid), pendingSale?.dealerPlayerId) then
    DebugPrint(("PurchaseVehiclePreCheck failed for player %s"):format(tostring(src)), "debug")
    return false
  end

  -- Remove money
  if purchaseType == "society" and paymentMethod == "societyFund" then
    Framework.Server.RemoveFromSocietyFund(society, societyType, amountToPay)
  else
    Framework.Server.PlayerRemoveMoney(src, amountToPay, paymentMethod)
  end

  if dealership.type == "owned" then
    MySQL.update.await("UPDATE dealership_stock SET stock = stock - 1 WHERE vehicle = ? AND dealership = ?", {model, dealershipId})
    MySQL.update.await("UPDATE dealership_data SET balance = balance + ? WHERE name = ?", {amountToPay, dealershipId})
    UpdateDealershipShowroomCache(dealershipId)
  end
  
  MySQL.insert.await("INSERT INTO dealership_sales (dealership, vehicle, plate, player, seller, purchase_type, paid, owed) VALUES(?, ?, ?, ?, ?, ?, ?, ?)", {dealershipId, model, plate, player, sellerPlayer, paymentType, paid, owed})

  -- Save vehicle to garage
  local vehicleId = Framework.Server.SaveVehicleToGarage(src, purchaseType, society, societyType, model, plate, financed, financeData)

  -- Spawn vehicle on server (if configured)
  local netId = nil

  if Config.SpawnVehiclesWithServerSetter then
    local warp = not Config.DoNotSpawnInsideVehicle
    local properties = {
      plate = plate,
      colour = colour
    }

    netId = SpawnVehicleServer(src, vehicleId or 0, model, plate, coords, warp, properties, "purchase")
    if not netId or netId == 0 then
      Framework.Server.Notify(src, "Could not spawn vehicle with Config.SpawnVehiclesWithServerSetter", "error") 
      DebugPrint("Could not spawn vehicle with Config.SpawnVehiclesWithServerSetter", "warning")
      return false
    end
  end
  
  -- Send webhook
  SendWebhook(src, Webhooks.Purchase, "New Vehicle Purchase", "success", {
    { key = "Vehicle", value = model },
    { key = "Plate", value = plate },
    { key = "Financed", value = financed and "Yes" or "No" },
    { key = "Amount Paid", value = amountToPay },
    { key = "Payment method", value = paymentMethod },
    { key = "Dealership", value = dealershipId },
    { key = "Seller Name", value = sellerPlayerName or "-" }
  })

  Framework.Server.Notify(src, Locale.purchaseSuccess, "success")

  return true, netId, vehicleId, plate, amountToPay
end

lib.callback.register("jg-dealerships:server:purchase-vehicle", function(...)
  return purchaseVehicle(...)
end)

RegisterNetEvent("jg-dealerships:server:update-purchased-vehicle-props", function(purchaseType, society, plate, props)
  local src = source
  local identifier = purchaseType == "society" and society or Framework.Server.GetPlayerIdentifier(src)

  MySQL.update.await("UPDATE " .. Framework.VehiclesTable .. " SET " .. Framework.VehProps .. " = ? WHERE plate = ? AND " .. Framework.PlayerId .. " = ?", {
    json.encode(props), plate, identifier
  })
end)
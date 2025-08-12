-- 
-- Events
-- 

---Fired when a vehicle is purchased
---@param vehNetId integer
---@param plate string
---@param purchaseType "personal"|"society"
---@param amount number
---@param paymentMethod "bank"|"cash"
---@param financed boolean
RegisterNetEvent("jg-dealerships:server:purchase-vehicle:config", function(vehNetId, plate, purchaseType, amount, paymentMethod, financed)
  local src = source
  local vehicle = NetworkGetEntityFromNetworkId(vehNetId)

end)

---Fired when vehicle finance has paid in full
---@param playerId integer
---@param plate string
RegisterNetEvent("jg-dealerships:server:vehicle-finance-complete", function(playerId, plate)

end)

---Fired when vehicle finance loan has been defaulted on
---@param playerId integer
---@param plate string
---@param amountOwed number
RegisterNetEvent("jg-dealerships:server:vehicle-finance-defaulted", function(playerId, plate, amountOwed)
  
end)

-- 
-- Hooks
-- 

---Add custom checks before the vehicle can be sold - return false to prevent purchase
---@param dealershipId string
---@param plate string
---@param model string
---@param price number
---@return boolean allowed
function SellVehiclePreCheck(dealershipId, plate, model, price)
  return true
end

---Add custom checks here before a sale can go ahead - return false to prevent purchase
---@param playerId integer
---@param dealershipId string
---@param plate string
---@param model string|integer
---@param purchaseType "personal"|"society"
---@param amountToPay number
---@param paymentMethod "bank"|"cash"
---@param society string
---@param societyType "job"|"gang"
---@param financed boolean
---@param noOfPayments? number
---@param downPayment? number
---@param isDirectSale? boolean
---@param sellerPlayerId? integer
---@return boolean allowed
function PurchaseVehiclePreCheck(playerId, dealershipId, plate, model, purchaseType, amountToPay, paymentMethod, society, societyType, financed, noOfPayments, downPayment, isDirectSale, sellerPlayerId)  
  return true
end
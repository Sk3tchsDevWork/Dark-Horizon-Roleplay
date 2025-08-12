-- 
-- Events
-- 

---Fired when the vehicle is purchased
---@param vehicle integer
---@param plate string
---@param purchaseType "personal"|"society"
---@param amount number
---@param paymentMethod "bank"|"cash"
---@param financed boolean
RegisterNetEvent("jg-dealerships:client:purchase-vehicle:config", function(vehicle, plate, purchaseType, amount, paymentMethod, financed)

end)

---Fired when vehicle is test driven
---@param vehicle integer
---@param plate string
RegisterNetEvent("jg-dealerships:client:start-test-drive:config", function(vehicle, plate)

end)

---Fired when a vehicle is sold; this also contains the delete vehicle function
---@param vehicle integer
---@param plate string
RegisterNetEvent("jg-dealerships:client:sell-vehicle:config", function(vehicle, plate)
  --
  -- Add code here to run before the vehicle is deleted
  --

  JGDeleteVehicle(vehicle) -- this runs Kimi's AdvancedParking export already! 
end)

-- 
-- Hooks
-- 

---Runs before the showroom opens; return false to prevent showroom from opening
---@param dealershipId string
---@return boolean allowed
function ShowroomPreCheck(dealershipId)
  return true
end
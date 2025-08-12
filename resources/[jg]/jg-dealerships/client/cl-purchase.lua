---Purchase a vehicle
---@param dealershipId string
---@param model string|integer
---@param colour string
---@param purchaseType "society"|"personal"
---@param paymentMethod "bank"|"cash"
---@param society? any if purchaseType == "society"
---@param societyType? any
---@param finance boolean
---@param directSaleUuid? string
---@return boolean success
local function purchaseVehicle(dealershipId, model, colour, purchaseType, paymentMethod, society, societyType, finance, directSaleUuid)
  local dealership = Config.DealershipLocations[dealershipId]
  local hash = ConvertModelToHash(model)
  local vehicleType = GetVehicleTypeFromClass(GetVehicleClassFromName(hash))
  local coords = FindVehicleSpawnCoords(dealership.purchaseSpawn)

  ExitShowroom()

  local success, netId, vehicleId, plate, price = lib.callback.await("jg-dealerships:server:purchase-vehicle", false, dealershipId, coords, purchaseType, society, societyType, model, colour, paymentMethod, finance, directSaleUuid)
  local vehicle = netId and NetToVeh(netId) or nil --[[@as integer|false]]
  if not success then return false end

  -- TODO WIP: new spawning logic

  if Config.SpawnVehiclesWithServerSetter and not vehicle then
    print("^1[ERROR] There was a problem spawning in your vehicle")
    return false
  end

  -- Server spawning disabled, create vehicle on client
  if not vehicle and not Config.SpawnVehiclesWithServerSetter then
    local warp = not Config.DoNotSpawnInsideVehicle
    local properties = {
      plate = plate,
      colour = colour
    }
    
    vehicle = SpawnVehicleClient(vehicleId or 0, model, plate, coords, warp, properties, "purchase")
    if not vehicle then return false end
    
    netId = VehToNet(vehicle)
  end

  if not vehicle then return false end

  -- TODO: refactor this maybe? it's also a vulnerable event for people that know what they are doing
  local props = Framework.Client.GetVehicleProperties(vehicle)
  TriggerServerEvent("jg-dealerships:server:update-purchased-vehicle-props", purchaseType, society, plate, props)
  -- TODO END

  TriggerEvent("jg-dealerships:client:purchase-vehicle:config", vehicle, plate, purchaseType, price, paymentMethod, finance)
  TriggerServerEvent("jg-dealerships:server:purchase-vehicle:config", netId, plate, purchaseType, price, paymentMethod, finance)

  -- If they are running jg-advancedgarages, register the vehicle is out & set vehicle in valid garage ID
  if GetResourceState("jg-advancedgarages") == "started" then
    TriggerServerEvent("jg-advancedgarages:server:register-vehicle-outside", plate, netId)
    TriggerServerEvent("jg-advancedgarages:server:dealerships-send-to-default-garage", vehicleType, plate)
  end

  DoScreenFadeIn(500)

  return true
end

RegisterNUICallback("purchase-vehicle", function(data, cb)
  local dealershipId = data.dealership
  local model = data.vehicle
  local vehicleColor = data.color
  local purchaseType = data.purchaseType
  local paymentMethod = data.paymentMethod
  local finance = data.finance
  local society = data.society
  local societyType = data.societyType
  local directSaleUuid = data.directSaleUuid

  DoScreenFadeOut(500)
  Wait(500)

  local res = purchaseVehicle(dealershipId, model, vehicleColor, purchaseType, paymentMethod, society, societyType, finance, directSaleUuid)
  
  if not res then
    DoScreenFadeIn(0)
    return cb({error = true}) 
  end
  
  cb(true)
end)
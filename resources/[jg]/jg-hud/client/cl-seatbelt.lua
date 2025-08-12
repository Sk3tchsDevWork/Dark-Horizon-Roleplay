IsSeatbeltOn = true
local seatbeltThreadCreated = false

---Can vehicle class have a seatbelt? Disabled for bikes, motorcycles boats etc by default
---@param vehicle integer
---@return boolean canHaveSeatbelt
local function canVehicleClassHaveSeatbelt(vehicle)
  if not Config.EnableSeatbelt then return false end

  if not vehicle or not DoesEntityExist(vehicle) then
    return false
  end
  
  local vehicleClass = GetVehicleClass(vehicle)
  
  local seatbeltCompatibleClasses = {
    [0] = true,  -- Compacts
    [1] = true,  -- Sedans
    [2] = true,  -- SUVs
    [3] = true,  -- Coupes
    [4] = true,  -- Muscle
    [5] = true,  -- Sports Classics
    [6] = true,  -- Sports
    [7] = true,  -- Super
    [9] = true,  -- Off-road
    [10] = true, -- Industrial
    [11] = true, -- Utility
    [12] = true, -- Vans
    [17] = true, -- Service
    [18] = true, -- Emergency
    [19] = true, -- Military
    [20] = true, -- Commercial
  }
  
  -- Excluded veh classes
  -- [8] = Motorcycles
  -- [13] = Cycles/Bicycles
  -- [14] = Boats
  -- [15] = Helicopters
  -- [16] = Planes
  -- [21] = Trains
  
  return seatbeltCompatibleClasses[vehicleClass] or false
end

---Is a seatbelt allowed in this particular vehicle? Checks emergency vehicles, passenger seats etc
---@param vehicle integer
---@return boolean isSeatbeltAllowed
local function isSeatbeltAllowed(vehicle)
  if not Config.EnableSeatbelt then return false end
  if not vehicle then return false end
  
  if not canVehicleClassHaveSeatbelt(vehicle) then
    return false
  end

  if Config.DisablePassengerSeatbelts and cache.seat ~= -1 then
    return false
  end
  
  if Config.DisableSeatbeltInEmergencyVehicles then
    local vehicleClass = GetVehicleClass(vehicle)
    if vehicleClass == 18 then -- Emergency vehicles
      return false
    end
  end
  
  return true
end

---Simple built in seatbelt system using "fly through windscreen" natives
---@param willBeYeeted boolean
local function setWhetherPedWillFlyThroughWindscreen(willBeYeeted)
  SetFlyThroughWindscreenParams(
    ((not willBeYeeted) and Config.MinSpeedMphEjectionSeatbeltOn or Config.MinSpeedMphEjectionSeatbeltOff) / 2.237,
    1.0, 17.0, 10.0
  )
  SetPedConfigFlag(cache.ped, 32, willBeYeeted)
end

---Toggle seatbelt main function
---@param vehicle integer
---@param toggle boolean
function ToggleSeatbelt(vehicle, toggle)
  if not vehicle or not isSeatbeltAllowed(vehicle) then
    return
  end

  IsSeatbeltOn = toggle
  LocalPlayer.state:set("seatbelt", toggle) -- for integrations with other scripts, like jg-stress-addon

  if Config.UseCustomSeatbeltIntegration then
    Framework.Client.ToggleSeatbelt(vehicle, toggle)
  else
    setWhetherPedWillFlyThroughWindscreen(not toggle)
  end
end

---Thread to disable exiting vehicle when seatbelt is on
local function startSeatbeltExitPreventionThread()
  if not Config.PreventExitWhileBuckled then return end
  if seatbeltThreadCreated then return end
  seatbeltThreadCreated = true
  
  CreateThread(function()  
    while cache.vehicle do
      if IsSeatbeltOn then
        DisableControlAction(0, 75, true)
        DisableControlAction(27, 75, true)
      end
      
      Wait(1)
    end
    
    seatbeltThreadCreated = false
  end)
end

---When entering vehicle
---@param vehicle integer
local function onEnterVehicle(vehicle)
  if not isSeatbeltAllowed(vehicle) then
    setWhetherPedWillFlyThroughWindscreen(false)
    IsSeatbeltOn = true
    return
  end

  ToggleSeatbelt(vehicle, false) -- Seatbelt is off when entering vehicle
  startSeatbeltExitPreventionThread()
end

if Config.EnableSeatbelt then
  lib.onCache("vehicle", onEnterVehicle)

  CreateThread(function()
    if cache.vehicle then
      onEnterVehicle(cache.vehicle)
    end
  end)
end

-- Key mapping
if Config.EnableSeatbelt and Config.SeatbeltKeybind then
  RegisterCommand("toggle_seatbelt", function()
    ToggleSeatbelt(cache.vehicle, not IsSeatbeltOn)
  end, false)

  RegisterKeyMapping("toggle_seatbelt", "Toggle vehicle seatbelt", "keyboard", Config.SeatbeltKeybind or "B")
end

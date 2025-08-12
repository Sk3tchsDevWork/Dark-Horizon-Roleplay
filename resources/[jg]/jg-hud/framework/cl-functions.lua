Framework.CachedPlayerData = {
  job = nil,
  gang = nil,
  cash = nil,
  bank = nil,
  dirtyMoney = nil,
  hunger = nil,
  thirst = nil,
  stress = nil,
  micRange = 2,
  radioActive = false,
  voiceModes = 3,
}

---@param vehicle integer
---@return number fuelLevel
function Framework.Client.VehicleGetFuel(vehicle)
  if not DoesEntityExist(vehicle) then return 0 end

  if (Config.FuelSystem == "LegacyFuel" or Config.FuelSystem == "lc_fuel" or Config.FuelSystem == "ps-fuel" or Config.FuelSystem == "lj-fuel" or Config.FuelSystem == "cdn-fuel" or Config.FuelSystem == "hyon_gas_station" or Config.FuelSystem == "okokGasStation" or Config.FuelSystem == "nd_fuel" or Config.FuelSystem == "myFuel") then
    return exports[Config.FuelSystem]:GetFuel(vehicle)
  elseif Config.FuelSystem == "ti_fuel" then
    local level = exports["ti_fuel"]:getFuel(vehicle)
    return level
  elseif Config.FuelSystem == "ox_fuel" or Config.FuelSystem == "Renewed-Fuel" then
    return GetVehicleFuelLevel(vehicle)
  elseif Config.FuelSystem == "rcore_fuel" then
    return exports.rcore_fuel:GetVehicleFuelPercentage(vehicle)
  else
    return 100 -- or set up custom fuel system here...
  end
end

---Toggles the engine, this is used in the keybind & in the vehicle control panel
---@param vehicle integer
---@param on boolean on or off
function Framework.Client.ToggleEngine(vehicle, on)
  -- !! Consider adding a key script check here - to disallow enabling the engine if no keys are present
  SetVehicleEngineOn(vehicle, on, false, true)
end

---Code to run when seatbelt is toggled
---@param vehicle integer
---@param seatbeltOn boolean true = seatbelt on, false = seatbelt off
function Framework.Client.ToggleSeatbelt(vehicle, seatbeltOn)
  -- Add a custom seatbelt integration here
end

---@return table | false playerData
function Framework.Client.GetPlayerData()
  if Config.Framework == "QBCore" then
    ---@diagnostic disable-next-line: undefined-field
    return QBCore.Functions.GetPlayerData()
  elseif Config.Framework == "Qbox" then
    return exports.qbx_core:GetPlayerData()
  elseif Config.Framework == "ESX" then
    ---@diagnostic disable-next-line: undefined-field
    return ESX.GetPlayerData()
  end

  return false
end

---@return string?
function Framework.Client.GetPlayerJob()
  local player = Framework.Client.GetPlayerData()
  if not player or not player.job then return nil end

  if Config.Framework == "QBCore" or Config.Framework == "Qbox" then
    return string.format("%s (%s)", player.job.label, player.job.grade.name)
  elseif Config.Framework == "ESX" then
    return string.format("%s (%s)", player.job.label, player.job.grade_label)  
  end

  return nil
end

---@return string?
function Framework.Client.GetPlayerGang()
  if GetResourceState("rcore_gangs") == "started" then
    local gang = exports.rcore_gangs:GetPlayerGang()
    if not gang then return nil end

    return gang.tag
  end

  local player = Framework.Client.GetPlayerData()
  if not player or not player.gang then return nil end

  if Config.Framework == "QBCore" or Config.Framework == "Qbox" then
    return string.format("%s (%s)", player.gang.label, player.gang.grade.name)
  elseif Config.Framework == "ESX" then
    return nil
  end

  return nil
end

---@return boolean dead
function Framework.Client.IsPlayerDead()
  if Config.Framework == "QBCore" or Config.Framework == "Qbox" then
    local player = Framework.Client.GetPlayerData()
    if not player then return false end

    if player.metadata?.isdead or player.metadata?.inlaststand then
      return true
    end
  elseif Config.Framework == "ESX" then
    return IsEntityDead(cache.ped)
  end

  return false
end

---@param type "cash" | "bank" | "money" | "dirtyMoney" | "black_money"
---@return number? balance
function Framework.Client.GetBalance(type)
  if Config.Framework == "QBCore" then
    ---@diagnostic disable-next-line: undefined-field
    local playerData = QBCore.Functions.GetPlayerData()

    if type == "dirtyMoney" then
      -- Fetch "markedbills" from inventory
      local dirty = 0
      for _, item in pairs(playerData.items or {}) do
        if item.name == "markedbills" then
          if item.info and item.info.worth then
            dirty = dirty + item.info.worth
          end
        end
      end
      return dirty
    end
    
    return playerData?.money?[type] or 0
  elseif Config.Framework == "Qbox" then
    if type == "dirtyMoney" and GetResourceState("ox_inventory") == "started" then
      -- Fetch dirty_money from ox_inv
      return exports.ox_inventory:GetItemCount("black_money") or 0
    end
 
    return exports.qbx_core:GetPlayerData()?.money?[type] or 0
  elseif Config.Framework == "ESX" then
    if type == "cash" then type = "money" end
    if type == "dirtyMoney" then type = "black_money" end
 
    ---@diagnostic disable-next-line: undefined-field
    local playerData = ESX.GetPlayerData()
    if not playerData then return 0 end
    
    for i, acc in pairs(playerData?.accounts or {}) do
      if acc.name == type then
        return acc.money or 0
      end
    end

    return 0
  end

  return nil
end

---@param vehicle integer
function Framework.Client.GetVehicleMileageInKm(vehicle)
  if not vehicle or vehicle == 0 then return false end

  -- t1ger_mechanic integration
  if GetResourceState("t1ger_mechanic") == "started" then
    return exports["t1ger_mechanic"]:GetVehicleMileage(vehicle)
  end

  -- This is for jg-vehiclemileage, as it's stored in a statebag
  -- If you're using a different vehicle mileage script, you can add the export for it here! :)
  return Entity(vehicle).state.vehicleMileage or 0
end

---@param km number
---@return number
function Framework.Client.ConvertKmToMiles(km)
  return km * 0.621371
end

function Framework.Client.ConvertSpeed(speed, unit)
  if unit == "mph" then return speed * 2.236936 end
  if unit == "kph" then return speed * 3.6 end
  return speed
end

function Framework.Client.ConvertDistance(dist, unit)
  if unit == "meters" then return dist * 1 end
  if unit == "feet" then return dist * 3.28084 end
  return dist
end

-- Setup event listeners for player login
---@return nil
function Framework.Client.SetupPlayerLoginListeners()
  if Config.Framework == "QBCore" then
    RegisterNetEvent("QBCore:Client:OnPlayerLoaded", function()
      LocalPlayer.state:set("jgHudPlayerLoggedIn", true)

      Framework.CachedPlayerData.job = Framework.Client.GetPlayerJob()
      Framework.CachedPlayerData.gang = Framework.Client.GetPlayerGang()
      
      local playerData = Framework.Client.GetPlayerData()
      if playerData then
        Framework.CachedPlayerData.hunger = math.min(math.max(playerData.metadata?.hunger or 0, 0), 100)
        Framework.CachedPlayerData.thirst = math.min(math.max(playerData.metadata?.thirst or 0, 0), 100)
      end
    end)

    RegisterNetEvent("QBCore:Client:OnPlayerUnload", function()
      LocalPlayer.state:set("jgHudPlayerLoggedIn", false)
    end)
  elseif Config.Framework == "Qbox" then
    AddStateBagChangeHandler("isLoggedIn", ("player:%s"):format(cache.serverId), function(_, _, loggedIn)
      if loggedIn then LocalPlayer.state:set("jgHudPlayerLoggedIn", true)
      else LocalPlayer.state:set("jgHudPlayerLoggedIn", false) end
    end)
  elseif Config.Framework == "ESX" then
    RegisterNetEvent("esx:playerLoaded", function()
      lib.waitFor(function()
        if Framework.Client.GetPlayerData() and cache.ped then return true end
      end, "Ped has not loaded or GetPlayerData returned false (waited 30 seconds)", 30000)

      LocalPlayer.state:set("jgHudPlayerLoggedIn", true)
      Framework.CachedPlayerData.job = Framework.Client.GetPlayerJob()
    end)

    RegisterNetEvent("esx:onPlayerSpawn", function()
      lib.waitFor(function()
        if Framework.Client.GetPlayerData() and cache.ped then return true end
      end, "Ped has not loaded or GetPlayerData returned false (waited 30 seconds)", 30000)

      LocalPlayer.state:set("jgHudPlayerLoggedIn", true)
      Framework.CachedPlayerData.job = Framework.Client.GetPlayerJob()
    end)

    RegisterNetEvent("esx:onPlayerLogout", function()
      LocalPlayer.state:set("jgHudPlayerLoggedIn", false)
    end)
  else
    -- No framework, just say they are already logged in.
    -- Or you can add your own system or exports here! Just update the 
    -- LocalPlayer jgHudPlayerLoggedIn true/false and everything will work!
    lib.waitFor(function()
      if cache.ped then
        LocalPlayer.state:set("jgHudPlayerLoggedIn", true)
        return true
      end
    end, "[Standalone] Ped never loaded in; could not login (waited 500 seconds)", 500000)
  end
end

-- Setup all core event listeners, for things like thirst, hunger, job, money & voice
---@return nil
function Framework.Client.CreateEventListeners()
  local state = LocalPlayer.state
  Framework.CachedPlayerData.hunger = math.min(math.max(state?.hunger or 0, 0), 100) or nil
  Framework.CachedPlayerData.thirst = math.min(math.max(state?.thirst or 0, 0), 100) or nil
  Framework.CachedPlayerData.stress = math.min(math.max(state?.stress or 0, 0), 100) or nil

  -- Initial fetch
  if Config.Framework == "ESX" or Config.Framework == "QBCore" or Config.Framework == "Qbox" then
    if not Framework.Client.GetPlayerData() then return end

    if Config.ShowComponents.job then
      Framework.CachedPlayerData.job = Framework.Client.GetPlayerJob()
    end

    if Config.ShowComponents.gang then
      Framework.CachedPlayerData.gang = Framework.Client.GetPlayerGang()
    end

    if Config.ShowComponents.cashBalance then
      Framework.CachedPlayerData.cash = Framework.Client.GetBalance("cash")
    end

    if Config.ShowComponents.bankBalance then
      Framework.CachedPlayerData.bank = Framework.Client.GetBalance("bank")
    end

    if Config.ShowComponents.dirtyMoneyBalance then
      Framework.CachedPlayerData.dirtyMoney = Framework.Client.GetBalance("dirtyMoney")
    end

    if Config.Framework == "QBCore" then
      local playerData = Framework.Client.GetPlayerData()
      if playerData then
        Framework.CachedPlayerData.hunger = math.min(math.max(playerData.metadata?.hunger or 0, 0), 100)
        Framework.CachedPlayerData.thirst = math.min(math.max(playerData.metadata?.thirst or 0, 0), 100)
      end
    end
  end

  -- ESX
  if Config.Framework == "ESX" then
    RegisterNetEvent("esx_status:onTick")
    AddEventHandler("esx_status:onTick", function(data)
      local newHunger, newThirst

      for i = 1, #data do
        if data[i].name == "thirst" then
          newThirst = math.floor(data[i].percent)
        end
        if data[i].name == "hunger" then
          newHunger = math.floor(data[i].percent)
        end
      end

      Framework.CachedPlayerData.hunger = math.min(math.max(newHunger or 0, 0), 100)
      Framework.CachedPlayerData.thirst = math.min(math.max(newThirst or 0, 0), 100) 
    end)

    RegisterNetEvent("esx:setJob")
    AddEventHandler("esx:setJob", function(job)
      Framework.CachedPlayerData.job = string.format("%s (%s)", job.label, job.grade_label)
    end)

    RegisterNetEvent("esx:setAccountMoney", function(account)
      if account.name == "money" then Framework.CachedPlayerData.cash = account.money end
      if account.name == "bank" then Framework.CachedPlayerData.bank = account.money end
      if account.name == "black_money" then Framework.CachedPlayerData.dirtyMoney = account.money end
    end)
  end

  -- QBCore & Qbox
  if Config.Framework == "QBCore" or Config.Framework == "Qbox" then
    RegisterNetEvent("hud:client:UpdateNeeds", function(newHunger, newThirst) -- Triggered in qb-core
      Framework.CachedPlayerData.hunger = newHunger
      Framework.CachedPlayerData.thirst = newThirst
    end)

    RegisterNetEvent("hud:client:OnMoneyChange", function(type)
      -- The reason I fetch them directly from `GetBalance` and don't use the amount/isMinus args is because
      -- they didn't consistently work for me - especially when using /setmoney in QB or Qbox
      if type == "cash" then Framework.CachedPlayerData.cash = Framework.Client.GetBalance("cash") end
      if type == "bank" then Framework.CachedPlayerData.bank = Framework.Client.GetBalance("bank") end
    end)

    RegisterNetEvent("QBCore:Client:OnJobUpdate")
    AddEventHandler("QBCore:Client:OnJobUpdate", function()
      Framework.CachedPlayerData.job = Framework.Client.GetPlayerJob()
    end)

    RegisterNetEvent("QBCore:Client:OnGangUpdate")
    AddEventHandler("QBCore:Client:OnGangUpdate", function()
      Framework.CachedPlayerData.gang = Framework.Client.GetPlayerGang()
    end)
  end

  -- Qbox only
  if Config.Framework == "Qbox" then
    local playerState = LocalPlayer.state
    if playerState.hunger then Framework.CachedPlayerData.hunger = math.min(math.max(playerState.hunger or 0, 0), 100) end
    if playerState.thirst then Framework.CachedPlayerData.thirst = math.min(math.max(playerState.thirst or 0, 0), 100) end

    AddEventHandler("ox_inventory:itemCount", function(itemName, totalCount)
      if itemName == "black_money" then
        Framework.CachedPlayerData.dirtyMoney = totalCount
      end
    end)

    AddStateBagChangeHandler("hunger", ("player:%s"):format(cache.serverId), function(_, _, value)
      Framework.CachedPlayerData.hunger = math.min(math.max(value or 0, 0), 100)
    end)

    AddStateBagChangeHandler("thirst", ("player:%s"):format(cache.serverId), function(_, _, value)
      Framework.CachedPlayerData.thirst = math.min(math.max(value or 0, 0), 100)
    end)
  end

  -- rcore_gangs
  if GetResourceState("rcore_gangs") == "started" then
    RegisterNetEvent("rcore_gangs:client:set_gang", function(gang)
      if not gang then return end
      Framework.CachedPlayerData.gang = gang.tag
    end)
  end

  -- jg-stress integration
  AddStateBagChangeHandler("stress", ("player:%s"):format(cache.serverId), function(_, _, value)
    Framework.CachedPlayerData.stress = math.min(math.max(value or 0, 0), 100)
  end)

  -- PMA Voice
  if GetResourceState("pma-voice") == "started" then
    AddEventHandler("pma-voice:setTalkingMode", function(mode)
      Framework.CachedPlayerData.micRange = mode
    end)

    AddEventHandler("pma-voice:radioActive", function(isActive)
      Framework.CachedPlayerData.radioActive = isActive
    end)

    AddEventHandler("pma-voice:settingsCallback", function(voiceSettings)
      Framework.CachedPlayerData.voiceModes = #voiceSettings.voiceModes
    end)
  end
end
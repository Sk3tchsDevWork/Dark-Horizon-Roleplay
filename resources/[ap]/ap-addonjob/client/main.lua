local currency = Config.Currency

SetupPeds = {}

RegisterNetEvent('ap-addonjob:client:addNewJobPed', function(data)
  SetupPedLocation(data)
end)

RegisterNetEvent('ap-addonjob:client:deleteAddonJobNow', function(data)
  QBCore.Functions.TriggerCallback('ap-addonjob:getJobsFromDatabase', function(db)
    if AddJobAddonData[data.v.job] then AddJobAddonData[data.v.job] = nil end
    if SetupPeds[data.v.job] then
      TriggerServerEvent('ap-addonjob:server:deletePeds', data.v.job)
    end
    if db[data.v.job] then
      TriggerServerEvent('ap-addonjob:server:deleteAddonJobNow', data)
    else
      OpenEditAddonJob()
      AddonJobNotify(LangClientNotify['deleteAddonJobNow'])
    end
  end, data.v.job)
end)

OpenEditAddonJob = function()
  QBCore.Functions.TriggerCallback('ap-addonjob:getSharedJobs', function(SharedJobs)
    TriggerEvent('ap-addonjob:client:editAddonJob', {Jobs = SharedJobs})
  end)
end

RegisterNetEvent('ap-addonjob:client:deletePeds', function(job)
  local entity = SetupPeds[job].entity
  if DoesEntityExist(entity) then
    local GetCoords = GetEntityCoords(entity)
    DeletePed(entity)
    ClearAreaOfObjects(GetCoords, 2.0, 0)
    if not DoesEntityExist(entity) then
      SetupPeds[job] = nil
    end
  end
end)

CheckPlayerManagement = function(table)
  local isPlayerManagement = false
  for k,v in pairs(table) do
    if k == GetIdentifier() then
      isPlayerManagement = true
    end
  end
  return isPlayerManagement
end

isPlayerManagement = function(cid, table)
  local isPlayerManagement = false
  for k,v in pairs(table) do
    if k == cid then
      isPlayerManagement = true
    end
  end
  return isPlayerManagement
end

GetPlayerManagementData = function(table)
  local PlayerManagementData = {}
  for k,v in pairs(table) do
    if k == GetIdentifier() then
      PlayerManagementData = v
    end
  end
  return PlayerManagementData
end

function toboolean(str)
  local bool = false
  if str == "true" then
    bool = true
  end
  return bool
end

local Application = {}

RegisterNUICallback('getApplicationConfig', function(data,cb)
  cb(Application)
end)

RegisterNUICallback('close', function()
  SetNuiFocus(false, false)
end)

OpenApplicationUI = function(App, Player, Data)
  Application = App
  SendNUIMessage({
		type = "openJobApplicationUI",
    data = {application = App, player = Player, jobData = Data} 
	})
	SetNuiFocus(true,true)
end

RegisterNetEvent('ap-addonjob:client:showApplicationUI', function(data)
  ShowApplicationUI(data)
end)

ShowApplicationUI = function(data)
  Application = data.application
  SendNUIMessage({
		type = "openJobApplicationUI",
    data = data 
	})
	SetNuiFocus(true,true)
end

RegisterNetEvent('ap-addonjob:client:OpenLogoUI', function(data)
  ShowLogoUI(data)
end)

ShowLogoUI = function(data)
  SendNUIMessage({
		type = "openLogoUI",
    data = data 
	})
	SetNuiFocus(true,true)
end

local function getKeyFromTable(table, desiredKey)
  for key, value in pairs(table) do
    if key == desiredKey then
      return key
    end
  end
  return nil
end

isPlayerApplied = function(identifier, table)
  local hasApplication = false
  for k,v in pairs(table) do
    if k == identifier then
      hasApplication = true
    end
  end
  return hasApplication
end

RegisterNUICallback('sendApplication', function(info)
  local data = info.ApplicationData.application
  local player = info.ApplicationData.player
  local applicationQuestions = info.extended_information
  for k,v in pairs(data.extended_information) do
    if v.id == getKeyFromTable(applicationQuestions, v.id) then
      v.value = applicationQuestions[v.id]
    end
  end
  data.type = "show"

  local NewApplication = {
    state = 0,
    date = "",
    applicationID = "",
    name = player.name,
    appliedDate = player.date,
    position = player.position
  }
  TriggerServerEvent('ap-addonjob:server:NewJobApplication', {application = data, player = player, newApp = NewApplication, job = info.ApplicationData.jobData.job})
end)

RegisterNUICallback('returnManagement', function(info)
  SetNuiFocus(false, false)
  TriggerEvent('ap-addonjob:client:manageApplication', {JobData = info.ApplicationData.JobData, cid = info.ApplicationData.Player.identifier, appdata = info.ApplicationData.Player})
end)

RegisterNUICallback('managementMenu', function(info)
  SetNuiFocus(false, false)
  TriggerEvent('ap-addonjob:client:managementSettings', info)
end)

RegisterNUICallback('updateLogo', function(info)
  SetNuiFocus(false, false)
  TriggerServerEvent('ap-addonjob:server:updateLogo', info)
end)
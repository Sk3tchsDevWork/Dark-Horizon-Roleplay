QBCore = exports['qb-core']:GetCoreObject()

local cfg = Config.Target
local Interactions = Config.Interactions

RegisterNetEvent('ap-addonjob:notify')
AddEventHandler('ap-addonjob:notify', function(msg)
	AddonJobNotify(msg)
end)

AddonJobNotify = function(msg)
  QBCore.Functions.Notify(msg)
end

local PlayerData = QBCore.Functions.GetPlayerData()

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
  PlayerData = QBCore.Functions.GetPlayerData()
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
  PlayerData = {}
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
  PlayerData.job = JobInfo
end)

checkJob = function(name, grade)
  if not PlayerData then return false end
  if not PlayerData.job then return false end
  if grade ~= nil then
    if PlayerData.job.name == name and PlayerData.job.grade.level >= tonumber(grade) then
      return true
    end
  else
    if PlayerData.job.name == name then
      return true
    end
  end
  return false   
end

GetIdentifier = function()
  return PlayerData.citizenid
end

GetPlayerSource = function()
  return PlayerData.source
end

Citizen.CreateThread(function()
  UtilisePeds()
end)

UtilisePeds = function()
  QBCore.Functions.TriggerCallback('ap-addonjob:getJobsFromDatabase', function(data)
    for k, v in pairs(data) do
      if v.enable == "true" then
        SetupPedLocation({coords = v.coords, pedModel = v.ped, job = v.job, joblabel = v.joblabel})
      end
    end
  end)
end

SetupPedLocation = function(data)
  local hash = GetHashKey(data.pedModel)
  
  while not HasModelLoaded(hash) do
    RequestModel(hash)
    Wait(0)
  end

  local ent = CreatePed(0, hash, data.coords.x, data.coords.y, data.coords.z, data.coords.h, false, false)
  
  FreezeEntityPosition(ent,true)
  TaskSetBlockingOfNonTemporaryEvents(ent,true)
  SetEntityInvincible(ent,true)

  SetupPeds[data.job] = {
    coords = data.coords,
    ped = data.pedModel,
    job = data.job,
    entity = ent
  }

  if Config.Interactions.qbTarget then
    exports['qb-target']:AddTargetEntity(ent, {
      options = {
        {
          type = "client",
          event = "ap-addonjob:client:publicMenu",
          icon = "fas fa-box-circle-check",
          label = data.joblabel.." Reception",
          args = SetupPeds[data.job]
        }
      },
      distance = 3.0
    })
  elseif Config.Interactions.qTarget then
    exports['qtarget']:AddTargetEntity(ent, {
      options = {
        { 
          event = "ap-addonjob:client:publicMenu", 
          icon = 'fas fa-box-circle-check',
          label = data.joblabel..' Reception',
          args = SetupPeds[data.job]
        }
      },
      distance = 2.5,
    })
  end
end





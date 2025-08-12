QBCore = exports[Config.FrameworkExport]:GetCoreObject()

Citizen.CreateThread(function ()
    if GetResourceState(GetCurrentResourceName()) == 'started' then
      print('[INFO] Join Discord for support and information, https://discord.gg/8Cn3EjfzrM') 
    end
end)

local currency = Config.Currency
local phs = Config.PhoneSettings

QBCore.Functions.CreateCallback('ap-addonjob:getJobsFromDatabase',function(source, cb)
  local GetAllAddons = GetAllAddonJobs()
  cb(GetAllAddons)
end)

QBCore.Functions.CreateCallback('ap-addonjob:getRanksFromJob',function(source, cb, job)
  local GetGrades = QBCore.Shared.Jobs[job].grades
  cb(GetGrades)
end)

QBCore.Functions.CreateCallback('ap-addonjob:getApplicationData',function(source, cb, job)
  local Player = QBCore.Functions.GetPlayer(source)
  local JobName = QBCore.Shared.Jobs[job].label
  local ApplicationData = {
    name = getName(Player.PlayerData.citizenid),
    identifier = Player.PlayerData.citizenid,
    job = JobName,
    date = os.date("%d/%m/%Y"),
    grades = QBCore.Shared.Jobs[job].grades
  }
  cb(ApplicationData)
end)

QBCore.Functions.CreateCallback('ap-addonjob:getSharedJobs',function(source, cb, job)
  local SharedJobs = QBCore.Shared.Jobs
  cb(SharedJobs)
end)

QBCore.Functions.CreateCallback('ap-addonjob:getAddonJobData',function(source, cb, job)
  local result = MySQL.Sync.fetchAll('SELECT * FROM `ap_addonjob` WHERE job = @job', {['@job'] = job})
  if result[1] then
    cb({
      enable = result[1].enable,
      job = result[1].job,
      joblabel = GetJobName(result[1].job),
      boss_rank = result[1].boss_rank, 
      coords = json.decode(result[1].coords), 
      ped = result[1].ped, 
      management = json.decode(result[1].management),
      appointments = json.decode(result[1].appointments), 
      applications = json.decode(result[1].applications),
      template = json.decode(result[1].template)
    })
  else
    cb(false)
  end
end)

GetAddonJobData = function(job)
  local result = MySQL.Sync.fetchAll('SELECT * FROM `ap_addonjob` WHERE job = @job', {['@job'] = job})
  if result[1] then
    return {
      enable = result[1].enable,
      job = result[1].job,
      joblabel = GetJobName(result[1].job), 
      boss_rank = result[1].boss_rank, 
      coords = json.decode(result[1].coords), 
      ped = result[1].ped, 
      management = json.decode(result[1].management),
      appointments = json.decode(result[1].appointments), 
      applications = json.decode(result[1].applications),
      template = json.decode(result[1].template)
    }
  else
    return false
  end
end

QBCore.Functions.CreateCallback('ap-addonjob:server:getOnlinePlayers', function(source, cb, job)
  local xPlayers = QBCore.Functions.GetPlayers()
  local players  = {}
  local mainPed = GetPlayerPed(source)
  for i=1, #xPlayers, 1 do
      local xPlayer = QBCore.Functions.GetPlayer(xPlayers[i])
      local ped = GetPlayerPed(xPlayer.PlayerData.source)
      if #(GetEntityCoords(mainPed) - GetEntityCoords(ped)) <= 10 then
        if xPlayer.PlayerData.job.name == job then
          table.insert(players, {
              source     = xPlayer.PlayerData.source,
              identifier = xPlayer.PlayerData.citizenid,
              name       = xPlayer.PlayerData.charinfo.firstname .. ' ' .. xPlayer.PlayerData.charinfo.lastname
          })
        end
      end
  end
  cb(players)
end)

RegisterNetEvent('ap-addonjob:server:saveAddonJob', function(data)
  local Player = QBCore.Functions.GetPlayer(source)
  local GetAllAddons = GetAllAddonJobs()
  if Player then
    if GetAllAddons[data.job] then
      TriggerClientEvent('ap-addonjob:notify', Player.PlayerData.source, LangServerNotify['saveAddonJob_1'])
    else
      AddJobToDatabase(data)
      if data.enable == "true" then
        TriggerClientEvent('ap-addonjob:client:addNewJobPed', -1, {coords = data.coords, pedModel = data.ped, job = data.job, joblabel = GetJobName(data.job)})
      end
      TriggerClientEvent('ap-addonjob:notify', Player.PlayerData.source, LangServerNotify['saveAddonJob_2'])
    end
  end
end)

RegisterNetEvent('ap-addonjob:server:changeAddonJob', function(data)
  local Player = QBCore.Functions.GetPlayer(source)
  local GetAllAddons = GetAllAddonJobs()
  if GetAllAddons[data.job] then
    MySQL.Sync.execute("UPDATE ap_addonjob SET enable = @enable, boss_rank = @boss_rank, coords = @coords, ped = @ped, webhook = @webhook WHERE job = @job", {
      ['@enable'] = data.enable,
      ['@boss_rank'] = data.grade,
      ['@coords'] = json.encode(data.coords),
      ['@ped'] = data.ped,
      ['@job'] = data.job,
      ['@webhook'] = data.webhook
    })
    if data.enable == "true" then
      TriggerClientEvent('ap-addonjob:client:addNewJobPed', -1, {coords = data.coords, pedModel = data.ped, job = data.job, joblabel = GetJobName(data.job)})
    end
    TriggerClientEvent('ap-addonjob:notify', Player.PlayerData.source, LangServerNotify['changeAddonJob_1'])
  else
    AddJobToDatabase(data)
    if data.enable == "true" then
      TriggerClientEvent('ap-addonjob:client:addNewJobPed', -1, {coords = data.coords, pedModel = data.ped, job = data.job, joblabel = GetJobName(data.job)})
    end
    TriggerClientEvent('ap-addonjob:notify', Player.PlayerData.source, LangServerNotify['changeAddonJob_2'])
  end
end)

RegisterNetEvent('ap-addonjob:server:deleteAddonJobNow', function(data)
  local Player = QBCore.Functions.GetPlayer(source)
  if Player then
    MySQL.Async.execute('DELETE FROM ap_addonjob WHERE job = @job', {["@job"] = data.v.job})
    TriggerClientEvent('ap-addonjob:notify', Player.PlayerData.source, LangServerNotify['deleteAddonJobNow'])
    TriggerClientEvent('ap-addonjob:client:editAddonJob', Player.PlayerData.source, {Jobs = QBCore.Shared.Jobs})
  end
end)


RegisterNetEvent('ap-addonjob:server:deletePeds', function(job)
  TriggerClientEvent('ap-addonjob:client:deletePeds', -1, job)
end)

RegisterNetEvent('ap-addonjob:server:hiringtoggle', function(data)
  local Player = QBCore.Functions.GetPlayer(source)
  local notify = nil
  if Player then
    if data.management.applications then
      data.management.applications = false
      notify = LangServerNotify['hiringtoggle_1']
    else
      data.management.applications = true
      notify = LangServerNotify['hiringtoggle_2']
    end
    UpdateManagement(data.job, data.management)
    TriggerClientEvent('ap-addonjob:client:managementSettings', Player.PlayerData.source, data)
    TriggerClientEvent('ap-addonjob:notify', Player.PlayerData.source, notify)
  end
end)

RegisterNetEvent('ap-addonjob:server:appointmenttoggle', function(data)
  local Player = QBCore.Functions.GetPlayer(source)
  local notify = nil
  if Player then
    if data.management.appointments then
      data.management.appointments = false
      notify = LangServerNotify['appointmenttoggle_1']
    else
      data.management.appointments = true
      notify = LangServerNotify['appointmenttoggle_2']
    end
    UpdateManagement(data.job, data.management)
    TriggerClientEvent('ap-addonjob:client:managementSettings', Player.PlayerData.source, data)
    TriggerClientEvent('ap-addonjob:notify', Player.PlayerData.source, notify)
  end
end)

RegisterNetEvent('ap-addonjob:server:addNewStaff', function(data)
  local Player = QBCore.Functions.GetPlayer(source)
  local tPlayer = QBCore.Functions.GetPlayerByCitizenId(data.player.identifier)
  local result = MySQL.Sync.fetchAll('SELECT * FROM `ap_addonjob` WHERE job = @job', {['@job'] = data.db.job})
  local newStaffData = data.management.staff[data.player.identifier]
  if Player then
    UpdateManagement(data.db.job, data.management)
    if tPlayer then
      TriggerClientEvent('ap-addonjob:notify', tPlayer.PlayerData.source, LangServerNotify['addNewStaff_1'])
    end
    TriggerClientEvent('ap-addonjob:notify', Player.PlayerData.source, LangServerNotify['addNewStaff_2']:format(data.player.name))
    local jobData = GetAddonJobData(data.db.job)
    if jobData ~= false then
      TriggerClientEvent('ap-addonjob:client:manageReceptionStaff', Player.PlayerData.source, jobData)
    end
    if Config.DiscordWebhook.ReceptionStaff then
      local WebhookData = webhookMsg.ReceptionStaff
      sendLogsDiscord(
        WebhookData['title']:format(GetJobName(data.db.job)), 
        WebhookData['message']:format(newStaffData.name, tostring(newStaffData.appointments), tostring(newStaffData.applications), tostring(newStaffData.management)), 
        GetWebhook(data.db.job),
        GetLogo(data.db.job)
      )
    end
  end
end)

RegisterNetEvent('ap-addonjob:server:removeStaffReception', function(data)
  local Player = QBCore.Functions.GetPlayer(source)
  if Player then
    local managementStaff = GetManagement(data.db.job)
    if managementStaff.staff[data.player.identifier] then
      managementStaff.staff[data.player.identifier] = nil
      UpdateManagement(data.db.job, managementStaff)
    end
    TriggerClientEvent('ap-addonjob:notify', Player.PlayerData.source, LangServerNotify['removeStaffReception']:format(data.player.name))
    local jobData = GetAddonJobData(data.db.job)
    if jobData ~= false then
      TriggerClientEvent('ap-addonjob:client:manageReceptionStaff', Player.PlayerData.source, jobData)
    end
  end
end)

RegisterNetEvent('ap-addonjob:server:changeStaffPerms', function(data)
  local Player = QBCore.Functions.GetPlayer(source)
  if Player then
    UpdateManagement(data.db.job, data.management)
    TriggerClientEvent('ap-addonjob:notify', Player.PlayerData.source, LangServerNotify['changeStaffPerms']:format(data.player.name))
    local jobData = GetAddonJobData(data.db.job)
    if jobData ~= false then
      TriggerClientEvent('ap-addonjob:client:manageReceptionStaff', Player.PlayerData.source, jobData)
    end
  end
end)

RegisterNetEvent('ap-addonjob:server:changeQuestionJob', function(data, question)
  local Player = QBCore.Functions.GetPlayer(source)
  if Player then
    local Template = GetTemplate(data.db.job)
    Template[data.k].label = data.db.template[data.k].label
    Template[data.k].type = data.db.template[data.k].type
    UploadTemplate(data.db.job, Template)
    TriggerClientEvent('ap-addonjob:notify', Player.PlayerData.source, LangServerNotify['changeQuestionJob'])
    local jobData = GetAddonJobData(data.db.job)
    if jobData ~= false then
      TriggerClientEvent('ap-addonjob:client:manageApplicationQuestions', Player.PlayerData.source, jobData)
    end
  end
end)

RegisterNetEvent('ap-addonjob:server:manageApplicationPositions', function(data)
  local Player = QBCore.Functions.GetPlayer(source)
  if Player then
    local Management = GetManagement(data.db.job)
    if Management.positions[data.k].enable then
      Management.positions[data.k].enable = false
    else
      Management.positions[data.k].enable = true
    end
    UpdateManagement(data.db.job, Management)
    TriggerClientEvent('ap-addonjob:notify', Player.PlayerData.source, LangServerNotify['manageApplicationPositions']:format(data.k, tostring(Management.positions[data.k].enable)))
    local jobData = GetAddonJobData(data.db.job)
    if jobData ~= false then
      TriggerClientEvent('ap-addonjob:client:manageApplicationPositions', Player.PlayerData.source, jobData)
    end
  end
end)

RegisterNetEvent('ap-addonjob:server:NewJobApplication', function(data)
  local Player = QBCore.Functions.GetPlayer(source)
  local AddApplication = UploadApplication(data.application)
  local ApplicationData = GetApplications(data.job)
  if Player then
    ApplicationData[data.player.identifier] = {
      state = 0,
      date = "",
      applicationID = AddApplication,
      name = data.player.name,
      identifier = data.player.identifier,
      appliedDate = data.player.date,
      position = data.player.position,
    }
    UploadApplications(data.job, ApplicationData)
    if Config.DiscordWebhook.ApplicationSubmission then
      local WebhookData, App = webhookMsg.ApplicationSubmission, data.application.extended_information
      sendLogsDiscord(WebhookData.Main['title']:format(GetJobName(data.job)), WebhookData.Main['message']:format(GetJobName(data.job), data.player.name), GetWebhook(data.job), data.application.logo)
      Wait(100)
      for k,v in pairs(data.application.extended_information) do
        print(v.label, v.value)
        sendLogsQuestionDiscord(WebhookData.Question['title']:format(v.label), WebhookData.Question['message']:format(v.value), GetWebhook(data.job), data.application.logo)
        Wait(300)
      end
    end
    TriggerClientEvent('ap-addonjob:notify', Player.PlayerData.source, LangServerNotify['NewJobApplication']:format(GetJobName(data.job)))
    local jobData = GetAddonJobData(data.job)
    if jobData ~= false then
      TriggerClientEvent('ap-addonjob:client:jobapplication', Player.PlayerData.source, jobData)
    end
  end
end)

RegisterNetEvent('ap-addonjob:server:rejectJobApplication', function(data)
  local Player = QBCore.Functions.GetPlayer(source)
  if Player then
    local Job = QBCore.Shared.Jobs[data.JobData.job].label
    local Applications = GetApplications(data.JobData.job)
    if Applications[data.Player.identifier] then
      Applications[data.Player.identifier] = nil
      UploadApplications(data.JobData.job, Applications)
      DeleteApplication(data.Player.applicationID)
      local phonecfg = Config.PhoneSettings.application_decline
      PhoneNotify({
        identifier = data.Player.identifier, notifytitle = phonecfg.title, notifymsg = phonecfg.msg:format(Job), sender = phonecfg.sender:format(Job), subject = phonecfg.subject,
        image = phonecfg.image, mail = phonecfg.mail:format(data.Player.name, Job, Job), email = phonecfg.email:format(data.JobData.job), photo = phonecfg.photo, photoattachment = phonecfg.photoattachment
      })
      local jobData = GetAddonJobData(data.db.job)
      if jobData ~= false then
        TriggerClientEvent('ap-addonjob:client:managementApplications', Player.PlayerData.source, jobData)
      end
    end
  end
end)

RegisterNetEvent('ap-addonjob:server:createJobInterview', function(data, info)
  local Player = QBCore.Functions.GetPlayer(source)
  local newDate = nil
  if Config.Dialog.QB then newDate = info elseif Config.Dialog.OX then newDate = os.date("%d/%m/%Y", info.date).. " "..os.date("%H:%M %p", info.time) end
  if Player then
    local Job = QBCore.Shared.Jobs[data.JobData.job].label
    local AppData = GetApplications(data.JobData.job)
    AppData[data.Player.identifier].date = newDate
    AppData[data.Player.identifier].state = 1
    UploadApplications(data.JobData.job, AppData)
    TriggerClientEvent('ap-addonjob:notify', Player.PlayerData.source, LangServerNotify['createJobInterview']:format(data.Player.name, tostring(newDate)))
    local phonecfg = Config.PhoneSettings.interview_notify
    PhoneNotify({
      identifier = data.Player.identifier, notifytitle = phonecfg.title, notifymsg = phonecfg.msg:format(Job), sender = phonecfg.sender:format(Job), subject = phonecfg.subject,
      image = phonecfg.image, mail = phonecfg.mail:format(data.Player.name, newDate, Job), email = phonecfg.email:format(data.JobData.job), photo = phonecfg.photo, photoattachment = phonecfg.photoattachment
    })
    if Config.DiscordWebhook.JobInterview then
      local WebhookData = webhookMsg.JobInterview
      sendLogsDiscord(
        WebhookData['title']:format(GetJobName(data.JobData.job)), 
        WebhookData['message']:format(data.Player.name, tostring(newDate)), 
        GetWebhook(data.JobData.job),
        GetLogo(data.JobData.job)
      )
    end
  end
end)

RegisterNetEvent('ap-addonjob:server:changeJobInterview', function(data, info)
  local Player = QBCore.Functions.GetPlayer(source)
  local newDate = nil
  if Config.Dialog.QB then newDate = info elseif Config.Dialog.OX then newDate = os.date("%d/%m/%Y", info.date).. " "..os.date("%H:%M %p", info.time) end
  if Player then
    local Job = QBCore.Shared.Jobs[data.JobData.job].label
    local AppData = GetApplications(data.JobData.job)
    AppData[data.Player.identifier].date = newDate
    UploadApplications(data.JobData.job, AppData)
    TriggerClientEvent('ap-addonjob:notify', Player.PlayerData.source, LangServerNotify['changeJobInterview']:format(data.Player.name, tostring(newDate)))
    local phonecfg = Config.PhoneSettings.interview_date_change
    PhoneNotify({
      identifier = data.Player.identifier, notifytitle = phonecfg.title, notifymsg = phonecfg.msg:format(Job), sender = phonecfg.sender:format(Job), subject = phonecfg.subject,
      image = phonecfg.image, mail = phonecfg.mail:format(data.Player.name, newDate, Job), email = phonecfg.email:format(data.JobData.job), photo = phonecfg.photo, photoattachment = phonecfg.photoattachment
    })
  end
end)

RegisterNetEvent('ap-addonjob:server:viewJobApplication', function(data)
  local Player = QBCore.Functions.GetPlayer(source)
  if Player then
    local Application = GetApplication(data.Player.applicationID)
    data.application = Application
    data.staff = Player.PlayerData.citizenid
    TriggerClientEvent('ap-addonjob:client:showApplicationUI', Player.PlayerData.source, data)
  end
end)

RegisterNetEvent('ap-addonjob:server:awardjob', function(data, jobData)
  local Player = QBCore.Functions.GetPlayer(source)
  if Player then
    local Job = QBCore.Shared.Jobs[data.JobData.job].label
    local AppData = GetApplications(data.JobData.job)
    AppData[data.Player.identifier].offer = {job = data.JobData.job, grade = jobData.grade, name = jobData.name}
    AppData[data.Player.identifier].state = 2
    UploadApplications(data.JobData.job, AppData)
    local phonecfg = Config.PhoneSettings.application_hire
    PhoneNotify({
      identifier = data.Player.identifier, notifytitle = phonecfg.title, notifymsg = phonecfg.msg:format(Job), sender = phonecfg.sender:format(Job), subject = phonecfg.subject,
      image = phonecfg.image, mail = phonecfg.mail:format(data.Player.name, Job, jobData.name, Job), email = phonecfg.email:format(data.JobData.job), photo = phonecfg.photo, photoattachment = phonecfg.photoattachment
    })
    TriggerClientEvent('ap-addonjob:notify', Player.PlayerData.source, LangServerNotify['awardjob']:format(data.Player.name, jobData.name))
    if Config.DiscordWebhook.JobOfferGiven then
      local WebhookData = webhookMsg.JobOfferGiven
      sendLogsDiscord(
        WebhookData['title']:format(GetJobName(data.JobData.job)), 
        WebhookData['message']:format(data.Player.name, GetJobName(data.JobData.job), jobData.name, os.date("%d/%m/%Y"), getName(Player.PlayerData.citizenid)), 
        GetWebhook(data.JobData.job),
        GetLogo(data.JobData.job)
      )
    end
  end
end)

RegisterNetEvent('ap-addonjob:server:startJob', function(data)
  local Player = QBCore.Functions.GetPlayer(source)
  if Player then
    local Job = QBCore.Shared.Jobs[data.job].label
    local AppData = GetApplications(data.job)
    local ApplicationData = AppData[Player.PlayerData.citizenid]
    Player.Functions.SetJob(ApplicationData.offer.job, ApplicationData.offer.grade)
    DeleteApplication(ApplicationData.applicationID)
    AppData[Player.PlayerData.citizenid] = nil
    UploadApplications(data.job, AppData)
    TriggerClientEvent('ap-addonjob:notify', Player.PlayerData.source, LangServerNotify['startJob']:format(Job))
  end
end)

RegisterNetEvent('ap-addonjob:server:declineJobOffer', function(data)
  local Player = QBCore.Functions.GetPlayer(source)
  if Player then
    local Job = QBCore.Shared.Jobs[data.job].label
    local AppData = GetApplications(data.job)
    DeleteApplication(AppData[Player.PlayerData.citizenid].applicationID)
    AppData[Player.PlayerData.citizenid] = nil
    UploadApplications(data.job, AppData)
    TriggerClientEvent('ap-addonjob:notify', Player.PlayerData.source, LangServerNotify['declineJobOffer']:format(Job))
  end
end)

RegisterNetEvent('ap-addonjob:server:canceljobapplication', function(data)
  local Player = QBCore.Functions.GetPlayer(source)
  if Player then
    local Job = QBCore.Shared.Jobs[data.job].label
    local AppData = GetApplications(data.job)
    if AppData[Player.PlayerData.citizenid].applicationID then
      DeleteApplication(AppData[Player.PlayerData.citizenid].applicationID)
    end
    AppData[Player.PlayerData.citizenid] = nil
    UploadApplications(data.job, AppData)
    TriggerClientEvent('ap-addonjob:notify', Player.PlayerData.source, LangServerNotify['canceljobapplication']:format(Job))
  end
end)

RegisterNetEvent('ap-addonjob:server:submitAppointment', function(reason, data)
  local Player = QBCore.Functions.GetPlayer(source)
  if Player then
    local Job = QBCore.Shared.Jobs[data.job].label
    local Appointments = GetAppointments(data.job)
    Appointments[Player.PlayerData.citizenid] = {
      reason = reason,
      name = getName(Player.PlayerData.citizenid),
      identifier = Player.PlayerData.citizenid,
      phone = getMobile(Player.PlayerData.citizenid),
      date = "",
      staffname = "",
      state = 1
    }
    UploadAppointments(data.job, Appointments)
    TriggerClientEvent('ap-addonjob:notify', Player.PlayerData.source, LangServerNotify['submitAppointment']:format(Job))
    local jobData = GetAddonJobData(data.job)
    if jobData ~= false then
      TriggerClientEvent('ap-addonjob:client:appointments', Player.PlayerData.source, jobData)
    end
    if Config.DiscordWebhook.AppointmentRequest then
      local WebhookData = webhookMsg.AppointmentRequest
      sendLogsDiscord(
        WebhookData['title']:format(GetJobName(data.job)), 
        WebhookData['message']:format(getName(Player.PlayerData.citizenid), reason), 
        GetWebhook(data.job),
        GetLogo(data.job)
      )
    end
  end
end)

RegisterNetEvent('ap-addonjob:server:cancelappointmentJob', function(data)
  local Player = QBCore.Functions.GetPlayer(source)
  if Player then
    local Job = GetJobName(data.db.job)
    local Appointments = GetAppointments(data.db.job)
    Appointments[data.k] = nil
    UploadAppointments(data.db.job, Appointments)
    TriggerClientEvent('ap-addonjob:notify', Player.PlayerData.source, LangServerNotify['cancelappointmentJob']:format(data.v.name))
    local phonecfg = Config.PhoneSettings.appointment_cancel
    PhoneNotify({
      identifier = data.k, notifytitle = phonecfg.title, notifymsg = phonecfg.msg:format(Job), sender = phonecfg.sender:format(Job), subject = phonecfg.subject,
      image = phonecfg.image, mail = phonecfg.mail:format(data.v.name, Job), email = phonecfg.email:format(data.db.job), photo = phonecfg.photo, photoattachment = phonecfg.photoattachment
    })
  end
end)

RegisterNetEvent('ap-addonjob:server:cancelAppointment', function(data)
  local Player = QBCore.Functions.GetPlayer(source)
  if Player then
    local Appointments = GetAppointments(data.job)
    Appointments[Player.PlayerData.citizenid] = nil
    UploadAppointments(data.job, Appointments)
    TriggerClientEvent('ap-addonjob:notify', Player.PlayerData.source, LangServerNotify['cancelAppointment'])
  end
end)

RegisterNetEvent('ap-addonjob:server:issueappointment', function(info, data)
  local Player = QBCore.Functions.GetPlayer(source)
  local tPlayer = QBCore.Functions.GetPlayerByCitizenId(data.v.identifier)
  local newDate = nil
  if Config.Dialog.QB then newDate = info elseif Config.Dialog.OX then newDate = os.date("%d/%m/%Y", info.date).. " "..os.date("%H:%M %p", info.time) end
  if Player then
    local Job = QBCore.Shared.Jobs[data.db.job].label
    local Appointments = GetAppointments(data.db.job)
    if Appointments[data.v.identifier] then
      Appointments[data.v.identifier].date = newDate
      Appointments[data.v.identifier].staff = Player.PlayerData.citizenid
      Appointments[data.v.identifier].staffname = getName(Player.PlayerData.citizenid)
      Appointments[data.v.identifier].state = 2
      UploadAppointments(data.db.job, Appointments)
      TriggerClientEvent('ap-addonjob:notify', Player.PlayerData.source, LangServerNotify['issueappointment_1']:format(data.v.name))
      local phonecfg = Config.PhoneSettings.appointment_notify
      PhoneNotify({
        identifier = data.v.identifier, notifytitle = phonecfg.title, notifymsg = phonecfg.msg:format(Job), sender = phonecfg.sender:format(Job), subject = phonecfg.subject,
        image = phonecfg.image, mail = phonecfg.mail:format(data.v.name, newDate, Job, Job), email = phonecfg.email:format(data.db.job), photo = phonecfg.photo, photoattachment = phonecfg.photoattachment
      })
      if tPlayer then
        TriggerClientEvent('ap-addonjob:notify', tPlayer.PlayerData.source, LangServerNotify['issueappointment_2']:format(Job))
      end
      local jobData = GetAddonJobData(data.db.job)
      if jobData ~= false then
        TriggerClientEvent('ap-addonjob:client:requestedAppointments', Player.PlayerData.source, jobData)
      end
      if Config.DiscordWebhook.AppointmentApprove then
        local WebhookData = webhookMsg.AppointmentApprove
        sendLogsDiscord(
          WebhookData['title']:format(GetJobName(data.db.job)), 
          WebhookData['message']:format(data.v.name, getName(Player.PlayerData.citizenid), data.v.reason, tostring(newDate)), 
          GetWebhook(data.db.job),
          GetLogo(data.db.job)
        )
      end
    end
  end
end)

RegisterNetEvent('ap-addonjob:server:updateLogo', function(data)
  local Player = QBCore.Functions.GetPlayer(source)
  if Player then
    local Management = GetManagement(data.job)
    Management.logo = data.management.logo
    UploadManagement(data.job, Management)
    TriggerClientEvent('ap-addonjob:notify', Player.PlayerData.source, LangServerNotify['updateLogo'])
    local jobData = GetAddonJobData(data.job)
    if jobData ~= false then
      TriggerClientEvent('ap-addonjob:client:managementSettings', Player.PlayerData.source, jobData)
    end
  end
end)

RegisterNetEvent('ap-addonjob:server:finishappointment', function(data)
  local Player = QBCore.Functions.GetPlayer(source)
  local Appointments = GetAppointments(data.db.job)
  Appointments[data.v.identifier] = nil
  UploadAppointments(data.db.job, Appointments)
  TriggerClientEvent('ap-addonjob:notify', Player.PlayerData.source, LangServerNotify['finishappointment'])
end)

GetJobName = function(job)
  return QBCore.Shared.Jobs[job].label
end

GetLogo = function(job)
  local result = MySQL.Sync.fetchAll('SELECT * FROM `ap_addonjob` WHERE job = @job', {['@job'] = job})
  if result[1] then
    local Management = json.decode(result[1].management)
    return Management.logo
  end
end

GetWebhook = function(job)
  local result = MySQL.Sync.fetchAll('SELECT * FROM `ap_addonjob` WHERE job = @job', {['@job'] = job})
  if result[1] then
    return result[1].webhook
  end
end

GetAppointments = function(job)
  local result = MySQL.Sync.fetchAll('SELECT * FROM `ap_addonjob` WHERE job = @job', {['@job'] = job})
  if result[1] then
    return json.decode(result[1].appointments)
  end
end

UploadAppointments = function(job, table)
  MySQL.Sync.execute("UPDATE ap_addonjob SET appointments = @appointments WHERE job = @job", {
    ['@appointments'] = json.encode(table),
    ['@job'] = job,
  })
end

GetManagement = function(job)
  local result = MySQL.Sync.fetchAll('SELECT * FROM `ap_addonjob` WHERE job = @job', {['@job'] = job})
  if result[1] then
    return json.decode(result[1].management)
  end
end

UploadManagement = function(job, table)
  MySQL.Sync.execute("UPDATE ap_addonjob SET management = @management WHERE job = @job", {
    ['@management'] = json.encode(table),
    ['@job'] = job,
  })
end

GetTemplate = function(job)
  local result = MySQL.Sync.fetchAll('SELECT * FROM `ap_addonjob` WHERE job = @job', {['@job'] = job})
  if result[1] then
    return json.decode(result[1].template)
  end
end

GetApplication = function(id)
  local result = MySQL.Sync.fetchAll('SELECT * FROM `ap_addonapplications` WHERE applicationID = @applicationID', {['@applicationID'] = id})
  if result[1] then
    return json.decode(result[1].data)
  end
end

UploadApplication = function(table)
  local applicationID = QBCore.Shared.RandomInt(2) .. QBCore.Shared.RandomStr(3) .. QBCore.Shared.RandomInt(1) .. QBCore.Shared.RandomStr(2) .. QBCore.Shared.RandomInt(3) .. QBCore.Shared.RandomStr(4)
  MySQL.Async.execute('INSERT INTO ap_addonapplications (applicationID, data) VALUES (@applicationID, @data)', {
    ['@applicationID'] = tostring(applicationID),
    ['@data'] = json.encode(table),
  })
  return applicationID
end

DeleteApplication = function(id)
  MySQL.Async.execute('DELETE FROM ap_addonapplications WHERE applicationID = @applicationID', {['@applicationID'] = id}) 
end

GetApplications = function(job)
  local result = MySQL.Sync.fetchAll('SELECT * FROM `ap_addonjob` WHERE job = @job', {['@job'] = job})
  if result[1] then
    return json.decode(result[1].applications)
  end
end

UploadApplications = function(job, table)
  MySQL.Sync.execute("UPDATE ap_addonjob SET applications = @applications WHERE job = @job", {
    ['@applications'] = json.encode(table),
    ['@job'] = job,
  })
end

UploadTemplate = function(job, table)
  MySQL.Sync.execute("UPDATE ap_addonjob SET template = @template WHERE job = @job", {
    ['@template'] = json.encode(table),
    ['@job'] = job,
  })
end

UpdateManagement = function(job, table)
  MySQL.Sync.execute("UPDATE ap_addonjob SET management = @management WHERE job = @job", {
    ['@management'] = json.encode(table),
    ['@job'] = job,
  })
end

AddJobToDatabase = function(data)
  local positions = {}
  for k,v in pairs(QBCore.Shared.Jobs[data.job].grades) do
    positions[v.name] = {
      name = v.name,
      grade = k,
      enable = true
    }
  end
  MySQL.Async.execute('INSERT INTO ap_addonjob (enable, job, boss_rank, coords, ped, webhook, management, template) VALUES (@enable, @job, @boss_rank, @coords, @ped, @webhook, @management, @template)', {
    ['@enable'] = data.enable,
    ['@job'] = data.job,
    ['@boss_rank'] = data.grade,
    ['@coords'] = json.encode(data.coords),
    ['@ped'] = data.ped, 
    ['@webhook'] = data.webhook,
    ['@management'] = json.encode({['appointments'] = true, ['applications'] = true, ['staff'] = {}, ['positions'] = positions, ['logo'] = Config.DefaultJobLogo}),
    ['@template'] = json.encode({
      q1 = {id = "1", label = Config.StartingQuestions[1], type = "text_area", placement = "(Question)", required = "true", value = ""},
      q2 = {id = "2", label = Config.StartingQuestions[2], type = "text_area", placement = "(Question)", required = "true", value = ""},
      q3 = {id = "3", label = Config.StartingQuestions[3], type = "text_area", placement = "(Question)", required = "true", value = ""},
      q4 = {id = "4", label = Config.StartingQuestions[4], type = "text_area", placement = "(Question)", required = "true", value = ""},
      q5 = {id = "5", label = Config.StartingQuestions[5], type = "text_area", placement = "(Question)", required = "true", value = ""},
      q6 = {id = "6", label = Config.StartingQuestions[6], type = "text_area", placement = "(Question)", required = "true", value = ""},
    })
  })
end

GetAllAddonJobs = function()
  local result = MySQL.Sync.fetchAll('SELECT * FROM `ap_addonjob`', {})
  local Jobs = {}
  for k,v in pairs(result) do
    Jobs[v.job] = {enable = v.enable, job = v.job, joblabel = GetJobName(v.job), grade = v.boss_rank, coords = json.decode(v.coords), ped = v.ped}
  end
  return Jobs
end

getMobile = function(identifier)
  local result = MySQL.Sync.fetchAll('SELECT charinfo FROM `players` WHERE citizenid = @citizenid', {
  ['@citizenid'] = identifier
  }) 

  if result[1] and result[1].charinfo then
    local data = json.decode(result[1].charinfo)
    return ('%s'):format(data["phone"])
  end  
end

getName = function(identifier)
  local result = MySQL.Sync.fetchAll('SELECT charinfo FROM `players` WHERE citizenid = @citizenid', {
['@citizenid'] = identifier
})

if result[1] and result[1].charinfo then
      local data = json.decode(result[1].charinfo)
  return ('%s %s'):format(data["firstname"], data["lastname"])
  end
end

getFirstname = function(identifier)
  local result = MySQL.Sync.fetchAll('SELECT charinfo FROM `players` WHERE citizenid = @citizenid', {
['@citizenid'] = identifier
})

if result[1] and result[1].charinfo then
      local data = json.decode(result[1].charinfo)
  return ('%s'):format(data["firstname"])
  end
end

getLastname = function(identifier)
  local result = MySQL.Sync.fetchAll('SELECT charinfo FROM `players` WHERE citizenid = @citizenid', {
['@citizenid'] = identifier
})

if result[1] and result[1].charinfo then
      local data = json.decode(result[1].charinfo)
  return ('%s'):format(data["lastname"])
  end
end

getBirth = function(identifier)
  local result = MySQL.Sync.fetchAll('SELECT charinfo FROM `players` WHERE citizenid = @citizenid', {
['@citizenid'] = identifier
})

if result[1] and result[1].charinfo then
      local data = json.decode(result[1].charinfo)
  return ('%s'):format(data["birthdate"])
  end
end
-- {identifier = here, notifytitle = here, notifymsg = here, sender = here, subject = here, image, mail, button, email, photo, photoattachment}
PhoneNotify = function(args)
  local tPlayer = QBCore.Functions.GetPlayerByCitizenId(args.identifier)
  if Config.Phone.GKSPhone == true then
    if tPlayer then
      TriggerClientEvent('gksphone:notifi', tPlayer.PlayerData.source, {title = args.notifytitle, message = args.notifymsg, img= '/html/static/img/icons/mail.png' })
    end
    MySQL.Async.execute('INSERT INTO gksphone_mails (citizenid, sender, subject, image, message, button) VALUES (@citizenid, @sender, @subject, @image, @message, @button)', {
        ['@citizenid'] = args.identifier,
        ['@sender'] = args.sender,
        ['@subject'] = args.subject, 
        ['@image'] = args.image,
        ['@message'] = args.mail,
        ['@button'] = args.button,
    })
  elseif Config.Phone.QuasarPhone == true then
    local data = {}
    data.sender = args.sender
    data.subject = args.subject
    data.message = args.mail
    data.button = args.button
    TriggerEvent('qs-smartphone:server:sendNewMailToOffline', args.identifier, data)
  elseif Config.Phone.QSPRO == true then
    if tPlayer then
      exports['qs-smartphone-pro']:sendNewMail(tPlayer.PlayerData.source, {
        sender = args.sender,
        subject = args.subject,
        message = args.mail
      })
      local phoneQS = exports['qs-smartphone-pro']:GetPhoneNumberFromIdentifier(args.identifier, false) -- Sender phone number
      exports['qs-smartphone-pro']:sendNotification(phoneQS, {
        app = 'mail',
        msg = 'You have a mail from '..args.sender,
        head = 'Mail'
      }, false)
    else
      local PlayerMailAccounts = MySQL.Sync.fetchAll('SELECT * FROM `mail_accounts` WHERE owner = @owner', {['@owner'] = args.identifier})
      for k,v in pairs(PlayerMailAccounts) do
        math.randomseed(os.time())
        MySQL.Async.execute('INSERT INTO player_mails (taker, sender, subject, message, mailid) VALUES (@taker, @sender, @subject, @message, @mailid)', {
          ['@taker'] = v.mail,
          ['@sender'] = args.sender,
          ['@subject'] = args.subject, 
          ['@message'] = args.mail,
          ['@mailid'] = math.random(100000, 999999),
        })
      end
    end
  elseif Config.Phone.QBPhone == true then
    local data = {}
    data.sender = args.sender
    data.subject = args.subject
    data.message = args.mail
    data.button = args.button
    TriggerEvent('qb-phone:server:sendNewMailToOffline', args.identifier, data)
  elseif Config.Phone.LBPhone == true then
    local PhoneNumber = exports["lb-phone"]:GetEquippedPhoneNumber(args.identifier)
    if PhoneNumber then
      local emailAdress = exports["lb-phone"]:GetEmailAddress(PhoneNumber)
      if emailAdress then
        local senderData = { to = emailAdress, sender = args.sender, subject = args.subject, message = args.mail, actions = {} }
        exports["lb-phone"]:SendMail(senderData)
      end
    end
  elseif Config.Phone.HighPhone == true then
    local senderData = { address = args.email, name = args.sender, photo = args.photo }
    local attachments = {{ image = args.photoattachment }}
    TriggerEvent("high_phone:sendMailFromServer", args.identifier, senderData, args.subject, args.mail, attachments)
  elseif Config.Phone.Custom == true then
    local newData = {
      id = args.identifier,
      notifytitle = args.notifytitle, 
      notifymsg = args.notifymsg, 
      sender = args.sender, 
      subject = args.subject, 
      image = args.image, 
      mail = args.mail, 
      button = args.button, 
      email = args.email, 
      photo = args.photo, 
      photoattachment = args.photoattachment,
    }
    customphonefunction(newData)
  end
end

QBCore.Commands.Add("manage:addonjobmenu", "Create New Job Addon Menu", {}, false, function(source)
  TriggerClientEvent('ap-addonjob:client:AdminMenu', source, {Jobs = QBCore.Shared.Jobs})
end, "admin")
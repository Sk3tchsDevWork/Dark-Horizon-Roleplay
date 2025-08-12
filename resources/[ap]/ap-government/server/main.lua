QBCore = exports[Config.FrameworkExport]:GetCoreObject()

Citizen.CreateThread(function ()
    if GetResourceState(GetCurrentResourceName()) == 'started' then
      print('[INFO] Join Discord for support and information, https://discord.gg/8Cn3EjfzrM') 
    end
end)

if Config.AddJobsFromConfig then
  exports[Config.FrameworkExport]:AddJobs(Config.AddSharedJobs)
end

local currency = Config.Currency
local phs = Config.PhoneSettings

QBCore.Functions.CreateCallback('ap-government:getCandidates',function(source, cb)
  local Player = QBCore.Functions.GetPlayer(source)
  local result = MySQL.Sync.fetchAll('SELECT * FROM `ap_voting` WHERE identifier = @identifier', {['@identifier'] = Player.PlayerData.citizenid})
  if result[1] ~= nil then
	  cb(result)
  else
    local data = {
      [1] = {state = 0}
    }
    cb(data)
  end
end)

QBCore.Functions.CreateCallback('ap-government:getCandidate',function(source, cb)
  local result = MySQL.Sync.fetchAll('SELECT * FROM `ap_voting`', {})
  cb(result)
end)

QBCore.Functions.CreateCallback('ap-government:callback:getAppointments',function(source, cb)
  local result = MySQL.Sync.fetchAll('SELECT * FROM `ap_appointments`', {})
  cb(result)
end)

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

getBirth = function(identifier)
  local result = MySQL.Sync.fetchAll('SELECT charinfo FROM `players` WHERE citizenid = @citizenid', {
['@citizenid'] = identifier
})

if result[1] and result[1].charinfo then
      local data = json.decode(result[1].charinfo)
  return ('%s'):format(data["birthdate"])
  end
end

QBCore.Functions.CreateCallback('ap-government:callback:getName',function(source, cb, id)
  if id == "Government Owned" then
    cb("Government Owned")
  else
    cb({name = getName(id), dob = getBirth(id)})
  end
end)

QBCore.Functions.CreateCallback('ap-government:getAppliedCandidates',function(source, cb)
  local result = MySQL.Sync.fetchAll('SELECT * FROM `ap_voting`', {})
  cb(result)
end)

QBCore.Functions.CreateCallback('ap-government:getJsonData',function(source, cb)
  local result = MySQL.Sync.fetchAll('SELECT * FROM `ap_dlcsettings` WHERE script = @script', {['@script'] = "ap_voting"})
  if result[1].script == "ap_voting" then
    local data = json.decode(result[1].settings)
    cb(data)
  else
    print("[ERROR] You have not imported the dlc SQL insert, please make sure you add it into your Database.")
  end
end)

QBCore.Functions.CreateCallback('ap-government:getDBTax',function(source, cb)
  local result = MySQL.Sync.fetchAll('SELECT * FROM `ap_dlcsettings` WHERE script = @script', {['@script'] = "ap_voting"})
  if result[1].script == "ap_voting" then
    local data = json.decode(result[1].other)
    cb(data)
  else
    print("[ERROR] You have not imported the dlc SQL insert, please make sure you add it into your Database.")
  end
end)

QBCore.Functions.CreateCallback('ap-government:callback:getBusinessGrantHistory',function(source, cb, job)
  local result = MySQL.Sync.fetchAll('SELECT * FROM `ap_tax` WHERE business = @business', {['@business'] = job})
  cb(json.decode(result[1].grants))
end)

RegisterServerEvent('ap-government:server:saveCandidate')
AddEventHandler('ap-government:server:saveCandidate', function(sd, q1, q2)
  local xPlayer = QBCore.Functions.GetPlayer(source)
  MySQL.Async.execute('INSERT INTO ap_voting (identifier, name, age, shortDescription, whyDoYouWantToBeACandidate, WhatYoullBringToTheCity, denied, votes, state) VALUES (@identifier, @name, @age, @shortDescription, @whyDoYouWantToBeACandidate, @WhatYoullBringToTheCity, @denied, @votes, @state)', {
    ['@identifier'] = xPlayer.PlayerData.citizenid,
    ['@name'] = getName(xPlayer.PlayerData.citizenid),
    ['@age'] = getBirth(xPlayer.PlayerData.citizenid),
    ['@shortDescription'] = sd, 
    ['@whyDoYouWantToBeACandidate'] = q1, 
    ['@WhatYoullBringToTheCity'] = q2, 
    ['@denied'] = "N/A",
    ['@votes'] = 0,
    ['@state'] = 1,
  })
  TriggerClientEvent('ap-government:client:applyCandidate', xPlayer.PlayerData.source)
end)

RegisterServerEvent('ap-government:server:candidateStatus')
AddEventHandler('ap-government:server:candidateStatus', function(e)
  local tPlayer = QBCore.Functions.GetPlayerByCitizenId(e.v.identifier)
  if e.input == "accept" then
    if tPlayer then
      TriggerClientEvent('ap-government:notify', tPlayer.PlayerData.source, LangServer[Config.Language].notifications['candidateStatus_one'])
    end
    MySQL.Sync.execute("UPDATE ap_voting SET state = @state WHERE identifier = @identifier", {
      ['@state'] = 3,
      ['@identifier'] = e.v.identifier
    }) 
    PhoneNotify(e.v.identifier, phs['MAIL']['approve_candidate']['title'], phs['MAIL']['approve_candidate']['msg'], phs['MAIL']['approve_candidate']['sender'], phs['MAIL']['approve_candidate']['subject'], phs['MAIL']['approve_candidate']['image'], phs['MAIL']['approve_candidate']['mail']:format(getName(e.v.identifier)), phs['MAIL']['approve_candidate']['button'], phs['MAIL']['approve_candidate']['email'], phs['MAIL']['approve_candidate']['photo'], phs['MAIL']['approve_candidate']['photoattachment'])
  elseif e.input == "deny" then
    if tPlayer then
      TriggerClientEvent('ap-government:notify', tPlayer.PlayerData.source, LangServer[Config.Language].notifications['candidateStatus_two'])
    end
    MySQL.Sync.execute("UPDATE ap_voting SET state = @state, denied = @denied WHERE identifier = @identifier", {
      ['@state'] = 2,
      ['@denied'] = tostring(e.reason),
      ['@identifier'] = e.v.identifier
    }) 
    PhoneNotify(e.v.identifier, phs['MAIL']['denied_candidate']['title'], phs['MAIL']['denied_candidate']['msg'], phs['MAIL']['denied_candidate']['sender'], phs['MAIL']['denied_candidate']['subject'], phs['MAIL']['denied_candidate']['image'], phs['MAIL']['denied_candidate']['mail']:format(getName(e.v.identifier), tostring(e.reason)), phs['MAIL']['denied_candidate']['button'], phs['MAIL']['denied_candidate']['email'], phs['MAIL']['denied_candidate']['photo'], phs['MAIL']['denied_candidate']['photoattachment'])
  end
end)

RegisterServerEvent('ap-government:server:startVoting')
AddEventHandler('ap-government:server:startVoting', function(id)
  local xPlayer = QBCore.Functions.GetPlayer(source)
  local result = MySQL.Sync.fetchAll('SELECT * FROM `ap_dlcsettings` WHERE script = @script', {['@script'] = "ap_voting"})
  if result[1] then
    local data = json.decode(result[1].settings)
    data["currentType"] = id
    MySQL.Sync.execute("UPDATE ap_dlcsettings SET settings = @settings WHERE script = @script", {
      ['@settings'] = json.encode(data),
      ['@script'] = "ap_voting"
    }) 
    updateVote(1)
    if Config.displayVotingChatNotify then
      TriggerClientEvent('chat:addMessage', -1, {
        color = { 0, 0, 255},
        multiline = true,
        args = {'Voting | ', LangServer[Config.Language].notifications['startVoting']}
      })
    else
      TriggerClientEvent('ap-government:notify', -1, LangServer[Config.Language].notifications['startVoting'])
    end
    if Config.DiscordWebhook.CandidateStarted then
      sendLogsDiscord(webhookMsg['CandidateStarted']['title']:format(Config.Voting[id].poll), webhookMsg['CandidateStarted']['message'], "CandidateStartedWebhook")
    end
  else
    print("[ERROR] You have not imported the dlc SQL insert, please make sure you add it into your Database.")
  end
end)

RegisterServerEvent('ap-government:server:applyDialog')
AddEventHandler('ap-government:server:applyDialog', function(v)
  local Player = QBCore.Functions.GetPlayer(source)
  if Player then
    if Player.PlayerData.job.name == v.job then
      TriggerClientEvent("ap-government:client:applyDialog", Player.PlayerData.source)
    else
      TriggerClientEvent('ap-government:notify', Player.PlayerData.source, LangServer[Config.Language].notifications['applyDialog']:format(v.notify))
    end
  end
end)

DumpTable = function(table, nb)
	if nb == nil then
		nb = 0
	end

	if type(table) == 'table' then
		local s = ''
		for i = 1, nb + 1, 1 do
			s = s .. "    "
		end

		s = '{\n'
		for k,v in pairs(table) do
			if type(k) ~= 'number' then k = '"'..k..'"' end
			for i = 1, nb, 1 do
				s = s .. "    "
			end
			s = s .. '['..k..'] = ' .. DumpTable(v, nb + 1) .. ',\n'
		end

		for i = 1, nb, 1 do
			s = s .. "    "
		end

		return s .. '}'
	else
		return tostring(table)
	end
end

RegisterServerEvent('ap-government:server:enableVoting')
AddEventHandler('ap-government:server:enableVoting', function()
  local xPlayer = QBCore.Functions.GetPlayer(source)
  local candidate = MySQL.Sync.fetchAll('SELECT * FROM `ap_voting`', {})
  if candidate[1] then
    MySQL.Sync.execute("UPDATE ap_voting SET state = @state", {
      ['@state'] = 4
    })  
    updateVote(2)
    if Config.displayVotingChatNotify then
      TriggerClientEvent('chat:addMessage', -1, {
        color = { 0, 0, 255},
        multiline = true,
        args = {'Voting | ', LangServer[Config.Language].notifications['enableVoting_one']}
      })
    else
      TriggerClientEvent('ap-government:notify', -1, LangServer[Config.Language].notifications['enableVoting_one'])
    end
    if Config.DiscordWebhook.PollsOpen then
      local voters = MySQL.Sync.fetchAll('SELECT * FROM `ap_dlcsettings` WHERE script = @script', {['@script'] = "ap_voting"})
      local data = json.decode(voters[1].settings)
      sendLogsDiscord(webhookMsg['PollsOpen']['title']:format(Config.Voting[data["currentType"]].poll), webhookMsg['PollsOpen']['message'], "PollsOpenWebhook")
    end
  else
    TriggerClientEvent('ap-government:notify', xPlayer.PlayerData.source, LangServer[Config.Language].notifications['enableVoting_two'])
  end
end)

updateVote = function(status)
  local result = MySQL.Sync.fetchAll('SELECT * FROM `ap_dlcsettings` WHERE script = @script', {['@script'] = "ap_voting"})
  if result[1].script == "ap_voting" then
    local data = json.decode(result[1].settings)
    data["voteState"] = status
    MySQL.Sync.execute("UPDATE ap_dlcsettings SET settings = @settings WHERE script = @script", {
      ['@settings'] = json.encode(data),
      ['@script'] = "ap_voting"
    })  
  else
    print("[ERROR] You have not imported the dlc SQL insert, please make sure you add it into your Database.")
  end
end

resetSystem = function()
  local result = MySQL.Sync.fetchAll('SELECT * FROM `ap_dlcsettings` WHERE script = @script', {['@script'] = "ap_voting"})
  if result[1] then
    local data = json.decode(result[1].settings)
    data["currentType"] = 0
    MySQL.Sync.execute("UPDATE ap_dlcsettings SET settings = @settings WHERE script = @script", {
      ['@settings'] = json.encode(data),
      ['@script'] = "ap_voting"
    }) 
    MySQL.Async.execute('DELETE FROM ap_voting', {}) 
  end
end

RegisterServerEvent('ap-government:server:finishVoting')
AddEventHandler('ap-government:server:finishVoting', function()
  local xPlayer = QBCore.Functions.GetPlayer(source)
  local candidate = MySQL.Sync.fetchAll('SELECT identifier, name, votes FROM `ap_voting` WHERE votes = ( SELECT MAX(votes) FROM `ap_voting` )', {})
  if candidate[1] then
    local voters = MySQL.Sync.fetchAll('SELECT * FROM `ap_dlcsettings` WHERE script = @script', {['@script'] = "ap_voting"})
    MySQL.Sync.execute("UPDATE ap_voting SET state = @state WHERE identifier = @identifier", {
      ['@state'] = 5,
      ['@identifier'] = candidate[1].identifier
    })  
    local data = json.decode(voters[1].settings)
    if Config.NotifyWinnerByPhone then
      PhoneNotify(candidate[1].identifier, phs['MAIL']['candidate_winner']['title'], phs['MAIL']['candidate_winner']['msg'], phs['MAIL']['candidate_winner']['sender'], phs['MAIL']['candidate_winner']['subject'], phs['MAIL']['candidate_winner']['image'], phs['MAIL']['candidate_winner']['mail']:format(candidate[1].name, Config.Voting[data["currentType"]].givenJob.label, candidate[1].votes), phs['MAIL']['candidate_winner']['button'], phs['MAIL']['candidate_winner']['email'], phs['MAIL']['candidate_winner']['photo'], phs['MAIL']['candidate_winner']['photoattachment'])
      TriggerClientEvent('ap-government:notify', xPlayer.PlayerData.source, LangServer[Config.Language].notifications['finishVoting_one'])
    end
    if Config.DiscordWebhook.CandidateWinner then
      sendLogsDiscord(webhookMsg['CandidateWinner']['title']:format(Config.Voting[data["currentType"]].poll), webhookMsg['CandidateWinner']['message']:format(candidate[1].name), "CandidateWinnerWebhook")
    end
    updateVote(0)  
    if voters[1] then
      MySQL.Sync.execute("UPDATE ap_dlcsettings SET id_storage = @id_storage WHERE script = @script", {
        ['@id_storage'] = "[]",
        ['@script'] = "ap_voting"
      }) 
    else
      print("[ERROR] You have not imported the dlc SQL insert, please make sure you add it into your Database.")
    end
    TriggerClientEvent('ap-government:client:setVotingTrue', -1, false)
  else
    TriggerClientEvent('ap-government:notify', xPlayer.PlayerData.source, LangServer[Config.Language].notifications['finishVoting_two'])
  end
end)

RegisterServerEvent('ap-government:server:acceptJob')
AddEventHandler('ap-government:server:acceptJob', function(v)
  local Player = QBCore.Functions.GetPlayer(source)
  if Player then
    Player.Functions.SetJob(v.givenJob.name, v.givenJob.grade)
    resetSystem()
  end
end)

RegisterServerEvent('ap-government:server:removeCandidate')
AddEventHandler('ap-government:server:removeCandidate', function(v, reason)
  local Player = QBCore.Functions.GetPlayer(source)
  if Player then
    TriggerClientEvent('ap-government:notify', Player.PlayerData.source, LangServer[Config.Language].notifications['removeCandidate']:format(v.name))
  end
  MySQL.Sync.execute("UPDATE ap_voting SET state = @state, votes = @votes, denied = @denied WHERE identifier = @identifier", {
    ['@state'] = 6,
    ['@votes'] = 0,
    ['@denied'] = tostring(reason),
    ['@identifier'] = v.identifier
  }) 
end)

RegisterServerEvent('ap-government:server:takeFullPayment')
AddEventHandler('ap-government:server:takeFullPayment', function(v)
  local Player = QBCore.Functions.GetPlayer(source)
  local business = MySQL.Sync.fetchAll('SELECT * FROM `ap_tax` WHERE business = @business', {['@business'] = v.business})
  if business[1] then
    if RemoveAccountMoney(v.business, tonumber(v.amount_owed)) then
      local amount = business[1].total_tax_paid
      local newAmount = (amount + v.amount_owed)
      MySQL.Sync.execute("UPDATE ap_tax SET amount_owed = @amount_owed, total_tax_paid = @total_tax_paid WHERE business = @business", {
        ['@amount_owed'] = 0,
        ['@total_tax_paid'] = tonumber(newAmount),
        ['@business'] = v.business
      })  
      TriggerClientEvent('ap-government:notify', Player.PlayerData.source, LangServer[Config.Language].notifications['takeFullPayment_one']:format(v.label))
    else
      TriggerClientEvent('ap-government:notify', Player.PlayerData.source, LangServer[Config.Language].notifications['takeFullPayment_two']:format(v.label))
    end
  end
end)

RegisterServerEvent('ap-government:server:clearUnpaidTax')
AddEventHandler('ap-government:server:clearUnpaidTax', function(v)
  local Player = QBCore.Functions.GetPlayer(source)
  local business = MySQL.Sync.fetchAll('SELECT * FROM `ap_tax` WHERE business = @business', {['@business'] = v.business})
  if business[1] then
    MySQL.Sync.execute("UPDATE ap_tax SET amount_owed = @amount_owed WHERE business = @business", {
      ['@amount_owed'] = 0,
      ['@business'] = v.business
    }) 
    TriggerClientEvent('ap-government:notify', Player.PlayerData.source, LangServer[Config.Language].notifications['clearUnpaidTax']:format(v.label))
  end
end)

RegisterServerEvent('ap-government:server:systemTax')
AddEventHandler('ap-government:server:systemTax', function(playerid, type, amount)
  local Player = QBCore.Functions.GetPlayer(playerid)
  local cfg = Config.Tax
  local money = tonumber(amount)
  if type == "Player" then
    local IncomeTax = "Income"
    if cfg.MayorControl.enable then
      local playersTax = MySQL.Sync.fetchAll('SELECT * FROM `ap_dlcsettings` WHERE script = @script', {['@script'] = "ap_voting"})
      if playersTax[1] then
        local data = json.decode(playersTax[1].other)
        local taxAmount = tonumber(data[IncomeTax])
        local percent = money * taxAmount
        Player.Functions.RemoveMoney('bank', math.floor(tonumber(percent)))
        if cfg.MayorControl.TaxTypes[IncomeTax].AddCityHallFunds then
          manageFunds("Add", math.floor(tonumber(percent)))
        end
        local identifier = Player.PlayerData.citizenid
        BankingTransaction(identifier, math.floor(tonumber(percent)), IncomeTax)
        TriggerClientEvent('ap-government:notify', Player.PlayerData.source, LangServer[Config.Language].notifications['systemTax']:format(currency, percent))
      else
        print("[ERROR] You have not imported the dlc SQL insert, please make sure you add it into your Database.")
      end
    else
      local taxAmount = money * tonumber(cfg.MayorControl.TaxTypes[IncomeTax].percentage)
      Player.Functions.RemoveMoney('bank', math.floor(tonumber(taxAmount)))
      if cfg.MayorControl.TaxTypes[IncomeTax].AddCityHallFunds then
        manageFunds("Add", math.floor(tonumber(taxAmount)))
      end
      local identifier = Player.PlayerData.citizenid
      BankingTransaction(identifier, math.floor(tonumber(percent)), IncomeTax)
      TriggerClientEvent('ap-government:notify', Player.PlayerData.source, LangServer[Config.Language].notifications['systemTax']:format(currency, percent))
    end
  end
end)

businessTaxPayments = function()
  local tType = Config.BusinessTax.tax
  if tType.AutoStoreTime.enable ~= true then
    MySQL.Async.fetchAll('SELECT * FROM ap_tax', {}, function(results) 
      if #results > 0 then
        for k,v in pairs(results) do
          local account = GetAccountData(v.business)
          if account < v.base_tax then
            logTax(v.business, v.base_tax, "unpaid")
            if v.owner ~= "COMPANY OWNER" or v.owner ~= "Government Owned" then
              local Player = QBCore.Functions.GetPlayerByCitizenId(v.owner)
              if Player then
                TriggerClientEvent('ap-government:notify', Player.PlayerData.source, LangServer[Config.Language].notifications['businessTaxPayments_one']:format(currency, v.base_tax))
              end
            end
          else
            RemoveAccountMoney(v.business, v.base_tax)
            logTax(v.business, v.base_tax, "paid")
            if tType.AddCityHallFunds then
              manageFunds("Add", v.base_tax)
            end 
            if v.owner ~= "COMPANY OWNER" or v.owner ~= "Government Owned" then
              local Player = QBCore.Functions.GetPlayerByCitizenId(v.owner)
              if Player then
                TriggerClientEvent('ap-government:notify', Player.PlayerData.source, LangServer[Config.Language].notifications['businessTaxPayments_two']:format(currency, v.base_tax))
              end
            end
          end
        end
      end
    end)
    SetTimeout(tType.timetaken * (60 * 1000), businessTaxPayments)
  else
    MySQL.Async.fetchAll('SELECT * FROM ap_tax', {}, function(results) 
      if #results > 0 then
        for k,v in pairs(results) do
          if v.pay_timer >= tType.AutoStoreTime.timetaken then
            local account = GetAccountData(v.business)
            if account < v.base_tax then
              logTax(v.business, v.base_tax, "unpaid")
              if v.owner ~= "COMPANY OWNER" or v.owner ~= "Government Owned" then
                local Player = QBCore.Functions.GetPlayerByCitizenId(v.owner)
                if Player then
                  TriggerClientEvent('ap-government:notify', Player.PlayerData.source, LangServer[Config.Language].notifications['businessTaxPayments_one']:format(currency, v.base_tax))
                end
              end
              ResetTimer(v.business)
            else
              RemoveAccountMoney(v.business, v.base_tax)
              logTax(v.business, v.base_tax, "paid")
              if tType.AddCityHallFunds then
                manageFunds("Add", v.base_tax)
              end 
              if v.owner ~= "COMPANY OWNER" or v.owner ~= "Government Owned" then
                local Player = QBCore.Functions.GetPlayerByCitizenId(v.owner)
                if Player then
                  TriggerClientEvent('ap-government:notify', Player.PlayerData.source, LangServer[Config.Language].notifications['businessTaxPayments_two']:format(currency, v.base_tax))
                end
              end
              ResetTimer(v.business)
            end
          else
            AddTimer(v.business, v.pay_timer)
          end
        end
      end
    end)
    SetTimeout(1 * (60 * 1000), businessTaxPayments)
  end
end

ResetTimer = function(business)
  MySQL.Sync.execute("UPDATE ap_tax SET pay_timer = @pay_timer WHERE business = @business", {
    ['@pay_timer'] = 0,
    ['@business'] = business
  }) 
end

AddTimer = function(business, currentTime)
  local time = (currentTime + 1)
  MySQL.Sync.execute("UPDATE ap_tax SET pay_timer = @pay_timer WHERE business = @business", {
    ['@pay_timer'] = time,
    ['@business'] = business
  }) 
end

logTax = function(job, amount, type)
  local Business = MySQL.Sync.fetchAll('SELECT * FROM `ap_tax` WHERE business = @business', {['@business'] = job})
  if type == "unpaid" then
    if Business[1] then
      local data = Business[1].amount_owed
      local newData = (data + amount)
      MySQL.Sync.execute("UPDATE ap_tax SET amount_owed = @amount_owed WHERE business = @business", {
        ['@amount_owed'] = newData,
        ['@business'] = Business[1].business
      })
    end
  elseif type == "paid" then
    if Business[1] then
      local data = Business[1].total_tax_paid
      local newData = (data + amount)
      MySQL.Sync.execute("UPDATE ap_tax SET total_tax_paid = @total_tax_paid WHERE business = @business", {
        ['@total_tax_paid'] = newData,
        ['@business'] = Business[1].business
      })
    end
  end
end

QBCore.Functions.CreateCallback('ap-government:getBusinessAccounts',function(source, cb)
  local result = MySQL.Sync.fetchAll('SELECT * FROM `ap_tax`', {})
  cb(result)
end)

PhoneNotify = function(identifier, notifytitle, notifymsg, sender, subject, image, mail, button, email, photo, photoattachment)
  local tPlayer = QBCore.Functions.GetPlayerByCitizenId(identifier)
  if Config.Phone.GKSPhone == true then
    if tPlayer then
      TriggerClientEvent('gksphone:notifi', tPlayer.PlayerData.source, {title = notifytitle, message = notifymsg, img= '/html/static/img/icons/mail.png' })
    end
    MySQL.Async.execute('INSERT INTO gksphone_mails (citizenid, sender, subject, image, message, button) VALUES (@citizenid, @sender, @subject, @image, @message, @button)', {
        ['@citizenid'] = identifier,
        ['@sender'] = sender,
        ['@subject'] = subject, 
        ['@image'] = image,
        ['@message'] = mail,
        ['@button'] = button,
    })
  elseif Config.Phone.QuasarPhone == true then
    local data = {}
    data.sender = sender
    data.subject = subject
    data.message = mail
    data.button = button
    TriggerEvent('qs-smartphone:server:sendNewMailToOffline', identifier, data)
  elseif Config.Phone.QSPRO == true then
    if tPlayer then
      exports['qs-smartphone-pro']:sendNewMail(tPlayer.PlayerData.source, {
        sender = sender,
        subject = subject,
        message = mail
      })
      local phoneQS = exports['qs-smartphone-pro']:GetPhoneNumberFromIdentifier(identifier, false) -- Sender phone number
      exports['qs-smartphone-pro']:sendNotification(phoneQS, {
        app = 'mail',
        msg = 'You have a mail from '..sender,
        head = 'Mail'
      }, false)
    else
      local PlayerMailAccounts = MySQL.Sync.fetchAll('SELECT * FROM `mail_accounts` WHERE owner = @owner', {['@owner'] = identifier})
      for k,v in pairs(PlayerMailAccounts) do
        math.randomseed(os.time())
        MySQL.Async.execute('INSERT INTO player_mails (taker, sender, subject, message, mailid) VALUES (@taker, @sender, @subject, @message, @mailid)', {
          ['@taker'] = v.mail,
          ['@sender'] = sender,
          ['@subject'] = subject, 
          ['@message'] = mail,
          ['@mailid'] = math.random(100000, 999999),
        })
      end
    end
  elseif Config.Phone.QBPhone == true then
    local data = {}
    data.sender = sender
    data.subject = subject
    data.message = mail
    data.button = button
    TriggerEvent('qb-phone:server:sendNewMailToOffline', identifier, data)
  elseif Config.Phone.HighPhone == true then
    local senderData = { address = email, name = sender, photo = photo }
    local attachments = {{ image = photoattachment }}
    TriggerEvent("high_phone:sendMailFromServer", identifier, senderData, subject, mail, attachments)
  elseif Config.Phone.LBPhone == true then
    local PhoneNumber = exports["lb-phone"]:GetEquippedPhoneNumber(identifier)
    if PhoneNumber then
      local emailAdress = exports["lb-phone"]:GetEmailAddress(PhoneNumber)
      if emailAdress then
        exports["lb-phone"]:SendMail({
          to = emailAdress,
          sender = sender,
          subject = subject,
          message = mail,
          actions = {}
        })
      end
    end
  elseif Config.Phone.Custom == true then
    local newData = {
      id = identifier,
      notifytitle = notifytitle, 
      notifymsg = notifymsg, 
      sender = sender, 
      subject = subject, 
      image = image, 
      mail = mail, 
      button = button, 
      email = email, 
      photo = photo, 
      photoattachment = photoattachment,
    }
    customphonefunction(newData)
  end
end 

RegisterNetEvent('lucid-mail:sendOfflineMailNow')
AddEventHandler('lucid-mail:sendOfflineMailNow', function(data)
  TriggerEvent('lucid-mail:getTime', function(time)
    local sender = data.sender
    local receiver = data.receiver
    local notify = data.notify
    local text = data.text
    local receiverPlayer = QBCore.Functions.GetPlayerByCitizenId(receiver)
    local isOffline = 0
    if receiverPlayer then
      isOffline = 1
      TriggerClientEvent('QBCore:Notify', receiverPlayer.PlayerData.source, notify)
      TriggerClientEvent('lucid-mail:hud.hasMail', receiverPlayer.PlayerData.source, true)
    end
    MySQL.Async.execute('INSERT INTO player_mails_new (sender, receiver, text, sended_at, unread) VALUES (@sender, @receiver, @text, @sended_at, @unread)', {
        ['@sender'] = sender,
        ['@receiver'] = receiver,
        ['@text'] = text, 
        ['@sended_at'] = time,
        ['@unread'] = isOffline,
    })
  end)
end)

RegisterServerEvent('ap-government:server:changeTaxCity')
AddEventHandler('ap-government:server:changeTaxCity', function(v, tax)
  local Player = QBCore.Functions.GetPlayer(source)
  local accountsTax = MySQL.Sync.fetchAll('SELECT * FROM `ap_dlcsettings` WHERE script = @script', {['@script'] = "ap_voting"})
  if accountsTax[1] then
    local data = json.decode(accountsTax[1].other)
    data[v.label] = tonumber(tax)
    MySQL.Sync.execute("UPDATE ap_dlcsettings SET other = @other WHERE script = @script", {
      ['@other'] = json.encode(data),
      ['@script'] = "ap_voting"
    })
    TriggerClientEvent('ap-government:notify', Player.PlayerData.source, LangServer[Config.Language].notifications['changeTaxCity']:format(v.label, tax, "%"))
    TriggerClientEvent('ap-government:client:taxSettings', Player.PlayerData.source)
  else
    print("[ERROR] You have not imported the dlc SQL insert, please make sure you add it into your Database.")
  end
end)

chargeCityTax = function(playerid, type, amount, moneytype)
  local Player = QBCore.Functions.GetPlayer(playerid)
  if Player then
    if Config.Tax.MayorControl.TaxTypes[type].label == type then
      local tax = Config.Tax.MayorControl.TaxTypes[type]
      if amount ~= nil then
        if tax.enable then
          if tax.mayorControl then
            local taxType = MySQL.Sync.fetchAll('SELECT * FROM `ap_dlcsettings` WHERE script = @script', {['@script'] = "ap_voting"})
            if taxType[1].other then
              local data = json.decode(taxType[1].other)
              if data[type] then
                local percent = amount * data[type]
                if moneytype == nil or moneytype == "bank" then
                  Player.Functions.RemoveMoney('bank', math.floor(tonumber(percent)))
                  local identifier = Player.PlayerData.citizenid
                  BankingTransaction(identifier, math.floor(tonumber(percent)), type)
                elseif moneytype == "cash" then
                  Player.Functions.RemoveMoney('cash', math.floor(tonumber(percent)))
                end
                if tax.AddCityHallFunds then
                  manageFunds("Add", tonumber(percent))
                end
                TriggerClientEvent('ap-government:notify', Player.PlayerData.source, LangServer[Config.Language].notifications['chargeCityTax']:format(currency, percent, type))
              else
                print(type.." has not been added to the others table in the DB please add this in order to use this mayor controled tax.")
              end
            else
              print("[ERROR] You have not imported the dlc SQL insert, please make sure you add it into your Database.")
            end
          else
            local controledAmount = tonumber(tax.percentage)
            local percent = amount * controledAmount
            if moneytype == nil or moneytype == "bank" then
              Player.Functions.RemoveMoney('bank', math.floor(tonumber(percent)))
              local identifier = Player.PlayerData.citizenid
              BankingTransaction(identifier, math.floor(tonumber(percent)), type)
            elseif moneytype == "cash" then
              Player.Functions.RemoveMoney('cash', math.floor(tonumber(percent)))
            end
            if tax.AddCityHallFunds then
              manageFunds("Add", tonumber(percent))
            end
            TriggerClientEvent('ap-government:notify', Player.PlayerData.source, LangServer[Config.Language].notifications['chargeCityTax']:format(currency, percent, type))
          end
        end
      else
        print("The chargeCityTax Export is pulling a nil value for amount, please make sure you have added the right argument for the amount in the export.")
      end
    else
      print("There is no such tax: "..type.." in the config file please make sure you have added this correctly.")
    end
  end
end

RegisterServerEvent('ap-government:server:isRegistered')
AddEventHandler('ap-government:server:isRegistered', function()  
  local Player = QBCore.Functions.GetPlayer(source)
  local identifierMatch = false
  MySQL.Async.fetchAll("SELECT id_storage FROM ap_dlcsettings WHERE script = @script", {['@script'] = "ap_voting"}, function(data)
    if data[1].id_storage ~= nil then
        local id_storage = json.decode(data[1].id_storage)
        if #id_storage > 0 then
            for k,v in pairs(id_storage) do 
                if v.identifier == Player.PlayerData.citizenid then 
                  identifierMatch = true
                  break
                end
            end
        else
          identifierMatch = false
        end
    end 
  end)
  local dbData = MySQL.Sync.fetchAll('SELECT * FROM `ap_dlcsettings` WHERE script = @script', {['@script'] = "ap_voting"})
  local db = json.decode(dbData[1].settings)
  if identifierMatch then 
    if db["voteState"] == 2 then
      TriggerClientEvent('ap-government:client:setVotingTrue', Player.PlayerData.source, true)
      TriggerClientEvent('ap-government:notify', Player.PlayerData.source, LangClient[Config.Language].notifications['open_voting_ui_error_one'])
    else
      TriggerClientEvent('ap-government:notify', Player.PlayerData.source, LangClient[Config.Language].notifications['open_voting_ui_error_two'])
    end
  else
    if db["voteState"] == 2 then
      TriggerClientEvent('ap-government:client:openVotingSystem', Player.PlayerData.source)
    else
      TriggerClientEvent('ap-government:notify', Player.PlayerData.source, LangClient[Config.Language].notifications['open_voting_ui_error_two'])
    end
  end
end)

RegisterServerEvent('ap-government:server:registerVote')
AddEventHandler('ap-government:server:registerVote', function(v)
  local Player = QBCore.Functions.GetPlayer(source)
  local registerIdentifier = MySQL.Sync.fetchAll('SELECT * FROM `ap_dlcsettings` WHERE script = @script', {['@script'] = "ap_voting"})
  if registerIdentifier[1] then
    local dbData = json.decode(registerIdentifier[1].id_storage)
    table.insert(dbData, {identifier = Player.PlayerData.citizenid})
    MySQL.Sync.execute("UPDATE ap_dlcsettings SET id_storage = @id_storage WHERE script = @script", {
      ['@id_storage'] = json.encode(dbData),
      ['@script'] = "ap_voting"
    })
    addVote(v.citizen)
  end
end)

addVote = function(id)
  local candidateID = MySQL.Sync.fetchAll('SELECT * FROM `ap_voting` WHERE identifier = @identifier', {['@identifier'] = id})
  if candidateID[1] then
    local currentVotes = candidateID[1].votes
    MySQL.Sync.execute("UPDATE ap_voting SET votes = @votes WHERE identifier = @identifier", {
      ['@votes'] = currentVotes + 1,
      ['@identifier'] = id
    })
  else
    print("[ERROR] There is an issue with your ap_votings table.")
  end
end

RegisterServerEvent('ap-government:server:warnCandidate')
AddEventHandler('ap-government:server:warnCandidate', function(warnTxt, v)
  local Player = QBCore.Functions.GetPlayer(source)
  local tPlayer = QBCore.Functions.GetPlayerByCitizenId(v.identifier)
  if tPlayer then
    TriggerClientEvent('ap-government:notify', Player.PlayerData.source, LangServer[Config.Language].notifications['warnCandidate'])
  end
  PhoneNotify(v.identifier, phs['MAIL']['candidate_warn']['title'], phs['MAIL']['candidate_warn']['msg'], phs['MAIL']['candidate_warn']['sender'], phs['MAIL']['candidate_warn']['subject'], phs['MAIL']['candidate_warn']['image'], phs['MAIL']['candidate_warn']['mail']:format(v.name, warnTxt), phs['MAIL']['candidate_warn']['button'], phs['MAIL']['candidate_warn']['email'], phs['MAIL']['candidate_warn']['photo'], phs['MAIL']['candidate_warn']['photoattachment'])
end)

manageFunds = function(type, amount)
  local db = MySQL.Sync.fetchAll('SELECT * FROM `ap_dlcsettings` WHERE script = @script', {['@script'] = "ap_voting"})
  if db[1] then
    if type == "Add" then
      local data = json.decode(db[1].settings)
      data["funds"] = (data["funds"] + math.floor(tonumber(amount)))
      MySQL.Sync.execute("UPDATE ap_dlcsettings SET settings = @settings WHERE script = @script", {
        ['@settings'] = json.encode(data),
        ['@script'] = "ap_voting"
      })
    end
    if type == "Remove" then
      local data = json.decode(db[1].settings)
      data["funds"] = (data["funds"] - amount)
      MySQL.Sync.execute("UPDATE ap_dlcsettings SET settings = @settings WHERE script = @script", {
        ['@settings'] = json.encode(data),
        ['@script'] = "ap_voting"
      })
    end
  else
    print("[ERROR] You have not imported the dlc SQL insert, please make sure you add it into your Database.")
  end
end

RegisterServerEvent('ap-government:server:sortfunds')
AddEventHandler('ap-government:server:sortfunds', function(type, v, amount)
  local Player = QBCore.Functions.GetPlayer(source)
  local db = MySQL.Sync.fetchAll('SELECT * FROM `ap_dlcsettings` WHERE script = @script', {['@script'] = "ap_voting"})
  if type == "withdraw" then
    if tonumber(amount) > tonumber(v["funds"]) then
      TriggerClientEvent('ap-government:notify', Player.PlayerData.source, LangServer[Config.Language].notifications['sortfunds_one'])
      TriggerClientEvent('ap-government:client:withdrawfunds', Player.PlayerData.source, v)
    elseif tonumber(amount) < Config.MayorOptions.funds.withdrawal.min then
      TriggerClientEvent('ap-government:notify', Player.PlayerData.source, LangServer[Config.Language].notifications['sortfunds_two']:format(currency, Config.MayorOptions.funds.withdrawal.min))
      TriggerClientEvent('ap-government:client:withdrawfunds', Player.PlayerData.source, v)
    elseif tonumber(amount) > Config.MayorOptions.funds.withdrawal.max then
      TriggerClientEvent('ap-government:notify', Player.PlayerData.source, LangServer[Config.Language].notifications['sortfunds_three']:format(currency, Config.MayorOptions.funds.withdrawal.max))
      TriggerClientEvent('ap-government:client:withdrawfunds', Player.PlayerData.source, v)
    else
      if db[1] then
        local data = json.decode(db[1].settings)
        data["funds"] = (data["funds"] - amount)
        MySQL.Sync.execute("UPDATE ap_dlcsettings SET settings = @settings WHERE script = @script", {
          ['@settings'] = json.encode(data),
          ['@script'] = "ap_voting"
        })
        TriggerClientEvent('ap-government:notify', Player.PlayerData.source, LangServer[Config.Language].notifications['sortfunds_four']:format(currency, amount))
        Player.Functions.AddMoney('bank', tonumber(amount))
      end
    end
  elseif type == "deposit" then
    local money = Player.PlayerData.money["bank"]
    if tonumber(money) < tonumber(amount) then
      TriggerClientEvent('ap-government:notify', Player.PlayerData.source, LangServer[Config.Language].notifications['sortfunds_five'])
      TriggerClientEvent('ap-government:client:depositfunds', Player.PlayerData.source, v)
    elseif tonumber(amount) < Config.MayorOptions.funds.deposit.min then
      TriggerClientEvent('ap-government:notify', Player.PlayerData.source, LangServer[Config.Language].notifications['sortfunds_six']:format(currency, Config.MayorOptions.funds.deposit.min))
      TriggerClientEvent('ap-government:client:depositfunds', Player.PlayerData.source, v)
    elseif tonumber(amount) > Config.MayorOptions.funds.deposit.max then
      TriggerClientEvent('ap-government:notify', Player.PlayerData.source, LangServer[Config.Language].notifications['sortfunds_seven']:format(currency, Config.MayorOptions.funds.deposit.max))
      TriggerClientEvent('ap-government:client:depositfunds', Player.PlayerData.source, v)  
    else
      if db[1] then
        local data = json.decode(db[1].settings)
        data["funds"] = (data["funds"] + tonumber(amount))
        MySQL.Sync.execute("UPDATE ap_dlcsettings SET settings = @settings WHERE script = @script", {
          ['@settings'] = json.encode(data),
          ['@script'] = "ap_voting"
        })
        TriggerClientEvent('ap-government:notify', Player.PlayerData.source, LangServer[Config.Language].notifications['sortfunds_eight']:format(currency, amount))
        Player.Functions.RemoveMoney('bank', tonumber(amount))
      end   
    end   
  end
end)

QBCore.Functions.CreateCallback('ap-government:callback:players',function(source, cb)
  local xPlayers = QBCore.Functions.GetPlayers()
	local players  = {}
  local mainPed = GetPlayerPed(source)
	for i=1, #xPlayers, 1 do
		local xPlayer = QBCore.Functions.GetPlayer(xPlayers[i])
    local ped = GetPlayerPed(xPlayer.PlayerData.source)
    if #(GetEntityCoords(mainPed) - GetEntityCoords(ped)) <= 5 then
      table.insert(players, {
        source     = xPlayer.PlayerData.source,
        identifier = xPlayer.PlayerData.citizenid,
        name       = xPlayer.PlayerData.charinfo.firstname .. " " .. xPlayer.PlayerData.charinfo.lastname,
        isBoss     = xPlayer.PlayerData.job.isboss,
        job_label  = xPlayer.PlayerData.job.label,
        job_name   = xPlayer.PlayerData.job.name
      })
    end
  end
  cb(players) 
end)

RegisterServerEvent('ap-government:server:verifyPin')
AddEventHandler('ap-government:server:verifyPin', function(pin, v)
  local Player = QBCore.Functions.GetPlayer(source)
  TriggerClientEvent('ap-government:notify', Player.PlayerData.source, LangServer[Config.Language].notifications['verifyPin']:format(v.name))
  PhoneNotify(v.identifier, phs['MAIL']['verify_player']['title'], phs['MAIL']['verify_player']['msg'], phs['MAIL']['verify_player']['sender'], phs['MAIL']['verify_player']['subject'], phs['MAIL']['verify_player']['image'], phs['MAIL']['verify_player']['mail']:format(v.name, pin), phs['MAIL']['verify_player']['button'], phs['MAIL']['verify_player']['email'], phs['MAIL']['verify_player']['photo'], phs['MAIL']['verify_player']['photoattachment'])
  TriggerClientEvent('ap-government:client:securitychecks', Player.PlayerData.source, pin, v)
end)

RegisterServerEvent('ap-government:server:registerplayercompany')
AddEventHandler('ap-government:server:registerplayercompany', function(v)
  local Player = QBCore.Functions.GetPlayer(source)
  local registerd_Name = checkGovJob(v)
  local isName = registerd_Name
  if Player then
    TriggerClientEvent('ap-government:notify', Player.PlayerData.source, LangServer[Config.Language].notifications['registerplayercompany']:format(v.job_label))
  end
  MySQL.Async.execute('INSERT INTO ap_tax (business, label, owner, base_tax) VALUES (@business, @label, @owner, @base_tax)', {
    ['@business'] = v.job_name,
    ['@label'] = v.job_label,
    ['@owner'] = registerd_Name, 
    ['@base_tax'] = tonumber(Config.BusinessTax.tax.basicAmount),
  })
  if registerd_Name ~= "Government Owned" or registerd_Name ~= "COMPANY OWNER" then 
    PhoneNotify(v.identifier, phs['MAIL']['registerd_company']['title'], phs['MAIL']['registerd_company']['msg'], phs['MAIL']['registerd_company']['sender'], phs['MAIL']['registerd_company']['subject'], phs['MAIL']['registerd_company']['image'], phs['MAIL']['registerd_company']['mail']:format(v.name, v.job_label), phs['MAIL']['registerd_company']['button'], phs['MAIL']['registerd_company']['email'], phs['MAIL']['registerd_company']['photo'], phs['MAIL']['registerd_company']['photoattachment'])
    isName = getName(registerd_Name)
  end
  if Config.DiscordWebhook.CompanyRegisterd then
    sendLogsDiscord(webhookMsg['CompanyRegisterd']['title'], webhookMsg['CompanyRegisterd']['message']:format(v.job_label, isName, getName(Player.PlayerData.citizenid), tostring(os.date("%c"))), "CompanyRegisterdWebhook")
  end
end)

checkGovJob = function(v)
  for i, e in pairs(Config.GovernmentJobs) do
    if e == v.job_name then
      return "Government Owned"
    else
      return v.identifier
    end
  end
end

QBCore.Functions.CreateCallback('ap-government:callback:checkifregisterd',function(source, cb, v)
  local result = MySQL.Sync.fetchAll('SELECT * FROM `ap_tax` WHERE business = @business', {['@business'] = v.job_name})
  if result[1] then
    cb(true)
  else
    cb(false)
  end
end)

QBCore.Functions.CreateCallback('ap-government:callback:checkifcanstart',function(source, cb, v)
  MySQL.Async.fetchAll('SELECT * FROM ap_voting', {}, function(results) 
    if #results > 0 then
      cb(false)
    else
      cb(true)
    end
  end)
end)

RegisterServerEvent('ap-government:server:transferplayercompany')
AddEventHandler('ap-government:server:transferplayercompany', function(v)
  local Player = QBCore.Functions.GetPlayer(source)
  local result = MySQL.Sync.fetchAll('SELECT * FROM `ap_tax` WHERE business = @business', {['@business'] = v.job_name})
  if result[1].owner ~= "Government Owned" then
    if Player then
      TriggerClientEvent('ap-government:notify', Player.PlayerData.source, LangServer[Config.Language].notifications['transferplayercompany_one']:format(v.job_label, v.name))
      TriggerClientEvent('ap-government:client:registerplayercompany', Player.PlayerData.source, v)
    end
    PhoneNotify(result[1].owner, phs['MAIL']['transfer_company']['title'], phs['MAIL']['transfer_company']['msg'], phs['MAIL']['transfer_company']['sender'], phs['MAIL']['transfer_company']['subject'], phs['MAIL']['transfer_company']['image'], phs['MAIL']['transfer_company']['mail']:format(getName(result[1].owner), v.job_label, v.name), phs['MAIL']['transfer_company']['button'], phs['MAIL']['transfer_company']['email'], phs['MAIL']['transfer_company']['photo'], phs['MAIL']['transfer_company']['photoattachment'])
    MySQL.Sync.execute("UPDATE ap_tax SET owner = @owner WHERE business = @business", {
      ['@owner'] = v.identifier,
      ['@business'] = v.job_name
    })
  else
    TriggerClientEvent('ap-government:notify', Player.PlayerData.source, LangServer[Config.Language].notifications['transferplayercompany_two'])
  end
end)

RegisterServerEvent('ap-government:server:changeplayercompanytax')
AddEventHandler('ap-government:server:changeplayercompanytax', function(amount, prevAmount, v)
  local Player = QBCore.Functions.GetPlayer(source)  
  if tonumber(amount) > tonumber(Config.BusinessTax.tax.mayorControl.amounts.max) then
    TriggerClientEvent('ap-government:notify', Player.PlayerData.source, LangServer[Config.Language].notifications['changeplayercompanytax_one'])
    TriggerClientEvent('ap-government:client:registerplayercompany', Player.PlayerData.source, v)
  elseif tonumber(amount) < tonumber(Config.BusinessTax.tax.mayorControl.amounts.min) then
    TriggerClientEvent('ap-government:notify', Player.PlayerData.source, LangServer[Config.Language].notifications['changeplayercompanytax_two'])
    TriggerClientEvent('ap-government:client:registerplayercompany', Player.PlayerData.source, v)
  else
    PhoneNotify(v.identifier, phs['MAIL']['company_tax_change']['title'], phs['MAIL']['company_tax_change']['msg'], phs['MAIL']['company_tax_change']['sender'], phs['MAIL']['company_tax_change']['subject'], phs['MAIL']['company_tax_change']['image'], phs['MAIL']['company_tax_change']['mail']:format(v.name, prevAmount, amount, v.job_label), phs['MAIL']['company_tax_change']['button'], phs['MAIL']['company_tax_change']['email'], phs['MAIL']['company_tax_change']['photo'], phs['MAIL']['company_tax_change']['photoattachment'])
    MySQL.Sync.execute("UPDATE ap_tax SET base_tax = @base_tax WHERE business = @business", {
      ['@base_tax'] = tonumber(amount),
      ['@business'] = v.job_name
    })
    TriggerClientEvent('ap-government:notify', Player.PlayerData.source, LangServer[Config.Language].notifications['changeplayercompanytax_three']:format(prevAmount, amount))
    TriggerClientEvent('ap-government:client:registerplayercompany', Player.PlayerData.source, v)
    if Config.DiscordWebhook.MayorTaxChange then
      sendLogsDiscord(webhookMsg['MayorTaxChange']['title'], webhookMsg['MayorTaxChange']['message']:format(v.job_label, currency, prevAmount, currency, amount, getName(v.identifier), getName(Player.PlayerData.citizenid)), "MayorTaxChangeWebhook")
    end
  end
end)

QBCore.Functions.CreateCallback('ap-government:callback:getBusinessAccount',function(source, cb, job)
  local result = MySQL.Sync.fetchAll('SELECT * FROM `ap_tax` WHERE business = @business', {['@business'] = job})
  cb(result[1].base_tax)
end)

RegisterServerEvent('ap-government:server:messageOwner')
AddEventHandler('ap-government:server:messageOwner', function(v, warnTxt)
  local Player = QBCore.Functions.GetPlayer(source)
  local tPlayer = QBCore.Functions.GetPlayerByCitizenId(v.owner)
  if tPlayer then
    TriggerClientEvent('ap-government:notify', Player.PlayerData.source, LangServer[Config.Language].notifications['messageOwner'])
  end
  PhoneNotify(v.owner, phs['MAIL']['message_company_owner']['title'], phs['MAIL']['message_company_owner']['msg'], phs['MAIL']['message_company_owner']['sender'], phs['MAIL']['message_company_owner']['subject'], phs['MAIL']['message_company_owner']['image'], phs['MAIL']['message_company_owner']['mail']:format(getName(v.owner), warnTxt), phs['MAIL']['message_company_owner']['button'], phs['MAIL']['message_company_owner']['email'], phs['MAIL']['message_company_owner']['photo'], phs['MAIL']['message_company_owner']['photoattachment'])
end)

RegisterServerEvent('ap-government:server:appointmentData')
AddEventHandler('ap-government:server:appointmentData', function()
  local xPlayer = QBCore.Functions.GetPlayer(source)
  MySQL.Async.fetchAll('SELECT * FROM ap_appointments WHERE identifier = @identifier', {['@identifier'] = xPlayer.PlayerData.citizenid}, function(app)
    if app[1] then
      TriggerClientEvent("ap-government:client:appointments", xPlayer.PlayerData.source, app[1])
    else
      MySQL.Async.execute('INSERT INTO ap_appointments (identifier, name, type, state) VALUES (@identifier, @name, @type, @state)', {
        ['@identifier'] = xPlayer.PlayerData.citizenid,
        ['@name'] = getName(xPlayer.PlayerData.citizenid),
        ['@type'] = tostring('mayor'), 
        ['@state'] = 0,
      })
      TriggerClientEvent("ap-government:client:appointments", xPlayer.PlayerData.source, {identifier = xPlayer.PlayerData.citizenid, name = getName(xPlayer.PlayerData.citizenid), type = "mayor", state = 0})
    end
  end)
end)

RegisterServerEvent('ap-government:server:submitAppointment')
AddEventHandler('ap-government:server:submitAppointment', function(reason, v)
  local xPlayer = QBCore.Functions.GetPlayer(source)
  local oldData = {
    date = tostring("None"),
    reason = tostring(reason)
  }
  MySQL.Sync.execute("UPDATE ap_appointments SET appData = @appData, state = @state WHERE identifier = @identifier", {
    ['@appData'] = json.encode(oldData),
    ['@state'] = 1,
    ['@identifier'] = xPlayer.PlayerData.citizenid
  })
  TriggerClientEvent('ap-government:notify', xPlayer.PlayerData.source, LangServer[Config.Language].notifications['submitAppointment'])
  if Config.DiscordWebhook.AppointmentRequest then
    sendLogsDiscord(webhookMsg['AppointmentRequest']['title'], webhookMsg['AppointmentRequest']['message']:format(getName(xPlayer.PlayerData.citizenid), reason, tostring(os.date("%c"))), "AppointmentRequestWebhook")
  end
  TriggerClientEvent("ap-government:client:passEvent", xPlayer.PlayerData.source)
end)

RegisterServerEvent('ap-government:server:cancelAppointment')
AddEventHandler('ap-government:server:cancelAppointment', function(v)
  local xPlayer = QBCore.Functions.GetPlayer(source)
  MySQL.Async.execute('DELETE FROM ap_appointments WHERE id = @id', {["@id"] = v.id}) 
  TriggerClientEvent('ap-government:notify', xPlayer.PlayerData.source, LangServer[Config.Language].notifications['cancelAppointment'])
end)

RegisterServerEvent('ap-government:server:mayorCancelAppointment')
AddEventHandler('ap-government:server:mayorCancelAppointment', function(v)
  local xPlayer = QBCore.Functions.GetPlayer(source)
  MySQL.Async.execute('DELETE FROM ap_appointments WHERE id = @id', {["@id"] = v.id}) 
  TriggerClientEvent('ap-government:notify', xPlayer.PlayerData.source, LangServer[Config.Language].notifications['mayorCancelAppointment']:format(v.name))
end)

RegisterServerEvent('ap-government:server:issueAppointment')
AddEventHandler('ap-government:server:issueAppointment', function(datetime, v)
  local xPlayer = QBCore.Functions.GetPlayer(source)
  local result = MySQL.Sync.fetchAll('SELECT * FROM `ap_appointments` WHERE id = @id', {['@id'] = v.id})
  if result[1] then
    local data = json.decode(result[1].appData)
    data["date"] = tostring(datetime)
    MySQL.Sync.execute("UPDATE ap_appointments SET appData = @appData, state = @state WHERE id = @id", {
      ['@appData'] = json.encode(data),
      ['@state'] = 2,
      ['@id'] = v.id,
    })
    PhoneNotify(v.identifier, phs['MAIL']['arrange_appointment']['title'], phs['MAIL']['arrange_appointment']['msg'], phs['MAIL']['arrange_appointment']['sender'], phs['MAIL']['arrange_appointment']['subject'], phs['MAIL']['arrange_appointment']['image'], phs['MAIL']['arrange_appointment']['mail']:format(getName(v.identifier), datetime), phs['MAIL']['arrange_appointment']['button'], phs['MAIL']['arrange_appointment']['email'], phs['MAIL']['arrange_appointment']['photo'], phs['MAIL']['arrange_appointment']['photoattachment'])
    if Config.DiscordWebhook.AppointmentApprove then
      sendLogsDiscord(webhookMsg['AppointmentApprove']['title'], webhookMsg['AppointmentApprove']['message']:format(getName(v.identifier), getName(xPlayer.PlayerData.citizenid), data["reason"], tostring(datetime)), "AppointmentApproveWebhook")
    end
    TriggerClientEvent('ap-government:notify', xPlayer.PlayerData.source, LangServer[Config.Language].notifications['issueAppointment']:format(getName(v.identifier), datetime))
    TriggerClientEvent('ap-government:client:appointmentsManage', xPlayer.PlayerData.source)
  end
end)

RegisterServerEvent('ap-government:server:finishAppointment')
AddEventHandler('ap-government:server:finishAppointment', function(v)
  local xPlayer = QBCore.Functions.GetPlayer(source)
  MySQL.Async.execute('DELETE FROM ap_appointments WHERE id = @id', {["@id"] = v.id}) 
  TriggerClientEvent('ap-government:notify', xPlayer.PlayerData.source, LangServer[Config.Language].notifications['finishAppointment'])
end)

TaxAmounts = function(type)
  local c = Config.Tax.MayorControl.TaxTypes
  if c[type] then
    if c[type].mayorControl then
      local data = MySQL.Sync.fetchAll('SELECT * FROM `ap_dlcsettings` WHERE script = @script', {['@script'] = "ap_voting"})
      if data[1] then
        local newData = json.decode(data[1].other)
        if newData[type] then
          return tonumber(newData[type])
        else
          return 0
        end
      else
        return 0
      end
    else
      return tonumber(c[type].percentage)
    end
  else
    return 0
  end
end

AddToCityhallFunds = function(tax, amount)
  local c = Config.Tax.MayorControl.TaxTypes
  if c[tax] then
    if c[tax].AddCityHallFunds then
      manageFunds("Add", tonumber(amount))
    end
  end
end

RegisterServerEvent('ap-government:server:issueGrant')
AddEventHandler('ap-government:server:issueGrant', function(v, funds, reason, amount)
  local xPlayer = QBCore.Functions.GetPlayer(source)
  local tPlayer = QBCore.Functions.GetPlayerByCitizenId(v.source)
  if tonumber(amount) > tonumber(funds) then
    TriggerClientEvent('ap-government:notify', xPlayer.PlayerData.source, LangServer[Config.Language].notifications['issueGrant_one'])
  elseif tonumber(amount) < tonumber(Config.MayorOptions.funds.grants.min) or tonumber(amount) > tonumber(Config.MayorOptions.funds.grants.max) then
    TriggerClientEvent('ap-government:notify', xPlayer.PlayerData.source, LangServer[Config.Language].notifications['issueGrant_two']:format(currency, tonumber(Config.MayorOptions.funds.grants.min), currency, tonumber(Config.MayorOptions.funds.grants.max)))
  else
    local result = MySQL.Sync.fetchAll('SELECT * FROM `ap_tax` WHERE business = @business', {['@business'] = v.job_name})
    if result[1].grants ~= "nil" then
      local data = json.decode(result[1].grants)
      table.insert(data, {
        main = reason,
        date = os.date("%x"),
        amount = amount
      })
      MySQL.Sync.execute("UPDATE ap_tax SET grants = @grants WHERE business = @business", {
        ['@grants'] = json.encode(data),
        ['@business'] = v.job_name
      })
      AddAccountMoney(v.job_name, amount)
      manageFunds("Remove", amount)
      TriggerClientEvent('ap-government:notify', xPlayer.PlayerData.source, LangServer[Config.Language].notifications['issueGrant_three']:format(currency, amount, v.job_label))
      PhoneNotify(v.identifier, phs['MAIL']['company_grant']['title'], phs['MAIL']['company_grant']['msg'], phs['MAIL']['company_grant']['sender'], phs['MAIL']['company_grant']['subject'], phs['MAIL']['company_grant']['image'], phs['MAIL']['company_grant']['mail']:format(getName(v.identifier), amount, reason), phs['MAIL']['company_grant']['button'], phs['MAIL']['company_grant']['email'], phs['MAIL']['company_grant']['photo'], phs['MAIL']['company_grant']['photoattachment'])
      if Config.DiscordWebhook.CompanyGrantGiven then
        sendLogsDiscord(webhookMsg['CompanyGrantGiven']['title']:format(v.job_label), webhookMsg['CompanyGrantGiven']['message']:format(reason, currency, amount, tostring(os.date("%c")), getName(v.identifier), getName(xPlayer.PlayerData.citizenid)), "CompanyGrantGivenWebhook")
      end
    else
      local newData = {}
      table.insert(newData, {main = reason, date = os.date("%x"), amount = amount})
      MySQL.Sync.execute("UPDATE ap_tax SET grants = @grants WHERE business = @business", {
        ['@grants'] = json.encode(newData),
        ['@business'] = v.job_name
      })
      AddAccountMoney(v.job_name, amount)
      manageFunds("Remove", amount)
      TriggerClientEvent('ap-government:notify', xPlayer.PlayerData.source, LangServer[Config.Language].notifications['issueGrant_four']:format(currency, amount, v.job_label))
      PhoneNotify(v.identifier, phs['MAIL']['company_grant']['title'], phs['MAIL']['company_grant']['msg'], phs['MAIL']['company_grant']['sender'], phs['MAIL']['company_grant']['subject'], phs['MAIL']['company_grant']['image'], phs['MAIL']['company_grant']['mail']:format(getName(v.identifier), amount, reason), phs['MAIL']['company_grant']['button'], phs['MAIL']['company_grant']['email'], phs['MAIL']['company_grant']['photo'], phs['MAIL']['company_grant']['photoattachment'])
      if Config.DiscordWebhook.CompanyGrantGiven then
        sendLogsDiscord(webhookMsg['CompanyGrantGiven']['title']:format(v.job_label), webhookMsg['CompanyGrantGiven']['message']:format(reason, currency, amount, tostring(os.date("%c")), getName(v.identifier), getName(xPlayer.PlayerData.citizenid)), "CompanyGrantGivenWebhook")
      end
    end
  end
end)

--------------------------------------------------------------------------------------------------------------------------------------------------

RegisterNetEvent('ap-government:server:SetBounty', function(data)
  local cfgDirk = Config.Dirk_BountyHunterV2.Option
  local Player = QBCore.Functions.GetPlayer(source)
  local AmountOwed = 0
  if Player then
    if cfgDirk.CompanySafety then AmountOwed = -cfgDirk.SafetyBufferAmount end
    MySQL.Sync.execute("UPDATE ap_tax SET amount_owed = @amount_owed, total_tax_paid = @total_tax_paid WHERE business = @business", {
      ['@amount_owed'] = AmountOwed,
      ['@total_tax_paid'] = (data.CompanyTotalPaid + data.OutstandingTax),
      ['@business'] = data.CompanyID
    })
    manageFunds("Remove", data.BountyAmount)
    TriggerClientEvent('ap-government:notify', Player.PlayerData.source, LangServer[Config.Language].notifications['BountySet']:format(data.CompanyOwnerName))
    PhoneNotify(data.CompanyOwnerID, phs['MAIL']['bounty_issued']['title'], phs['MAIL']['bounty_issued']['msg'], phs['MAIL']['bounty_issued']['sender'], phs['MAIL']['bounty_issued']['subject'], phs['MAIL']['bounty_issued']['image'], phs['MAIL']['bounty_issued']['mail']:format(data.CompanyOwnerName, data.OutstandingTax), phs['MAIL']['bounty_issued']['button'], phs['MAIL']['bounty_issued']['email'], phs['MAIL']['bounty_issued']['photo'], phs['MAIL']['bounty_issued']['photoattachment'])
    TriggerClientEvent('ap-government:client:taxAccounts', Player.PlayerData.source)
  end
end)

QBCore.Functions.CreateCallback('ap-government:getManagementData', function(source, cb)
  local VotingData = {candidates = {}}
  local SettingsData = MySQL.Sync.fetchAll('SELECT * FROM `ap_dlcsettings` WHERE script = @script', {['@script'] = "ap_voting"})
  local VotingSettings = json.decode(SettingsData[1].settings)
  VotingData.settings = {
    votingState = tonumber(VotingSettings.voteState),
    votingType = tonumber(VotingSettings.currentType),
    time = tonumber(VotingSettings.time),
    endDate = tostring(VotingSettings.endDate)
  }

  local CandidateData = MySQL.Sync.fetchAll('SELECT * FROM `ap_voting`',{})
  for k, v in pairs(CandidateData) do
    table.insert(VotingData.candidates, {
      id = v.id, identifier = v.identifier, name = v.name, age = v.age, description = v.shortDescription, q1 = v.whyDoYouWantToBeACandidate, q2 = v.WhatYoullBringToTheCity, isDenied = v.denied, votes = v.votes, state = v.state 
    })
  end
  cb(VotingData)
end)

QBCore.Functions.CreateCallback('ap-government:getPassedLawData', function(source, cb)
  
  local laws = {}
  local result = MySQL.Sync.fetchAll('SELECT * FROM `ap_lawvoting`', {})

  for k, v in pairs(result) do
    if v.state == 1 then
      table.insert(laws, {
        id = tonumber(v.id), name = v.name, description = v.description, fors = tonumber(v.fors), against = tonumber(v.against), date = CalcalateTime(v.date), storage = hasPlayerVoted(json.decode(v.storage), source), state = v.state 
      })
    end
  end

  local isStaff = false
  if QBCore.Functions.HasPermission(source, Config.VotingSettings.Staff.rank) then isStaff = true end

  cb({laws = laws, staff = isStaff})
end)

RegisterNetEvent('ap-government:server:removePassedLaw', function(data)
  local Player = QBCore.Functions.GetPlayer(source)
  MySQL.Async.execute('DELETE FROM ap_lawvoting WHERE id = @id', {["@id"] = data.id})
  TriggerClientEvent('ap-government:notify', Player.PlayerData.source, LangServer[Config.Language].notifications['removedPassedLaw']:format(data.name))
  if Config.DiscordWebhook.LawRemoved then
    sendLogsDiscord(webhookMsg['LawRemoved']['title']:format(data.name), webhookMsg['LawRemoved']['message']:format(getName(Player.PlayerData.citizenid), data.name), "LawRemovedWebhook")
  end
end)

QBCore.Functions.CreateCallback('ap-government:getJsonLawData',function(source, cb)
  local result = MySQL.Sync.fetchAll('SELECT * FROM `ap_lawvoting`', {})
  local laws = {}
  for k, v in pairs(result) do
    table.insert(laws, {
      id = tonumber(v.id), name = v.name, description = v.description, fors = tonumber(v.fors), against = tonumber(v.against), date = CalcalateTime(v.date), storage = hasPlayerVoted(json.decode(v.storage), source), state = v.state 
    })
  end
  cb(laws)
end)

RegisterNetEvent('ap-government:server:updateLawVoting', function(data)
 local Player = QBCore.Functions.GetPlayer(source)
 if Player and data.id then
  local VotedPlayers = GetPlayersFromVotingID(data.id)
  if VotedPlayers then
    table.insert(VotedPlayers, Player.PlayerData.citizenid)
    ChangePlayersFromVotingID(data.id, VotedPlayers)
    local VotingUpdate = UpdateVotingDB(Player, data)
    TriggerClientEvent('ap-government:notify', Player.PlayerData.source, VotingUpdate)
  end
 end
end)

RegisterNetEvent('ap-government:server:createLaw', function(data)
  local Player = QBCore.Functions.GetPlayer(source)
  if data and Player then
    local NewLaw = CreateNewLaw(data)
    if NewLaw then
      TriggerClientEvent('ap-government:notify', Player.PlayerData.source, LangServer[Config.Language].notifications['newLawVoting']:format(data.name, CalcalateTime(data.time)))
      if Config.DiscordWebhook.NewLaw then
        sendLogsDiscord(webhookMsg['NewLaw']['title']:format(data.name), webhookMsg['NewLaw']['message']:format(data.name, data.description, tostring(os.date("%c"))), "NewLawWebhook")
      end
    end
  end
end)

UpdateVotingDB = function(Player, data)
  local VotingData = GetVotingData(data.id)
  local NotiforcationString = ''
  if data.type == 'fors' then
    MySQL.Sync.execute("UPDATE ap_lawvoting SET fors = @fors WHERE id = @id", {
      ['@fors'] = (VotingData.fors + 1),
      ['@id'] = data.id,
    })
    NotiforcationString = LangServer[Config.Language].notifications['updateVotingDB_one']:format(data.name)
  elseif data.type == 'against' then
    MySQL.Sync.execute("UPDATE ap_lawvoting SET against = @against WHERE id = @id", {
      ['@against'] = (VotingData.against + 1),
      ['@id'] = data.id,
    })
    NotiforcationString = LangServer[Config.Language].notifications['updateVotingDB_two']:format(data.name)
  end
  return NotiforcationString
end

CreateNewLaw = function(data)
  MySQL.Async.execute('INSERT INTO ap_lawvoting (name, description, fors, against, date, storage, state) VALUES (@name, @description, @fors, @against, @date, @storage, @state)', {
    ['@name'] = data.name,
    ['@description'] = data.description,
    ['@fors'] = 0,
    ['@against'] = 0, 
    ['@date'] = data.time, 
    ['@storage'] = '{}', 
    ['@state'] = 0,
  })
  return true
end

GetVotingData = function(id)
  local result = MySQL.Sync.fetchAll('SELECT * FROM `ap_lawvoting` WHERE id = @id', {['@id'] = id})
  if result[1] then
    return result[1]
  end
end

GetPlayersFromVotingID = function(id)
  local result = MySQL.Sync.fetchAll('SELECT * FROM `ap_lawvoting` WHERE id = @id', {['@id'] = id})
  if result[1] then
    return json.decode(result[1].storage)
  end
end

ChangePlayersFromVotingID = function(id, data)
  MySQL.Sync.execute("UPDATE ap_lawvoting SET storage = @storage WHERE id = @id", {
    ['@storage'] = json.encode(data),
    ['@id'] = id,
  })
end

hasPlayerVoted = function(data, src)
  local Player = QBCore.Functions.GetPlayer(src)
  local hasVoted = false
  if Player then
    for k,v in pairs(data) do
      if v == Player.PlayerData.citizenid then
        hasVoted = true
      end
    end
    return hasVoted
  end
end

UpdateVotingTimer = function(id, time)
  MySQL.Sync.execute("UPDATE ap_lawvoting SET date = @date WHERE id = @id", {
    ['@date'] = (time - 1),
    ['@id'] = id,
  })
end

GetVotingSettings = function()
  local SettingsData = MySQL.Sync.fetchAll('SELECT * FROM `ap_dlcsettings` WHERE script = @script', {['@script'] = "ap_voting"})
  return json.decode(SettingsData[1].settings)
end

UpdateVotingSettings = function(data)
  MySQL.Sync.execute("UPDATE ap_dlcsettings SET settings = @settings WHERE script = @script", {
    ['@settings'] = json.encode(data),
    ['@script'] = 'ap_voting',
  })
end

ResetIDStorage = function()
  MySQL.Sync.execute("UPDATE ap_dlcsettings SET id_storage = @id_storage WHERE script = @script", {
    ['@id_storage'] = "[]",
    ['@script'] = "ap_voting"
  }) 
end

RegisterNetEvent('ap-government:server:updatevotingState', function(data)
  local Player = QBCore.Functions.GetPlayer(source)
  local GetSettingsData = GetVotingSettings()
  GetSettingsData['voteState'] = data.state
  GetSettingsData['currentType'] = data.type
  UpdateVotingSettings(GetSettingsData)
  if Config.displayVotingChatNotify then
    TriggerClientEvent('chat:addMessage', -1, {
      color = { 0, 0, 255},
      multiline = true,
      args = {'Voting | ', LangServer[Config.Language].notifications['startVoting']}
    })
  else
    TriggerClientEvent('ap-government:notify', -1, LangServer[Config.Language].notifications['startVoting'])
  end
  if Config.DiscordWebhook.CandidateStarted then
    sendLogsDiscord(webhookMsg['CandidateStarted']['title']:format(Config.Voting[data.type].poll), webhookMsg['CandidateStarted']['message'], "CandidateStartedWebhook")
  end
end)

CalcalateTime = function(minutes)
  local days = math.floor(minutes / 1440)
  local remainingMinutes = minutes % 1440
  local hours = math.floor(remainingMinutes / 60)
  local remainingSeconds = remainingMinutes % 60
  return LangServer[Config.Language].notifications['calcalateTime']:format(days, hours, remainingSeconds)
end

RegisterNetEvent('ap-government:server:startVotingPolls', function(data)
  local Player = QBCore.Functions.GetPlayer(source)
  local GetSettingsData = GetVotingSettings()
  GetSettingsData['voteState'] = data.state
  GetSettingsData['currentType'] = data.type
  GetSettingsData['time'] = data.time
  GetSettingsData['endDate'] = CalcalateTime(data.time)
  UpdateVotingSettings(GetSettingsData)
  if Config.displayVotingChatNotify then
    TriggerClientEvent('chat:addMessage', -1, {
      color = { 0, 0, 255},
      multiline = true,
      args = {'Voting | ', LangServer[Config.Language].notifications['enableVoting_one']}
    })
  else
    TriggerClientEvent('ap-government:notify', -1, LangServer[Config.Language].notifications['enableVoting_one'])
  end
  if Config.DiscordWebhook.PollsOpen then
    sendLogsDiscord(webhookMsg['PollsOpen']['title']:format(Config.Voting[data.type].poll), webhookMsg['PollsOpen']['message'], "PollsOpenWebhook")
  end
end)

UpdateWinnerJob = function(identifier, key)
  local xPlayer = QBCore.Functions.GetPlayerByCitizenId(identifier)
  local cfg = Config.Voting[key].givenJob
  if xPlayer then
    xPlayer.Functions.SetJob(cfg.name, cfg.grade)
  else
    local NewJob = QBCore.Shared.Jobs[cfg.name]
    if NewJob then
      local NewJobName, NewJobLabel, NewJobType, NewJobPayment, NewJobIsBoss, NewJobDuty, NewJobGradeName, NewJobGrade = "", "", "", 0, false, false, "", 0
      if cfg.name then NewJobName = cfg.name end
      if NewJob.label then NewJobLabel = NewJob.label end
      if NewJob.type then NewJobType = NewJob.type end
      if NewJob.grades[tostring(cfg.grade)].payment then NewJobPayment = NewJob.grades[tostring(cfg.grade)].payment end
      if NewJob.grades[tostring(cfg.grade)].isboss == true then NewJobIsBoss = true end
      if NewJob.defaultDuty == true then NewJobDuty = true end
      if NewJob.grades[tostring(cfg.grade)].name then NewJobGradeName = NewJob.grades[tostring(cfg.grade)].name end
      if NewJob.grades[tostring(cfg.grade)] then NewJobGrade = cfg.grade end

      local NewJobData = {
        name = NewJobName,
        label = NewJobLabel,
        type = NewJobType,
        payment = NewJobPayment,
        isboss = NewJobIsBoss,
        onduty = NewJobDuty,
        grade = {name = NewJobGradeName, level = NewJobGrade}
      }
      
      MySQL.Sync.execute("UPDATE players SET job = @job WHERE citizenid = @citizenid", {
        ['@job'] = json.encode(NewJobData),
        ['@citizenid'] = identifier,
      })
    end
  end
end

ResetVoting = function()
  local data = GetVotingSettings()
  data['voteState'] = 0
  data['currentType'] = 0
  data['time'] = 0
  data['endDate'] = CalcalateTime(0)
  UpdateVotingSettings(data)
  ResetIDStorage()
  MySQL.Sync.execute('DELETE FROM ap_voting', {})
end

RegisterNetEvent('ap-government:server:terminateVoting', function()
  local settings = MySQL.Sync.fetchAll('SELECT * FROM `ap_dlcsettings` WHERE script = @script', {['@script'] = "ap_voting"})
  local data = json.decode(settings[1].settings)
  if Config.DiscordWebhook.TerminateVoting then
    sendLogsDiscord(webhookMsg['TerminateVoting']['title']:format(Config.Voting[data["currentType"]].poll), webhookMsg['TerminateVoting']['message'], "TerminateVotingWebhook")
  end
  ResetVoting()
  TriggerClientEvent('ap-government:client:setVotingTrue', -1, false)
end)

RegisterNetEvent('ap-government:server:finishVotingNew', function(refreshSettings)
  local candidate = MySQL.Sync.fetchAll('SELECT identifier, name, votes FROM `ap_voting` WHERE votes = ( SELECT MAX(votes) FROM `ap_voting` )', {})
  if candidate[1] then
    local voters = MySQL.Sync.fetchAll('SELECT * FROM `ap_dlcsettings` WHERE script = @script', {['@script'] = "ap_voting"})
    local data = json.decode(voters[1].settings)
    if Config.NotifyWinnerByPhone then
      PhoneNotify(candidate[1].identifier, phs['MAIL']['candidate_winner_new']['title'], phs['MAIL']['candidate_winner_new']['msg'], phs['MAIL']['candidate_winner_new']['sender'], phs['MAIL']['candidate_winner_new']['subject'], phs['MAIL']['candidate_winner_new']['image'], phs['MAIL']['candidate_winner_new']['mail']:format(candidate[1].name, Config.Voting[data["currentType"]].givenJob.label, candidate[1].votes), phs['MAIL']['candidate_winner_new']['button'], phs['MAIL']['candidate_winner_new']['email'], phs['MAIL']['candidate_winner_new']['photo'], phs['MAIL']['candidate_winner_new']['photoattachment'])
    end
    if Config.DiscordWebhook.CandidateWinner then
      sendLogsDiscord(webhookMsg['CandidateWinner']['title']:format(Config.Voting[data["currentType"]].poll), webhookMsg['CandidateWinner']['message']:format(candidate[1].name), "CandidateWinnerWebhook")
    end
    UpdateWinnerJob(candidate[1].identifier, data["currentType"])
    updateVote(0)  
    if voters[1] then
      ResetVoting()
    else
      print("[ERROR] You have not imported the dlc SQL insert, please make sure you add it into your Database.")
    end
    TriggerClientEvent('ap-government:client:setVotingTrue', -1, false)
  end
end)

RegisterNetEvent('ap-government:server:candidateRemoval', function(data)
  local Player = QBCore.Functions.GetPlayer(source)
  if Player then
    TriggerClientEvent('ap-government:notify', Player.PlayerData.source, LangServer[Config.Language].notifications['candidateRemove']:format(data.name))
  end
  MySQL.Async.execute('DELETE FROM ap_voting WHERE identifier = @identifier', {["@identifier"] = data.identifier})
  PhoneNotify(data.identifier, phs['MAIL']['candidate_removal']['title'], phs['MAIL']['candidate_removal']['msg'], phs['MAIL']['candidate_removal']['sender'], phs['MAIL']['candidate_removal']['subject'], phs['MAIL']['candidate_removal']['image'], phs['MAIL']['candidate_removal']['mail']:format(data.name, data.reason), phs['MAIL']['candidate_removal']['button'], phs['MAIL']['candidate_removal']['email'], phs['MAIL']['candidate_removal']['photo'], phs['MAIL']['candidate_removal']['photoattachment'])
end)

RegisterServerEvent('ap-government:server:warnCandidate')
AddEventHandler('ap-government:server:warnCandidate', function(v)
  local Player = QBCore.Functions.GetPlayer(source)
  if Player then
    TriggerClientEvent('ap-government:notify', Player.PlayerData.source, LangServer[Config.Language].notifications['warnCandidateNew']:format(v.name))
  end
  PhoneNotify(v.identifier, phs['MAIL']['candidate_warn']['title'], phs['MAIL']['candidate_warn']['msg'], phs['MAIL']['candidate_warn']['sender'], phs['MAIL']['candidate_warn']['subject'], phs['MAIL']['candidate_warn']['image'], phs['MAIL']['candidate_warn']['mail']:format(v.name, v.reason), phs['MAIL']['candidate_warn']['button'], phs['MAIL']['candidate_warn']['email'], phs['MAIL']['candidate_warn']['photo'], phs['MAIL']['candidate_warn']['photoattachment'])
end)

DeleteLaw = function(v)
  MySQL.Async.execute('DELETE FROM ap_lawvoting WHERE id = @id', {["@id"] = v.id})
  if Config.DiscordWebhook.LawAgainst then
    sendLogsDiscord(webhookMsg['LawAgainst']['title']:format(v.name), webhookMsg['LawAgainst']['message']:format(v.name), "LawAgainstWebhook")
  end
end

UpdateLaw = function(v)
  if v.fors > v.against then
    MySQL.Sync.execute("UPDATE ap_lawvoting SET state = @state WHERE id = @id", {
      ['@state'] = 1,
      ['@id'] = v.id,
    })
    if Config.DiscordWebhook.LawPassed then
      sendLogsDiscord(webhookMsg['LawPassed']['title']:format(v.name), webhookMsg['LawPassed']['message']:format(v.name, v.description, v.fors, v.against), "LawPassedWebhook")
    end
  else
    DeleteLaw(v)
  end
end

VotingLawsTimer = function()
  if Config.VotingLaws then
    MySQL.Async.fetchAll('SELECT * FROM ap_lawvoting', {}, function(lawResults) 
      if #lawResults > 0 then
        for _, law in pairs(lawResults) do
          if law.state == 0 then
            if law.date > 0 then
              UpdateVotingTimer(law.id, law.date)
            else
              UpdateLaw(law)
            end
          end
        end
      end
    end)
  end
  
  MySQL.Async.fetchAll('SELECT * FROM ap_dlcsettings WHERE script = @script', {['@script'] = "ap_voting"}, function(settingsResults)
    if #settingsResults > 0 then
      local SettingsDecode = json.decode(settingsResults[1].settings)
      
      if SettingsDecode and SettingsDecode.voteState >= 2 then
        if SettingsDecode.time > 0 then
          SettingsDecode.time = SettingsDecode.time - 1
          SettingsDecode.endDate = CalcalateTime(SettingsDecode.time)
          
          MySQL.Async.execute("UPDATE ap_dlcsettings SET settings = @settings WHERE script = @script", {
            ['@settings'] = json.encode(SettingsDecode),
            ['@script'] = 'ap_voting',
          })
        else
          TriggerEvent('ap-government:server:finishVotingNew')
        end
      end
    end
  end)
  
  SetTimeout(60 * 1000, VotingLawsTimer)
end

VotingLawsTimer()


----------------------------------------------------------------------------------------------------------------------------------------------------------
--AP CORE--

function formatPercentage(number)
  local percentage = string.format("%.0f%%", number * 100)
  return percentage
end

GetTaxFromDB = function(taxKey)
  local query = string.format('SELECT JSON_UNQUOTE(JSON_EXTRACT(other, "$.%s")) as TaxValue FROM `ap_dlcsettings` WHERE script = @script', taxKey)
  local taxResult = MySQL.Sync.fetchAll(query, {['@script'] = "ap_voting"})
  if taxResult[1] then
    return {tax = taxKey, value = taxResult[1]}
  else
    return {tax = taxKey, value = Config.Tax.MayorControl.TaxTypes[taxKey].percentage}
  end
end

SendTaxToCore = function()
  local TaxConfig = Config.Tax.MayorControl.TaxTypes
  local TaxData = {}
  
  for k,v in pairs(TaxConfig) do
    if v.enable and v.mayorControl then
      local GetTaxFromDB = GetTaxFromDB(k)
      table.insert(TaxData, {
        tax = GetTaxFromDB.tax,
        value = GetTaxFromDB.value.TaxValue,
        percentage = formatPercentage(GetTaxFromDB.value.TaxValue),
        icon = v.icon
      })
    end
    if v.enable and v.mayorControl ~= true then 
      table.insert(TaxData, {
        tax = k,
        value = v.percentage,
        percentage = formatPercentage(v.percentage),
        icon = v.icon
      })
    end
  end

  return TaxData
end

exports('SendTaxToCore', SendTaxToCore)

----------------------------------------------------------------------------------------------------------------------------------------------------------

if Config.VotingSettings.Staff.enable then
  QBCore.Commands.Add(Config.VotingSettings.Staff.Command, LangServer[Config.Language].notifications['staffVotingCommand'], {}, false, function(source)
    TriggerClientEvent('ap-government:client:staffVotingMenu', source)
  end, Config.VotingSettings.Staff.rank)
end

businessTaxPayments()
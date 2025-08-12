QBCore = exports[Config.FrameworkExport]:GetCoreObject()

Citizen.CreateThread(function ()
    if GetResourceState(GetCurrentResourceName()) == 'started' then
      print('[INFO] Join Discord for support and information, https://discord.gg/8Cn3EjfzrM') 
    end
end)

local currency = Config.Currency
local phs = Config.PhoneSettings

RegisterNetEvent('ap-court:getBarStatus')
AddEventHandler('ap-court:getBarStatus', function()
    local xPlayer = QBCore.Functions.GetPlayer(source)
    MySQL.Async.fetchAll("SELECT * FROM ap_bar WHERE owner=@identifier",{['@identifier'] = xPlayer.PlayerData.citizenid}, function(result)
        if result[1] then
          MySQL.Async.execute('UPDATE ap_bar SET job = @job WHERE owner = @owner', { ['@job'] = xPlayer.PlayerData.job.label, ['@owner'] = xPlayer.PlayerData.citizenid })
            TriggerClientEvent('ap-court:barMenu', xPlayer.PlayerData.source)
        else 
            MySQL.Async.execute('INSERT INTO ap_bar (owner, name, mobile, job) VALUES (@owner, @name, @mobile, @job)', {['@owner'] = xPlayer.PlayerData.citizenid, ['@name'] = xPlayer.PlayerData.charinfo.firstname .. ' ' .. xPlayer.PlayerData.charinfo.lastname, ['@job'] = xPlayer.PlayerData.job.label, ['@mobile'] = getMobile(xPlayer.PlayerData.citizenid)})
            TriggerClientEvent('ap-court:barMenu', xPlayer.PlayerData.source)
        end
    end)
end)

QBCore.Functions.CreateCallback('ap-court:getMembers',function(source, cb)
    local xPlayer = QBCore.Functions.GetPlayer(source)
	MySQL.Async.fetchAll('SELECT * FROM ap_bar WHERE owner = @owner', {['@owner'] = xPlayer.PlayerData.citizenid}, function(state)
		cb(state)
	end)
end)

QBCore.Functions.CreateCallback('ap-court:getCitizen',function(source, cb, name) 
    local Matches = {}
	local users = MySQL.Sync.fetchAll('SELECT * FROM `players`', {})
    for index = 1, #users, 1 do
      local CharInfo = json.decode(users[index].charinfo)
      if CharInfo ~= nil then
        local firstname = string.lower(CharInfo.firstname)
        local lastname = string.lower(CharInfo.lastname)
        local fullname = firstname..' '..lastname
        local id = string.lower(users[index].citizenid)
        if string.find(firstname, string.lower(name)) or string.find(lastname, string.lower(name)) or string.find(fullname, string.lower(name)) or string.find(id, string.lower(name)) then
            table.insert(Matches, {
                identifier = users[index].citizenid,
                fullname = CharInfo.firstname .. ' ' .. CharInfo.lastname,
                dateofbirth = CharInfo.birthdate
            })
            cb(Matches)
        end 
      end
    end
end)

QBCore.Functions.CreateCallback('ap-court:getBarMembers',function(source, cb)
	MySQL.Async.fetchAll('SELECT * FROM ap_bar', {}, function(state)
		cb(state)
	end)
end)

RegisterNetEvent('ap-court:barPay')
AddEventHandler('ap-court:barPay', function()
	local xPlayer = QBCore.Functions.GetPlayer(source)
    local price = Config.BarLicensePrice

    if xPlayer ~= nil then
        local bankCount = xPlayer.Functions.GetMoney('bank')
        if bankCount >= Config.BarLicensePrice then
            xPlayer.Functions.RemoveMoney('bank', tonumber(price))
            TriggerClientEvent('ap-court:notify', xPlayer.PlayerData.source, LangServer['bar_pay_notify']:format(currency,tostring(price)))
            TriggerClientEvent('ap-court:startBarTest', xPlayer.PlayerData.source)
        else
            TriggerClientEvent('ap-court:notify', xPlayer.PlayerData.source, LangServer['bar_pay_enougth_money'])
        end
    end
end)

RegisterNetEvent('ap-court:updateState')
AddEventHandler('ap-court:updateState', function(state)
	local xPlayer = QBCore.Functions.GetPlayer(source)
	if xPlayer then
        MySQL.Async.execute('UPDATE ap_bar SET bar_state = @bar_state WHERE owner = @owner', { ['@bar_state'] = state, ['@owner'] = xPlayer.PlayerData.citizenid })
    end
end)

RegisterNetEvent('ap-court:server:updatePlayerRetakeJudge')
AddEventHandler('ap-court:server:updatePlayerRetakeJudge', function(v)
    local xPlayer = QBCore.Functions.GetPlayer(source)
    local tPlayer = QBCore.Functions.GetPlayerByCitizenId(v.owner)
    MySQL.Async.execute('UPDATE ap_bar SET bar_state = @bar_state WHERE owner = @owner', { ['@bar_state'] = 7, ['@owner'] = v.owner })
    TriggerClientEvent('ap-court:notify', xPlayer.PlayerData.source, LangServer['retake_judge_exam_notify_one']:format(v.name))
    GKSPhone(v.owner, phs['GKS-QSR']['bar_exam_retake']['title'], phs['GKS-QSR']['bar_exam_retake']['msg'], phs['GKS-QSR']['bar_exam_retake']['sender'], phs['GKS-QSR']['bar_exam_retake']['subject'], phs['GKS-QSR']['bar_exam_retake']['image'], phs['GKS-QSR']['bar_exam_retake']['mail']:format(v.name), phs['GKS-QSR']['bar_exam_retake']['button'], phs['GKS-QSR']['bar_exam_retake']['email'], phs['GKS-QSR']['bar_exam_retake']['photo'], phs['GKS-QSR']['bar_exam_retake']['photoattachment'])
    if tPlayer then
      TriggerClientEvent('ap-court:notify', tPlayer.PlayerData.source, LangServer['retake_judge_exam_notify_two'])
    end
end)

RegisterNetEvent('ap-court:server:denyBarMembership')
AddEventHandler('ap-court:server:denyBarMembership', function(v, reason)
	local xPlayer = QBCore.Functions.GetPlayer(source)
    MySQL.Async.execute('UPDATE ap_bar SET bar_state = @bar_state, bar_r_reason = @bar_r_reason WHERE owner = @owner', { ['@bar_state'] = 3, ['@bar_r_reason'] = reason, ['@owner'] = v.owner })
    TriggerClientEvent('ap-court:notify', xPlayer.PlayerData.source, LangServer['deny_bar_membership_notify']:format(v.name,reason))
    GKSPhone(v.owner, phs['GKS-QSR']['bar_deny']['title'], phs['GKS-QSR']['bar_deny']['msg'], phs['GKS-QSR']['bar_deny']['sender'], phs['GKS-QSR']['bar_deny']['subject'], phs['GKS-QSR']['bar_deny']['image'], phs['GKS-QSR']['bar_deny']['mail']:format(v.name, reason), phs['GKS-QSR']['bar_deny']['button'], phs['GKS-QSR']['bar_deny']['email'], phs['GKS-QSR']['bar_deny']['photo'], phs['GKS-QSR']['bar_deny']['photoattachment'])
end)

RegisterNetEvent('ap-court:server:issueBarMembership')
AddEventHandler('ap-court:server:issueBarMembership', function(v)
    local xPlayer = QBCore.Functions.GetPlayer(source)
    local date = os.date('%d %B %Y')
    MySQL.Async.execute('UPDATE ap_bar SET bar_id = @bar_id, bar_date = @bar_date, bar_state = @bar_state WHERE owner = @owner', { ['@bar_id'] = idNumber(), ['@bar_date'] = date, ['@bar_state'] = 4, ['@owner'] = v.owner })
    TriggerClientEvent('ap-court:notify', xPlayer.PlayerData.source, LangServer['issue_bar_membership_notify']:format(v.name))
    GKSPhone(v.owner, phs['GKS-QSR']['bar_approve']['title'], phs['GKS-QSR']['bar_approve']['msg'], phs['GKS-QSR']['bar_approve']['sender'], phs['GKS-QSR']['bar_approve']['subject'], phs['GKS-QSR']['bar_approve']['image'], phs['GKS-QSR']['bar_approve']['mail']:format(v.name), phs['GKS-QSR']['bar_approve']['button'], phs['GKS-QSR']['bar_approve']['email'], phs['GKS-QSR']['bar_approve']['photo'], phs['GKS-QSR']['bar_approve']['photoattachment'])
end)

RegisterNetEvent('ap-court:server:arrangeAppointment')
AddEventHandler('ap-court:server:arrangeAppointment', function(reason)
    local xPlayer = QBCore.Functions.GetPlayer(source)
    MySQL.Async.execute('UPDATE ap_bar SET app_state = @app_state, app_reason = @app_reason WHERE owner = @owner', { ['@app_state'] = 1, ['@app_reason'] = reason, ['@owner'] = xPlayer.PlayerData.citizenid })
    TriggerClientEvent('ap-court:notify', xPlayer.PlayerData.source, LangServer['arrange_appointment_notify'])
end)

RegisterNetEvent('ap-court:getAppStatus')
AddEventHandler('ap-court:getAppStatus', function()
    local xPlayer = QBCore.Functions.GetPlayer(source)
    MySQL.Async.fetchAll("SELECT * FROM ap_bar WHERE owner=@identifier",{['@identifier'] = xPlayer.PlayerData.citizenid}, function(result)
        if result[1] then
            MySQL.Async.execute('UPDATE ap_bar SET job = @job WHERE owner = @owner', { ['@job'] = xPlayer.PlayerData.job.label, ['@owner'] = xPlayer.PlayerData.citizenid })
            TriggerClientEvent('ap-court:client:appointments', xPlayer.PlayerData.source)
        else
            MySQL.Async.execute('INSERT INTO ap_bar (owner, name, mobile, job) VALUES (@owner, @name, @mobile, @job)', {['@owner'] = xPlayer.PlayerData.citizenid, ['@name'] = xPlayer.PlayerData.charinfo.firstname .. ' ' .. xPlayer.PlayerData.charinfo.lastname, ['@job'] = xPlayer.PlayerData.job.label, ['@mobile'] = getMobile(xPlayer.PlayerData.citizenid)})
            TriggerClientEvent('ap-court:client:appointments', xPlayer.PlayerData.source)
        end
    end)
end)

RegisterNetEvent('ap-court:server:cancelAppointment')
AddEventHandler('ap-court:server:cancelAppointment', function()
    local xPlayer = QBCore.Functions.GetPlayer(source)
    MySQL.Async.execute('UPDATE ap_bar SET app_state = @app_state, app_reason = @app_reason WHERE owner = @owner', { ['@app_state'] = 0, ['@app_reason'] = 'Reason', ['@owner'] = xPlayer.PlayerData.citizenid })
    TriggerClientEvent('ap-court:notify', xPlayer.PlayerData.source, LangServer['cancel_appointment_notify'])
end)

RegisterNetEvent('ap-court:getJuryStatus')
AddEventHandler('ap-court:getJuryStatus', function()
    local xPlayer = QBCore.Functions.GetPlayer(source)
    MySQL.Async.fetchAll("SELECT * FROM ap_bar WHERE owner=@identifier",{['@identifier'] = xPlayer.PlayerData.citizenid}, function(result)
        if result[1] then
            MySQL.Async.execute('UPDATE ap_bar SET job = @job WHERE owner = @owner', { ['@job'] = xPlayer.PlayerData.job.label, ['@owner'] = xPlayer.PlayerData.citizenid })
            TriggerClientEvent('ap-court:client:juryService', xPlayer.PlayerData.source)
        else
            MySQL.Async.execute('INSERT INTO ap_bar (owner, name, mobile, job) VALUES (@owner, @name, @mobile, @job)', {['@owner'] = xPlayer.PlayerData.citizenid, ['@name'] = xPlayer.PlayerData.charinfo.firstname .. ' ' .. xPlayer.PlayerData.charinfo.lastname, ['@job'] = xPlayer.PlayerData.job.label, ['@mobile'] = getMobile(xPlayer.PlayerData.citizenid)})
            TriggerClientEvent('ap-court:client:juryService', xPlayer.PlayerData.source)
        end
    end)
end)

RegisterNetEvent('ap-court:server:joinJury')
AddEventHandler('ap-court:server:joinJury', function()
    local xPlayer = QBCore.Functions.GetPlayer(source)
    if xPlayer then
        MySQL.Async.execute('UPDATE ap_bar SET jury_state = @jury_state WHERE owner = @owner', { ['@jury_state'] = 1, ['@owner'] = xPlayer.PlayerData.citizenid })
        xPlayer.Functions.AddMoney('bank', Config.JoinJuryPayment)
        TriggerClientEvent('ap-court:notify', xPlayer.PlayerData.source, LangServer['join_jury_notify']:format(currency,Config.JoinJuryPayment))
    end
end)

RegisterNetEvent('ap-court:server:collectPayment', function(data)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)

    if not xPlayer then return end

    local payAmount = tonumber(data.jury_pay) or 0
    if payAmount <= 0 then return end

    xPlayer.Functions.AddMoney('bank', payAmount)

    MySQL.Async.execute([[
        UPDATE ap_bar
        SET jury_state = @jury_state,
            jury_pay = @jury_pay,
            jury_case = @jury_case
        WHERE owner = @owner
    ]], {
        ['@jury_state'] = 1,
        ['@jury_pay'] = 0,
        ['@jury_case'] = 0,
        ['@owner'] = xPlayer.PlayerData.citizenid
    })

    TriggerClientEvent('ap-court:notify', src, LangServer['collect_jury_payment_notify']:format(currency, payAmount))
end)

QBCore.Functions.CreateCallback('ap-court:getCourtCase',function(source, cb)
	MySQL.Async.fetchAll('SELECT * FROM ap_cases', {}, function(check)
		cb(check)
	end)
end)

QBCore.Functions.CreateCallback('ap-court:selectCourtCase',function(source, cb, case)
	MySQL.Async.fetchAll('SELECT * FROM ap_cases WHERE id = @id', {['@id'] = case}, function(check)
		cb(check)
	end)
end)

RegisterNetEvent('ap-court:server:giveVerdict')
AddEventHandler('ap-court:server:giveVerdict', function(member, case, guilty, notGuilty)
    local xPlayer = QBCore.Functions.GetPlayer(source)
    if xPlayer then
        if guilty == "YES" then
            MySQL.Async.execute('UPDATE ap_cases SET guilty = @guilty WHERE id = @id', { 
                ['@guilty'] = case.guilty + 1, 
                ['@id'] = case.id
            })
            MySQL.Async.execute('UPDATE ap_bar SET jury_v_state = @jury_v_state WHERE owner = @owner', { ['@jury_v_state'] = 1, ['@owner'] = xPlayer.PlayerData.citizenid })
            TriggerClientEvent('ap-court:notify', xPlayer.PlayerData.source, LangServer['give_verdict_notify_one'])
        elseif notGuilty == "YES" then
            MySQL.Async.execute('UPDATE ap_cases SET not_guilty = @not_guilty WHERE id = @id', { 
                ['@not_guilty'] = case.not_guilty + 1, 
                ['@id'] = case.id
            })
            MySQL.Async.execute('UPDATE ap_bar SET jury_v_state = @jury_v_state WHERE owner = @owner', { ['@jury_v_state'] = 1, ['@owner'] = xPlayer.PlayerData.citizenid })
            TriggerClientEvent('ap-court:notify', xPlayer.PlayerData.source, LangServer['give_verdict_notify_two'])
        elseif guilty ~= "YES" or notGuilty ~= "YES" then
            TriggerClientEvent('ap-court:notify', xPlayer.PlayerData.source, LangServer['give_verdict_notify_three'])
        end
    end
end)

RegisterNetEvent('ap-court:server:createCourtCase')
AddEventHandler('ap-court:server:createCourtCase', function(casename)
    local xPlayer = QBCore.Functions.GetPlayer(source)
    
    MySQL.Async.insert('INSERT INTO ap_cases (judgeid, judgen, casename) VALUES (@judgeid, @judgen, @casename)', {
        ['@judgeid'] = xPlayer.PlayerData.citizenid,
        ['@judgen'] = getName(xPlayer.PlayerData.citizenid),
        ['@casename'] = casename,
    }, function(insertId)
        TriggerClientEvent('ap-court:notify', xPlayer.PlayerData.source, LangServer['create_court_case_notify']:format(casename))
        TriggerClientEvent('ap-court:client:openCaseMenu', xPlayer.PlayerData.source, insertId)
    end)
end)

getMobile = function(identifier)
    if not identifier then return nil end

    if Config.Phone.RoadPhone then
        local result = MySQL.Sync.fetchAll(
            'SELECT phone_number FROM `players` WHERE citizenid = @citizenid',
            { ['@citizenid'] = identifier }
        )
        return result[1] and result[1].phone_number or nil
    end

    if Config.Phone.LBPhone then
        local number = exports["lb-phone"]:GetEquippedPhoneNumber(identifier)
        if number then return number end
    end

    local result = MySQL.Sync.fetchAll(
        'SELECT charinfo FROM `players` WHERE citizenid = @citizenid',
        { ['@citizenid'] = identifier }
    )

    if result[1] and result[1].charinfo then
        local charinfo = json.decode(result[1].charinfo)
        return charinfo and charinfo.phone or nil
    end

    return nil
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

RegisterNetEvent('ap-court:server:updateCourtDate', function(cc, date, time)
    local playerId = source
    local xPlayer = QBCore.Functions.GetPlayer(playerId)
    if not xPlayer then return end

    local caseId = tonumber(cc and cc.id)
    if not caseId or not date or not time then
        return
    end

    local courtDate = ("%s %s"):format(date, time)

    MySQL.Async.execute(
        'UPDATE ap_cases SET courtdate = @courtdate WHERE id = @id',
        {
            ['@courtdate'] = courtDate,
            ['@id'] = caseId
        },
        function(rowsChanged)
            if rowsChanged > 0 then
                TriggerClientEvent('ap-court:notify', playerId, LangServer['update_court_date_notify']:format(courtDate))
            else
                TriggerClientEvent('ap-court:notify', playerId, "Failed to update court date.")
            end
        end
    )

    TriggerClientEvent('ap-court:client:openCaseMenu', playerId, caseId)
end)


RegisterNetEvent('ap-court:server:updateCourtFee', function(cc, fee)
    local playerId = source
    local xPlayer = QBCore.Functions.GetPlayer(playerId)
    if not xPlayer then return end

    local caseId = tonumber(cc and cc.id)
    local newFee = tonumber(fee)

    if not caseId or not newFee then
        return
    end

    MySQL.Async.execute(
        'UPDATE ap_cases SET courtfees = @courtfees WHERE id = @id',
        { ['@courtfees'] = newFee, ['@id'] = caseId },
        function(rowsChanged)
            if rowsChanged > 0 then
                TriggerClientEvent('ap-court:notify', playerId, LangServer['update_court_fee_notify']:format(currency, newFee))
            else
                TriggerClientEvent('ap-court:notify', playerId, "Court fee update failed. Case not found.")
            end
        end
    )

    if cc.state == 0 then
        TriggerClientEvent('ap-court:client:openCaseMenu', playerId, caseId)
    elseif cc.state == 3 then
        TriggerClientEvent('ap-court:client:openLiveCaseMenu', playerId, caseId)
    end
end)


RegisterNetEvent('ap-court:server:barMemberRemove')
AddEventHandler('ap-court:server:barMemberRemove', function(v, reason)
    local xPlayer = QBCore.Functions.GetPlayer(source)
    MySQL.Async.execute('UPDATE ap_bar SET bar_r_reason = @bar_r_reason, bar_state = @bar_state WHERE owner = @owner', { ['@bar_r_reason'] = reason, ['@bar_state'] = 6, ['@owner'] = v.owner })
    GKSPhone(v.owner, phs['GKS-QSR']['bar_remove']['title'], phs['GKS-QSR']['bar_remove']['msg'], phs['GKS-QSR']['bar_remove']['sender'], phs['GKS-QSR']['bar_remove']['subject'], phs['GKS-QSR']['bar_remove']['image'], phs['GKS-QSR']['bar_remove']['mail']:format(v.name, reason), phs['GKS-QSR']['bar_remove']['button'], phs['GKS-QSR']['bar_remove']['email'], phs['GKS-QSR']['bar_remove']['photo'], phs['GKS-QSR']['bar_remove']['photoattachment'])
    TriggerClientEvent('ap-court:notify', xPlayer.PlayerData.source, LangServer['remove_bar_member_notify']:format(v.name))
end)

RegisterNetEvent('ap-court:server:updateJudge', function(v)
    local xPlayer = QBCore.Functions.GetPlayer(source)
    if not xPlayer then return end

    if v.job == Config.CourtJob then
        MySQL.Async.execute([[
            UPDATE ap_cases 
            SET judgeid = @judgeid, judgen = @judgen 
            WHERE id = @id
        ]], {
            ['@judgeid'] = v.player,
            ['@judgen'] = v.name,
            ['@id'] = v.case
        })

        TriggerClientEvent('ap-court:notify', xPlayer.PlayerData.source, LangServer['update_judge_notify_one']:format(v.name))

        if v.state == 0 then
            TriggerClientEvent('ap-court:client:openCaseMenu', xPlayer.PlayerData.source, v.case)
        elseif v.state == 3 then
            TriggerClientEvent('ap-court:client:openLiveCaseMenu', xPlayer.PlayerData.source, v.case)
        end
    else
        TriggerClientEvent('ap-court:notify', xPlayer.PlayerData.source, LangServer['update_judge_notify_two']:format(v.name))
        TriggerClientEvent('ap-court:client:openCaseMenu', xPlayer.PlayerData.source, v.case)
    end
end)

local function handleParticipantUpdate(participantType, v)
    local xPlayer = QBCore.Functions.GetPlayer(source)
    if not xPlayer then return end

    local fields = {
        defendant = { idField = "defendantid", nameField = "defendantn", langKey = "update_defendent_notify" },
        defense = { idField = "defenseid", nameField = "defensen", langKey = "update_defence_notify" }
    }

    local f = fields[participantType]
    if not f then return end

    MySQL.Async.execute(string.format('UPDATE ap_cases SET %s = @id, %s = @name WHERE id = @caseId', f.idField, f.nameField), {
        ['@id'] = v.player,
        ['@name'] = v.name,
        ['@caseId'] = v.case
    })

    TriggerClientEvent('ap-court:notify', xPlayer.PlayerData.source, LangServer[f.langKey]:format(v.name))

    local mail = phs['GKS-QSR']['court_summons']
    GKSPhone(
        v.player,
        mail.title,
        mail.msg,
        mail.sender,
        mail.subject,
        mail.image,
        mail.mail:format(v.name, v.date, v.casename),
        mail.button,
        mail.email,
        mail.photo,
        mail.photoattachment
    )

    local state = v.menu and v.menu.state
    if state == 0 then
        TriggerClientEvent('ap-court:client:openCaseMenu', xPlayer.PlayerData.source, v.case)
    elseif state == 3 then
        TriggerClientEvent('ap-court:client:openLiveCaseMenu', xPlayer.PlayerData.source, v.case)
    end
end

RegisterNetEvent('ap-court:server:updateDefendent', function(v)
    handleParticipantUpdate("defendant", v)
end)

RegisterNetEvent('ap-court:server:updateDefence', function(v)
    handleParticipantUpdate("defense", v)
end)

RegisterNetEvent('ap-court:server:addJuryCase', function(v)
    local xPlayer = QBCore.Functions.GetPlayer(source)
    if not xPlayer then return end

    MySQL.Async.execute([[
        UPDATE ap_bar 
        SET jury_state = @state, jury_case_date = @date, jury_case = @case 
        WHERE owner = @owner
    ]], {
        ['@state'] = 2,
        ['@date'] = v.date,
        ['@case'] = v.case,
        ['@owner'] = v.player
    })

    TriggerClientEvent('ap-court:notify', xPlayer.PlayerData.source, LangServer['add_jury_notify']:format(v.name))

    GKSPhone(
        v.player,
        phs['GKS-QSR']['jury_summons']['title'],
        phs['GKS-QSR']['jury_summons']['msg'],
        phs['GKS-QSR']['jury_summons']['sender'],
        phs['GKS-QSR']['jury_summons']['subject'],
        phs['GKS-QSR']['jury_summons']['image'],
        phs['GKS-QSR']['jury_summons']['mail']:format(v.name, v.casename, v.date),
        phs['GKS-QSR']['jury_summons']['button'],
        phs['GKS-QSR']['jury_summons']['email'],
        phs['GKS-QSR']['jury_summons']['photo'],
        phs['GKS-QSR']['jury_summons']['photoattachment']
    )

    TriggerClientEvent('ap-court:client:openCaseMenu', xPlayer.PlayerData.source, v.case)
end)

RegisterNetEvent('ap-court:server:removeJuryCase', function(v)
    local xPlayer = QBCore.Functions.GetPlayer(source)
    if not xPlayer then return end

    MySQL.Async.execute([[
        UPDATE ap_bar 
        SET jury_state = @state, jury_case_date = @date, jury_case = @case 
        WHERE owner = @owner
    ]], {
        ['@state'] = 1,
        ['@date'] = 'Court Date',
        ['@case'] = 0,
        ['@owner'] = v.player
    })

    TriggerClientEvent('ap-court:notify', xPlayer.PlayerData.source, LangServer['remove_jury_notify']:format(v.name))

    GKSPhone(
        v.player,
        phs['GKS-QSR']['jury_summons_remove']['title'],
        phs['GKS-QSR']['jury_summons_remove']['msg'],
        phs['GKS-QSR']['jury_summons_remove']['sender'],
        phs['GKS-QSR']['jury_summons_remove']['subject'],
        phs['GKS-QSR']['jury_summons_remove']['image'],
        phs['GKS-QSR']['jury_summons_remove']['mail']:format(v.name, v.menu.casename, v.menu.courtdate),
        phs['GKS-QSR']['jury_summons_remove']['button'],
        phs['GKS-QSR']['jury_summons_remove']['email'],
        phs['GKS-QSR']['jury_summons_remove']['photo'],
        phs['GKS-QSR']['jury_summons_remove']['photoattachment']
    )

    TriggerClientEvent('ap-court:client:openCaseMenu', xPlayer.PlayerData.source, v.case)
end)

RegisterNetEvent('ap-court:server:editListing')
AddEventHandler('ap-court:server:editListing', function(v)
    local xPlayer = QBCore.Functions.GetPlayer(source)
    local statenum, statelabel

    if v.state == 0 then
        statenum, statelabel = 1, LangServer['edit_court_listing_label_one']
    elseif v.state == 1 then
        statenum, statelabel = 0, LangServer['edit_court_listing_label_two']
    end
        
    MySQL.Async.execute('UPDATE ap_cases SET state = @state WHERE id = @id', { ['@state'] = statenum, ['@id'] = v.id })
    TriggerClientEvent('ap-court:notify', xPlayer.PlayerData.source, LangServer['edit_court_listing_notify']:format(statelabel))
    TriggerClientEvent('ap-court:client:openCaseMenu', xPlayer.PlayerData.source, v.id)
end)

RegisterNetEvent('ap-court:server:requestCourtCase')
AddEventHandler('ap-court:server:requestCourtCase', function(job, casename, fee, scheduledDate)
    local xPlayer = QBCore.Functions.GetPlayer(source)
    MySQL.Async.execute('INSERT INTO ap_cases (casename, job_request, courtfees, courtdate, state) VALUES (@casename, @job_request, @courtfees, @courtdate, @state)', {
        ['@casename'] = casename,
        ['@job_request'] = job,
        ['@courtfees'] = fee,
        ['@courtdate'] = scheduledDate,
        ['@state'] = 2,
    })
    TriggerClientEvent('ap-court:notify', xPlayer.PlayerData.source, LangServer['request_court_case_notify']:format(casename))
end)

RegisterNetEvent('ap-court:server:deleteCase', function(v)
    local playerId = source
    local xPlayer = QBCore.Functions.GetPlayer(playerId)
    if not xPlayer then return end

    local caseId = tonumber(v and v.id)
    if not caseId then
        return
    end

    MySQL.Async.execute('DELETE FROM ap_cases WHERE id = @id', {
        ['@id'] = caseId
    }, function(rowsChanged)
        if rowsChanged > 0 then
            TriggerClientEvent('ap-court:notify', playerId, LangServer['delete_court_case_notify'])

            MySQL.Async.fetchAll('SELECT * FROM `ap_bar` WHERE jury_case = @jury_case', {
                ['@jury_case'] = caseId
            }, function(jury)
                if jury and #jury > 0 then
                    MySQL.Async.execute("UPDATE ap_bar SET jury_state = @jury_state, jury_v_state = @jury_v_state WHERE jury_case = @jury_case", {
                        ['@jury_state'] = 1,
                        ['@jury_v_state'] = 0,
                        ['@jury_case'] = caseId
                    })
                end
            end)
        else
            TriggerClientEvent('ap-court:notify', playerId, "Failed to delete court case.")
        end
    end)

    TriggerClientEvent('ap-court:client:caseConfigureMenu', playerId)
end)


RegisterNetEvent('ap-court:server:courtProceedings')
AddEventHandler('ap-court:server:courtProceedings', function(v)
    local xPlayer = QBCore.Functions.GetPlayer(source)
    if v.judgeid ~= 'Judge ID' and v.judgen ~= 'Add To Case' and v.defendantid ~= 'Defendant ID' and v.defendantn ~= 'Add To Case' and v.defenseid ~= 'Defense ID' and v.defensen ~= 'Add To Case' and v.casename ~= 'Case Name' and v.courtfees ~= 0 then
        if v.judgeid == xPlayer.PlayerData.citizenid then
            MySQL.Async.execute('UPDATE ap_cases SET state = @state WHERE id = @id', { ['@state'] = 3, ['@id'] = v.id })
            TriggerClientEvent('ap-court:notify', xPlayer.PlayerData.source, LangServer['court_proceedings_notify_one'])
        else
            TriggerClientEvent('ap-court:notify', xPlayer.PlayerData.source, LangServer['court_proceedings_notify_two'])
            TriggerClientEvent('ap-court:client:editCase', xPlayer.PlayerData.source, v)
        end
    else
        TriggerClientEvent('ap-court:notify', xPlayer.PlayerData.source, LangServer['court_proceedings_notify_three'])
        TriggerClientEvent('ap-court:client:editCase', xPlayer.PlayerData.source, v)
    end
end)

QBCore.Functions.CreateCallback('ap-court:server:getOnlinePlayers', function(source, cb)
    local xPlayers = QBCore.Functions.GetPlayers()
    local players  = {}
    local mainPed = GetPlayerPed(source)
    for i=1, #xPlayers, 1 do
        local xPlayer = QBCore.Functions.GetPlayer(xPlayers[i])
        local ped = GetPlayerPed(xPlayer.PlayerData.source)
        if #(GetEntityCoords(mainPed) - GetEntityCoords(ped)) <= 10 then
            table.insert(players, {
                source     = xPlayer.PlayerData.source,
                identifier = xPlayer.PlayerData.citizenid,
                name       = xPlayer.PlayerData.charinfo.firstname .. ' ' .. xPlayer.PlayerData.charinfo.lastname,
                job = xPlayer.PlayerData.job
            })
        end
    end
    cb(players)
end)

RegisterNetEvent('ap-court:server:showCard')
AddEventHandler('ap-court:server:showCard', function(details)
    local xPlayer = QBCore.Functions.GetPlayer(source)
    for _, e in pairs(details) do
        if e.info.bar_state == 4 or e.info.bar_state == 5 then
            local subText = 'NAME: ~y~'..e.info.name..'~s~\nID# ~y~'..e.info.bar_id..'~s~\nMEMBER SINCE ~y~'..string.upper(e.info.bar_date)..' ~s~'
            TriggerClientEvent('ap-court:notifyLawyerCard', e.tplayer, subText)
        elseif e.info.bar_state == 6 then
            local subText = 'NAME: ~r~'..e.info.name..'~s~\nID# ~r~'..e.info.bar_id..' ~s~\nMEMBER SINCE ~r~'..string.upper(e.info.bar_date)..' ~s~'
            TriggerClientEvent('ap-court:notifyLawyerCard', e.tplayer, subText)
        else
            TriggerClientEvent('ap-court:notify', xPlayer.PlayerData.source, "This card seems to be tampered with.")
        end
    end
end)

RegisterNetEvent('ap-court:server:addRecordArchives')
AddEventHandler('ap-court:server:addRecordArchives', function(identifier, fine, amount)    
    local xPlayer = QBCore.Functions.GetPlayer(source)
    local date = os.date('%Y-%m-%d') 
    MySQL.Async.fetchAll("SELECT * FROM ap_criminalarchives WHERE identifier=@identifier",{['@identifier'] = identifier}, function(result)
        if result[1] then
            local data = json.decode(result[1].data)
            table.insert(data,{fine = fine, amount = amount, date = date})
            MySQL.Sync.execute("UPDATE ap_criminalarchives SET data = @data WHERE identifier = @identifier", {
                ['@data'] = json.encode(data),
                ['@identifier'] = identifier
            })
            TriggerClientEvent('ap-court:notify', xPlayer.PlayerData.source, LangServer['add_record_archives_notify'])
        else
            local data = {}
            table.insert(data,{fine = fine, amount = amount, date = date})
            MySQL.Async.execute('INSERT INTO ap_criminalarchives (identifier, name, data) VALUES (@identifier, @name, @data)', {['@identifier'] = identifier, ['@name'] = getName(identifier), ['@data'] = json.encode(data)})
            TriggerClientEvent('ap-court:notify', xPlayer.PlayerData.source, LangServer['add_record_archives_notify'])
        end
    end)
end)

QBCore.Functions.CreateCallback('ap-court:server:searchArchives',function(source, cb, name, cc)
    local xPlayer = QBCore.Functions.GetPlayer(source)
	MySQL.Async.fetchAll('SELECT * FROM ap_criminalarchives WHERE name = @name', {['@name'] = name}, function(result)
        if result[1] then
            local data = json.decode(result[1].data)
		    cb(data)
        else
          TriggerClientEvent('ap-court:client:criminalRecordArc', xPlayer.PlayerData.source, cc)
          TriggerClientEvent('ap-court:notify', xPlayer.PlayerData.source, LangServer['search_archives_notify'])
        end
	end)
end)

QBCore.Functions.CreateCallback('ap-court:server:isArchives',function(source, cb)
  local xPlayer = QBCore.Functions.GetPlayer(source)
	MySQL.Async.fetchAll('SELECT * FROM ap_criminalarchives WHERE identifier = @identifier', {['@identifier'] = xPlayer.PlayerData.citizenid}, function(result)
    if result[1] then
		  cb(true)
    else
      cb(false)
    end
	end)
end)

idNumber = function()
    local a,b,c,d,e,f,g = math.random(1, 9),math.random(1, 9),math.random(1, 9),math.random(1, 9),math.random(1, 9),math.random(1, 9),math.random(1, 9)
    local issue = ""..a..""..b..""..c..""..d..""..e..""..f..""..g..""
    return issue
end

RegisterNetEvent('ap-court:server:changeJudgeExamQuestions')
AddEventHandler('ap-court:server:changeJudgeExamQuestions', function(sqlID, oldType, menuType, newType)
    local xPlayer = QBCore.Functions.GetPlayer(source) 
    if menuType == "Question" then
        MySQL.Sync.execute("UPDATE ap_judgeexam SET question = @question, last_changed_by = @last_changed_by WHERE id = @id", {
            ['@question'] = newType,
            ['@last_changed_by'] = getName(xPlayer.PlayerData.citizenid),
            ['@id'] = sqlID
        })
        TriggerClientEvent('ap-court:notify', xPlayer.PlayerData.source, menuType.." changed from "..oldType.." to "..newType)
        TriggerClientEvent('ap-court:client:judgeExamQuestions', xPlayer.PlayerData.source)    
    elseif menuType == "Answer A" then
        MySQL.Sync.execute("UPDATE ap_judgeexam SET a = @a, last_changed_by = @last_changed_by WHERE id = @id", {
            ['@a'] = newType,
            ['@last_changed_by'] = getName(xPlayer.PlayerData.citizenid),
            ['@id'] = sqlID
        })
        TriggerClientEvent('ap-court:notify', xPlayer.PlayerData.source, menuType.." changed from "..oldType.." to "..newType)  
        TriggerClientEvent('ap-court:client:judgeExamQuestions', xPlayer.PlayerData.source)  
    elseif menuType == "Answer B" then
        MySQL.Sync.execute("UPDATE ap_judgeexam SET b = @b, last_changed_by = @last_changed_by WHERE id = @id", {
            ['@b'] = newType,
            ['@last_changed_by'] = getName(xPlayer.PlayerData.citizenid),
            ['@id'] = sqlID
        })
        TriggerClientEvent('ap-court:notify', xPlayer.PlayerData.source, menuType.." changed from "..oldType.." to "..newType)
        TriggerClientEvent('ap-court:client:judgeExamQuestions', xPlayer.PlayerData.source) 
    elseif menuType == "Answer C" then
        MySQL.Sync.execute("UPDATE ap_judgeexam SET c = @c, last_changed_by = @last_changed_by WHERE id = @id", {
            ['@c'] = newType,
            ['@last_changed_by'] = getName(xPlayer.PlayerData.citizenid),
            ['@id'] = sqlID
        })
        TriggerClientEvent('ap-court:notify', xPlayer.PlayerData.source, menuType.." changed from "..oldType.." to "..newType)  
        TriggerClientEvent('ap-court:client:judgeExamQuestions', xPlayer.PlayerData.source) 
    elseif menuType == "Answer D" then
        MySQL.Sync.execute("UPDATE ap_judgeexam SET d = @d, last_changed_by = @last_changed_by WHERE id = @id", {
            ['@d'] = newType,
            ['@last_changed_by'] = getName(xPlayer.PlayerData.citizenid),
            ['@id'] = sqlID
        })
        TriggerClientEvent('ap-court:notify', xPlayer.PlayerData.source, menuType.." changed from "..oldType.." to "..newType) 
        TriggerClientEvent('ap-court:client:judgeExamQuestions', xPlayer.PlayerData.source)  
    elseif menuType == "Correct Answer" then
        MySQL.Sync.execute("UPDATE ap_judgeexam SET answer = @answer, last_changed_by = @last_changed_by WHERE id = @id", {
            ['@answer'] = newType,
            ['@last_changed_by'] = getName(xPlayer.PlayerData.citizenid),
            ['@id'] = sqlID
        })
        TriggerClientEvent('ap-court:notify', xPlayer.PlayerData.source, menuType.." changed from "..oldType.." to "..newType)  
        TriggerClientEvent('ap-court:client:judgeExamQuestions', xPlayer.PlayerData.source)  
    end
end) 

QBCore.Functions.CreateCallback('ap-court:getBarQuestionsJudge',function(source, cb)
	MySQL.Async.fetchAll('SELECT * FROM ap_judgeexam', {}, function(check)
		cb(check)
	end)
end)

RegisterNetEvent('ap-court:server:NoShowMenuPayout')
AddEventHandler('ap-court:server:NoShowMenuPayout', function(dataz)
    local xPlayer = QBCore.Functions.GetPlayer(source) 
    local v = dataz.v
    local menuType = dataz.input
    local amount = dataz.amount
    local defenPlayer = QBCore.Functions.GetPlayerByCitizenId(v.defendantid)
    local defensePlayer = QBCore.Functions.GetPlayerByCitizenId(v.defenseid)
    if menuType == "Defendant" then
      if defenPlayer then
        defenPlayer.Functions.RemoveMoney('bank', tonumber(amount))
        TriggerClientEvent('ap-court:notify', defenPlayer.PlayerData.source, LangServer['no_show_menu_payout_notify_one']:format(currency,amount)) 
        TriggerClientEvent('ap-court:notify', xPlayer.PlayerData.source, LangServer['no_show_menu_payout_notify_two'])
      else
        local result = MySQL.Sync.fetchAll('SELECT * FROM `players` WHERE citizenid = @citizenid', {['@citizenid'] = v.defendantid})
        local data = json.decode(result[1].money)
        data["bank"] = (data["bank"] - tonumber(amount))
        MySQL.Sync.execute("UPDATE players SET money = @money WHERE citizenid = @citizenid", {
            ['@money'] = json.encode(data),
            ['@citizenid'] = v.defendantid
        })
        TriggerClientEvent('ap-court:notify', xPlayer.PlayerData.source, LangServer['no_show_menu_payout_notify_three'])
      end
      UpdatePaymentMenu(v.id, 'no_show')
    elseif menuType == "Defense" then
      if defensePlayer then
        defensePlayer.Functions.RemoveMoney('bank', tonumber(amount))
        TriggerClientEvent('ap-court:notify', defensePlayer.PlayerData.source, LangServer['no_show_menu_payout_notify_four']:format(currency,amount)) 
        TriggerClientEvent('ap-court:notify', xPlayer.PlayerData.source, LangServer['no_show_menu_payout_notify_five'])
      else
        local result = MySQL.Sync.fetchAll('SELECT * FROM `players` WHERE citizenid = @citizenid', {['@citizenid'] = v.defenseid})
        local data = json.decode(result[1].money)
        data["bank"] = (data["bank"] - tonumber(amount))
        MySQL.Sync.execute("UPDATE players SET money = @money WHERE citizenid = @citizenid", {
            ['@money'] = json.encode(data),
            ['@citizenid'] = v.defenseid
        })
        TriggerClientEvent('ap-court:notify', xPlayer.PlayerData.source, LangServer['no_show_menu_payout_notify_six'])
      end
      UpdatePaymentMenu(v.id, 'no_show')
    end
end)

removeMoneyOffline = function(identifier, amount)
    local result = MySQL.Sync.fetchAll('SELECT * FROM `players` WHERE citizenid = @citizenid', {['@citizenid'] = identifier})
    local data = json.decode(result[1].money)
    data["bank"] = (data["bank"] - amount)
    MySQL.Sync.execute("UPDATE players SET money = @money WHERE citizenid = @citizenid", {
        ['@money'] = json.encode(data),
        ['@citizenid'] = identifier
    })  
end 

addMoneyOffline = function(identifier, amount)
    local result = MySQL.Sync.fetchAll('SELECT * FROM `players` WHERE citizenid = @citizenid', {['@citizenid'] = identifier})
    local data = json.decode(result[1].money)
    data["bank"] = (data["bank"] + amount)
    MySQL.Sync.execute("UPDATE players SET money = @money WHERE citizenid = @citizenid", {
        ['@money'] = json.encode(data),
        ['@citizenid'] = identifier
    })  
end

RegisterNetEvent('ap-court:server:finishProceedings')
AddEventHandler('ap-court:server:finishProceedings', function(v)
  closeCourtCase(v)
end)

closeCourtCase = function(v)
  local xPlayer = QBCore.Functions.GetPlayer(source)
  local result = MySQL.Sync.fetchAll('SELECT * FROM `ap_cases` WHERE id = @id', {['@id'] = v.id})
  if result[1] ~= nil then
    if Config.DiscordWebhook == true then
      local verdict = nil
      if v.guilty > v.not_guilty then
        verdict = "Guilty"
      else
        verdict = "Not Guilty"
      end
      sendLogsDiscord(webhookMsg['FinishProceedings']['title']:format(v.id), webhookMsg['FinishProceedings']['message']:format(v.casename,v.judgen,v.defendantn,v.defensen,v.courtfees,v.courtdate,verdict), "FinishProceedingsWebhook")
    end
    MySQL.Async.execute('DELETE FROM ap_cases WHERE id = @id', {['@id'] = result[1].id}) 
    TriggerClientEvent('ap-court:notify', xPlayer.PlayerData.source, LangServer['close_court_case_notify'])
    local jury = MySQL.Sync.fetchAll('SELECT * FROM `ap_bar` WHERE jury_case = @jury_case', {['@jury_case'] = v.id})
    if jury[1] then
      MySQL.Sync.execute("UPDATE ap_bar SET jury_state = @jury_state, jury_v_state = @jury_v_state, jury_pay = @jury_pay WHERE jury_case = @jury_case", {
        ['@jury_state'] = 3,
        ['@jury_v_state'] = 0,
        ['@jury_pay'] = Config.JuryCasePayout,
        ['@jury_case'] = v.id
      })  
    end
  end
end

UpdatePaymentMenu = function(id, table)
    if table == 'settlement' then
        MySQL.Sync.execute("UPDATE ap_cases SET settlement_state = @settlement_state WHERE id = @id", {
            ['@settlement_state'] = 1,
            ['@id'] = id
        })
    elseif table == 'no_show' then
        MySQL.Sync.execute("UPDATE ap_cases SET no_show_state = @no_show_state WHERE id = @id", {
            ['@no_show_state'] = 1,
            ['@id'] = id
        })
    end    
end

RegisterNetEvent('ap-court:server:adjournCourtCase')
AddEventHandler('ap-court:server:adjournCourtCase', function(data)
  local xPlayer = QBCore.Functions.GetPlayer(source)
  local id = data.id
  local menuType = data.menuType
  local newDate = data.newDate
  local v = data.disc
  local result = MySQL.Sync.fetchAll('SELECT * FROM `ap_cases` WHERE id = @id', {['@id'] = id})
  if menuType == false then
    if result[1] ~= nil then
      TriggerClientEvent('ap-court:client:adjournCourtTime', xPlayer.PlayerData.source, id, v)
    end
  elseif menuType == true then
    if result[1] ~= nil then
      MySQL.Sync.execute("UPDATE ap_cases SET courtdate = @courtdate, state = @state WHERE id = @id", {
        ['@courtdate'] = newDate,
        ['@state'] = 0,
        ['@id'] = id
      }) 
      TriggerClientEvent('ap-court:notify', xPlayer.PlayerData.source, LangServer['adjourn_court_case_notify'])
      local jury = MySQL.Sync.fetchAll('SELECT * FROM `ap_bar` WHERE jury_case = @jury_case', {['@jury_case'] = id})
      if jury[1] then
        MySQL.Sync.execute("UPDATE ap_bar SET jury_case_date = @jury_case_date WHERE jury_case = @jury_case", {
          ['@jury_case_date'] = newDate,
          ['@jury_case'] = id
        })  
      end
      if Config.DiscordWebhook == true then
        sendLogsDiscord(webhookMsg['AdjournCourt']['title']:format(v.id), webhookMsg['AdjournCourt']['message']:format(v.casename,v.judgen,v.defendantn,v.defensen,v.courtfees,newDate), "AdjournCourtWebhook")
      end
    end
  end
end)

RegisterNetEvent('ap-court:server:payoutsSettlement')
AddEventHandler('ap-court:server:payoutsSettlement', function(b)
    local xPlayer = QBCore.Functions.GetPlayer(source) 
    local menuType = b.input
    local v = b.v
    local amount = tonumber(v.courtfees)

    local defenPlayer = QBCore.Functions.GetPlayerByCitizenId(v.defendantid)
    local defensePlayer = QBCore.Functions.GetPlayerByCitizenId(v.defenseid)

    if menuType == "Defendant" then
      if defenPlayer then
        defenPlayer.Functions.AddMoney('bank', amount)
        TriggerClientEvent('ap-court:notify', defenPlayer.PlayerData.source, LangServer['settlement_payout_notify_one']:format(currency,amount))
        TriggerClientEvent('ap-court:notify', xPlayer.PlayerData.source, LangServer['settlement_payout_notify_two'])
      else
        addMoneyOffline(v.defendantid, amount)
        TriggerClientEvent('ap-court:notify', xPlayer.PlayerData.source, LangServer['settlement_payout_notify_three'])
      end
      if defensePlayer then
        defensePlayer.Functions.RemoveMoney('bank', amount)
        TriggerClientEvent('ap-court:notify', defensePlayer.PlayerData.source, LangServer['settlement_payout_notify_four']:format(currency,amount))
        TriggerClientEvent('ap-court:notify', xPlayer.PlayerData.source, LangServer['settlement_payout_notify_five'])
      else
        removeMoneyOffline(v.defenseid, amount)
        TriggerClientEvent('ap-court:notify', xPlayer.PlayerData.source, LangServer['settlement_payout_notify_five'])
      end
      UpdatePaymentMenu(v.id, 'settlement')
    elseif menuType == "Defense" then
      if defensePlayer then
        defensePlayer.Functions.AddMoney('bank', amount)
        TriggerClientEvent('ap-court:notify', defensePlayer.PlayerData.source, LangServer['settlement_payout_notify_one']:format(currency,amount))
        TriggerClientEvent('ap-court:notify', xPlayer.PlayerData.source, LangServer['settlement_payout_notify_six'])
      else
        addMoneyOffline(v.defenseid, amount)
        TriggerClientEvent('ap-court:notify', xPlayer.PlayerData.source, LangServer['settlement_payout_notify_seven'])
      end
      if defenPlayer then
        defenPlayer.Functions.RemoveMoney('bank', amount)
        TriggerClientEvent('ap-court:notify', defenPlayer.PlayerData.source, LangServer['settlement_payout_notify_four']:format(currency,amount))
        TriggerClientEvent('ap-court:notify', xPlayer.PlayerData.source, LangServer['settlement_payout_notify_eight'])
      else
        removeMoneyOffline(v.defendantid, amount)
        TriggerClientEvent('ap-court:notify', xPlayer.PlayerData.source, LangServer['settlement_payout_notify_eight'])
      end
      UpdatePaymentMenu(v.id, 'settlement')
    end
end)

RegisterNetEvent('ap-court:server:ApproveAppointment')
AddEventHandler('ap-court:server:ApproveAppointment', function(v, date)
  local xPlayer = QBCore.Functions.GetPlayer(source) 
  local tPlayer = QBCore.Functions.GetPlayerByCitizenId(v.owner)
  local result = MySQL.Sync.fetchAll('SELECT * FROM `ap_bar` WHERE owner = @owner', {['@owner'] = v.owner})
  if result[1] ~= nil then
    MySQL.Sync.execute("UPDATE ap_bar SET app_state = @app_state, app_date = @app_date WHERE owner = @owner", {
        ['@app_state'] = 2,
        ['@app_date'] = date,
        ['@owner'] = result[1].owner
    }) 
    if tPlayer then
      TriggerClientEvent('ap-court:notify', tPlayer.PlayerData.source, LangServer['approve_appointment_notify_one'])
    end
    TriggerClientEvent('ap-court:notify', xPlayer.PlayerData.source, LangServer['approve_appointment_notify_two']:format(v.name,date))
    GKSPhone(v.owner, phs['GKS-QSR']['appointment_update']['title'], phs['GKS-QSR']['appointment_update']['msg'], phs['GKS-QSR']['appointment_update']['sender'], phs['GKS-QSR']['appointment_update']['subject'], phs['GKS-QSR']['appointment_update']['image'], phs['GKS-QSR']['appointment_update']['mail']:format(date), phs['GKS-QSR']['appointment_update']['button'], phs['GKS-QSR']['appointment_update']['email'], phs['GKS-QSR']['appointment_update']['photo'], phs['GKS-QSR']['appointment_update']['photoattachment'])
  end
end)

RegisterNetEvent('ap-court:server:DenyAppointment')
AddEventHandler('ap-court:server:DenyAppointment', function(v, date)
  local xPlayer = QBCore.Functions.GetPlayer(source) 
  local tPlayer = QBCore.Functions.GetPlayerByCitizenId(v.owner)
  local result = MySQL.Sync.fetchAll('SELECT * FROM `ap_bar` WHERE owner = @owner', {['@owner'] = v.owner})
  if result[1] ~= nil then
    MySQL.Sync.execute("UPDATE ap_bar SET app_state = @app_state WHERE owner = @owner", {
        ['@app_state'] = 0,
        ['@owner'] = result[1].owner
    }) 
    if tPlayer then
      TriggerClientEvent('ap-court:notify', tPlayer.PlayerData.source, LangServer['deny_appointment_notify_one'])
    end
    TriggerClientEvent('ap-court:notify', xPlayer.PlayerData.source, LangServer['deny_appointment_notify_two']:format(v.name))
  end
end)

RegisterNetEvent('ap-court:server:CloseAppointment')
AddEventHandler('ap-court:server:CloseAppointment', function(v)
  local xPlayer = QBCore.Functions.GetPlayer(source) 
  local tPlayer = QBCore.Functions.GetPlayerByCitizenId(v.owner)
  local result = MySQL.Sync.fetchAll('SELECT * FROM `ap_bar` WHERE owner = @owner', {['@owner'] = v.owner})
  if result[1] ~= nil then
    MySQL.Sync.execute("UPDATE ap_bar SET app_state = @app_state WHERE owner = @owner", {
        ['@app_state'] = 0,
        ['@owner'] = result[1].owner
    }) 
    if tPlayer then
      TriggerClientEvent('ap-court:notify', tPlayer.PlayerData.source, LangServer['close_appointment_notify_one'])
    end
    TriggerClientEvent('ap-court:notify', xPlayer.PlayerData.source, LangServer['close_appointment_notify_two']:format(v.name))
  end
end)

GKSPhone = function(identifier, notifytitle, notifymsg, sender, subject, image, mail, button, email, photo, photoattachment)
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
  elseif Config.Phone.RoadPhone == true then
    MySQL.Async.execute('INSERT INTO roadphone_messages (sender, receiver, message, isgps, ispicture, picture, date) VALUES (@sender, @receiver, @message, @isgps, @ispicture, @picture, @date)', {
      ['@sender'] = sender,
      ['@receiver'] = getMobile(identifier),
      ['@message'] = mail,
      ['@isgps'] = 0,
      ['@ispicture'] = 0,
      ['@picture'] = "N/A",
      ['@date'] = os.date()
    })
    if tPlayer then
      TriggerClientEvent("ap-court:notify", tPlayer.PlayerData.source, notifymsg)
      TriggerClientEvent("ap-court:client:fixphone", tPlayer.PlayerData.source)
    end
  elseif Config.Phone.LBPhone == true then
    local PhoneNumber = exports["lb-phone"]:GetEquippedPhoneNumber(identifier)
    if PhoneNumber then
      local emailAdress = exports["lb-phone"]:GetEmailAddress(PhoneNumber)
      if emailAdress then
        local senderData = { to = emailAdress, sender = sender, subject = subject, message = mail, actions = {} }
        exports["lb-phone"]:SendMail(senderData)
      end
    end
  elseif Config.Phone.Yseries == true then
    local PhoneNumber = exports["yseries"]:GetPhoneNumberByIdentifier(identifier)
    if PhoneNumber then
      exports["yseries"]:SendMail({
        title = subject,
        sender = email,
        senderDisplayName = sender,
        content = mail,
      }, "phoneNumber", PhoneNumber)
    end
  elseif Config.Phone.Custom == true then
    local newData = {
      id = identifier,
      notifytitle = notifytitle, 
      notifymsg = notifymsg, 
      sender = sender, 
      subject = subject, 
      image = image, 
      message = mail, 
      button = button, 
      email = email, 
      photo = photo, 
      photoattachment = photoattachment,
    }
    customphonefunction(newData)
  end
end 


RegisterNetEvent('ap-court:server:collectLicense')
AddEventHandler('ap-court:server:collectLicense', function(v)
    local xPlayer = QBCore.Functions.GetPlayer(source)

    if xPlayer ~= nil then
      MetaDataCheck(xPlayer)
      MySQL.Async.execute('UPDATE ap_bar SET bar_state = @bar_state WHERE owner = @owner', { ['@bar_state'] = 5, ['@owner'] = xPlayer.PlayerData.citizenid })
    end
end)

RegisterNetEvent('ap-court:server:newLicense')
AddEventHandler('ap-court:server:newLicense', function(v)
	local xPlayer = QBCore.Functions.GetPlayer(source)
    local price = Config.NewIDCardCost

    if xPlayer ~= nil then
        local bankCount = xPlayer.Functions.GetMoney('bank')
        if bankCount >= price then
            xPlayer.Functions.RemoveMoney('bank', tonumber(price))
            MetaDataCheck(xPlayer)
        else
            TriggerClientEvent('ap-court:notify', xPlayer.PlayerData.source, LangServer['bar_pay_enougth_money'])
        end
    end
end)

RegisterNetEvent('ap-court:server:courtProceedingsDiscordia')
AddEventHandler('ap-court:server:courtProceedingsDiscordia', function(v)
  local xPlayer = QBCore.Functions.GetPlayer(source)
  if Config.DiscordWebhook == true then
    if v.judgeid ~= 'Judge ID' and v.judgen ~= 'Add To Case' and v.defendantid ~= 'Defendant ID' and v.defendantn ~= 'Add To Case' and v.defenseid ~= 'Defense ID' and v.defensen ~= 'Add To Case' and v.casename ~= 'Case Name' and v.courtfees ~= 0 then
      sendLogsDiscord(webhookMsg['CreateCourt']['title']:format(v.id), webhookMsg['CreateCourt']['message']:format(v.casename,v.judgen,v.defendantn,v.defensen,v.courtfees,v.courtdate), "CreateCourtWebhook")
      TriggerClientEvent('ap-court:client:openCaseMenu', xPlayer.PlayerData.source, v.id)
    else
      TriggerClientEvent('ap-court:notify', xPlayer.PlayerData.source, LangServer['court_proceedings_notify_three'])
      TriggerClientEvent('ap-court:client:openCaseMenu', xPlayer.PlayerData.source, v.id)
    end
  end
end)

local unauthorized = false

RegisterServerEvent('ap-court:server:cardopen')
AddEventHandler('ap-court:server:cardopen', function(targetID, v)
  local data = {}

	if v.bar_state == 4 or v.bar_state == 5 then
    table.insert(data, {name = v.name, barid = v.bar_id, date = v.bar_date})
    TriggerClientEvent('ap-court:client:cardopen', targetID, data)
	end
end)

if Config.LawyerIDMetaData.Enable then
  if Config.useID_UI == true then
    if Config.LawyerIDMetaData.Inventory.QB then
      QBCore.Functions.CreateUseableItem(Config.lawyerID, function(source, item)
        local metadata = item.info
        if metadata ~= nil then
          local result = MySQL.Sync.fetchAll('SELECT * FROM `ap_bar` WHERE bar_id = @bar_id', {['@bar_id'] = metadata.baridnumber})
          TriggerClientEvent('ap-court:client:useCard', source, true, result[1])
        else
          UsableItem(source)
        end
      end)
    end
  else
    QBCore.Functions.CreateUseableItem(Config.lawyerID, function(source)
      UsableItem(source)
    end)
  end
else
  QBCore.Functions.CreateUseableItem(Config.lawyerID, function(source)
    UsableItem(source)
  end)
end

RegisterServerEvent('ap-court:server:usingLawyerCard')
AddEventHandler('ap-court:server:usingLawyerCard', function(data)
  local src = source
  if data.metadata ~= nil then
    local result = MySQL.Sync.fetchAll('SELECT * FROM `ap_bar` WHERE bar_id = @bar_id', {['@bar_id'] = Item.metadata.baridnumber})
    TriggerClientEvent('ap-court:client:useCard', src, true, result[1])
  else
    UsableItem(source)
  end
end)

UsableItem = function(source)
  if Config.useID_UI == true then
	  TriggerClientEvent('ap-court:client:useCard', source, false)
  else
    TriggerClientEvent('ap-court:client:lawyerID', source)
  end
end

AddItem = function (xPlayer)
  return xPlayer.Functions.AddItem(Config.lawyerID, 1)
end

MetaDataCheck = function(xPlayer)
  local cfg = Config.LawyerIDMetaData
  if cfg.Enable then
    local result = MySQL.Sync.fetchAll('SELECT * FROM `ap_bar` WHERE owner = @owner', {['@owner'] = xPlayer.PlayerData.citizenid})
    local barID = result[1].bar_id
    local Inv = cfg.Inventory
    if Inv.QB then
      local info = {baridnumber = barID, lawyername = getName(xPlayer.PlayerData.citizenid)}
      if not xPlayer.Functions.AddItem(Config.lawyerID, 1, nil, info) then AddItem(xPlayer) end
    elseif Inv.OX then
      local info = {baridnumber = barID, lawyername = getName(xPlayer.PlayerData.citizenid)}
      if not exports.ox_inventory:AddItem(xPlayer.PlayerData.source, Config.lawyerID, 1, info) then AddItem(xPlayer) end
    else
      AddItem(xPlayer)
    end
  else
    AddItem(xPlayer)
  end
end

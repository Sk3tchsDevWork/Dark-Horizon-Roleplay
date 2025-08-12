local currency = Config.Currency

local cfgTax = Config.Tax

local context = Config.Context

local dialogInput = Config.Dialog

local hasVoted = false

ContextMenu = function(data)
  if Config.Context.QB then
    exports[Config.ExportNames.menu]:openMenu(data)
  elseif Config.Context.OX then
    lib.registerContext({
      id = data.id,
      title = data.title,
      options = data.options
    })
    lib.showContext(data.id)
  end
end

RegisterNUICallback('getCandidate', function(data,cb)
  QBCore.Functions.TriggerCallback('ap-government:getCandidate', function(polls)
    cb(polls)
  end)
end)

RegisterNUICallback('voteForSomeone', function(data)
	QBCore.Functions.Notify(LangClient[Config.Language].notifications['vote_submit'], 'success')
    TriggerServerEvent('ap-government:server:registerVote', data)
	TriggerEvent('ap-government:client:setVotingTrue', true)
end)

RegisterNUICallback('error', function()
    QBCore.Functions.Notify(LangClient[Config.Language].notifications['vote_error'], 'error')
end)

RegisterNUICallback('close', function()
    SetNuiFocus(false, false)
end)

usingCourt = function()
  if Config.UsingAPCourt == true then
	local archives = exports['ap-court']:usingCriminalRecord()
	if archives == true then
	  return true
	else
	  return false
	end
  else
	return false
  end
end

RegisterNetEvent('ap-government:client:setVotingTrue', function(data)
  hasVoted = data
end)

RegisterNetEvent('ap-government:client:applyCandidate', function()
  QBCore.Functions.TriggerCallback('ap-government:getCandidates', function(polls)
	for k,v in pairs(polls) do
		local usingCourtSystem = usingCourt()
		if usingCourtSystem then
			QBCore.Functions.TriggerCallback('ap-court:server:isArchives', function(record)
			  if record then
				if context.QB then
					local applyCandidate = ContextMenu({
						{
							header = LangClient[Config.Language].menus['applyCandidate_ap_court_header'],
							txt = LangClient[Config.Language].menus['applyCandidate_ap_court_txt'],
							isMenuHeader = true,
						},
					})
				elseif Context.OX then
					ContextMenu({
						id = 'apply_record',
						title = LangClient[Config.Language].menus['applyCandidate_ap_court_title'],
						options = {
							{
								title = LangClient[Config.Language].menus['applyCandidate_ap_court_header_OX'],
								description = LangClient[Config.Language].menus['applyCandidate_ap_court_txt'],
								disabled = true,
							}
						}
					})
				end
			  else
				if v.state == 5 then
				  QBCore.Functions.TriggerCallback('ap-government:getJsonData', function(db)
					if context.QB then
						local applyCandidate = ContextMenu({
							{
								header = LangClient[Config.Language].menus['applyCandidate_state_five_header_one'],
								txt = LangClient[Config.Language].menus['applyCandidate_state_five_txt_one'],
								isMenuHeader = true,
							},
							{
								header = LangClient[Config.Language].menus['applyCandidate_state_five_header_two']:format(Config.Voting[db["currentType"]].givenJob.label),
								txt = LangClient[Config.Language].menus['applyCandidate_state_five_txt_two']:format(string.lower(Config.Voting[db["currentType"]].givenJob.label)),
								params = {
									isServer = true,
									event = "ap-government:server:acceptJob",
									args = Config.Voting[db["currentType"]]
								}
							}
						})
					elseif context.OX then
						ContextMenu({
							id = 'apply_candidate_5',
							title = LangClient[Config.Language].menus['applyCandidate_ap_court_title'],
							options = {
								{
									title = LangClient[Config.Language].menus['applyCandidate_state_five_header_one_OX'],
									description = LangClient[Config.Language].menus['applyCandidate_state_five_txt_one'],
									disabled = true,
								},
								{
									title = LangClient[Config.Language].menus['applyCandidate_state_five_header_two']:format(Config.Voting[db["currentType"]].givenJob.label),
									description = LangClient[Config.Language].menus['applyCandidate_state_five_txt_two']:format(string.lower(Config.Voting[db["currentType"]].givenJob.label)),
									serverEvent = "ap-government:server:acceptJob",
									args = Config.Voting[db["currentType"]]
								}
							}
						})
					end
				  end)
			    elseif v.state == 4 then
					if context.QB then
						local applyCandidate = ContextMenu({
							{
								header = LangClient[Config.Language].menus['applyCandidate_state_four_header'],
								txt = LangClient[Config.Language].menus['applyCandidate_state_four_txt']:format(v.votes),
								isMenuHeader = true,
							},
						})
					elseif context.OX then
						ContextMenu({
							id = 'apply_candidate_4',
							title = LangClient[Config.Language].menus['applyCandidate_ap_court_title'],
							options = {
								{
									title = LangClient[Config.Language].menus['applyCandidate_state_four_header_OX'],
									description = LangClient[Config.Language].menus['applyCandidate_state_four_txt']:format(v.votes),
									disabled = true,
								}
							}
						})
					end
				elseif v.state == 3 then
					if context.QB then
						local applyCandidate = ContextMenu({
							{
								header = LangClient[Config.Language].menus['applyCandidate_state_three_header'],
								txt = LangClient[Config.Language].menus['applyCandidate_state_three_txt'],
								isMenuHeader = true,
							},
						})
					elseif context.OX then
						ContextMenu({
							id = 'apply_candidate_3',
							title = LangClient[Config.Language].menus['applyCandidate_ap_court_title'],
							options = {
								{
									title = LangClient[Config.Language].menus['applyCandidate_state_three_header_OX'],
									description = LangClient[Config.Language].menus['applyCandidate_state_three_txt'],
									disabled = true,
								}
							}
						})
					end
			    elseif v.state == 2 then
					if context.QB then
						local applyCandidate = ContextMenu({
							{
								header = LangClient[Config.Language].menus['applyCandidate_state_two_header'],
								txt = LangClient[Config.Language].menus['applyCandidate_state_two_txt']:format(v.denied),
								isMenuHeader = true,
							},
						})
					elseif context.OX then
						ContextMenu({
							id = 'apply_candidate_2',
							title = LangClient[Config.Language].menus['applyCandidate_ap_court_title'],
							options = {
								{
									title = LangClient[Config.Language].menus['applyCandidate_state_two_header_OX'],
									description = LangClient[Config.Language].menus['applyCandidate_state_two_txt']:format(v.denied),
									disabled = true,
								}
							}
						})
					end
			    elseif v.state == 1 then
					if context.QB then
						local applyCandidate = ContextMenu({
							{
								header = LangClient[Config.Language].menus['applyCandidate_state_one_header'],
								txt = LangClient[Config.Language].menus['applyCandidate_state_one_txt'],
								isMenuHeader = true,
							},
						})
					elseif context.OX then
						ContextMenu({
							id = 'apply_candidate_1',
							title = LangClient[Config.Language].menus['applyCandidate_ap_court_title'],
							options = {
								{
									title = LangClient[Config.Language].menus['applyCandidate_state_one_header_OX'],
									description = LangClient[Config.Language].menus['applyCandidate_state_one_txt'],
									disabled = true,
								}
							}
						})
					end
			    elseif v.state == 0 then
				  QBCore.Functions.TriggerCallback('ap-government:getJsonData', function(db)
					local applyCandidate = {}
					local params = nil
					if context.QB then
						if db["voteState"] == 1 then
							if Config.Voting[db["currentType"]].applicationJobCheck.enable then
							  params = {isServer = true, event = "ap-government:server:applyDialog", args = Config.Voting[db["currentType"]].applicationJobCheck}
							else
							  params = {isServer = false, event = "ap-government:client:applyDialog", args = {}}
							end  
							table.insert(applyCandidate, {
								header = LangClient[Config.Language].menus['applyCandidate_state_zero_header_one'],
								txt = LangClient[Config.Language].menus['applyCandidate_state_zero_txt_one'],
								params = params	
							})
						else
							table.insert(applyCandidate, {
								header = LangClient[Config.Language].menus['applyCandidate_state_zero_header_two'],
								txt = LangClient[Config.Language].menus['applyCandidate_state_zero_txt_two'],
								isMenuHeader = true	
							})
						end
						ContextMenu(applyCandidate)
					elseif context.OX then
						if db["voteState"] == 1 then
							if Config.Voting[db["currentType"]].applicationJobCheck.enable then
								table.insert(applyCandidate, {
									title = LangClient[Config.Language].menus['applyCandidate_state_zero_header_one_OX'],
									description = LangClient[Config.Language].menus['applyCandidate_state_zero_txt_one'],
									serverEvent = "ap-government:server:applyDialog",
									args = Config.Voting[db["currentType"]].applicationJobCheck
								})
							else
								table.insert(applyCandidate, {
									title = LangClient[Config.Language].menus['applyCandidate_state_zero_header_one_OX'],
									description = LangClient[Config.Language].menus['applyCandidate_state_zero_txt_one'],
									event = "ap-government:client:applyDialog",
									args = {}
								})
							end  
						else
							table.insert(applyCandidate, {
								title = LangClient[Config.Language].menus['applyCandidate_state_zero_header_two_OX'],
								description = LangClient[Config.Language].menus['applyCandidate_state_zero_txt_two'],
								disabled = true	
							})
						end
						ContextMenu({
							id = 'apply_candidate_0',
							title = LangClient[Config.Language].menus['applyCandidate_ap_court_apply_title']:format(Config.Voting[db["currentType"]].poll),
							options = applyCandidate
						})
					end
				  end)
				end
			  end
			end)
		else
			if v.state == 6 then
				if context.QB then
					local applyCandidate = ContextMenu({
						{
							header = LangClient[Config.Language].menus['applyCandidate_state_six_header'],
							txt = LangClient[Config.Language].menus['applyCandidate_state_six_txt']:format(v.denied),
							isMenuHeader = true,
						},
					})
				elseif context.OX then
					ContextMenu({
						id = 'apply_candidate_1_6',
						title = LangClient[Config.Language].menus['applyCandidate_ap_court_title'],
						options = {
							{
								title = LangClient[Config.Language].menus['applyCandidate_state_six_header_OX'],
								description = LangClient[Config.Language].menus['applyCandidate_state_six_txt']:format(v.denied),
								disabled = true,
							}
						}
					})
				end
			elseif v.state == 5 then
				QBCore.Functions.TriggerCallback('ap-government:getJsonData', function(db)
					if context.QB then
						local applyCandidate = ContextMenu({
							{
								header = LangClient[Config.Language].menus['applyCandidate_state_five_header_one'],
								txt = LangClient[Config.Language].menus['applyCandidate_state_five_txt_one'],
								isMenuHeader = true,
							},
							{
								header = LangClient[Config.Language].menus['applyCandidate_state_five_header_two']:format(Config.Voting[db["currentType"]].givenJob.label),
								txt = LangClient[Config.Language].menus['applyCandidate_state_five_txt_two']:format(string.lower(Config.Voting[db["currentType"]].givenJob.label)),
								params = {
									isServer = true,
									event = "ap-government:server:acceptJob",
									args = Config.Voting[db["currentType"]]
								}
							}
						})
					elseif context.OX then
						ContextMenu({
							id = 'apply_candidate_1_5',
							title = LangClient[Config.Language].menus['applyCandidate_ap_court_title'],
							options = {
								{
									title = LangClient[Config.Language].menus['applyCandidate_state_five_header_one_OX'],
									description = LangClient[Config.Language].menus['applyCandidate_state_five_txt_one'],
									disabled = true,
								},
								{
									title = LangClient[Config.Language].menus['applyCandidate_state_five_header_two']:format(Config.Voting[db["currentType"]].givenJob.label),
									description = LangClient[Config.Language].menus['applyCandidate_state_five_txt_two']:format(string.lower(Config.Voting[db["currentType"]].givenJob.label)),
									serverEvent = "ap-government:server:acceptJob",
									args = Config.Voting[db["currentType"]]
								}
							}
						})
					end
				end)
		    elseif v.state == 4 then
				if context.QB then
					local applyCandidate = ContextMenu({
						{
							header = LangClient[Config.Language].menus['applyCandidate_state_four_header'],
							txt = LangClient[Config.Language].menus['applyCandidate_state_four_txt']:format(v.votes),
							isMenuHeader = true,
						},
					})
				elseif context.OX then
					ContextMenu({
						id = 'apply_candidate_1_4',
						title = LangClient[Config.Language].menus['applyCandidate_ap_court_title'],
						options = {
							{
								title = LangClient[Config.Language].menus['applyCandidate_state_four_header_OX'],
								description = LangClient[Config.Language].menus['applyCandidate_state_four_txt_OX']:format(v.votes),
								disabled = true,
							}
						}
					})
				end
			elseif v.state == 3 then
				if context.QB then
					local applyCandidate = ContextMenu({
						{
							header = LangClient[Config.Language].menus['applyCandidate_state_three_header'],
							txt = LangClient[Config.Language].menus['applyCandidate_state_three_txt'],
							isMenuHeader = true,
						},
					})
				elseif context.OX then
					ContextMenu({
						id = 'apply_candidate_1_3',
						title = LangClient[Config.Language].menus['applyCandidate_ap_court_title'],
						options = {
							{
								title = LangClient[Config.Language].menus['applyCandidate_state_three_header_OX'],
								description = LangClient[Config.Language].menus['applyCandidate_state_three_txt'],
								disabled = true,
							}
						}
					})
				end
			elseif v.state == 2 then
				if context.QB then
					local applyCandidate = ContextMenu({
						{
							header = LangClient[Config.Language].menus['applyCandidate_state_two_header'],
							txt = LangClient[Config.Language].menus['applyCandidate_state_two_txt']:format(v.denied),
							isMenuHeader = true,
						},
					})
				elseif context.OX then
					ContextMenu({
						id = 'apply_candidate_1_2',
						title = LangClient[Config.Language].menus['applyCandidate_ap_court_title'],
						options = {
							{
								title = LangClient[Config.Language].menus['applyCandidate_state_two_header_OX'],
								description = LangClient[Config.Language].menus['applyCandidate_state_two_txt']:format(v.denied),
								disabled = true,
							}
						}
					})
				end
			elseif v.state == 1 then
				if context.QB then
					local applyCandidate = ContextMenu({
						{
							header = LangClient[Config.Language].menus['applyCandidate_state_one_header'],
							txt = LangClient[Config.Language].menus['applyCandidate_state_one_txt'],
							isMenuHeader = true,
						},
					})
				elseif context.OX then
					ContextMenu({
						id = 'apply_candidate_1_1',
						title = LangClient[Config.Language].menus['applyCandidate_ap_court_title'],
						options = {
							{
								title = LangClient[Config.Language].menus['applyCandidate_state_one_header_OX'],
								description = LangClient[Config.Language].menus['applyCandidate_state_one_txt'],
								disabled = true,
							}
						}
					})
				end
			elseif v.state == 0 then
			  QBCore.Functions.TriggerCallback('ap-government:getJsonData', function(db)
				local applyCandidate = {}
				local params = nil
				if context.QB then
					if db["voteState"] == 1 then
						if Config.Voting[db["currentType"]].applicationJobCheck.enable then
						  params = {isServer = true, event = "ap-government:server:applyDialog", args = Config.Voting[db["currentType"]].applicationJobCheck}
						else
						  params = {isServer = false, event = "ap-government:client:applyDialog", args = {}}
						end  
						table.insert(applyCandidate, {
							header = LangClient[Config.Language].menus['applyCandidate_state_zero_header_one'],
							txt = LangClient[Config.Language].menus['applyCandidate_state_zero_txt_one'],
							params = params	
						})
					else
						table.insert(applyCandidate, {
							header = LangClient[Config.Language].menus['applyCandidate_state_zero_header_two'],
							txt = LangClient[Config.Language].menus['applyCandidate_state_zero_txt_two'],
							isMenuHeader = true	
						})
					end
					ContextMenu(applyCandidate)
				elseif context.OX then
					if db["voteState"] == 1 then
						if Config.Voting[db["currentType"]].applicationJobCheck.enable then
							table.insert(applyCandidate, {
								title = LangClient[Config.Language].menus['applyCandidate_state_zero_header_one_OX'],
								description = LangClient[Config.Language].menus['applyCandidate_state_zero_txt_one'],
								serverEvent = "ap-government:server:applyDialog",
								args = Config.Voting[db["currentType"]].applicationJobCheck	
							})
						else
							table.insert(applyCandidate, {
								title = LangClient[Config.Language].menus['applyCandidate_state_zero_header_one_OX'],
								description = LangClient[Config.Language].menus['applyCandidate_state_zero_txt_one'],
								event = "ap-government:client:applyDialog",
								args = {}
							})
						end  
					else
						table.insert(applyCandidate, {
							title = LangClient[Config.Language].menus['applyCandidate_state_zero_header_two_OX'],
							description = LangClient[Config.Language].menus['applyCandidate_state_zero_txt_two'],
							disabled = true	
						})
					end
					ContextMenu({
						id = 'apply_candidate_1_0',
						title = LangClient[Config.Language].menus['applyCandidate_ap_court_apply_title']:format(Config.Voting[db["currentType"]].poll),
						options = applyCandidate
					})
				end
			  end)
			end
		end
	end
  end)
end)

RegisterNetEvent('ap-government:client:applyDialog', function(v)
	SendNUIMessage({
	  type  = "showCandidatesApp",
	})
	SetNuiFocus(true,true)
  end)

RegisterNUICallback('submitCandidateApplication', function(data)
  TriggerServerEvent('ap-government:server:saveCandidate', data.q1, data.q2, data.q3)
end)

RegisterNetEvent('ap-government:client:majorOffice', function()
	if context.QB then
		local applyCandidate = {
			{
				header = LangClient[Config.Language].menus['majorOffice_header_one'],
				txt = LangClient[Config.Language].menus['majorOffice_txt_one'],
				params = {
					isServer = false,
					event = "ap-government:client:taxSettings",
					args = {}
				}
			},
			{
				header = LangClient[Config.Language].menus['majorOffice_header_two'],
				txt = LangClient[Config.Language].menus['majorOffice_txt_two'],
				params = {
					isServer = false,
					event = "ap-government:client:taxAccounts",
					args = {}
				}
			},
			{
				header = LangClient[Config.Language].menus['majorOffice_header_three'],
				txt = LangClient[Config.Language].menus['majorOffice_txt_three'],
				params = {
					isServer = false,
					event = "ap-government:client:registerBusiness",
					args = {}
				}
			},
			{
				header = LangClient[Config.Language].menus['majorOffice_header_four'],
				txt = LangClient[Config.Language].menus['majorOffice_txt_four'],
				params = {
					isServer = false,
					event = "ap-government:client:fundsmenu",
					args = {}
				}
			},
			{
				header = LangClient[Config.Language].menus['majorOffice_header_five'],
				txt = LangClient[Config.Language].menus['majorOffice_txt_five'],
				params = {
					isServer = false,
					event = "ap-government:client:appointmentsManage",
					args = {}
				}
			},
		}
		if Config.CustomEdits == "BWLMS22" then
		  table.insert(applyCandidate, {
			header = CustomConfig.Language['majorOffice_header_six'],
			txt = CustomConfig.Language['majorOffice_txt_six'],
			params = {
				isServer = false,
				event = "ap-government:customconfig:sellbusiness",
				args = {}
			}
		  })
		end
		if Config.VotingLaws then
			table.insert(applyCandidate, {
			  header = LangClient[Config.Language].menus['majorOffice_header_seven'],
			  txt = LangClient[Config.Language].menus['majorOffice_txt_seven'],
			  params = {
				isServer = false,
				event = "ap-government:client:openLawVotingManagement",
				args = {}
			  }
			})
		end
		ContextMenu(applyCandidate)
	elseif context.OX then
		local MenuData = {
			{
				title = LangClient[Config.Language].menus['majorOffice_header_one'],
				description = LangClient[Config.Language].menus['majorOffice_txt_one'],
				event = "ap-government:client:taxSettings",
				args = {}
			},
			{
				title = LangClient[Config.Language].menus['majorOffice_header_two'],
				description = LangClient[Config.Language].menus['majorOffice_txt_two'],
				event = "ap-government:client:taxAccounts",
				args = {}
			},
			{
				title = LangClient[Config.Language].menus['majorOffice_header_three'],
				description = LangClient[Config.Language].menus['majorOffice_txt_three'],
				event = "ap-government:client:registerBusiness",
				args = {}
			},
			{
				title = LangClient[Config.Language].menus['majorOffice_header_four'],
				description = LangClient[Config.Language].menus['majorOffice_txt_four'],
				event = "ap-government:client:fundsmenu",
				args = {}
			},
			{
				title = LangClient[Config.Language].menus['majorOffice_header_five'],
				description = LangClient[Config.Language].menus['majorOffice_txt_five'],
				event = "ap-government:client:appointmentsManage",
				args = {}
			},
		}
		if Config.VotingLaws then
			table.insert(MenuData, {
			  title = LangClient[Config.Language].menus['majorOffice_header_seven'],
			  description = LangClient[Config.Language].menus['majorOffice_txt_seven'],
			  event = "ap-government:client:openLawVotingManagement",
			  args = {}
			})
		end
		ContextMenu({
			id = 'majorOffice',
			title = LangClient[Config.Language].menus['majorOffice_title'],
			options = MenuData
		})
    end
end)

RegisterNetEvent('ap-government:client:taxAccounts', function()
	if context.QB then
		local applyCandidate = ContextMenu({
			{
				header = LangClient[Config.Language].menus['taxAccounts_header_one'],
				txt = LangClient[Config.Language].menus['taxAccounts_txt_one'],
				params = {
					isServer = false,
					event = "ap-government:client:viewallbusinesstax",
					args = {}
				}
			},
			{
				header = LangClient[Config.Language].menus['taxAccounts_header_two'],
				txt = LangClient[Config.Language].menus['taxAccounts_txt_two'],
				params = {
					isServer = false,
					event = "ap-government:client:viewunpaidtaxaccounts",
					args = {}
				}
			},
			{
				header = LangClient[Config.Language].menus['taxAccounts_header_three'],
				txt = LangClient[Config.Language].menus['taxAccounts_txt_three'],
				params = {
					isServer = false,
					event = "ap-government:client:majorOffice",
					args = {}
				}
			}
		})
	elseif context.OX then
		ContextMenu({
			id = 'taxAccounts',
			title = LangClient[Config.Language].menus['taxAccounts_title'],
			options = {
				{
					title = LangClient[Config.Language].menus['taxAccounts_header_one'],
					description = LangClient[Config.Language].menus['taxAccounts_txt_one'],
					event = "ap-government:client:viewallbusinesstax",
					args = {}
				},
				{
					title = LangClient[Config.Language].menus['taxAccounts_header_two'],
					description = LangClient[Config.Language].menus['taxAccounts_txt_two'],
					event = "ap-government:client:viewunpaidtaxaccounts",
					args = {}
				},
				{
					title = LangClient[Config.Language].menus['taxAccounts_header_three'],
					description = LangClient[Config.Language].menus['taxAccounts_txt_three'],
					event = "ap-government:client:majorOffice",
					args = {}
				}
			}
		})
	end
end)

RegisterNetEvent('ap-government:client:viewallbusinesstax', function()
	QBCore.Functions.TriggerCallback('ap-government:getBusinessAccounts', function(data)
		if context.QB then
			local businessAccounts = {
				{
					header = LangClient[Config.Language].menus['viewallbusinesstax_header_one'],
					isMenuHeader = true,
				},
			}
		
			if data ~= nil then 	
				for k,v in pairs(data) do
				  table.insert(businessAccounts,  {
					  header = LangClient[Config.Language].menus['viewallbusinesstax_header_two']:format(v.label), 
					  txt = LangClient[Config.Language].menus['viewallbusinesstax_txt_one'],
					  params = {
						  isServer = false,
						  event = "ap-government:client:viewalltaxaccountsnow",
						  args = v
					  }
				  })  
				end
			end
	  
			table.insert(businessAccounts, {
			  header = LangClient[Config.Language].menus['viewallbusinesstax_header_three'], 
			  txt = LangClient[Config.Language].menus['viewallbusinesstax_txt_two'],
			  params = {
				  isServer = false,
				  event = "ap-government:client:taxAccounts",
				  args = {}
			  }		
			})
		
			ContextMenu(businessAccounts)
		elseif context.OX then
			local businessAccounts = {}
		
			if data ~= nil then 	
				for k,v in pairs(data) do
				  table.insert(businessAccounts,  {
					title = LangClient[Config.Language].menus['viewallbusinesstax_header_two']:format(v.label), 
					description = LangClient[Config.Language].menus['viewallbusinesstax_txt_one'],
					event = "ap-government:client:viewalltaxaccountsnow",
					args = v
				  })  
				end
			end
	  
			table.insert(businessAccounts, {
			  title = LangClient[Config.Language].menus['viewallbusinesstax_header_three'], 
			  description = LangClient[Config.Language].menus['viewallbusinesstax_txt_two'],
			  event = "ap-government:client:taxAccounts",
			  args = {}	
			})
			ContextMenu({
				id = 'viewallbusinesstax',
				title = LangClient[Config.Language].menus['viewallbusinesstax_header_one'],
				options = businessAccounts
			})
		end
	end)
end)

RegisterNetEvent('ap-government:client:viewalltaxaccountsnow', function(v)
  QBCore.Functions.TriggerCallback('ap-government:callback:getName', function(data)	
	local state = nil
	if v.owner == "COMPANY OWNER" then
	  state = LangClient[Config.Language].menus['viewalltaxaccountsnow_state_one']
	else
	  state = LangClient[Config.Language].menus['viewalltaxaccountsnow_state_two']:format(data.name)
	end
	if context.QB then
		local taxAccountsShow = ContextMenu({
			{
				header = LangClient[Config.Language].menus['viewalltaxaccountsnow_header_one'],
				txt = LangClient[Config.Language].menus['viewalltaxaccountsnow_txt_one']:format(v.label),
				isMenuHeader = true
			},
			{
				header = LangClient[Config.Language].menus['viewalltaxaccountsnow_header_two'],
				txt = LangClient[Config.Language].menus['viewalltaxaccountsnow_txt_two']:format(v.total_tax_paid),
				isMenuHeader = true
			},
			{
				header = LangClient[Config.Language].menus['viewalltaxaccountsnow_header_three'],
				txt = LangClient[Config.Language].menus['viewalltaxaccountsnow_txt_three']:format(v.amount_owed),
				isMenuHeader = true
			},
			{
				header = LangClient[Config.Language].menus['viewalltaxaccountsnow_header_four'],
				txt = LangClient[Config.Language].menus['viewalltaxaccountsnow_txt_four']:format(state),
				isMenuHeader = true
			},
			{
				header = LangClient[Config.Language].menus['viewalltaxaccountsnow_header_five'],
				txt = LangClient[Config.Language].menus['viewalltaxaccountsnow_txt_five'],
				params = {
					isServer = false,
					event = "ap-government:client:viewallbusinesstax",
					args = {}
				}
			}
		})
	elseif context.OX then
		ContextMenu({
			id = 'viewalltaxaccountsnow',
			title = LangClient[Config.Language].menus['viewalltaxaccountsnow_title'],
			options = {
				{
					title = LangClient[Config.Language].menus['viewalltaxaccountsnow_header_one'],
					description = LangClient[Config.Language].menus['viewalltaxaccountsnow_txt_one']:format(v.label),
					disabled = true
				},
				{
					title = LangClient[Config.Language].menus['viewalltaxaccountsnow_header_two'],
					description = LangClient[Config.Language].menus['viewalltaxaccountsnow_txt_two_OX']:format(v.total_tax_paid),
					disabled = true
				},
				{
					title = LangClient[Config.Language].menus['viewalltaxaccountsnow_header_three'],
					description = LangClient[Config.Language].menus['viewalltaxaccountsnow_txt_three_OX']:format(v.amount_owed),
					disabled = true
				},
				{
					title = LangClient[Config.Language].menus['viewalltaxaccountsnow_header_four'],
					description = LangClient[Config.Language].menus['viewalltaxaccountsnow_txt_four']:format(state),
					disabled = true
				},
				{
					title = LangClient[Config.Language].menus['viewalltaxaccountsnow_header_five'],
					description = LangClient[Config.Language].menus['viewalltaxaccountsnow_txt_five'],
					event = "ap-government:client:viewallbusinesstax",
					args = {}
				}
			}
		})
	end
  end, v.owner)
end)

RegisterNetEvent('ap-government:client:viewunpaidtaxaccounts', function()
	QBCore.Functions.TriggerCallback('ap-government:getBusinessAccounts', function(data)
		if context.QB then
			local businessUnpaidAccounts = {
				{
					header = LangClient[Config.Language].menus['viewunpaidtaxaccounts_header_one'],
					isMenuHeader = true,
				},
			}
		
			if data ~= nil then 	
				for k,v in pairs(data) do
				  if v.amount_owed >= 1 then
					  table.insert(businessUnpaidAccounts,  {
						  header = LangClient[Config.Language].menus['viewunpaidtaxaccounts_header_two']:format(v.label), 
						  txt = LangClient[Config.Language].menus['viewunpaidtaxaccounts_txt_one'],
						  params = {
							  isServer = false,
							  event = "ap-government:client:manageUnpaidTaxAccounts",
							  args = v
						  }
					  }) 			
				  end 
				end
			end
	  
			table.insert(businessUnpaidAccounts, {
			  header = LangClient[Config.Language].menus['viewunpaidtaxaccounts_header_three'], 
			  txt = LangClient[Config.Language].menus['viewunpaidtaxaccounts_txt_two'],
			  params = {
				  isServer = false,
				  event = "ap-government:client:taxAccounts",
				  args = {}
			  }		
			})
		
			ContextMenu(businessUnpaidAccounts)
		elseif context.OX then
			local businessUnpaidAccounts = {}
	
			if data ~= nil then 	
				for k,v in pairs(data) do
				  if v.amount_owed >= 1 then
					  table.insert(businessUnpaidAccounts,  {
						  title = LangClient[Config.Language].menus['viewunpaidtaxaccounts_header_two']:format(v.label), 
						  description = LangClient[Config.Language].menus['viewunpaidtaxaccounts_txt_one'],
						  event = "ap-government:client:manageUnpaidTaxAccounts",
						  args = v
					  }) 			
				  end 
				end
			end
	  
			table.insert(businessUnpaidAccounts, {
			  title = LangClient[Config.Language].menus['viewunpaidtaxaccounts_header_three'], 
			  description = LangClient[Config.Language].menus['viewunpaidtaxaccounts_txt_two'],
			  event = "ap-government:client:taxAccounts",
			  args = {}	
			})

			ContextMenu({
				id = 'viewunpaidtaxaccounts',
				title = LangClient[Config.Language].menus['viewunpaidtaxaccounts_header_one'],
				options = businessUnpaidAccounts
			})
		end
	end)
end)

RegisterNetEvent('ap-government:client:fundsmenu', function()
  QBCore.Functions.TriggerCallback('ap-government:getJsonData', function(v)
	if context.QB then
		local fundstable = {
			{
				header = LangClient[Config.Language].menus['fundsmenu_header_one'],
				txt = LangClient[Config.Language].menus['fundsmenu_txt_one']:format(currency, v["funds"]),
				isMenuHeader = true
			},
		}
		if Config.MayorOptions.funds.withdrawal.enable then
			table.insert(fundstable, {
				header = LangClient[Config.Language].menus['fundsmenu_header_two'],
				txt = LangClient[Config.Language].menus['fundsmenu_txt_two'],
				params = {
					isServer = false,
					event = "ap-government:client:withdrawfunds",
					args = v
				}	
			})
		end
		if Config.MayorOptions.funds.deposit.enable then
			table.insert(fundstable, {
				header = LangClient[Config.Language].menus['fundsmenu_header_three'],
				txt = LangClient[Config.Language].menus['fundsmenu_txt_three'],
				params = {
					isServer = false,
					event = "ap-government:client:depositfunds",
					args = v
				}	
			})
		end
		table.insert(fundstable, {
			header = LangClient[Config.Language].menus['fundsmenu_header_four'],
			txt = LangClient[Config.Language].menus['fundsmenu_txt_four'],
			params = {
				isServer = false,
				event = "ap-government:client:majorOffice",
				args = {}
			}	
		})
		ContextMenu(fundstable)
	elseif context.OX then
		local fundstable = {
			{
				title = LangClient[Config.Language].menus['fundsmenu_header_one'],
				description = LangClient[Config.Language].menus['fundsmenu_txt_one']:format(currency, v["funds"]),
				disabled = true
			},
		}
		if Config.MayorOptions.funds.withdrawal.enable then
			table.insert(fundstable, {
				title = LangClient[Config.Language].menus['fundsmenu_header_two'],
				description = LangClient[Config.Language].menus['fundsmenu_txt_two'],
				event = "ap-government:client:withdrawfunds",
				args = v
			})
		end
		if Config.MayorOptions.funds.deposit.enable then
			table.insert(fundstable, {
				title = LangClient[Config.Language].menus['fundsmenu_header_three'],
				description = LangClient[Config.Language].menus['fundsmenu_txt_three'],
				event = "ap-government:client:depositfunds",
				args = v
			})
		end
		table.insert(fundstable, {
			title = LangClient[Config.Language].menus['fundsmenu_header_four'],
			description = LangClient[Config.Language].menus['fundsmenu_txt_four'],
			event = "ap-government:client:majorOffice",
			args = {}
		})
		ContextMenu({
			id = 'fundstable',
			title = LangClient[Config.Language].menus['fundsmenu_title'],
			options = fundstable
		})
	end
  end)
end)

RegisterNetEvent('ap-government:client:withdrawfunds', function(v)
	if dialogInput.QB then
		local dialog = exports[Config.ExportNames.input]:ShowInput({
			header = LangClient[Config.Language].dialog['withdrawfunds_header']:format(currency, v["funds"]),
			submitText = LangClient[Config.Language].dialog['withdrawfunds_submit'],
			inputs = {
				{
					text = LangClient[Config.Language].dialog['withdrawfunds_text'],
					name = "amount",
					type = "number",
					isRequired = true
				}
			}
		})
		
		if dialog ~= nil then
			TriggerServerEvent('ap-government:server:sortfunds', "withdraw", v, dialog.amount)
		end
	elseif dialogInput.OX then
		local dialog = lib.inputDialog(LangClient[Config.Language].dialog['withdrawfunds_header']:format(currency, v["funds"]), {LangClient[Config.Language].dialog['withdrawfunds_text']})
		if dialog then
			if dialog[1] ~= nil then
				TriggerServerEvent('ap-government:server:sortfunds', "withdraw", v, dialog[1]) 
			end
		end
	end
end)

RegisterNetEvent('ap-government:client:depositfunds', function(v)
	if dialogInput.QB then
		local dialog = exports[Config.ExportNames.input]:ShowInput({
			header = LangClient[Config.Language].dialog['depositfunds_header']:format(currency, v["funds"]),
			submitText = LangClient[Config.Language].dialog['depositfunds_submit'],
			inputs = {
				{
					text = LangClient[Config.Language].dialog['depositfunds_text'],
					name = "amount",
					type = "number",
					isRequired = true
				}
			}
		})
		
		if dialog ~= nil then
			TriggerServerEvent('ap-government:server:sortfunds', "deposit", v, dialog.amount)
		end
	elseif dialogInput.OX then
		local dialog = lib.inputDialog(LangClient[Config.Language].dialog['depositfunds_header']:format(currency, v["funds"]), {LangClient[Config.Language].dialog['depositfunds_text']})
		if dialog then
			if dialog[1] ~= nil then
				TriggerServerEvent('ap-government:server:sortfunds', "deposit", v, dialog[1])
			end
		end
	end
end)

RegisterNetEvent('ap-government:client:manageUnpaidTaxAccounts', function(v)
  QBCore.Functions.TriggerCallback('ap-government:callback:getName', function(data)		
	local state, OwnerData = nil, nil
	if v.owner ~= "COMPANY OWNER" then
	  state = LangClient[Config.Language].menus['manageUnpaidTaxAccounts_state_one']:format(data.name)
	  OwnerData = data
	elseif v.owner == "COMPANY OWNER" then
	  state = LangClient[Config.Language].menus['manageUnpaidTaxAccounts_state_two']	
	end
	if context.QB then
		local taxAccountsShow = {
			{
				header = LangClient[Config.Language].menus['manageUnpaidTaxAccounts_header_one'],
				txt = LangClient[Config.Language].menus['manageUnpaidTaxAccounts_txt_one']:format(v.label),
				isMenuHeader = true
			},
			{
				header = LangClient[Config.Language].menus['manageUnpaidTaxAccounts_header_two'],
				txt = LangClient[Config.Language].menus['manageUnpaidTaxAccounts_txt_two']:format(v.total_tax_paid),
				isMenuHeader = true
			},
			{
				header = LangClient[Config.Language].menus['manageUnpaidTaxAccounts_header_three'],
				txt = LangClient[Config.Language].menus['manageUnpaidTaxAccounts_txt_three']:format(v.amount_owed),
				isMenuHeader = true
			},
			{
				header = LangClient[Config.Language].menus['manageUnpaidTaxAccounts_header_four'],
				txt = LangClient[Config.Language].menus['manageUnpaidTaxAccounts_txt_four']:format(state),
				isMenuHeader = true
			},
			{
				header = LangClient[Config.Language].menus['manageUnpaidTaxAccounts_header_five'],
				txt = LangClient[Config.Language].menus['manageUnpaidTaxAccounts_txt_five'],
				params = {
					isServer = true,
					event = "ap-government:server:takeFullPayment",
					args = v
				}
			},
			{
				header = LangClient[Config.Language].menus['manageUnpaidTaxAccounts_header_six'],
				txt = LangClient[Config.Language].menus['manageUnpaidTaxAccounts_txt_six'],
				params = {
					isServer = true,
					event = "ap-government:server:clearUnpaidTax",
					args = v
				}
			},
		}
		if v.owner ~= "Government Owned" and v.owner ~= "COMPANY OWNER" then
		  if Config.Dirk_BountyHunterV2.UsingScript then
			table.insert(taxAccountsShow, {
			  header = LangClient[Config.Language].menus['manageUnpaidTaxAccounts_header_nine'],
			  txt = LangClient[Config.Language].menus['manageUnpaidTaxAccounts_txt_nine'],
			  params = {
				isServer = false,
				event = "ap-government:client:SetBounty",
				args = {
					CompanyOwnerName = OwnerData.name,
					CompanyOwnerID = v.owner,
					CompanyOwnerDOB = OwnerData.dob,
					OutstandingTax = v.amount_owed,
					CompanyID = v.business,
					CompanyTotalPaid = v.total_tax_paid
				}
			  }
			})
		  end
		  table.insert(taxAccountsShow, {
			header = LangClient[Config.Language].menus['manageUnpaidTaxAccounts_header_seven'],
			txt = LangClient[Config.Language].menus['manageUnpaidTaxAccounts_txt_seven'],
			params = {
				isServer = false,
				event = "ap-government:client:messageOwner",
				args = v
			}
		  })
		end
		table.insert(taxAccountsShow, {
			header = LangClient[Config.Language].menus['manageUnpaidTaxAccounts_header_eight'],
			txt = LangClient[Config.Language].menus['manageUnpaidTaxAccounts_txt_eight'],
			params = {
				isServer = false,
				event = "ap-government:client:viewunpaidtaxaccounts",
				args = {}
			}
		})
		ContextMenu(taxAccountsShow)
	elseif context.OX then
		local taxAccountsShow = {
			{
				title = LangClient[Config.Language].menus['manageUnpaidTaxAccounts_header_one'],
				description = LangClient[Config.Language].menus['manageUnpaidTaxAccounts_txt_one']:format(v.label),
				disabled = true
			},
			{
				title = LangClient[Config.Language].menus['manageUnpaidTaxAccounts_header_two'],
				description = LangClient[Config.Language].menus['manageUnpaidTaxAccounts_txt_two_OX']:format(v.total_tax_paid),
				disabled = true
			},
			{
				title = LangClient[Config.Language].menus['manageUnpaidTaxAccounts_header_three'],
				description = LangClient[Config.Language].menus['manageUnpaidTaxAccounts_txt_three_OX']:format(v.amount_owed),
				disabled = true
			},
			{
				title = LangClient[Config.Language].menus['manageUnpaidTaxAccounts_header_four'],
				description = LangClient[Config.Language].menus['manageUnpaidTaxAccounts_txt_four']:format(state),
				disabled = true
			},
			{
				title = LangClient[Config.Language].menus['manageUnpaidTaxAccounts_header_five'],
				description = LangClient[Config.Language].menus['manageUnpaidTaxAccounts_txt_five'],
				serverEvent = "ap-government:server:takeFullPayment",
				args = v
			},
			{
				title = LangClient[Config.Language].menus['manageUnpaidTaxAccounts_header_six'],
				description = LangClient[Config.Language].menus['manageUnpaidTaxAccounts_txt_six'],
				serverEvent = "ap-government:server:clearUnpaidTax",
				args = v
			},
		}
		if v.owner ~= "Government Owned" and v.owner ~= "COMPANY OWNER" then
		  if Config.Dirk_BountyHunterV2.UsingScript then
			table.insert(taxAccountsShow, {
			  title = LangClient[Config.Language].menus['manageUnpaidTaxAccounts_header_nine'],
			  description = LangClient[Config.Language].menus['manageUnpaidTaxAccounts_txt_nine'],
			  event = "ap-government:client:SetBounty",
			  args = {
				CompanyOwnerName = OwnerData.name,
				CompanyOwnerID = v.owner,
				CompanyOwnerDOB = OwnerData.dob,
				OutstandingTax = v.amount_owed,
				CompanyID = v.business,
				CompanyTotalPaid = v.total_tax_paid
			  }
			})
		  end	
		  table.insert(taxAccountsShow, {
			title = LangClient[Config.Language].menus['manageUnpaidTaxAccounts_header_seven'],
			description = LangClient[Config.Language].menus['manageUnpaidTaxAccounts_txt_seven'],
			event = "ap-government:client:messageOwner",
			args = v
		  })
		end
		table.insert(taxAccountsShow, {
			title = LangClient[Config.Language].menus['manageUnpaidTaxAccounts_header_eight'],
			description = LangClient[Config.Language].menus['manageUnpaidTaxAccounts_txt_eight'],
			event = "ap-government:client:viewunpaidtaxaccounts",
			args = {}
		})
		ContextMenu({
			id = 'taxAccountsShow',
			title = LangClient[Config.Language].menus['manageUnpaidTaxAccounts_title'],
			options = taxAccountsShow
		})
	end
  end, v.owner)
end)

RegisterNetEvent('ap-government:client:messageOwner', function(v)
	if dialogInput.QB then
		local dialog = exports[Config.ExportNames.input]:ShowInput({
			header = LangClient[Config.Language].dialog['messageOwner_header'],
			submitText = LangClient[Config.Language].dialog['messageOwner_submit'],
			inputs = {
				{
					text = LangClient[Config.Language].dialog['messageOwner_text'],
					name = "reason",
					type = "text",
					isRequired = true
				}
			}
		})
		
		if dialog ~= nil then
			if dialog.reason == nil then
				TriggerEvent('ap-government:notify',LangClient[Config.Language].notifications['message_owner_error'])
			else
				TriggerServerEvent('ap-government:server:messageOwner', v, dialog.reason)  
			end
		end
	elseif dialogInput.OX then
		local dialog = lib.inputDialog(LangClient[Config.Language].dialog['messageOwner_header'], {LangClient[Config.Language].dialog['messageOwner_text']})
		if dialog then
			if dialog[1] == nil then
				TriggerEvent('ap-government:notify',LangClient[Config.Language].notifications['message_owner_error'])
			else
				TriggerServerEvent('ap-government:server:messageOwner', v, dialog[1]) 
			end
		end
	end
end)

RegisterNetEvent('ap-government:client:removeCandidate', function(v)
	if dialogInput.QB then
		local dialog = exports[Config.ExportNames.input]:ShowInput({
			header = LangClient[Config.Language].dialog['removeCandidate_header'],
			submitText = LangClient[Config.Language].dialog['removeCandidate_submit'],
			inputs = {
				{
					text = LangClient[Config.Language].dialog['removeCandidate_text'],
					name = "reason",
					type = "text",
					isRequired = true
				}
			}
		})
		
		if dialog ~= nil then
			if dialog.reason == nil then
				TriggerEvent('ap-government:notify',LangClient[Config.Language].notifications['removeCandidate_error'])
			else
				TriggerServerEvent('ap-government:server:removeCandidate', v, dialog.reason)  
			end
		end
	elseif dialogInput.OX then
		local dialog = lib.inputDialog(LangClient[Config.Language].dialog['removeCandidate_header'], {LangClient[Config.Language].dialog['removeCandidate_text']})
		if dialog then
			if dialog[1] == nil then
				TriggerEvent('ap-government:notify',LangClient[Config.Language].notifications['removeCandidate_error'])
			else
				TriggerServerEvent('ap-government:server:removeCandidate', v, dialog[1]) 
			end
		end
	end
end)

RegisterNetEvent('ap-government:client:taxSettings', function()
	if context.QB then
		local otherTaxMenu = {
			{
				header = LangClient[Config.Language].menus['taxSettings_header_one'],
				isMenuHeader = true,
			},
		}
		
		for k,v in pairs(cfgTax.MayorControl.TaxTypes) do
			if v.enable then
				table.insert(otherTaxMenu,  {
					header = LangClient[Config.Language].menus['taxSettings_header_two']:format(v.label), 
					txt = LangClient[Config.Language].menus['taxSettings_txt_one'],
					params = {
						isServer = false,
						event = "ap-government:client:taxcontrol",
						args = v
					}
				}) 			
			end 
		end
		table.insert(otherTaxMenu, {
			header = LangClient[Config.Language].menus['taxSettings_header_three'],
			txt = LangClient[Config.Language].menus['taxSettings_txt_two'],
			params = {
				isServer = false,
				event = "ap-government:client:majorOffice",
				args = {}
			}	
		})
		ContextMenu(otherTaxMenu)
	elseif context.OX then
		local otherTaxMenu = {}
		for k,v in pairs(cfgTax.MayorControl.TaxTypes) do
			if v.enable then
				table.insert(otherTaxMenu,  {
					title = LangClient[Config.Language].menus['taxSettings_header_two']:format(v.label), 
					description = LangClient[Config.Language].menus['taxSettings_txt_one'],
					event = "ap-government:client:taxcontrol",
					args = v
				}) 			
			end 
		end
		table.insert(otherTaxMenu, {
			title = LangClient[Config.Language].menus['taxSettings_header_three'],
			description = LangClient[Config.Language].menus['taxSettings_txt_two'],
			event = "ap-government:client:majorOffice",
			args = {}
		})
		ContextMenu({
			id = 'otherTaxMenu',
			title = LangClient[Config.Language].menus['taxSettings_header_one'],
			options = otherTaxMenu
		})
	end
end)

RegisterNetEvent('ap-government:client:taxcontrol', function(v)
	QBCore.Functions.TriggerCallback('ap-government:getDBTax', function(tax)
		local controlPercent = nil
		if v.mayorControl then
		  controlPercent = LangClient[Config.Language].menus['taxcontrol_control_percent_one']:format(tax[v.label], "%")
		else
		  controlPercent = LangClient[Config.Language].menus['taxcontrol_control_percent_two']:format(v.percentage, "%")
		end
		if context.QB then
			local taxAccountsShowNow = {
				{
					header = LangClient[Config.Language].menus['taxcontrol_header_one'],
					txt = LangClient[Config.Language].menus['taxcontrol_txt_one']:format(v.label),
					isMenuHeader = true
				},
				{
					header = LangClient[Config.Language].menus['taxcontrol_header_two'],
					txt = LangClient[Config.Language].menus['taxcontrol_txt_two']:format(controlPercent),
					isMenuHeader = true
				},
			}
			if v.mayorControl then
			  table.insert(taxAccountsShowNow, {
				header = LangClient[Config.Language].menus['taxcontrol_header_three'],
				txt = LangClient[Config.Language].menus['taxcontrol_txt_three'],
				params = {
					isServer = false,
					event = "ap-government:client:changeTaxCity",
					args = {
						v = v,
						tax = tax
					}
				}	
			  })
			end
			table.insert(taxAccountsShowNow, {
				header = LangClient[Config.Language].menus['taxcontrol_header_four'],
				txt = LangClient[Config.Language].menus['taxcontrol_txt_four'],
				params = {
					isServer = false,
					event = "ap-government:client:taxSettings",
					args = {}
				}	
			})
			ContextMenu(taxAccountsShowNow)
		elseif context.OX then
			local taxAccountsShowNow = {
				{
					title = LangClient[Config.Language].menus['taxcontrol_header_one'],
					description = LangClient[Config.Language].menus['taxcontrol_txt_one']:format(v.label),
					disabled = true
				},
				{
					title = LangClient[Config.Language].menus['taxcontrol_header_two'],
					description = LangClient[Config.Language].menus['taxcontrol_txt_two']:format(controlPercent),
					disabled = true
				},
			}
			if v.mayorControl then
			  table.insert(taxAccountsShowNow, {
				title = LangClient[Config.Language].menus['taxcontrol_header_three'],
				description = LangClient[Config.Language].menus['taxcontrol_txt_three'],
				event = "ap-government:client:changeTaxCity",
				args = {
					v = v,
					tax = tax
				}
			  })
			end
			table.insert(taxAccountsShowNow, {
				title = LangClient[Config.Language].menus['taxcontrol_header_four'],
				description = LangClient[Config.Language].menus['taxcontrol_txt_four'],
				event = "ap-government:client:taxSettings",
				args = {}	
			})
			ContextMenu({
				id = 'taxcontrol',
				title = LangClient[Config.Language].menus['taxcontrol_title'],
				options = taxAccountsShowNow
			})
		end
	end)
end)

RegisterNetEvent('ap-government:client:changeTaxCity', function(data)
	if dialogInput.QB then
		local dialog = exports[Config.ExportNames.input]:ShowInput({
			header = LangClient[Config.Language].dialog['changeTaxCity_header']:format(data.v.label),
			submitText = LangClient[Config.Language].dialog['changeTaxCity_submit'],
			inputs = {
				{
					text = LangClient[Config.Language].dialog['changeTaxCity_text']:format(data.tax[data.v.label], "%"),
					name = "taxp",
					type = "text",
					isRequired = true
				}
			}
		})
		
		if dialog ~= nil then
			if tonumber(dialog.taxp) >= 1 or tonumber(dialog.taxp) <= 0.00 then
				TriggerEvent('ap-government:notify',LangClient[Config.Language].notifications['change_city_tax_error_one'])
			else
			  if tonumber(dialog.taxp) >= Config.Tax.MayorControl.TaxTypes[data.v.label].percentageCap then
				TriggerEvent('ap-government:notify',LangClient[Config.Language].notifications['change_city_tax_error_two']:format(Config.Tax.MayorControl.TaxTypes[data.v.label].percentageCap, "%"))
			  else
				TriggerServerEvent('ap-government:server:changeTaxCity', data.v, dialog.taxp)  
			  end
			end
		end
	elseif dialogInput.OX then
		local dialog = lib.inputDialog(LangClient[Config.Language].dialog['changeTaxCity_header']:format(data.v.label), {LangClient[Config.Language].dialog['changeTaxCity_text']:format(data.tax[data.v.label], "%")})
		if dialog then
			if tonumber(dialog[1]) >= 1 or tonumber(dialog[1]) <= 0.00 then
				TriggerEvent('ap-government:notify',LangClient[Config.Language].notifications['change_city_tax_error_one'])
			else
			  if tonumber(dialog[1]) >= Config.Tax.MayorControl.TaxTypes[data.v.label].percentageCap then
				TriggerEvent('ap-government:notify',LangClient[Config.Language].notifications['change_city_tax_error_two']:format(Config.Tax.MayorControl.TaxTypes[data.v.label].percentageCap, "%"))
			  else
				TriggerServerEvent('ap-government:server:changeTaxCity', data.v, dialog[1])
			  end
			end
		end
	end
end)

RegisterNetEvent('ap-government:client:openVotingSystem', function()
  if hasVoted ~= true then
    SendNUIMessage({
	  type  = "show",
	})
	SetNuiFocus(true,true)
  end
end)

RegisterNetEvent('ap-government:client:registerBusiness', function()
  QBCore.Functions.TriggerCallback('ap-government:callback:players', function(players)
	if context.QB then
		local registerBusinessMenu = {
			{
				header = LangClient[Config.Language].menus['registerBusiness_header_one'],
				isMenuHeader = true,
			},
		}
		
		for k,v in pairs(players) do
			if v.isBoss == true then
				table.insert(registerBusinessMenu,  {
					header = LangClient[Config.Language].menus['registerBusiness_header_two']:format(v.name), 
					txt = LangClient[Config.Language].menus['registerBusiness_txt_one']:format(v.job_label),
					params = {
						isServer = false,
						event = "ap-government:client:pincheck",
						args = v
					}
				}) 			
			end 
		end
		table.insert(registerBusinessMenu, {
			header = LangClient[Config.Language].menus['registerBusiness_header_three'],
			txt = LangClient[Config.Language].menus['registerBusiness_txt_two'],
			params = {
				isServer = false,
				event = "ap-government:client:majorOffice",
				args = {}
			}	
		})
		ContextMenu(registerBusinessMenu)
	elseif context.OX then
		local registerBusinessMenu = {}
		
		for k,v in pairs(players) do
			if v.isBoss == true then
				table.insert(registerBusinessMenu,  {
					title = LangClient[Config.Language].menus['registerBusiness_header_two']:format(v.name), 
					description = LangClient[Config.Language].menus['registerBusiness_txt_one']:format(v.job_label),
					event = "ap-government:client:pincheck",
					args = v
				}) 			
			end 
		end
		table.insert(registerBusinessMenu, {
			title = LangClient[Config.Language].menus['registerBusiness_header_three'],
			description = LangClient[Config.Language].menus['registerBusiness_txt_two'],
			event = "ap-government:client:majorOffice",
			args = {}
		})
		ContextMenu({
			id = 'registerBusinessMenu',
			title = LangClient[Config.Language].menus['registerBusiness_header_one'],
			options = registerBusinessMenu
		})
	end
  end)
end)

RegisterNetEvent('ap-government:client:pincheck', function(v)
	if Config.BusinessTax.securityVerify then
	  local pin = math.random(1000, 9999)
	  TriggerServerEvent('ap-government:server:verifyPin', pin, v)
	else
	  TriggerEvent("ap-government:client:registerplayercompany", v)
	end
end)

RegisterNetEvent('ap-government:client:securitychecks', function(pin, v)
	if dialogInput.QB then
		local dialog = exports[Config.ExportNames.input]:ShowInput({
			header = LangClient[Config.Language].dialog['securitychecks_header'],
			submitText = LangClient[Config.Language].dialog['securitychecks_submit'],
			inputs = {
				{
					text = LangClient[Config.Language].dialog['securitychecks_text'],
					name = "data",
					type = "number",
					isRequired = true
				}
			}
		})
		
		if dialog ~= nil then
		  if tonumber(dialog.data) == tonumber(pin) then
			TriggerEvent('ap-government:client:registerplayercompany', v)
		  else
			TriggerEvent('ap-government:client:securitychecks', pin, v)
		  end
		end
	elseif dialogInput.OX then
		local dialog = lib.inputDialog(LangClient[Config.Language].dialog['securitychecks_header'], {LangClient[Config.Language].dialog['securitychecks_text']})
		if dialog then
		  if tonumber(dialog[1]) == tonumber(pin) then
	        TriggerEvent('ap-government:client:registerplayercompany', v)
	      else
		    TriggerEvent('ap-government:client:securitychecks', pin, v)
	      end
		end
	end
end)

RegisterNetEvent('ap-government:client:registerplayercompany', function(v)
  QBCore.Functions.TriggerCallback('ap-government:callback:checkifregisterd', function(Owned)
	if context.QB then
		local registerplayercompany = {
			{
				header = LangClient[Config.Language].menus['registerplayercompany_header_one'],
				txt = LangClient[Config.Language].menus['registerplayercompany_txt_one']:format(v.job_label),
				isMenuHeader = true
			},
		}
		if Owned then
			table.insert(registerplayercompany, {
				header = LangClient[Config.Language].menus['registerplayercompany_header_two'],
				txt = LangClient[Config.Language].menus['registerplayercompany_txt_two']:format(v.job_label, v.name),
				params = {
					isServer = true,
					event = "ap-government:server:transferplayercompany",
					args = v
				}
			})
			if Config.MayorOptions.funds.grants.enable then
				table.insert(registerplayercompany, {
					header = LangClient[Config.Language].menus['registerplayercompany_header_three'],
					txt = LangClient[Config.Language].menus['registerplayercompany_txt_three'],
					params = {
						isServer = false,
						event = "ap-government:client:grants",
						args = v
					}	
				})
			end
			if Config.BusinessTax.tax.mayorControl.changeAmount then
				table.insert(registerplayercompany, {
					header = LangClient[Config.Language].menus['registerplayercompany_header_four'],
					txt = LangClient[Config.Language].menus['registerplayercompany_txt_four'],
					params = {
						isServer = false,
						event = "ap-government:client:changeplayercompanytax",
						args = v
					}
				})
			end	
		else
			table.insert(registerplayercompany, {
				header = LangClient[Config.Language].menus['registerplayercompany_header_five'],
				txt = LangClient[Config.Language].menus['registerplayercompany_txt_five']:format(v.job_label),
				params = {
					isServer = true,
					event = "ap-government:server:registerplayercompany",
					args = v
				}
			})
		end
		table.insert(registerplayercompany, {
			header = LangClient[Config.Language].menus['registerplayercompany_header_six'],
			txt = LangClient[Config.Language].menus['registerplayercompany_txt_six'],
			params = {
				isServer = false,
				event = "ap-government:client:registerBusiness",
				args = {}
			}
		})
		ContextMenu(registerplayercompany)
	elseif context.OX then
		local registerplayercompany = {
			{
				title = LangClient[Config.Language].menus['registerplayercompany_header_one'],
				description = LangClient[Config.Language].menus['registerplayercompany_txt_one']:format(v.job_label),
				disabled = true
			},
		}
		if Owned then
			table.insert(registerplayercompany, {
				title = LangClient[Config.Language].menus['registerplayercompany_header_two'],
				description = LangClient[Config.Language].menus['registerplayercompany_txt_two']:format(v.job_label, v.name),
				serverEvent = "ap-government:server:transferplayercompany",
				args = v
			})
			if Config.MayorOptions.funds.grants.enable then
				table.insert(registerplayercompany, {
					title = LangClient[Config.Language].menus['registerplayercompany_header_three'],
					description = LangClient[Config.Language].menus['registerplayercompany_txt_three'],
				    event = "ap-government:client:grants",
				    args = v
				})
			end
			if Config.BusinessTax.tax.mayorControl.changeAmount then
				table.insert(registerplayercompany, {
					title = LangClient[Config.Language].menus['registerplayercompany_header_four'],
					description = LangClient[Config.Language].menus['registerplayercompany_txt_four'],
				    event = "ap-government:client:changeplayercompanytax",
				    args = v
				})
			end	
		else
			table.insert(registerplayercompany, {
				title = LangClient[Config.Language].menus['registerplayercompany_header_five'],
				description = LangClient[Config.Language].menus['registerplayercompany_txt_five']:format(v.job_label),
				serverEvent = "ap-government:server:registerplayercompany",
				args = v
			})
		end
		table.insert(registerplayercompany, {
			title = LangClient[Config.Language].menus['registerplayercompany_header_six'],
			description = LangClient[Config.Language].menus['registerplayercompany_txt_six'],
			event = "ap-government:client:registerBusiness",
			args = {}
		})
		ContextMenu({
			id = 'registerplayercompany',
			title = LangClient[Config.Language].menus['registerplayercompany_title'],
			options = registerplayercompany
		})
	end
  end, v)
end)

RegisterNetEvent('ap-government:client:changeplayercompanytax', function(v)
  QBCore.Functions.TriggerCallback('ap-government:callback:getBusinessAccount', function(acc)
	if dialogInput.QB then
		local dialog = exports[Config.ExportNames.input]:ShowInput({
			header = LangClient[Config.Language].dialog['changeplayercompanytax_header'],
			submitText = LangClient[Config.Language].dialog['changeplayercompanytax_submit'],
			inputs = {
				{
					text = LangClient[Config.Language].dialog['changeplayercompanytax_text']:format(currency, acc),
					name = "amount",
					type = "number",
					isRequired = true
				}
			}
		})
		
		if dialog ~= nil then
		  TriggerServerEvent('ap-government:server:changeplayercompanytax', dialog.amount, acc, v)
		end
	elseif dialogInput.OX then
		local dialog = lib.inputDialog(LangClient[Config.Language].dialog['changeplayercompanytax_header'], {LangClient[Config.Language].dialog['changeplayercompanytax_text']:format(currency, acc)})
		if dialog then
		  TriggerServerEvent('ap-government:server:changeplayercompanytax', dialog[1], acc, v)
		end
	end
  end, v.job_name)
end)

RegisterNetEvent('ap-government:client:appointments', function(data)
	local appointmentsMayor = {}
	if context.QB then
		if data.state == 2 then
			local date = json.decode(data.appData)
			table.insert(appointmentsMayor, {
				header = LangClient[Config.Language].menus['appointments_state_two_header_one'],
				txt = LangClient[Config.Language].menus['appointments_state_two_txt_one']:format(date["reason"]),
				isMenuHeader = true
			})
			table.insert(appointmentsMayor, {
				header = LangClient[Config.Language].menus['appointments_state_two_header_two'],
				txt = LangClient[Config.Language].menus['appointments_state_two_txt_two']:format(date["date"]),
				isMenuHeader = true
			}) 
			table.insert(appointmentsMayor, {
				header = LangClient[Config.Language].menus['appointments_state_two_header_three'],
				txt = LangClient[Config.Language].menus['appointments_state_two_txt_three'],
				params = {
					isServer = true,
					event = "ap-government:server:cancelAppointment",
					args = data
				}
			})
		elseif data.state == 1 then
			table.insert(appointmentsMayor, {
				header = LangClient[Config.Language].menus['appointments_state_one_header_one'],
				txt = LangClient[Config.Language].menus['appointments_state_one_txt_one'],
				isMenuHeader = true
			}) 
			table.insert(appointmentsMayor, {
				header = LangClient[Config.Language].menus['appointments_state_one_header_two'],
				txt = LangClient[Config.Language].menus['appointments_state_one_txt_two'],
				params = {
					isServer = true,
					event = "ap-government:server:cancelAppointment",
					args = data
				}
			})
		elseif data.state == 0 then
			table.insert(appointmentsMayor, {
				header = LangClient[Config.Language].menus['appointments_state_zero_header'],
				txt = LangClient[Config.Language].menus['appointments_state_zero_txt'],
				params = {
					isServer = false,
					event = "ap-government:client:appointmentReason",
					args = data
				}
			})
		end
		ContextMenu(appointmentsMayor)
	elseif context.OX then
		if data.state == 2 then
			local date = json.decode(data.appData)
			table.insert(appointmentsMayor, {
				title = LangClient[Config.Language].menus['appointments_state_two_header_one'],
				description = LangClient[Config.Language].menus['appointments_state_two_txt_one']:format(date["reason"]),
				disabled = true
			})
			table.insert(appointmentsMayor, {
				title = LangClient[Config.Language].menus['appointments_state_two_header_two'],
				description = LangClient[Config.Language].menus['appointments_state_two_txt_two']:format(date["date"]),
				disabled = true
			}) 
			table.insert(appointmentsMayor, {
				title = LangClient[Config.Language].menus['appointments_state_two_header_three'],
				description = LangClient[Config.Language].menus['appointments_state_two_txt_three'],
				serverEvent = "ap-government:server:cancelAppointment",
				args = data
			})
		elseif data.state == 1 then
			table.insert(appointmentsMayor, {
				title = LangClient[Config.Language].menus['appointments_state_one_header_one_OX'],
				description = LangClient[Config.Language].menus['appointments_state_one_txt_one'],
				disabled = true
			}) 
			table.insert(appointmentsMayor, {
				title = LangClient[Config.Language].menus['appointments_state_one_header_two'],
				description = LangClient[Config.Language].menus['appointments_state_one_txt_two'],
				serverEvent = "ap-government:server:cancelAppointment",
				args = data
			})
		elseif data.state == 0 then
			table.insert(appointmentsMayor, {
				title = LangClient[Config.Language].menus['appointments_state_zero_header'],
				description = LangClient[Config.Language].menus['appointments_state_zero_txt'],
				event = "ap-government:client:appointmentReason",
				args = data
			})
		end
		ContextMenu({
			id = 'appointmentsMayor',
			title = LangClient[Config.Language].menus['appointments_title'],
			options = appointmentsMayor
		})
	end
end)

RegisterNetEvent('ap-government:client:appointmentReason', function(v)
	if dialogInput.QB then
		local dialog = exports[Config.ExportNames.input]:ShowInput({
			header = LangClient[Config.Language].dialog['appointmentReason_header'],
			submitText = LangClient[Config.Language].dialog['appointmentReason_submit'],
			inputs = {
				{
					text = LangClient[Config.Language].dialog['appointmentReason_text'],
					name = "reason",
					type = "text",
					isRequired = true
				}
			}
		})
		
		if dialog ~= nil then
		  TriggerServerEvent('ap-government:server:submitAppointment', dialog.reason, v)
		end
	elseif dialogInput.OX then
		local dialog = lib.inputDialog(LangClient[Config.Language].dialog['appointmentReason_header'], {LangClient[Config.Language].dialog['appointmentReason_text']})
		if dialog then
			TriggerServerEvent('ap-government:server:submitAppointment', dialog[1], v)
		end
	end
end)

RegisterNetEvent('ap-government:client:passEvent', function()
  TriggerServerEvent("ap-government:server:appointmentData")
end)

RegisterNetEvent('ap-government:client:appointmentsManage', function()
  QBCore.Functions.TriggerCallback('ap-government:callback:getAppointments', function(data)
	if context.QB then
		local mayorAppointments = {
			{
				header = LangClient[Config.Language].menus['appointmentsManage_header_one'],
				txt = LangClient[Config.Language].menus['appointmentsManage_txt_one'],
				params = {
					isServer = false,
					event = "ap-government:client:requestedAppointments",
					args = data
				}
			},
			{
				header = LangClient[Config.Language].menus['appointmentsManage_header_two'],
				txt = LangClient[Config.Language].menus['appointmentsManage_txt_two'],
				params = {
					isServer = false,
					event = "ap-government:client:scheduledAppointments",
					args = data
				}	
			}
		}
		table.insert(mayorAppointments, {
			header = LangClient[Config.Language].menus['appointmentsManage_header_three'],
			txt = LangClient[Config.Language].menus['appointmentsManage_txt_three'],
			params = {
				isServer = false,
				event = "ap-government:client:majorOffice",
				args = v
			}	
		})
		ContextMenu(mayorAppointments)
	elseif context.OX then
		local mayorAppointments = {
			{
				title = LangClient[Config.Language].menus['appointmentsManage_header_one'],
				description = LangClient[Config.Language].menus['appointmentsManage_txt_one'],
				event = "ap-government:client:requestedAppointments",
				args = data
			},
			{
				title = LangClient[Config.Language].menus['appointmentsManage_header_two'],
				description = LangClient[Config.Language].menus['appointmentsManage_txt_two'],
				event = "ap-government:client:scheduledAppointments",
				args = data
			}
		}
		table.insert(mayorAppointments, {
			title = LangClient[Config.Language].menus['appointmentsManage_header_three'],
			description = LangClient[Config.Language].menus['appointmentsManage_txt_three'],
			event = "ap-government:client:majorOffice",
			args = v
		})
		ContextMenu({
			id = 'appointmentsManage',
			title = LangClient[Config.Language].menus['appointmentsManage_title'],
			options = mayorAppointments
		})
	end
  end)
end)

RegisterNetEvent('ap-government:client:scheduledAppointments', function(data)
	if context.QB then
		local scheduledAppointments = {
			{
				header = LangClient[Config.Language].menus['scheduledAppointments_header_one'],
				txt = LangClient[Config.Language].menus['scheduledAppointments_txt_one'],
				isMenuHeader = true
			},
		}
		if data ~= nil then
		  for k, v in pairs(data) do
			if v.state == 2 then
				table.insert(scheduledAppointments, {
					header = LangClient[Config.Language].menus['scheduledAppointments_header_two']:format(v.name),
					txt = LangClient[Config.Language].menus['scheduledAppointments_txt_two'],
					params = {
						isServer = false,
						event = "ap-government:client:manageAppointment",
						args = {
							v = v,
							type = "manage"
						}
					}	
				})
			end
		  end
		end
		table.insert(scheduledAppointments, {
			header = LangClient[Config.Language].menus['scheduledAppointments_header_three'],
			txt = LangClient[Config.Language].menus['scheduledAppointments_txt_three'],
			params = {
				isServer = false,
				event = "ap-government:client:appointmentsManage",
				args = v
			}	
		})
		ContextMenu(scheduledAppointments)
	elseif context.OX then
		local scheduledAppointments = {}
		if data ~= nil then
		  for k, v in pairs(data) do
			if v.state == 2 then
				table.insert(scheduledAppointments, {
					title = LangClient[Config.Language].menus['scheduledAppointments_header_two']:format(v.name),
					description = LangClient[Config.Language].menus['scheduledAppointments_txt_two'],
					event = "ap-government:client:manageAppointment",
					args = {
						v = v,
						type = "manage"
					}
				})
			end
		  end
		end
		table.insert(scheduledAppointments, {
			title = LangClient[Config.Language].menus['scheduledAppointments_header_three'],
			description = LangClient[Config.Language].menus['scheduledAppointments_txt_three'],
			event = "ap-government:client:appointmentsManage",
			args = v
		})
		ContextMenu({
			id = 'scheduledAppointments',
			title = LangClient[Config.Language].menus['scheduledAppointments_header_one'],
			options = scheduledAppointments
		})
	end
end)


RegisterNetEvent('ap-government:client:requestedAppointments', function(data)
	if context.QB then
		local requestedAppointments = {
			{
				header = LangClient[Config.Language].menus['requestedAppointments_header_one'],
				txt = LangClient[Config.Language].menus['requestedAppointments_txt_one'],
				isMenuHeader = true
			},
		}
		if data ~= nil then
		  for k, v in pairs(data) do
			if v.state == 1 then
				table.insert(requestedAppointments, {
					header = LangClient[Config.Language].menus['requestedAppointments_header_two']:format(v.name),
					txt = LangClient[Config.Language].menus['requestedAppointments_txt_two'],
					params = {
						isServer = false,
						event = "ap-government:client:manageAppointment",
						args = {
							v = v,
							type = "setup"
						}
					}	
				})
			end
		  end
		end
		table.insert(requestedAppointments, {
			header = LangClient[Config.Language].menus['requestedAppointments_header_three'],
			txt = LangClient[Config.Language].menus['requestedAppointments_txt_three'],
			params = {
				isServer = false,
				event = "ap-government:client:appointmentsManage",
				args = v
			}	
		})
		ContextMenu(requestedAppointments)
	elseif context.OX then
		local requestedAppointments = {}
		if data ~= nil then
		  for k, v in pairs(data) do
			if v.state == 1 then
				table.insert(requestedAppointments, {
					title = LangClient[Config.Language].menus['requestedAppointments_header_two']:format(v.name),
					description = LangClient[Config.Language].menus['requestedAppointments_txt_two'],
					event = "ap-government:client:manageAppointment",
					args = {
						v = v,
						type = "setup"
					}
				})
			end
		  end
		end
		table.insert(requestedAppointments, {
			title = LangClient[Config.Language].menus['requestedAppointments_header_three'],
			description = LangClient[Config.Language].menus['requestedAppointments_txt_three'],
			event = "ap-government:client:appointmentsManage",
			args = v	
		})
		ContextMenu({
			id = 'requestedAppointments',
			title = LangClient[Config.Language].menus['requestedAppointments_header_one'],
			options = requestedAppointments
		})
	end
end)

RegisterNetEvent('ap-government:client:manageAppointment', function(data)
  local v, input = data.v, data.type
  if input == "setup" then
	local date = json.decode(v.appData)
	if context.QB then
		local setupAppointment = {
			{
				header = LangClient[Config.Language].menus['manageAppointment_setup_header_one']:format(v.name),
				txt = LangClient[Config.Language].menus['manageAppointment_setup_txt_one'],
				isMenuHeader = true
			},
			{
				header = LangClient[Config.Language].menus['manageAppointment_setup_header_two'],
				txt = LangClient[Config.Language].menus['manageAppointment_setup_txt_two']:format(date["reason"]),
				isMenuHeader = true
			},
			{
				header = LangClient[Config.Language].menus['manageAppointment_setup_header_three'],
				txt = LangClient[Config.Language].menus['manageAppointment_setup_txt_three'],
				params = {
					isServer = false,
					event = "ap-government:client:issueAppointment",
					args = v
				}
			},
			{
				header = LangClient[Config.Language].menus['manageAppointment_setup_header_four'],
				txt = LangClient[Config.Language].menus['manageAppointment_setup_txt_four'],
				params = {
					isServer = true,
					event = "ap-government:server:mayorCancelAppointment",
					args = v
				}
			},
			{
				header = LangClient[Config.Language].menus['manageAppointment_setup_header_five'],
				txt = LangClient[Config.Language].menus['manageAppointment_setup_txt_five'],
				params = {
					isServer = false,
					event = "ap-government:client:appointmentsManage",
					args = v
				}
			}
		}
		ContextMenu(setupAppointment)
	elseif context.OX then
		ContextMenu({
			id = 'setupAppointment',
			title = LangClient[Config.Language].menus['manageAppointment_setup_title'],
			options = {
				{
					title = LangClient[Config.Language].menus['manageAppointment_setup_header_one']:format(v.name),
					description = LangClient[Config.Language].menus['manageAppointment_setup_txt_one'],
					disabled = true
				},
				{
					title = LangClient[Config.Language].menus['manageAppointment_setup_header_two'],
					description = LangClient[Config.Language].menus['manageAppointment_setup_txt_two']:format(date["reason"]),
					disabled = true
				},
				{
					title = LangClient[Config.Language].menus['manageAppointment_setup_header_three'],
					description = LangClient[Config.Language].menus['manageAppointment_setup_txt_three'],
					event = "ap-government:client:issueAppointment",
					args = v
				},
				{
					title = LangClient[Config.Language].menus['manageAppointment_setup_header_four'],
					description = LangClient[Config.Language].menus['manageAppointment_setup_txt_four'],
					serverEvent = "ap-government:server:mayorCancelAppointment",
					args = v
				},
				{
					title = LangClient[Config.Language].menus['manageAppointment_setup_header_five'],
					description = LangClient[Config.Language].menus['manageAppointment_setup_txt_five'],
					event = "ap-government:client:appointmentsManage",
					args = v
				}
			}
		})
	end
  elseif input == "manage" then
	local date = json.decode(v.appData)
	if context.QB then
		local manageCurrentAppointment = {
			{
				header = LangClient[Config.Language].menus['manageAppointment_manage_header_one']:format(v.name),
				txt = LangClient[Config.Language].menus['manageAppointment_manage_txt_one']:format(date["date"]),
				isMenuHeader = true
			},
			{
				header = LangClient[Config.Language].menus['manageAppointment_manage_header_two'],
				txt = LangClient[Config.Language].menus['manageAppointment_manage_txt_two']:format(date["reason"]),
				isMenuHeader = true
			},
			{
				header = LangClient[Config.Language].menus['manageAppointment_manage_header_three'],
				txt = LangClient[Config.Language].menus['manageAppointment_manage_txt_three'],
				params = {
					isServer = true,
					event = "ap-government:server:finishAppointment",
					args = v
				}
			},
			{
				header = LangClient[Config.Language].menus['manageAppointment_manage_header_four'],
				txt = LangClient[Config.Language].menus['manageAppointment_manage_txt_four'],
				params = {
					isServer = true,
					event = "ap-government:server:mayorCancelAppointment",
					args = v
				}
			},
			{
				header = LangClient[Config.Language].menus['manageAppointment_manage_header_five'],
				txt = LangClient[Config.Language].menus['manageAppointment_manage_txt_five'],
				params = {
					isServer = false,
					event = "ap-government:client:appointmentsManage",
					args = v
				}
			}
		}
		ContextMenu(manageCurrentAppointment)
	elseif context.OX then
		ContextMenu({
			id = 'manageCurrentAppointment',
			title = LangClient[Config.Language].menus['manageAppointment_manage_title'],
			options = {
				{
					title = LangClient[Config.Language].menus['manageAppointment_manage_header_one']:format(v.name),
					description = LangClient[Config.Language].menus['manageAppointment_manage_txt_one']:format(date["date"]),
					disabled = true
				},
				{
					title = LangClient[Config.Language].menus['manageAppointment_manage_header_two'],
					description = LangClient[Config.Language].menus['manageAppointment_manage_txt_two']:format(date["reason"]),
					disabled = true
				},
				{
					title = LangClient[Config.Language].menus['manageAppointment_manage_header_three'],
					description = LangClient[Config.Language].menus['manageAppointment_manage_txt_three'],
					serverEvent = "ap-government:server:finishAppointment",
					args = v
				},
				{
					title = LangClient[Config.Language].menus['manageAppointment_manage_header_four'],
					description = LangClient[Config.Language].menus['manageAppointment_manage_txt_four'],
					serverEvent = "ap-government:server:mayorCancelAppointment",
					args = v
				},
				{
					title = LangClient[Config.Language].menus['manageAppointment_manage_header_five'],
					description = LangClient[Config.Language].menus['manageAppointment_manage_txt_five'],
					event = "ap-government:client:appointmentsManage",
					args = v
				}
			}
		})
	end
  end
end)

RegisterNetEvent('ap-government:client:issueAppointment', function(v)
	if dialogInput.QB then
		local dialog = exports[Config.ExportNames.input]:ShowInput({
			header = LangClient[Config.Language].dialog['issueAppointment_header'],
			submitText = LangClient[Config.Language].dialog['issueAppointment_submit'],
			inputs = {
				{
					text = LangClient[Config.Language].dialog['issueAppointment_text_one'],
					name = "date",
					type = "text",
					isRequired = true
				},
				{
					text = LangClient[Config.Language].dialog['issueAppointment_text_two'],
					name = "time",
					type = "text",
					isRequired = true
				}
			}
		})
		
		if dialog ~= nil then
		  local datetime = dialog.date .. " " .. dialog.time
		  TriggerServerEvent('ap-government:server:issueAppointment', datetime, v)
		end
	elseif dialogInput.OX then
		local dialog = lib.inputDialog(LangClient[Config.Language].dialog['issueAppointment_header'], {LangClient[Config.Language].dialog['issueAppointment_text_one'],LangClient[Config.Language].dialog['issueAppointment_text_two']})
		if dialog then
			local datetime = dialog[1] .. " " .. dialog[2]
			TriggerServerEvent('ap-government:server:issueAppointment', datetime, v)
		end
	end
end)

RegisterNetEvent('ap-government:client:grants', function(v)
	if context.QB then
		local grants = {
			{
				header = LangClient[Config.Language].menus['grants_header_one'],
				txt = LangClient[Config.Language].menus['grants_txt_one'],
				params = {
					isServer = false,
					event = "ap-government:client:issueGrant",
					args = v
				}
			},
			{
				header = LangClient[Config.Language].menus['grants_header_two'],
				txt = LangClient[Config.Language].menus['grants_txt_two'],
				params = {
					isServer = false,
					event = "ap-government:client:grantHistory",
					args = v
				}	
			}
		}
		table.insert(grants, {
			header = LangClient[Config.Language].menus['grants_header_three'],
			txt = LangClient[Config.Language].menus['grants_txt_three'],
			params = {
				isServer = false,
				event = "ap-government:client:registerplayercompany",
				args = v
			}	
		})
		ContextMenu(grants)
	elseif context.OX then
		local grants = {
			{
				title = LangClient[Config.Language].menus['grants_header_one'],
				description = LangClient[Config.Language].menus['grants_txt_one'],
				event = "ap-government:client:issueGrant",
				args = v
			},
			{
				title = LangClient[Config.Language].menus['grants_header_two'],
				description = LangClient[Config.Language].menus['grants_txt_two'],
				event = "ap-government:client:grantHistory",
				args = v
			}
		}
		table.insert(grants, {
			title = LangClient[Config.Language].menus['grants_header_three'],
			description = LangClient[Config.Language].menus['grants_txt_three'],
			event = "ap-government:client:registerplayercompany",
			args = v	
		})
		ContextMenu({
			id = 'grants',
			title = LangClient[Config.Language].menus['grants_title'],
			options = grants
		})
	end
end)

RegisterNetEvent('ap-government:client:grantHistory', function(e)
  QBCore.Functions.TriggerCallback('ap-government:callback:getBusinessGrantHistory', function(data)
	if context.QB then
		local grantMenu = {
			{
				header = LangClient[Config.Language].menus['grantHistory_header_one']:format(e.job_label),
				txt = LangClient[Config.Language].menus['grantHistory_txt_one'],
				isMenuHeader = true
			},
		}
		if data ~= nil then
			for k, v in pairs(data) do
				table.insert(grantMenu, {
					header = LangClient[Config.Language].menus['grantHistory_header_two']:format(tostring(v.date)),
					txt = LangClient[Config.Language].menus['grantHistory_txt_two']:format(tostring(currency), tostring(v.amount), tostring(v.main)),
					isMenuHeader = true
				})
			end
		end
		table.insert(grantMenu, {
			header = LangClient[Config.Language].menus['grantHistory_header_three'],
			txt = LangClient[Config.Language].menus['grantHistory_txt_three'],
			params = {
				isServer = false,
				event = "ap-government:client:grants",
				args = e
			}	
		})
		ContextMenu(grantMenu)
	elseif context.OX then
		local grantMenu = {
			{
				title = LangClient[Config.Language].menus['grantHistory_header_one']:format(e.job_label),
				description = LangClient[Config.Language].menus['grantHistory_txt_one'],
				disabled = true
			},
		}
		if data ~= nil then
			for _, v in pairs(data) do
				table.insert(grantMenu, {
					title = LangClient[Config.Language].menus['grantHistory_header_two']:format(tostring(v.date)),
					description = LangClient[Config.Language].menus['grantHistory_txt_two']:format(tostring(currency), tostring(v.amount), tostring(v.main)),
					disabled = true
				})
			end
		end
		table.insert(grantMenu, {
			title = LangClient[Config.Language].menus['grantHistory_header_three'],
			description = LangClient[Config.Language].menus['grantHistory_txt_three'],
			event = "ap-government:client:grants",
			args = e
		})
		ContextMenu({
			id = 'grantMenu',
			title = LangClient[Config.Language].menus['grantHistory_title'],
			options = grantMenu
		})
	end
  end, e.job_name)
end)

RegisterNetEvent('ap-government:client:issueGrant', function(v)
	QBCore.Functions.TriggerCallback('ap-government:getJsonData', function(db)
		if dialogInput.QB then
			local dialog = exports[Config.ExportNames.input]:ShowInput({
				header = LangClient[Config.Language].dialog['issueGrant_header']:format(currency, db["funds"]),
				submitText = LangClient[Config.Language].dialog['issueGrant_submit'],
				inputs = {
					{
						text = LangClient[Config.Language].dialog['issueGrant_text_one'],
						name = "reason",
						type = "text",
						isRequired = true
					},
					{
						text = LangClient[Config.Language].dialog['issueGrant_text_two'],
						name = "amount",
						type = "number",
						isRequired = true
					}
				}
			})
			
			if dialog ~= nil then
			  TriggerServerEvent('ap-government:server:issueGrant', v, db["funds"], dialog.reason, dialog.amount)
			end
		elseif dialogInput.OX then
			local dialog = lib.inputDialog(LangClient[Config.Language].dialog['issueGrant_header']:format(currency, db["funds"]), {LangClient[Config.Language].dialog['issueGrant_text_one'],LangClient[Config.Language].dialog['issueGrant_text_two']})
			if dialog then
			  TriggerServerEvent('ap-government:server:issueGrant', v, db["funds"], dialog[1], dialog[2])
			end
		end
	end)
end)

----------------------------------------------------------------------------------------------------------------------------------------------

RegisterNetEvent('ap-government:client:SetBounty', function(data)
  local cfgDirk = Config.Dirk_BountyHunterV2.Option
  local BountyAmount, FineAmount = 0, 0

  if cfgDirk.BountyType == "percent" then BountyAmount = (data.OutstandingTax * cfgDirk.Amount) else BountyAmount = cfgDirk.Amount end
  if cfgDirk.Consequences.Fine then FineAmount = data.OutstandingTax else FineAmount = cfgDirk.Consequences.FineAmount end

  local bountyData = {
    OriginOffice = cfgDirk.OriginOffice,

    TargetName   = data.CompanyOwnerName,
    TargetID     = data.CompanyOwnerID,
    DOB          = data.CompanyOwnerDOB,
    Bounty       = BountyAmount,
    
    Reason       = cfgDirk.BountyReason:format(data.OutstandingTax),

    Consequences = {
      Fine              = true,
      FineAmount        = FineAmount,  
      Jail              = cfgDirk.Consequences.Jail,
      JailTime          = cfgDirk.Consequences.JailTime,
    },
  }

  data.BountyAmount = BountyAmount

  TriggerServerEvent("bountyoffices:createNewContract", bountyData, true)
  TriggerServerEvent("ap-government:server:SetBounty", data)
end)

RegisterNetEvent('ap-government:client:staffVotingMenu', function()
  QBCore.Functions.TriggerCallback('ap-government:getManagementData', function(data)
	for k,v in pairs(Config.Voting) do
	  Config.Voting[k].id = k
	end
	SendNUIMessage({
	  type  = "openManagementGov",
	  candidates = data['candidates'],
	  settings = data['settings'],
	  configVoting = Config.Voting,
	  pollInfo = Config.Voting[data['settings']['votingType']]
	})
	SetNuiFocus(true, true)
  end)
end)

CalcalateTime = function(minutes)
  local days = math.floor(minutes / 1440)
  local remainingMinutes = minutes % 1440
  local hours = math.floor(remainingMinutes / 60)
  local remainingSeconds = remainingMinutes % 60
  return LangClient[Config.Language].notifications['calcalateTimeClient']:format(days, hours, remainingSeconds)
end

RegisterNetEvent('ap-government:client:openLawVoting', function()
  QBCore.Functions.TriggerCallback('ap-government:getJsonLawData', function(laws)
	if Config.VotingLaws then
	  SendNUIMessage({
		type  = "openLawVoting",
		laws = laws
	  })
	  SetNuiFocus(true,true)
	else
	  TriggerEvent('ap-government:notify', LangClient[Config.Language].notifications['open_law_voting_error'])
	end
  end)
end)

RegisterNetEvent('ap-government:client:openLawVotingManagement', function()
  QBCore.Functions.TriggerCallback('ap-government:getJsonLawData', function(laws)
	  if Config.VotingLaws then
		SendNUIMessage({
		  type  = "openLawVotingManagement",
		  laws = laws,
		})
		SetNuiFocus(true,true)
	  else
		TriggerEvent('ap-government:notify', LangClient[Config.Language].notifications['open_law_voting_error'])
	  end
	end)
end)

RegisterNUICallback('updateLawVoting', function(data)
	print(json.encode(data, {indent = true}))
	TriggerServerEvent('ap-government:server:updateLawVoting', data.law)
end)

RegisterNUICallback('refreshVotingLaws', function()
  QBCore.Functions.TriggerCallback('ap-government:getJsonLawData', function(laws)
	SendNUIMessage({
	  type  = "refreshLaws",
	  laws = laws,
	})
  end)
end)

RegisterNUICallback('returnToLawCreator', function()
  SetNuiFocus(false, false)
  TriggerEvent('ap-government:client:majorOffice')
end)

RegisterNUICallback('createNewLaw', function(data)
  TriggerServerEvent('ap-government:server:createLaw', {name = data.lawName, description = data.lawDescription, time = data.minutesDifference})
end)

RegisterNetEvent('ap-government:client:openUINotiforcation', function(msg)
  SendNUIMessage({
    type  = "law-notiforcation",
	msg = msg,
  })
end)

RegisterNetEvent('ap-government:client:getManagementData', function()
  QBCore.Functions.TriggerCallback('ap-government:getManagementData', function(data)
	for k,v in pairs(Config.Voting) do
	  Config.Voting[k].id = k
	end
	SendNUIMessage({
	  type  = "openManagementGov",
	  candidates = data['candidates'],
	  settings = data['settings'],
	  configVoting = Config.Voting,
	  pollInfo = Config.Voting[data['settings']['votingType']]
	})
	SetNuiFocus(true, true)
  end)
end)

RegisterNUICallback('updateVotingState', function(data)
  TriggerServerEvent('ap-government:server:updatevotingState', data)
end)

RegisterNUICallback('startVotingPolls', function(data)
  TriggerServerEvent('ap-government:server:startVotingPolls', data)
end)

RegisterNUICallback('refreshVoting', function()
	QBCore.Functions.TriggerCallback('ap-government:getManagementData', function(data)
		for k,v in pairs(Config.Voting) do
		  Config.Voting[k].id = k
		end
		SendNUIMessage({
		  type  = "refreshManagement",
		  candidates = data['candidates'],
		  settings = data['settings'],
		  configVoting = Config.Voting,
		  pollInfo = Config.Voting[data['settings']['votingType']]
		})
	end)
end)

RegisterNUICallback('refreshVotingSettings', function(data,cb)
	QBCore.Functions.TriggerCallback('ap-government:getManagementData', function(data)
		for k,v in pairs(Config.Voting) do
		  Config.Voting[k].id = k
		end
		cb({
		  candidates = data['candidates'],
		  settings = data['settings'],
		  configVoting = Config.Voting,
		  pollInfo = Config.Voting[data['settings']['votingType']]
		})
	end)
end)

RegisterNetEvent('ap-government:client:passedLaws', function()
  QBCore.Functions.TriggerCallback('ap-government:getPassedLawData', function(data)
	SendNUIMessage({
	  type  = "passedLaws",
	  staff = data.s3taff,
	  laws = data.laws
	})
	SetNuiFocus(true, true)
  end)
end)

RegisterNUICallback('approveApplication', function(v)
   TriggerServerEvent('ap-government:server:candidateStatus', {v = v.data, input = "accept", reason = nil})
end)

RegisterNUICallback('denyApplication', function(v)
   TriggerServerEvent('ap-government:server:candidateStatus', {v = v.data, input = "deny", reason = v.data.reason})
end)

RegisterNUICallback('endVotingPolls', function()
  TriggerServerEvent('ap-government:server:finishVotingNew')
end)

RegisterNUICallback('terminateVoting', function()
  TriggerServerEvent('ap-government:server:terminateVoting')
end)

RegisterNUICallback('removeCandidate', function(v)
  TriggerServerEvent('ap-government:server:candidateRemoval', v.data)
end)

RegisterNUICallback('warnCandidate', function(v)
  TriggerServerEvent('ap-government:server:warnCandidate', v.data)
end)

RegisterNUICallback('removePassedLaw', function(v)
  TriggerServerEvent('ap-government:server:removePassedLaw', v.law)
end)


RegisterNUICallback('getLanguage', function(d,cb)
	cb(Config.Language)
end)
local QBCore = exports['qb-core']:GetCoreObject()

local currency = Config.Currency

RegisterNetEvent('ap-court:notifyLawyerCard')
AddEventHandler('ap-court:notifyLawyerCard', function(subText)
	RequestStreamedTextureDict('CHAR_MP_MORS_MUTUAL')
    BeginTextCommandThefeedPost("STRING")
    AddTextComponentSubstringPlayerName(subText)
    EndTextCommandThefeedPostMessagetext('CHAR_MP_MORS_MUTUAL', 'CHAR_MP_MORS_MUTUAL', false, 6, 'FSBA', 'Membership Card')
    EndTextCommandThefeedPostTicker(false, true)
end)

ContextMenu = function(data)
  if Config.Context.QB then
	exports[Config.ExportNames.menu]:openMenu(data)
  elseif Config.Context.OX then
	lib.showContext(data)
  end
end

local nhc = Config.Context

RegisterNetEvent('ap-court:barMenu', function()
    QBCore.Functions.TriggerCallback('ap-court:getMembers', function(state)
        local apOptions = {}

        for _, v in pairs(state) do
            local barState = v.bar_state

            local barConfig = {
                [8] = {
                    title = LangClient['bar_menu_8_header'],
                    description = LangClient['bar_menu_8_txt'],
                    icon = "fa-solid fa-ban",
                    disabled = true
                },
                [7] = {
                    title = LangClient['bar_menu_7_header'],
                    description = LangClient['bar_menu_7_txt'],
                    icon = "fa-solid fa-scale-balanced",
                    event = "ap-court:client:startJudgeTest",
                    isServer = false,
                    args = v
                },
                [6] = {
                    title = LangClient['bar_menu_6_header'],
                    description = LangClient['bar_menu_6_txt']:format(v.bar_r_reason),
                    icon = "fa-solid fa-xmark-circle",
                    disabled = true
                },
                [5] = {
                    title = LangClient['bar_menu_5_header_two'],
                    description = LangClient['bar_menu_5_txt']:format(currency, Config.NewIDCardCost),
                    icon = "fa-solid fa-id-card",
                    event = "ap-court:server:newLicense",
                    isServer = true,
                    args = v
                },
                [4] = {
                    multi = {
                        {
                            title = LangClient['bar_menu_4_header_one'],
                            description = LangClient['bar_menu_4_txt_one'],
                            icon = "fa-solid fa-clock",
                            disabled = true
                        },
                        {
                            title = LangClient['bar_menu_4_header_two'],
                            description = LangClient['bar_menu_4_txt_two'],
                            icon = "fa-solid fa-id-badge",
                            event = "ap-court:server:collectLicense",
                            isServer = true,
                            args = v
                        }
                    }
                },
                [3] = {
                    title = LangClient['bar_menu_3_header'],
                    description = LangClient['bar_menu_3_txt']:format(v.bar_r_reason),
                    icon = "fa-solid fa-comment-slash",
                    disabled = true
                },
                [2] = {
                    title = LangClient['bar_menu_2_header'],
                    description = LangClient['bar_menu_2_txt'],
                    icon = "fa-solid fa-file-lines",
                    disabled = true
                },
                [1] = {
                    title = LangClient['bar_menu_1_header'],
                    description = LangClient['bar_menu_1_txt'],
                    icon = "fa-solid fa-hourglass-start",
                    disabled = true
                },
                [0] = {
                    title = LangClient['bar_menu_0_header_two'],
                    description = LangClient['bar_menu_0_txt']:format(currency, Config.BarLicensePrice),
                    icon = "fa-solid fa-credit-card",
                    event = "ap-court:barPay",
                    isServer = true,
                    args = v
                }
            }

            local cfg = barConfig[barState]

            if nhc.AP then
                if cfg then
                    if cfg.multi then
                        for _, item in ipairs(cfg.multi) do
                            table.insert(apOptions, item)
                        end
                    else
                        table.insert(apOptions, cfg)
                    end
                end

            elseif nhc.QB and cfg then
                ContextMenu({
                    {
                        header = cfg.title,
                        txt = cfg.description,
                        isMenuHeader = cfg.disabled or cfg.icon == nil,
                        params = cfg.event and {
                            event = cfg.event,
                            args = cfg.args,
                            isServer = cfg.isServer
                        } or nil
                    }
                })

            elseif nhc.OX and cfg then
                local oxOptions = {}
                if cfg.multi then
                    for _, item in ipairs(cfg.multi) do
                        table.insert(oxOptions, {
                            title = item.title,
                            description = item.description,
                            icon = item.icon,
                            event = item.event,
                            serverEvent = item.isServer and item.event or nil,
                            args = item.args,
                            disabled = item.disabled
                        })
                    end
                else
                    table.insert(oxOptions, {
                        title = cfg.title,
                        description = cfg.description,
                        icon = cfg.icon,
                        event = cfg.event,
                        serverEvent = cfg.isServer and cfg.event or nil,
                        args = cfg.args,
                        disabled = cfg.disabled
                    })
                end

                lib.registerContext({
                    id = 'barstate' .. barState,
                    title = LangClient['bar_menu_title'],
                    options = oxOptions
                })

                ContextMenu('barstate' .. barState)
            end
        end

        if nhc.AP and #apOptions > 0 then
            MyUI.showContext(LangClient['bar_menu_title'], apOptions)
        end
    end)
end)

RegisterNetEvent('ap-court:startBarTest')
AddEventHandler('ap-court:startBarTest', function()
	StartBarTest()
end)

function StartBarTest()
    local ce = Config.ExamQuestions
    local ceO = Config.ExamOptions
	local questions = {}
	if Config.ExamScript.BCS then 
		for k, v in pairs(ce) do
			table.insert(questions, {
				question = v.Question,
				answers = {
					a = v.a,
					b = v.b,
					c = v.c,
					d = v.d,
					correct = v.Answer
				}
			})
		end
		
		exports['bcs_questionare']:openQuiz({
			title = ceO.title,
			description = ceO.description,
			image = ceO.image,
			minimum = ceO.minQuestions,
			shuffle = false,
		}, questions, function(correct, questions)
			TriggerServerEvent('ap-court:updateState', 2)
		end, function(correct, questions)
			TriggerServerEvent('ap-court:updateState', 1)
		end)
	elseif Config.ExamScript.AP then
		for k, v in pairs(ce) do
			table.insert(questions, {
				question = v.Question,
				answers = {
					a = v.a,
					b = v.b,
					c = v.c,
					d = v.d
				},
				correctAnswer = v.Answer
			})
		end
		local StartExam = exports['ap-questionnaire']:StartExam({
			title = ceO.title,
			Description = ceO.description,
			Logo = ceO.image,
			Minimum = ceO.minQuestions,
            ShuffleQuestions = false, 
            AmountOfQuestionsToShow = ceO.AmountOfQuestionsToShow,
			Questions = questions,
		})
        if StartExam then
			TriggerServerEvent('ap-court:updateState', 2)
		else
			TriggerServerEvent('ap-court:updateState', 1)
		end
	end
end

RegisterNetEvent('ap-court:client:startJudgeTest')
AddEventHandler('ap-court:client:startJudgeTest', function()
	StartJudgeTest()
end)

function StartJudgeTest()
	QBCore.Functions.TriggerCallback('ap-court:getBarQuestionsJudge', function(state)
	  local ceO = Config.ExamJudgeOptions
	  local questions = {}
	  if Config.ExamScript.BCS then
		for k, v in pairs(state) do
			table.insert(questions, {
				question = v.question,
				answers = {
					a = v.a,
					b = v.b,
					c = v.c,
					d = v.d,
					correct = v.answer
				}
			})
		end

		exports['bcs_questionare']:openQuiz({
			title = ceO.title,
			description = ceO.description,
			image = ceO.image,
			minimum = ceO.minQuestions,
			shuffle = false,
		}, questions, function(correct, questions)
			TriggerServerEvent('ap-court:updateState', 2)
		end, function(correct, questions)
			TriggerServerEvent('ap-court:updateState', 8)
		end)
	  elseif Config.ExamScript.AP then
		for k, v in pairs(state) do
			table.insert(questions, {
				question = v.Question,
				answers = {
					a = v.a,
					b = v.b,
					c = v.c,
					d = v.d
				},
				correctAnswer = v.Answer
			})
		end
		local StartExam = exports['ap-questionnaire']:StartExam({
			title = ceO.title,
			Description = ceO.description,
			Logo = ceO.image,
			Minimum = ceO.minQuestions,
            ShuffleQuestions = false, 
            AmountOfQuestionsToShow = ceO.AmountOfQuestionsToShow,
			Questions = questions,
		})
        if StartExam then
			TriggerServerEvent('ap-court:updateState', 2)
		else
			TriggerServerEvent('ap-court:updateState', 8)
		end
	  end
	end)
end

RegisterNetEvent('ap-court:client:appointments', function()
    QBCore.Functions.TriggerCallback('ap-court:getMembers', function(state)
        local apOptions = {}

        for _, v in pairs(state) do
            if v.app_state == 2 then
                local entries = {
                    {
                        title = LangClient['app_menu_2_header_one'],
                        description = LangClient['app_menu_2_txt_one']:format(v.app_reason),
                        icon = "fa-solid fa-circle-info",
                        disabled = true
                    },
                    {
                        title = LangClient['app_menu_2_header_two'],
                        description = LangClient['app_menu_2_txt_two']:format(v.app_date),
                        icon = "fa-solid fa-calendar-days",
                        disabled = true
                    },
                    {
                        title = LangClient['app_menu_2_header_three'],
                        description = LangClient['app_menu_2_txt_three'],
                        icon = "fa-solid fa-xmark",
                        event = "ap-court:server:cancelAppointment",
                        isServer = true,
                        args = {}
                    }
                }

                if nhc.AP then
                    for _, item in ipairs(entries) do table.insert(apOptions, item) end
                elseif nhc.QB then
                    ContextMenu({
                        {
                            header = entries[1].title,
                            txt = entries[1].description,
                            isMenuHeader = true
                        },
                        {
                            header = entries[2].title,
                            txt = entries[2].description,
                            isMenuHeader = true
                        },
                        {
                            header = entries[3].title,
                            txt = entries[3].description,
                            params = {
                                isServer = true,
                                event = entries[3].event,
                                args = entries[3].args
                            }
                        }
                    })
                elseif nhc.OX then
                    lib.registerContext({
                        id = 'appstate2',
                        title = LangClient['app_menu_title'],
                        options = {
                            {
                                title = entries[1].title,
                                description = entries[1].description,
                                disabled = true
                            },
                            {
                                title = entries[2].title,
                                description = entries[2].description,
                                disabled = true
                            },
                            {
                                title = entries[3].title,
                                description = entries[3].description,
                                serverEvent = entries[3].event,
                                args = entries[3].args
                            }
                        }
                    })
                    ContextMenu("appstate2")
                end

            elseif v.app_state == 1 then
                local entries = {
                    {
                        title = LangClient['app_menu_1_header_one'],
                        description = LangClient['app_menu_1_txt_one'],
                        icon = "fa-solid fa-hourglass-half",
                        disabled = true
                    },
                    {
                        title = LangClient['app_menu_1_header_two'],
                        description = LangClient['app_menu_1_txt_two'],
                        icon = "fa-solid fa-xmark",
                        event = "ap-court:server:cancelAppointment",
                        isServer = true,
                        args = {}
                    }
                }

                if nhc.AP then
                    for _, item in ipairs(entries) do table.insert(apOptions, item) end
                elseif nhc.QB then
                    ContextMenu({
                        {
                            header = entries[1].title,
                            txt = entries[1].description,
                            isMenuHeader = true
                        },
                        {
                            header = entries[2].title,
                            txt = entries[2].description,
                            params = {
                                isServer = true,
                                event = entries[2].event,
                                args = entries[2].args
                            }
                        }
                    })
                elseif nhc.OX then
                    lib.registerContext({
                        id = 'appstate1',
                        title = LangClient['app_menu_title'],
                        options = {
                            {
                                title = LangClient['app_menu_1_header_one_ox'],
                                description = LangClient['app_menu_1_txt_one'],
                                disabled = true
                            },
                            {
                                title = entries[2].title,
                                description = entries[2].description,
                                serverEvent = entries[2].event,
                                args = entries[2].args
                            }
                        }
                    })
                    ContextMenu("appstate1")
                end

            elseif v.app_state == 0 then
                local entry = {
                    title = LangClient['app_menu_0_header'],
                    description = LangClient['app_menu_0_txt'],
                    icon = "fa-solid fa-calendar-plus",
                    event = "ap-court:client:arrangeAppointment",
                    isServer = false,
                    args = {}
                }

                if nhc.AP then
                    table.insert(apOptions, entry)
                elseif nhc.QB then
                    ContextMenu({
                        {
                            header = entry.title,
                            txt = entry.description,
                            params = {
                                event = entry.event,
                                args = entry.args
                            }
                        }
                    })
                elseif nhc.OX then
                    lib.registerContext({
                        id = 'appstate0',
                        title = LangClient['app_menu_title'],
                        options = {
                            {
                                title = entry.title,
                                description = entry.description,
                                event = entry.event,
                                args = entry.args
                            }
                        }
                    })
                    ContextMenu("appstate0")
                end
            end
        end

        if nhc.AP and #apOptions > 0 then
            MyUI.showContext(LangClient['app_menu_title'], apOptions, {
				isServer = false,
				event = "ap-court:client:publicServicesMenu",
				args = {}
			})
        end
    end)
end)

RegisterNetEvent('ap-court:client:arrangeAppointment', function()
	if Config.Dialog.QB then
		local dialog = exports[Config.ExportNames.input]:ShowInput({
			header = LangClient['app_dialog_header'],
			submitText = "Submit",
			inputs = {
				{
					text = LangClient['app_dialog_txt'],
					name = "reason",
					type = "text",
					isRequired = true
				},
			}
		})
		
		if dialog ~= nil then
			if dialog.reason == nil then
				TriggerEvent('ap-court:notify','All fields need to be filled.')
			else
				TriggerServerEvent('ap-court:server:arrangeAppointment', dialog.reason)
			end
		end

	elseif Config.Dialog.OX then
		local dialog = lib.inputDialog(LangClient['app_dialog_header'], {LangClient['app_dialog_txt']})
		if dialog then
			if dialog[1] == nil then
				TriggerEvent('ap-court:notify','All fields need to be filled.')
			else
				TriggerServerEvent('ap-court:server:arrangeAppointment', dialog[1])
			end
		end

	elseif Config.Dialog.AP then
		MyUI.inputDialog(LangClient['app_dialog_header'], {
			{
				label = LangClient['app_dialog_txt'],
				type = "text",
				required = true,
				icon = "fa-pen"
			}
		}, function(data)
			local reason = data[1]
			if not reason or reason == "" then
				TriggerEvent('ap-court:notify','All fields need to be filled.')
			else
				TriggerServerEvent('ap-court:server:arrangeAppointment', reason)
			end
		end, {
			event = "ap-court:client:appointments",
			args = {},
			isServer = false
		})
	end
end)

RegisterNetEvent('ap-court:client:juryService', function()
    QBCore.Functions.TriggerCallback('ap-court:getMembers', function(members)
        for _, v in pairs(members) do
            local juryState = tonumber(v.jury_state)
            local returnAction = {
                isServer = false,
                event = "ap-court:client:publicServicesMenu",
                args = {}
            }

            local title = LangClient['jury_service_title']

            if juryState == 4 then
                local desc = LangClient['jury_service_menu_4_txt']:format(v.jury_removal)

                if nhc.QB then
                    ContextMenu({
                        {
                            header = LangClient['jury_service_menu_4_header'],
                            txt = desc,
                            isMenuHeader = true
                        }
                    })

                elseif nhc.OX then
                    lib.registerContext({
                        id = 'juryservice4',
                        title = title,
                        options = {
                            {
                                title = LangClient['jury_service_menu_4_header_ox'] or LangClient['jury_service_menu_4_header'],
                                description = desc,
                                disabled = true
                            }
                        }
                    })
                    ContextMenu("juryservice4")

                elseif nhc.AP then
                    MyUI.showContext(title, {
                        {
                            title = LangClient['jury_service_menu_4_header'],
                            description = desc,
                            icon = "fa-user-xmark",
                            disabled = true
                        }
                    }, returnAction)
                end

            elseif juryState == 3 then
                local options = {
                    {
                        title = LangClient['jury_service_menu_3_header_one'],
                        description = LangClient['jury_service_menu_3_txt_one'],
                        icon = "fa-info-circle",
                        disabled = true
                    },
                    {
                        title = LangClient['jury_service_menu_3_header_two'],
                        description = LangClient['jury_service_menu_3_txt_two']:format(currency, v.jury_pay),
                        icon = "fa-money-bill-wave",
                        event = "ap-court:server:collectPayment",
                        args = v,
                        isServer = true
                    }
                }

                if nhc.QB then
                    ContextMenu({
                        {
                            header = options[1].title,
                            txt = options[1].description,
                            isMenuHeader = true
                        },
                        {
                            header = options[2].title,
                            txt = options[2].description,
                            params = {
                                isServer = true,
                                event = options[2].event,
                                args = options[2].args
                            }
                        }
                    })

                elseif nhc.OX then
                    lib.registerContext({
                        id = 'juryservice3',
                        title = title,
                        options = {
                            {
                                title = options[1].title,
                                description = options[1].description,
                                disabled = true
                            },
                            {
                                title = options[2].title,
                                description = options[2].description,
                                serverEvent = options[2].event,
                                args = options[2].args
                            }
                        }
                    })
                    ContextMenu("juryservice3")

                elseif nhc.AP then
                    MyUI.showContext(title, options, returnAction)
                end

            elseif juryState == 2 then
                local options = {
                    {
                        title = LangClient['jury_service_menu_2_header_one'],
                        description = LangClient['jury_service_menu_2_txt_one'],
                        icon = "fa-scale-balanced",
                        disabled = true
                    },
                    {
                        title = LangClient['jury_service_menu_2_header_two'],
                        description = LangClient['jury_service_menu_2_txt_two']:format(v.jury_case),
                        icon = "fa-folder-open",
                        disabled = true
                    },
                    {
                        title = LangClient['jury_service_menu_2_header_three'],
                        description = LangClient['jury_service_menu_2_txt_three']:format(v.jury_case_date),
                        icon = "fa-calendar-day",
                        disabled = true
                    },
                    {
                        title = LangClient['jury_service_menu_2_header_four'],
                        description = LangClient['jury_service_menu_2_txt_four']:format(currency, Config.JuryCasePayout),
                        icon = "fa-hand-holding-dollar",
                        disabled = true
                    }
                }

                if nhc.QB then
                    ContextMenu({
                        {
                            header = options[1].title,
                            txt = options[1].description,
                            isMenuHeader = true
                        },
                        {
                            header = options[2].title,
                            txt = options[2].description,
                            isMenuHeader = true
                        },
                        {
                            header = options[3].title,
                            txt = options[3].description,
                            isMenuHeader = true
                        },
                        {
                            header = options[4].title,
                            txt = options[4].description,
                            isMenuHeader = true
                        }
                    })

                elseif nhc.OX then
                    lib.registerContext({
                        id = 'juryservice2',
                        title = title,
                        options = options
                    })
                    ContextMenu("juryservice2")

                elseif nhc.AP then
                    MyUI.showContext(title, options, returnAction)
                end

            elseif juryState == 1 then
                if nhc.QB then
                    ContextMenu({
                        {
                            header = LangClient['jury_service_menu_1_header'],
                            txt = LangClient['jury_service_menu_1_txt'],
                            isMenuHeader = true
                        }
                    })

                elseif nhc.OX then
                    lib.registerContext({
                        id = 'juryservice1',
                        title = title,
                        options = {
                            {
                                title = LangClient['jury_service_menu_1_header'],
                                description = LangClient['jury_service_menu_1_txt'],
                                disabled = true
                            }
                        }
                    })
                    ContextMenu("juryservice1")

                elseif nhc.AP then
                    MyUI.showContext(title, {
                        {
                            title = LangClient['jury_service_menu_1_header'],
                            description = LangClient['jury_service_menu_1_txt'],
                            icon = "fa-hourglass-half",
                            disabled = true
                        }
                    }, returnAction)
                end

            elseif juryState == 0 then
                local options = {
                    {
                        title = LangClient['jury_service_menu_0_header_one'],
                        description = LangClient['jury_service_menu_0_txt_one']:format(currency, Config.JoinJuryPayment, currency, Config.JuryCasePayout),
                        icon = "fa-scale-balanced",
                        disabled = true
                    },
                    {
                        title = LangClient['jury_service_menu_0_header_two'],
                        description = LangClient['jury_service_menu_0_txt_two'],
                        icon = "fa-circle-check",
                        event = "ap-court:server:joinJury",
                        args = {},
                        isServer = true
                    }
                }

                if nhc.QB then
                    ContextMenu({
                        {
                            header = options[1].title,
                            txt = options[1].description,
                            isMenuHeader = true
                        },
                        {
                            header = options[2].title,
                            txt = options[2].description,
                            params = {
                                isServer = true,
                                event = options[2].event,
                                args = {}
                            }
                        }
                    })

                elseif nhc.OX then
                    lib.registerContext({
                        id = 'juryservice0',
                        title = title,
                        options = {
                            {
                                title = options[1].title,
                                description = options[1].description,
                                disabled = true
                            },
                            {
                                title = options[2].title,
                                description = options[2].description,
                                serverEvent = options[2].event,
                                args = {}
                            }
                        }
                    })
                    ContextMenu("juryservice0")

                elseif nhc.AP then
                    MyUI.showContext(title, options, returnAction)
                end
            end
        end
    end)
end)

RegisterNetEvent('ap-court:client:courtCases', function()
	QBCore.Functions.TriggerCallback('ap-court:getCourtCase', function(check)
		if nhc.QB then
			local courtCases = {
				{
					header = LangClient['scheduled_cases_menu_header_one'],
					isMenuHeader = true,
				},
			}
		
			if check ~= nil then 	
				for k,v in pairs(check) do
					if v.state == 1 then
						table.insert(courtCases, {
							header = LangClient['scheduled_cases_menu_header_two']:format(v.casename),
							txt = LangClient['scheduled_cases_menu_txt']:format(v.courtdate),
							isMenuHeader = true,
						})
					end
				end
			end
		
			ContextMenu(courtCases)

		elseif nhc.OX then
			local courtCases = {}

			if check ~= nil then 	
				for k,v in pairs(check) do
					if v.state == 1 then
						table.insert(courtCases, {
							title = LangClient['scheduled_cases_menu_header_two']:format(v.casename),
							description = LangClient['scheduled_cases_menu_txt']:format(v.courtdate),
							disabled = true
						})
					end
				end
			end

			lib.registerContext({
				id = 'scheduled_cases',
				title = LangClient['scheduled_cases_menu_header_one'],
				options = courtCases
			})
			ContextMenu("scheduled_cases")

		elseif nhc.AP then
			local courtCases = {}

			if check ~= nil then 	
				for k,v in pairs(check) do
					if v.state == 1 then
						table.insert(courtCases, {
							title = LangClient['scheduled_cases_menu_header_two']:format(v.casename),
							description = LangClient['scheduled_cases_menu_txt']:format(v.courtdate),
							icon = "fa-gavel",
							disabled = true
						})
					end
				end
			end

			MyUI.showContext(LangClient['scheduled_cases_menu_header_one'], courtCases, {
				isServer = false,
				event = "ap-court:client:publicServicesMenu",
				args = ""
			}, 8, true)
		end
	end)
end)

RegisterNetEvent('ap-court:client:verdictMenu', function()
	QBCore.Functions.TriggerCallback('ap-court:getCourtCase', function(check)
		if nhc.QB then
			local courtVerdict = {
				{
					header = LangClient['verdict_menu_header_one'],
					txt = " ",
					isMenuHeader = true,
				}
			}
		
			if check ~= nil then 	
				for k,v in pairs(check) do
					if v.state == 3 then
						table.insert(courtVerdict,  {
							header = LangClient['verdict_menu_header_two']:format(v.casename), 
							txt = LangClient['verdict_menu_txt']:format(v.guilty,v.not_guilty),
							params = {
								isServer = false,
								event = "ap-court:client:juryVerdict",
								args = v
							}
						})
					end
				end
			end
		
			ContextMenu(courtVerdict)

		elseif nhc.OX then
			local courtVerdict = {}
		
			if check ~= nil then 	
				for k,v in pairs(check) do
					if v.state == 3 then
						table.insert(courtVerdict,  {
							title = LangClient['verdict_menu_header_two']:format(v.casename), 
							description = LangClient['verdict_menu_txt']:format(v.guilty,v.not_guilty),
							event = 'ap-court:client:juryVerdict',
							args = v
						})
					end
				end
			end

			lib.registerContext({
				id = 'verdict_menu',
				title = LangClient['verdict_menu_header_one'],
				options = courtVerdict
			})  
			ContextMenu("verdict_menu")

		elseif nhc.AP then
			local apOptions = {}

			if check ~= nil then 	
				for k,v in pairs(check) do
					if v.state == 3 then
						table.insert(apOptions, {
							title = LangClient['verdict_menu_header_two']:format(v.casename),
							description = LangClient['verdict_menu_txt']:format(v.guilty,v.not_guilty),
							event = "ap-court:client:juryVerdict",
							args = v,
							isServer = false
						})
					end
				end
			end

			MyUI.showContext(LangClient['verdict_menu_header_one'], apOptions)
		end
	end)
end)

RegisterNetEvent('ap-court:client:juryVerdict', function(cc)
	QBCore.Functions.TriggerCallback('ap-court:getMembers', function(check)
		for k, v in pairs(check) do
			if v.jury_v_state ~= 1 then
				if v.jury_case == cc.id then

					if Config.Dialog.QB then
						local dialog = exports[Config.ExportNames.input]:ShowInput({
							header = LangClient['verdict_dialog_header'],
							submitText = "Submit",
							inputs = {
								{
									text = LangClient['verdict_dialog_txt_one'],
									name = "one",
									type = "text",
									isRequired = false
								},
								{
									text = LangClient['verdict_dialog_txt_two'],
									name = "two",
									type = "text",
									isRequired = false
								},
							}
						})

						if dialog ~= nil then
							if dialog.one ~= "YES" and dialog.two ~= "YES" or dialog.one == "YES" and dialog.two == "YES" then
								TriggerEvent('ap-court:notify', 'Only type YES in one box.')
							else
								TriggerServerEvent('ap-court:server:giveVerdict', v, cc, dialog.one, dialog.two)
							end
						end

					elseif Config.Dialog.OX then
						local dialog = lib.inputDialog(LangClient['verdict_dialog_header_ox'], {
							{type = 'select', label = 'Select your vote here.', options = {
								{value = 'guilty', label = LangClient['verdict_dialog_txt_one']},
								{value = 'not_guilty', label = LangClient['verdict_dialog_txt_two']}
							}}
						})

						if dialog then
							if dialog[1] == 'guilty' then
								TriggerServerEvent('ap-court:server:giveVerdict', v, cc, "YES", nil)
							elseif dialog[1] == 'not_guilty' then
								TriggerServerEvent('ap-court:server:giveVerdict', v, cc, nil, "YES")
							end
						end

					elseif Config.Dialog.AP then
						MyUI.inputDialog(LangClient['verdict_dialog_header_ox'], {
							{
								label = 'Select your vote here.',
								type = "select",
								required = true,
								icon = "fa-scale-balanced",
								options = {
									{ label = LangClient['verdict_dialog_txt_one'], value = "guilty" },
									{ label = LangClient['verdict_dialog_txt_two'], value = "not_guilty" }
								}
							}
						}, function(data)
							if data[1] == "guilty" then
								TriggerServerEvent('ap-court:server:giveVerdict', v, cc, "YES", nil)
							elseif data[1] == "not_guilty" then
								TriggerServerEvent('ap-court:server:giveVerdict', v, cc, nil, "YES")
							end
						end, {
							event = "ap-court:client:verdictMenu",
							args = {},
							isServer = false
						})
					end

				else
					TriggerEvent('ap-court:notify', 'You are not assigned to this case!')
				end
			else
				TriggerEvent('ap-court:notify', 'You have already given your verdict!')
			end
		end
	end)
end)

RegisterNetEvent('ap-court:client:createCourtCase', function()
	if Config.Dialog.QB then
		local dialog = exports[Config.ExportNames.input]:ShowInput({
			header = LangClient['create_court_case_dialog_header'],
			submitText = "Submit",
			inputs = {
				{
					text = LangClient['create_court_case_dialog_txt'],
					name = "case",
					type = "text",
					isRequired = true
				},
			},
		})

		if dialog ~= nil then
			if dialog.case == nil then
				TriggerEvent('ap-court:notify', 'You need to input a case name!')
			else
				TriggerServerEvent('ap-court:server:createCourtCase', dialog.case)
			end
		end

	elseif Config.Dialog.OX then
		local dialog = lib.inputDialog(
			LangClient['create_court_case_dialog_header'],
			{ LangClient['create_court_case_dialog_txt'] }
		)

		if dialog then
			if dialog[1] == nil then
				TriggerEvent('ap-court:notify', 'You need to input a case name!')
			else
				TriggerServerEvent('ap-court:server:createCourtCase', dialog[1])
			end
		end

	elseif Config.Dialog.AP then
		MyUI.inputDialog(LangClient['create_court_case_dialog_header'], {
			{
				label = LangClient['create_court_case_dialog_txt'],
				type = "text",
				icon = "fa-scale-balanced",
				required = true
			}
		}, function(data)
			local caseName = data[1]
			if not caseName or caseName == "" then
				TriggerEvent('ap-court:notify', 'You need to input a case name!')
			else
				TriggerServerEvent('ap-court:server:createCourtCase', caseName)
			end
		end, {
			isServer = false,
			event = "ap-court:client:judgeMenu",
			args = {}
		})
	end
end)

RegisterNetEvent('ap-court:client:openCaseMenu', function(id)
	QBCore.Functions.TriggerCallback('ap-court:selectCourtCase', function(check)
	  if check ~= nil then
		for k,v in pairs(check) do
		  TriggerEvent('ap-court:client:editCase', v)
		end
	  end
	end, id)
end)

RegisterNetEvent('ap-court:client:openLiveCaseMenu', function(id)
	QBCore.Functions.TriggerCallback('ap-court:selectCourtCase', function(check)
	  if check ~= nil then
		for k,v in pairs(check) do
		  TriggerEvent('ap-court:client:activeCase', v)
		end
	  end
	end, id)
end)	

RegisterNetEvent('ap-court:client:caseConfigureMenu', function()
    QBCore.Functions.TriggerCallback('ap-court:getCourtCase', function(check)
        local apOptions = {}

        if nhc.QB then
            local courtCreate = {
                {
                    header = LangClient['case_configure_menu_header_one'],
                    txt = " ",
                    isMenuHeader = true
                }
            }

            for _, v in pairs(check or {}) do
                if v.state == 0 or v.state == 1 then
                    table.insert(courtCreate, {
                        header = LangClient['case_configure_menu_header_two']:format(v.casename),
                        txt = LangClient['case_configure_menu_txt'],
                        params = {
                            isServer = false,
                            event = "ap-court:client:editCase",
                            args = v
                        }
                    })
                end
            end

            ContextMenu(courtCreate)

        elseif nhc.OX then
            local courtCreate = {}

            for _, v in pairs(check or {}) do
                if v.state == 0 or v.state == 1 then
                    table.insert(courtCreate, {
                        title = LangClient['case_configure_menu_header_two']:format(v.casename),
                        description = LangClient['case_configure_menu_txt'],
                        event = "ap-court:client:editCase",
                        args = v
                    })
                end
            end

            lib.registerContext({
                id = 'case_configure',
                title = LangClient['case_configure_menu_header_one'],
                options = courtCreate
            })
            ContextMenu("case_configure")

        elseif nhc.AP then
            for _, v in pairs(check or {}) do
                if v.state == 0 or v.state == 1 then
                    table.insert(apOptions, {
                        title = LangClient['case_configure_menu_header_two']:format(v.casename),
                        description = LangClient['case_configure_menu_txt'],
                        icon = "fa-solid fa-file-circle-check",
                        event = "ap-court:client:editCase",
                        isServer = false,
                        args = v
                    })
                end
            end

            MyUI.showContext(LangClient['case_configure_menu_header_one'], apOptions, {
				isServer = false,
				event = "ap-court:client:judgeMenu",
				args = ""
			}, 6, true)
        end
    end)
end)

RegisterNetEvent('ap-court:client:editCase', function(cc)
    local status
    if cc.state == 0 then
        status = LangClient['edit_court_case_menu_status_one']
    elseif cc.state == 1 then
        status = LangClient['edit_court_case_menu_status_two']
    end

    local entries = {
        {
            title = LangClient['edit_court_case_menu_header_one']:format(cc.id),
            description = LangClient['edit_court_case_menu_txt_one']:format(cc.casename),
            icon = "fa-solid fa-gavel",
            disabled = true
        },
        {
            title = LangClient['edit_court_case_menu_header_two'],
            description = LangClient['edit_court_case_menu_txt_two']:format(cc.courtdate),
            icon = "fa-solid fa-calendar-days",
            event = "ap-court:client:editDate",
            isServer = false,
            args = cc
        },
        {
            title = LangClient['edit_court_case_menu_header_three'],
            description = LangClient['edit_court_case_menu_txt_three']:format(cc.courtfees),
            icon = "fa-solid fa-coins",
            event = "ap-court:client:editFee",
            isServer = false,
            args = cc
        },
        {
            title = LangClient['edit_court_case_menu_header_four'],
            description = LangClient['edit_court_case_menu_txt_four'],
            icon = "fa-solid fa-user-pen",
            event = "ap-court:client:editOnCase",
            isServer = false,
            args = cc
        },
        {
            title = LangClient['edit_court_case_menu_header_five'],
            description = LangClient['edit_court_case_menu_txt_five'],
            icon = "fa-solid fa-users",
            event = "ap-court:client:editJury",
            isServer = false,
            args = cc
        },
        {
            title = LangClient['edit_court_case_menu_header_six'],
            description = LangClient['edit_court_case_menu_txt_six']:format(status),
            icon = "fa-solid fa-clipboard-check",
            event = "ap-court:server:editListing",
            isServer = true,
            args = cc
        },
        {
            title = LangClient['edit_court_case_menu_header_seven'],
            description = LangClient['edit_court_case_menu_txt_seven'],
            icon = "fa-solid fa-trash",
            event = "ap-court:client:deleteCase",
            isServer = false,
            args = cc
        },
        {
            title = LangClient['edit_court_case_menu_header_eight'],
            description = " ",
            icon = "fa-solid fa-forward",
            event = "ap-court:server:courtProceedings",
            isServer = true,
            args = cc
        }
    }

    if Config.DiscordWebhook then
        table.insert(entries, {
            title = LangClient['edit_court_case_menu_header_nine'],
            description = " ",
            icon = "fa-brands fa-discord",
            event = "ap-court:server:courtProceedingsDiscordia",
            isServer = true,
            args = cc
        })
    end

    if nhc.AP then
        MyUI.showContext(LangClient['edit_court_case_title'], entries, {
			event = "ap-court:client:caseConfigureMenu",
			args = {},
			isServer = false
		})
    elseif nhc.QB then
        local menu = {}
        for _, item in ipairs(entries) do
            table.insert(menu, {
                header = item.title,
                txt = item.description,
                isMenuHeader = item.disabled or false,
                params = item.event and {
                    isServer = item.isServer,
                    event = item.event,
                    args = item.args
                } or nil
            })
        end
        ContextMenu(menu)

    elseif nhc.OX then
        local options = {}
        for _, item in ipairs(entries) do
            table.insert(options, {
                title = item.title,
                description = item.description,
                icon = item.icon,
                event = item.isServer and nil or item.event,
                serverEvent = item.isServer and item.event or nil,
                args = item.args,
                disabled = item.disabled or false
            })
        end
        lib.registerContext({
            id = 'edit_court_case',
            title = LangClient['edit_court_case_title'],
            options = options
        })
        ContextMenu('edit_court_case')
    end
end)

RegisterNetEvent('ap-court:client:deleteCase', function(cc)
	if nhc.QB then
		local deleteCheckMenu = ContextMenu({
			{
				header = LangClient['delete_court_case_menu_header_one'],
				txt = " ",
				params = {
					isServer = true,
					event = "ap-court:server:deleteCase",
					args = cc
				}
			},
			{
				header = LangClient['delete_court_case_menu_header_two'],
				txt = " ",
				params = {
					isServer = false,
					event = "ap-court:client:editCase",
					args = cc
				}
			}
		})

	elseif nhc.OX then
		lib.registerContext({
			id = 'deleteCheckMenu',
			title = LangClient['delete_court_case_menu_main_header']:format(cc.id),
			options = {
				{
					title = LangClient['delete_court_case_menu_header_one'],
					description = " ",
					serverEvent = "ap-court:server:deleteCase",
					args = cc
				},
				{
					title = LangClient['delete_court_case_menu_header_two'],
					description = " ",
					event = "ap-court:client:editCase",
					args = cc
				}
			}
		})
		ContextMenu("deleteCheckMenu")

	elseif nhc.AP then
		local apOptions = {
			{
				title = LangClient['delete_court_case_menu_header_one'],
				description = " ",
				icon = "fa-trash",
				isServer = true,
				event = "ap-court:server:deleteCase",
				args = cc
			}
		}

		MyUI.showContext(LangClient['delete_court_case_menu_main_header']:format(cc.id), apOptions, {
            event = "ap-court:client:editCase",
            args = cc,
            isServer = false
        })
	end
end)

RegisterNetEvent('ap-court:client:editDate', function(cc)
    local datePart, timePart = cc.courtdate:match("(%d%d%d%d%-%d%d%-%d%d)%s+(%d%d:%d%d)")

    if Config.Dialog.AP then
        MyUI.inputDialog(LangClient['edit_date_dialog_header'], {
            {
                type = "date",
                label = LangClient['edit_date_dialog_txt_one'],
                icon = "fa-calendar-days",
                description = "Choose the new court date.",
                default = datePart or "",
                required = true
            },
            {
                type = "time",
                label = LangClient['edit_date_dialog_txt_two'],
                icon = "fa-clock",
                description = "Set the new court session start time.",
                default = timePart or "",
                required = true
            }
        }, function(values)
            local date = values[1]
            local time = values[2]

            if not date or not time or date == "" or time == "" then
                TriggerEvent('ap-court:notify', 'You need to input a date & time!')
                return
            end

            TriggerServerEvent('ap-court:server:updateCourtDate', cc, date, time)
        end, {
            event = "ap-court:client:editCase",
            args = cc,
            isServer = false
        })

    elseif Config.Dialog.QB then
        local dialog = exports[Config.ExportNames.input]:ShowInput({
            header = LangClient['edit_date_dialog_header'],
            submitText = "Submit",
            inputs = {
                {
                    text = LangClient['edit_date_dialog_txt_one'],
                    name = "date",
                    type = "text",
                    isRequired = true
                },
                {
                    text = LangClient['edit_date_dialog_txt_two'],
                    name = "time",
                    type = "text",
                    isRequired = true
                }
            }
        })

        if dialog then
            if not dialog.date or not dialog.time or dialog.date == "" or dialog.time == "" then
                TriggerEvent('ap-court:notify', 'You need to input a date & time!')
            else
                TriggerServerEvent('ap-court:server:updateCourtDate', cc, dialog.date, dialog.time)
            end
        end

    elseif Config.Dialog.OX then
        local dialog = lib.inputDialog(LangClient['edit_date_dialog_header'], {
            LangClient['edit_date_dialog_txt_one'],
            LangClient['edit_date_dialog_txt_two']
        })

        if dialog then
            if not dialog[1] or not dialog[2] or dialog[1] == "" or dialog[2] == "" then
                TriggerEvent('ap-court:notify', 'You need to input a date & time!')
            else
                TriggerServerEvent('ap-court:server:updateCourtDate', cc, dialog[1], dialog[2])
            end
        end
    end
end)

RegisterNetEvent('ap-court:client:editFee', function(cc)
    if Config.Dialog.AP then
        local returnEvent = {}

		if cc.state == 3 then
			returnEvent = {
				event = "ap-court:client:activeCase",
				args = cc,
				isServer = false
			}
		else
			returnEvent = {
				event = "ap-court:client:editCase",
				args = cc,
				isServer = false
			}
		end

        MyUI.inputDialog(LangClient['edit_fee_dialog_header'], {
            {
                type = "number",
                label = LangClient['edit_fee_dialog_txt'],
                icon = "fa-coins",
				default = cc.courtfees,
                description = "Set the court fee amount.",
                required = true
            }
        }, function(values)
            local fee = values[1]
            local feeNum = tonumber(fee)

            if not fee or fee == "" then
                TriggerEvent('ap-court:notify', 'You need to input a fee!')
            elseif feeNum >= Config.MaxAddFee then
                TriggerEvent('ap-court:notify', 'You are not allowed to set the fee this high!')
            else
                TriggerServerEvent('ap-court:server:updateCourtFee', cc, fee)
            end
        end, returnEvent)

    elseif Config.Dialog.QB then
        local dialog = exports[Config.ExportNames.input]:ShowInput({
            header = LangClient['edit_fee_dialog_header'],
            submitText = "Submit",
            inputs = {
                {
                    text = LangClient['edit_fee_dialog_txt'],
                    name = "fee",
                    type = "text",
                    isRequired = true
                }
            }
        })

        if dialog then
            local fee = dialog.fee
            local feeNum = tonumber(fee)
            if not fee or fee == "" then
                TriggerEvent('ap-court:notify', 'You need to input a fee!')
            elseif feeNum >= Config.MaxAddFee then
                TriggerEvent('ap-court:notify', 'You are not allowed to set the fee this high!')
            else
                TriggerServerEvent('ap-court:server:updateCourtFee', cc, fee)
            end
        end

    elseif Config.Dialog.OX then
        local dialog = lib.inputDialog(LangClient['edit_fee_dialog_header'], {
            LangClient['edit_fee_dialog_txt']
        })

        if dialog then
            local fee = dialog[1]
            local feeNum = tonumber(fee)
            if not fee or fee == "" then
                TriggerEvent('ap-court:notify', 'You need to input a fee!')
            elseif feeNum >= Config.MaxAddFee then
                TriggerEvent('ap-court:notify', 'You are not allowed to set the fee this high!')
            else
                TriggerServerEvent('ap-court:server:updateCourtFee', cc, fee)
            end
        end
    end
end)

RegisterNetEvent('ap-court:client:editOnCase', function(cc)
	local returnEvent = {}

	if cc.state == 3 then
		returnEvent = {
			event = "ap-court:client:activeCase",
			args = cc,
			isServer = false
		}
	else
		returnEvent = {
			event = "ap-court:client:editCase",
			args = cc,
			isServer = false
		}
	end

    local entries = {
        {
            title = LangClient['edit_on_case_menu_header_one']:format(cc.id),
            description = LangClient['edit_on_case_menu_txt_one']:format(cc.casename),
            icon = "fa-solid fa-scale-balanced",
            disabled = true
        },
        {
            title = LangClient['edit_on_case_menu_header_two'],
            description = LangClient['edit_on_case_menu_txt_two']:format(cc.judgen),
            icon = "fa-solid fa-gavel",
            event = "ap-court:client:updateJudge",
            args = cc
        },
        {
            title = LangClient['edit_on_case_menu_header_three'],
            description = LangClient['edit_on_case_menu_txt_three']:format(cc.defendantn),
            icon = "fa-solid fa-user",
            event = "ap-court:client:updateDefendent",
            args = cc
        },
        {
            title = LangClient['edit_on_case_menu_header_four'],
            description = LangClient['edit_on_case_menu_txt_four']:format(cc.defensen),
            icon = "fa-solid fa-shield-halved",
            event = "ap-court:client:updateDefence",
            args = cc
        }
    }

    if nhc.AP then
        MyUI.showContext(LangClient['edit_on_case_title'], entries, returnEvent)
    elseif nhc.QB then
        local qbMenu = {}
        for _, item in ipairs(entries) do
            table.insert(qbMenu, {
                header = item.title,
                txt = item.description,
                isMenuHeader = item.disabled or false,
                params = item.event and {
                    isServer = false,
                    event = item.event,
                    args = item.args
                } or nil
            })
        end
        ContextMenu(qbMenu)

    elseif nhc.OX then
        local oxMenu = {}
        for _, item in ipairs(entries) do
            table.insert(oxMenu, {
                title = item.title,
                description = item.description,
                icon = item.icon,
                event = item.event,
                args = item.args,
                disabled = item.disabled or false
            })
        end
        lib.registerContext({
            id = 'conMenu',
            title = LangClient['edit_on_case_title'],
            options = oxMenu
        })
        ContextMenu("conMenu")
    end
end)

RegisterNetEvent('ap-court:client:updateJudge', function(cc)
    QBCore.Functions.TriggerCallback('ap-court:server:getOnlinePlayers', function(players)
        local judgeOptions = {}

        for _, v in pairs(players or {}) do
            if v.job.name == Config.CourtJob then
                table.insert(judgeOptions, {
                    label = v.name,
                    value = json.encode({
                        case = cc.id,
                        player = v.identifier,
                        name = v.name,
                        job = v.job.name,
                        state = cc.state
                    })
                })
            end
        end

        if nhc.AP then
            if #judgeOptions == 0 then
                TriggerEvent('ap-court:notify', 'No judges available.')
                return
            end

            MyUI.inputDialog(LangClient['update_judge_menu_header_one'], {
                {
                    type = "select",
                    label = LangClient['update_judge_menu_txt'],
                    icon = "fa-gavel",
                    options = judgeOptions,
                    required = true
                }
            }, function(values)
                local selection = values[1]
                if not selection or selection == "" then
                    TriggerEvent('ap-court:notify', 'You must select a judge!')
                    return
                end

                local judgeData = json.decode(selection)
                TriggerServerEvent('ap-court:server:updateJudge', judgeData)
            end, {
                event = "ap-court:client:editOnCase",
                args = cc,
                isServer = false
            })

        elseif nhc.QB then
            local menu = {
                {
                    header = LangClient['update_judge_menu_header_one'],
                    isMenuHeader = true
                }
            }

            for _, v in pairs(players or {}) do
                if v.job.name == Config.CourtJob then
                    table.insert(menu, {
                        header = LangClient['update_judge_menu_header_two']:format(v.name),
                        txt = LangClient['update_judge_menu_txt'],
                        params = {
                            isServer = true,
                            event = "ap-court:server:updateJudge",
                            args = {
                                case = cc.id,
                                player = v.identifier,
                                name = v.name,
                                job = v.job.name,
                                state = cc.state
                            }
                        }
                    })
                end
            end

            ContextMenu(menu)

        elseif nhc.OX then
            local options = {}

            for _, v in pairs(players or {}) do
                if v.job.name == Config.CourtJob then
                    table.insert(options, {
                        title = LangClient['update_judge_menu_header_two']:format(v.name),
                        description = LangClient['update_judge_menu_txt'],
                        serverEvent = "ap-court:server:updateJudge",
                        args = {
                            case = cc.id,
                            player = v.identifier,
                            name = v.name,
                            job = v.job.name,
                            state = cc.state
                        }
                    })
                end
            end

            lib.registerContext({
                id = 'searchJudge',
                title = LangClient['update_judge_menu_header_one'],
                options = options
            })
            ContextMenu("searchJudge")
        end
    end)
end)

RegisterNetEvent('ap-court:client:updateDefendent', function(cc)
	if Config.Dialog.QB then
		local dialog = exports[Config.ExportNames.input]:ShowInput({
			header = 'Search For Defendent',
			submitText = "Submit",
			inputs = {
				{
					text = 'Firstname',
					name = "name",
					type = "text",
					isRequired = true
				},
			},
		})

		if dialog ~= nil then
			if dialog.name == nil then
				TriggerEvent('ap-court:notify', 'You need to input a Firstname!')
			else
				TriggerEvent('ap-court:client:updateDefendentSub', cc, dialog.name)
			end
		end

	elseif Config.Dialog.OX then
		local dialog = lib.inputDialog('Search For Defendent', { 'Firstname' })
		if dialog then
			if dialog[1] == nil then
				TriggerEvent('ap-court:notify', 'You need to input a Firstname!')
			else
				TriggerEvent('ap-court:client:updateDefendentSub', cc, dialog[1])
			end
		end

	elseif Config.Dialog.AP then
		MyUI.inputDialog("Search For Defendent", {
			{
				label = "Firstname",
				type = "text",
				icon = "fa-user",
				required = true
			}
		}, function(data)
			local name = data[1]
			if not name or name == "" then
				TriggerEvent('ap-court:notify', 'You need to input a Firstname!')
			else
				TriggerEvent('ap-court:client:updateDefendentSub', cc, name)
			end
		end, {
			event = "ap-court:client:editOnCase",
			args = cc,
			isServer = false
		})
	end
end)

RegisterNetEvent('ap-court:client:updateDefendentSub', function(cc, firstname)
	QBCore.Functions.TriggerCallback('ap-court:getCitizen', function(check)
		if nhc.QB then
			local searchDefendent = {
				{
					header = LangClient['update_defendent_menu_header_one'],
					isMenuHeader = true,
				}
			}

			if check ~= nil then 	
				for k,v in pairs(check) do
					table.insert(searchDefendent, {
						header = LangClient['update_defendent_menu_header_two'], 
						txt = LangClient['update_defendent_menu_txt']:format(v.fullname, v.dateofbirth),
						params = {
							isServer = true,
							event = "ap-court:server:updateDefendent",
							args = {
								menu = cc,
								case = cc.id,
								player = v.identifier,
								name = v.fullname,
								casename = cc.casename,
								date = cc.courtdate
							}
						}
					})
				end
			end

			ContextMenu(searchDefendent)

		elseif nhc.OX then
			local searchDefendent = {}

			if check ~= nil then 	
				for k,v in pairs(check) do
					table.insert(searchDefendent, {
						title = LangClient['update_defendent_menu_header_two'], 
						description = LangClient['update_defendent_menu_txt']:format(v.fullname, v.dateofbirth),
						serverEvent = "ap-court:server:updateDefendent",
						args = {
							menu = cc,
							case = cc.id,
							player = v.identifier,
							name = v.fullname,
							casename = cc.casename,
							date = cc.courtdate
						}
					})
				end
			end

			lib.registerContext({
				id = 'searchDefendent',
				title = LangClient['update_defendent_menu_header_one'],
				options = searchDefendent
			})  
			ContextMenu("searchDefendent")

		elseif nhc.AP then
			local apOptions = {}

			if check ~= nil then 	
				for k,v in pairs(check) do
					table.insert(apOptions, {
						title = LangClient['update_defendent_menu_header_two'],
						description = LangClient['update_defendent_menu_txt']:format(v.fullname, v.dateofbirth),
						icon = "fa-user",
						event = "ap-court:server:updateDefendent",
						isServer = true,
						args = {
							menu = cc,
							case = cc.id,
							player = v.identifier,
							name = v.fullname,
							casename = cc.casename,
							date = cc.courtdate
						}
					})
				end
			end

			MyUI.showContext(LangClient['update_defendent_menu_header_one'], apOptions, {
				event = "ap-court:client:updateDefendent",
				args = cc,
				isServer = false
			})
		end
	end, firstname)
end)

RegisterNetEvent('ap-court:client:updateDefence', function(cc)
	if Config.Dialog.QB then
		local dialog = exports[Config.ExportNames.input]:ShowInput({
			header = 'Search For Defence',
			submitText = "Submit",
			inputs = {
				{
					text = 'Firstname',
					name = "name",
					type = "text",
					isRequired = true
				},
			},
		})

		if dialog ~= nil then
			if dialog.name == nil then
				TriggerEvent('ap-court:notify', 'You need to input a Firstname!')
			else
				TriggerEvent('ap-court:client:updateDefenceSub', cc, dialog.name)
			end
		end

	elseif Config.Dialog.OX then
		local dialog = lib.inputDialog('Search For Defence', { 'Firstname' })
		if dialog then
			if dialog[1] == nil then
				TriggerEvent('ap-court:notify', 'You need to input a Firstname!')
			else
				TriggerEvent('ap-court:client:updateDefenceSub', cc, dialog[1])
			end
		end

	elseif Config.Dialog.AP then
		MyUI.inputDialog("Search For Defence", {
			{
				label = "Firstname",
				type = "text",
				icon = "fa-user",
				required = true
			}
		}, function(data)
			local name = data[1]
			if not name or name == "" then
				TriggerEvent('ap-court:notify', 'You need to input a Firstname!')
			else
				TriggerEvent('ap-court:client:updateDefenceSub', cc, name)
			end
		end, {
			event = "ap-court:client:editOnCase",
			args = cc,
			isServer = false
		})
	end
end)

RegisterNetEvent('ap-court:client:updateDefenceSub', function(cc, firstname)
	QBCore.Functions.TriggerCallback('ap-court:getCitizen', function(check)
		if nhc.QB then
			local searchDefence = {
				{
					header = LangClient['update_defence_menu_header_one'],
					txt = " ",
					isMenuHeader = true,
				}
			}

			if check ~= nil then 	
				for k,v in pairs(check) do
					table.insert(searchDefence, {
						header = LangClient['update_defence_menu_header_two'], 
						txt = LangClient['update_defence_menu_txt']:format(v.fullname, v.dateofbirth),
						params = {
							isServer = true,
							event = "ap-court:server:updateDefence",
							args = {
								menu = cc,
								case = cc.id,
								player = v.identifier,
								name = v.fullname,
								casename = cc.casename,
								date = cc.courtdate
							}
						}
					})
				end
			end

			ContextMenu(searchDefence)

		elseif nhc.OX then
			local searchDefence = {}

			if check ~= nil then 	
				for k,v in pairs(check) do
					table.insert(searchDefence, {
						title = LangClient['update_defence_menu_header_two'], 
						description = LangClient['update_defence_menu_txt']:format(v.fullname, v.dateofbirth),
						serverEvent = "ap-court:server:updateDefence",
						args = {
							menu = cc,
							case = cc.id,
							player = v.identifier,
							name = v.fullname,
							casename = cc.casename,
							date = cc.courtdate
						}
					})
				end
			end

			lib.registerContext({
				id = 'searchDefence',
				title = LangClient['update_defence_menu_header_one'],
				options = searchDefence
			})
			ContextMenu("searchDefence")

		elseif nhc.AP then
			local apOptions = {}

			if check ~= nil then 	
				for k,v in pairs(check) do
					table.insert(apOptions, {
						title = LangClient['update_defence_menu_header_two'],
						description = LangClient['update_defence_menu_txt']:format(v.fullname, v.dateofbirth),
						icon = "fa-user",
						event = "ap-court:server:updateDefence",
						isServer = true,
						args = {
							menu = cc,
							case = cc.id,
							player = v.identifier,
							name = v.fullname,
							casename = cc.casename,
							date = cc.courtdate
						}
					})
				end
			end

			MyUI.showContext(LangClient['update_defence_menu_header_one'], apOptions, {
				event = "ap-court:client:updateDefendent",
				args = cc,
				isServer = false
			})
		end
	end, firstname)
end)

RegisterNetEvent('ap-court:client:editJury', function(cc)
	if nhc.QB then
		local jurMenu = ContextMenu({
			{
				header = LangClient['edit_jury_menu_header_one']:format(cc.id),
				txt = LangClient['edit_jury_menu_txt']:format(cc.casename),
				isMenuHeader = true,
			},
			{
				header = LangClient['edit_jury_menu_header_two'],
				txt = " ",
				params = {
					isServer = false,
					event = "ap-court:client:addJury",
					args = cc
				}
			},
			{
				header = LangClient['edit_jury_menu_header_three'],
				txt = " ",
				params = {
					isServer = false,
					event = "ap-court:client:removeJury",
					args = cc
				}
			},
		})

	elseif nhc.OX then
		lib.registerContext({
			id = 'jurMenu',
			title = LangClient['edit_jury_menu_title'],
			options = {
				{
					title = LangClient['edit_jury_menu_header_one']:format(cc.id),
					description = LangClient['edit_jury_menu_txt']:format(cc.casename),
					disabled = true
				},
				{
					title = LangClient['edit_jury_menu_header_two'],
					description = " ",
					event = "ap-court:client:addJury",
					args = cc
				},
				{
					title = LangClient['edit_jury_menu_header_three'],
					description = " ",
					event = "ap-court:client:removeJury",
					args = cc
				}
			}
		})
		ContextMenu("jurMenu")

	elseif nhc.AP then
		local apOptions = {
			{
				title = LangClient['edit_jury_menu_header_one']:format(cc.id),
				description = LangClient['edit_jury_menu_txt']:format(cc.casename),
				disabled = true,
				icon = "fa-gavel"
			},
			{
				title = LangClient['edit_jury_menu_header_two'],
				description = " ",
				event = "ap-court:client:addJury",
				isServer = false,
				icon = "fa-user-plus",
				args = cc
			},
			{
				title = LangClient['edit_jury_menu_header_three'],
				description = " ",
				event = "ap-court:client:removeJury",
				isServer = false,
				icon = "fa-user-minus",
				args = cc
			}
		}

		MyUI.showContext(LangClient['edit_jury_menu_title'], apOptions, {
			event = "ap-court:client:editCase",
			args = cc,
			isServer = false
		})
	end
end)

RegisterNetEvent('ap-court:client:addJury', function(cc)
	QBCore.Functions.TriggerCallback('ap-court:getBarMembers', function(check)
		if nhc.QB then
			local courtJury = {
				{
					header = LangClient['add_jury_menu_header_one'],
					txt = " ",
					isMenuHeader = true,
				}
			}

			if check ~= nil then 	
				for _, v in pairs(check) do
					if v.jury_state == 1 and (v.jury_case == 0 or v.jury_case == cc.id) then
						table.insert(courtJury, {
							header = LangClient['add_jury_menu_header_two']:format(v.name),
							txt = LangClient['add_jury_menu_txt']:format(v.job),
							params = {
								isServer = true,
								event = "ap-court:server:addJuryCase",
								args = {
									menu = cc,
									case = cc.id,
									player = v.owner,
									date = cc.courtdate,
									name = v.name,
									casename = cc.casename
								}
							}
						})
					end
				end
			end

			ContextMenu(courtJury)

		elseif nhc.OX then
			local courtJury = {}

			if check ~= nil then 	
				for _, v in pairs(check) do
					if v.jury_state == 1 and (v.jury_case == 0 or v.jury_case == cc.id) then
						table.insert(courtJury, {
							title = LangClient['add_jury_menu_header_two']:format(v.name),
							description = LangClient['add_jury_menu_txt']:format(v.job),
							serverEvent = "ap-court:server:addJuryCase",
							args = {
								menu = cc,
								case = cc.id,
								player = v.owner,
								date = cc.courtdate,
								name = v.name,
								casename = cc.casename
							}
						})
					end
				end
			end

			lib.registerContext({
				id = 'courtJury',
				title = LangClient['add_jury_menu_header_one'],
				options = courtJury
			})
			ContextMenu("courtJury")

		elseif nhc.AP then
			local apOptions = {}

			if check ~= nil then 	
				for _, v in pairs(check) do
					if v.jury_state == 1 and (v.jury_case == 0 or v.jury_case == cc.id) then
						table.insert(apOptions, {
							title = LangClient['add_jury_menu_header_two']:format(v.name),
							description = LangClient['add_jury_menu_txt']:format(v.job),
							icon = "fa-user-tie",
							isServer = true,
							event = "ap-court:server:addJuryCase",
							args = {
								menu = cc,
								case = cc.id,
								player = v.owner,
								date = cc.courtdate,
								name = v.name,
								casename = cc.casename
							}
						})
					end
				end
			end

			MyUI.showContext(LangClient['add_jury_menu_header_one'], apOptions, {
				event = "ap-court:client:editJury",
				args = cc,
				isServer = false
			})
		end
	end)
end)

RegisterNetEvent('ap-court:client:removeJury', function(cc)
	QBCore.Functions.TriggerCallback('ap-court:getBarMembers', function(check)
		if nhc.QB then
			local courtrJury = {
				{
					header = LangClient['remove_jury_menu_header_one'],
					txt = " ",
					isMenuHeader = true,
				}
			}

			if check ~= nil then 	
				for _, v in pairs(check) do
					if v.jury_state == 2 and (v.jury_case == 0 or v.jury_case == cc.id) then
						table.insert(courtrJury, {
							header = LangClient['remove_jury_menu_header_two']:format(v.name),
							txt = LangClient['remove_jury_menu_txt']:format(v.job),
							params = {
								isServer = true,
								event = "ap-court:server:removeJuryCase",
								args = {
									menu = cc,
									case = cc.id,
									player = v.owner,
									date = cc.courtdate,
									name = v.name
								}
							}
						})
					end
				end
			end

			ContextMenu(courtrJury)

		elseif nhc.OX then
			local courtrJury = {}

			if check ~= nil then 	
				for _, v in pairs(check) do
					if v.jury_state == 2 and (v.jury_case == 0 or v.jury_case == cc.id) then
						table.insert(courtrJury, {
							title = LangClient['remove_jury_menu_header_two']:format(v.name),
							description = LangClient['remove_jury_menu_txt']:format(v.job),
							serverEvent = "ap-court:server:removeJuryCase",
							args = {
								menu = cc,
								case = cc.id,
								player = v.owner,
								date = cc.courtdate,
								name = v.name
							}
						})
					end
				end
			end

			lib.registerContext({
				id = 'courtrJury',
				title = LangClient['remove_jury_menu_header_one'],
				options = courtrJury
			})
			ContextMenu("courtrJury")

		elseif nhc.AP then
			local apOptions = {}

			if check ~= nil then 	
				for _, v in pairs(check) do
					if v.jury_state == 2 and (v.jury_case == 0 or v.jury_case == cc.id) then
						table.insert(apOptions, {
							title = LangClient['remove_jury_menu_header_two']:format(v.name),
							description = LangClient['remove_jury_menu_txt']:format(v.job),
							icon = "fa-user-xmark",
							isServer = true,
							event = "ap-court:server:removeJuryCase",
							args = {
								menu = cc,
								case = cc.id,
								player = v.owner,
								date = cc.courtdate,
								name = v.name
							}
						})
					end
				end
			end

			MyUI.showContext(LangClient['remove_jury_menu_header_one'], apOptions, {
				event = "ap-court:client:editJury",
				args = cc,
				isServer = false
			})
		end
	end)
end)

showRequestedCase = function(job)
	QBCore.Functions.TriggerCallback('ap-court:getCourtCase', function(check)
		if nhc.QB then
			local showRequestedCase = {
				{
					header = LangClient['show_requested_case_menu_header_one'],
					txt = " ",
					isMenuHeader = true,
				},
			}

			if check ~= nil then 	
				for k, v in pairs(check) do
					if v.job_request == job then
						table.insert(showRequestedCase, {
							header = LangClient['show_requested_case_menu_header_two']:format(v.casename),
							txt = LangClient['show_requested_case_menu_txt']:format(v.courtdate, v.courtfees),
							isMenuHeader = true,
						})
					end
				end
			end

			ContextMenu(showRequestedCase)

		elseif nhc.OX then
			local showRequestedCase = {}

			if check ~= nil then 	
				for k, v in pairs(check) do
					if v.job_request == job then
						table.insert(showRequestedCase, {
							title = LangClient['show_requested_case_menu_header_two']:format(v.casename),
							description = LangClient['show_requested_case_menu_txt']:format(v.courtdate, v.courtfees),
							disabled = true
						})
					end
				end
			end

			lib.registerContext({
				id = 'showRequestedCase',
				title = LangClient['show_requested_case_menu_header_one'],
				options = showRequestedCase
			})  
			ContextMenu("showRequestedCase")

		elseif nhc.AP then
			local apOptions = {}

			if check ~= nil then 	
				for k, v in pairs(check) do
					if v.job_request == job then
						table.insert(apOptions, {
							title = LangClient['show_requested_case_menu_header_two']:format(v.casename),
							description = LangClient['show_requested_case_menu_txt']:format(v.courtdate, v.courtfees),
							disabled = true
						})
					end
				end
			end

			MyUI.showContext(LangClient['show_requested_case_menu_header_one'], apOptions, nil, 6)
		end
	end)
end

RegisterNetEvent('ap-court:client:lawyerID', function()
	QBCore.Functions.TriggerCallback('ap-court:server:getOnlinePlayers', function(xPlayers)
		QBCore.Functions.TriggerCallback('ap-court:getMembers', function(xPlayer)
			for k, v in pairs(xPlayer) do
				if nhc.QB then
					local showCard = {
						{
							header = LangClient['show_lawyer_card_menu_header_one'],
							txt = " ",
							isMenuHeader = true,
						}
					}

					if xPlayers ~= nil then 	
						for i = 1, #xPlayers, 1 do
							local details = {}
							table.insert(details, { info = v, tplayer = xPlayers[i].source })
							table.insert(showCard, {
								header = LangClient['show_lawyer_card_menu_header_two']:format(v.name), 
								txt = " ",
								params = {
									isServer = true,
									event = "ap-court:server:showCard",
									args = details
								}
							})
						end
					end

					ContextMenu(showCard)

				elseif nhc.OX then
					local showCard = {}

					if xPlayers ~= nil then 	
						for i = 1, #xPlayers, 1 do
							table.insert(showCard, {
								title = LangClient['show_lawyer_card_menu_header_two']:format(v.name),
								description = " ",
								serverEvent = "ap-court:server:showCard",
								args = { info = v, tplayer = xPlayers[i].source }
							})
						end
					end

					lib.registerContext({
						id = 'showCard',
						title = LangClient['show_lawyer_card_menu_header_one'],
						options = showCard
					})
					ContextMenu("showCard")

				elseif nhc.AP then
					local apOptions = {}

					if xPlayers ~= nil then 	
						for i = 1, #xPlayers, 1 do
							table.insert(apOptions, {
								title = LangClient['show_lawyer_card_menu_header_two']:format(v.name),
								description = " ",
								icon = "fa-id-card",
								isServer = true,
								event = "ap-court:server:showCard",
								args = { info = v, tplayer = xPlayers[i].source }
							})
						end
					end

					MyUI.showContext(LangClient['show_lawyer_card_menu_header_one'], apOptions)
				end
			end
		end)
	end)
end)

RegisterNetEvent('ap-court:client:addRecordArchives', function(cc)
	if nhc.QB then
		local conMenu = ContextMenu({
			{
				header = LangClient['add_record_archives_menu_header_one'],
				txt = LangClient['add_record_archives_menu_txt_one']:format(cc.defendantn),
				params = {
					isServer = false,
					event = "ap-court:client:addRecordArchivesNew",
					args = {player = cc.defendantid, menu = cc}
				}
			},
			{
				header = LangClient['add_record_archives_menu_header_two'],
				txt = LangClient['add_record_archives_menu_txt_two']:format(cc.defensen),
				params = {
					isServer = false,
					event = "ap-court:client:addRecordArchivesNew",
					args = {player = cc.defenseid, menu = cc}
				}
			},
		})

	elseif nhc.OX then
		lib.registerContext({
			id = 'add_record',
			title = LangClient['add_record_archives_title'],
			options = {
				{
					title = LangClient['add_record_archives_menu_header_one'],
					description = LangClient['add_record_archives_menu_txt_one']:format(cc.defendantn),
					event = "ap-court:client:addRecordArchivesNew",
					args = {player = cc.defendantid, menu = cc}
				},
				{
					title = LangClient['add_record_archives_menu_header_two'],
					description = LangClient['add_record_archives_menu_txt_two']:format(cc.defensen),
					event = "ap-court:client:addRecordArchivesNew",
					args = {player = cc.defenseid, menu = cc}
				},
			}
		})  
		ContextMenu("add_record")

	elseif nhc.AP then
		local apOptions = {
			{
				title = LangClient['add_record_archives_menu_header_one'],
				description = LangClient['add_record_archives_menu_txt_one']:format(cc.defendantn),
				icon = "fa-user-shield",
				event = "ap-court:client:addRecordArchivesNew",
				args = {player = cc.defendantid, menu = cc},
				isServer = false
			},
			{
				title = LangClient['add_record_archives_menu_header_two'],
				description = LangClient['add_record_archives_menu_txt_two']:format(cc.defensen),
				icon = "fa-user-tie", 
				event = "ap-court:client:addRecordArchivesNew",
				args = {player = cc.defenseid, menu = cc},
				isServer = false
			}
		}


		MyUI.showContext(LangClient['add_record_archives_title'], apOptions, {
			isServer = false,
			event = "ap-court:client:activeCase",
			args = cc
		}, 4)
	end
end)

RegisterNetEvent('ap-court:client:addRecordArchivesNew', function(v)
	local cc = v.player
	if Config.Dialog.QB then
		local dialog = exports[Config.ExportNames.input]:ShowInput({
			header = LangClient['add_record_archives_dialog_header'],
			submitText = "Submit",
			inputs = {
				{
					text = LangClient['add_record_archives_dialog_txt_one'],
					name = "reason",
					type = "text",
					isRequired = true
				},
				{
					text = LangClient['add_record_archives_dialog_txt_two'],
					name = "amount",
					type = "text",
					isRequired = true
				},
			},
		})

		if dialog ~= nil then
			if dialog.reason == nil or dialog.amount == nil then
				TriggerEvent('ap-court:notify','You need to input all fields!')
			else
				TriggerServerEvent('ap-court:server:addRecordArchives', cc, dialog.reason, dialog.amount)
			end
		end

	elseif Config.Dialog.OX then
		local dialog = lib.inputDialog(LangClient['add_record_archives_dialog_header'], {
			LangClient['add_record_archives_dialog_txt_one'],
			LangClient['add_record_archives_dialog_txt_two']
		})
		if dialog then
			if dialog[1] == nil or dialog[2] == nil then
				TriggerEvent('ap-court:notify','You need to input all fields!')
			else
				TriggerServerEvent('ap-court:server:addRecordArchives', cc, dialog[1], dialog[2])
			end
		end

	elseif Config.Dialog.AP then
		MyUI.inputDialog(LangClient['add_record_archives_dialog_header'], {
			{
				label = LangClient['add_record_archives_dialog_txt_one'],
				type = "text",
				required = true,
				icon = "fa-book"
			},
			{
				label = LangClient['add_record_archives_dialog_txt_two'],
				type = "text",
				required = true,
				icon = "fa-money-bill"
			}
		}, function(data)
			local reason = data[1]
			local amount = data[2]

			if not reason or not amount or reason == "" or amount == "" then
				TriggerEvent('ap-court:notify','You need to input all fields!')
			else
				TriggerServerEvent('ap-court:server:addRecordArchives', cc, reason, amount)
			end
		end, {
			event = "ap-court:client:addRecordArchives", 
			args = v.menu,
			isServer = false
		})
	end
end)

RegisterNetEvent('ap-court:client:criminalRecordArc', function(cc)
	if Config.Dialog.QB then
		local dialog = exports[Config.ExportNames.input]:ShowInput({
			header = LangClient['search_archives_dialog_header'],
			submitText = "Submit",
			inputs = {
				{
					text = LangClient['search_archives_dialog_txt'],
					name = "arch",
					type = "text",
					isRequired = true
				},
			},
		})

		if dialog ~= nil then
			if dialog.arch == nil or dialog.arch == "" then
				TriggerEvent('ap-court:notify', 'You need to input all fields!')
			else
				searchArchives(dialog.arch)
			end
		end

	elseif Config.Dialog.OX then
		local dialog = lib.inputDialog(LangClient['search_archives_dialog_header'], {
			LangClient['search_archives_dialog_txt']
		})
		if dialog then
			if dialog[1] == nil or dialog[1] == "" then
				TriggerEvent('ap-court:notify', 'You need to input all fields!')
			else
				searchArchives(dialog[1])
			end
		end

	elseif Config.Dialog.AP then
		MyUI.inputDialog(LangClient['search_archives_dialog_header'], {
			{
				label = LangClient['search_archives_dialog_txt'],
				type = "text",
				required = true,
				icon = "fa-search"
			}
		}, function(data)
			local searchValue = data[1]

			if not searchValue or searchValue == "" then
				TriggerEvent('ap-court:notify', 'You need to input all fields!')
			else
				searchArchives(searchValue, cc)
			end
		end, {
			isServer = false,
			event = "ap-court:client:judgeMenu",
			args = {}
		})
	end
end)

searchArchives = function(PlayerName, cc)
	QBCore.Functions.TriggerCallback('ap-court:server:searchArchives', function(history)
		if nhc.QB then
			local historyActive = {
				{
					header = LangClient['search_archives_menu_header_one']:format(PlayerName),
					txt = " ",
					isMenuHeader = true,
				}
			}

			if history ~= nil then 	
				for k,v in pairs(history) do
					table.insert(historyActive, {
						header = LangClient['search_archives_menu_header_two']:format(v.date), 
						txt = LangClient['search_archives_menu_txt']:format(v.fine),
						isMenuHeader = true,
					})
				end
			end

			ContextMenu(historyActive)

		elseif nhc.OX then
			local historyActive = {}

			if history ~= nil then 	
				for k,v in pairs(history) do
					table.insert(historyActive, {
						title = LangClient['search_archives_menu_header_two']:format(v.date), 
						description = LangClient['search_archives_menu_txt']:format(v.fine),
						disabled = true
					})
				end
			end

			lib.registerContext({
				id = 'historyActive',
				title = LangClient['search_archives_menu_header_one']:format(PlayerName),
				options = historyActive
			})  
			ContextMenu("historyActive")

		elseif nhc.AP then
			local apOptions = {}

			if history ~= nil then
				for k,v in pairs(history) do
					table.insert(apOptions, {
						title = LangClient['search_archives_menu_header_two']:format(v.date),
						description = LangClient['search_archives_menu_txt']:format(v.fine),
						disabled = true
					})
				end
			end

			MyUI.showContext(
				LangClient['search_archives_menu_header_one']:format(PlayerName),
				apOptions,
				{
					isServer = false,
					event = "ap-court:client:criminalRecordArc",
					args = cc
				}, 
				10
			)
		end
	end, PlayerName, cc)
end

RegisterNetEvent('ap-court:client:proManagement', function()
	QBCore.Functions.TriggerCallback('ap-court:getCourtCase', function(check)
		if nhc.QB then
			local courtActive = {
				{
					header = LangClient['live_court_case_menu_header_one'],
					txt = " ",
					isMenuHeader = true,
				}
			}
		
			if check ~= nil then 	
				for k,v in pairs(check) do
					if v.state == 3 then
						table.insert(courtActive, {
							header = LangClient['live_court_case_menu_header_two']:format(v.casename), 
							txt = LangClient['live_court_case_menu_txt'],
							icon = "fas fa-gavel",
							params = {
								isServer = false,
								event = "ap-court:client:activeCase",
								args = v
							}
						})
					end
				end
			end

			ContextMenu(courtActive)

		elseif nhc.OX then
			local courtActive = {}

			if check ~= nil then 	
				for k,v in pairs(check) do
					if v.state == 3 then
						table.insert(courtActive, {
							title = LangClient['live_court_case_menu_header_two']:format(v.casename), 
							description = LangClient['live_court_case_menu_txt'],
							icon = "fas fa-gavel",
							event = "ap-court:client:activeCase",
							args = v
						})
					end
				end
			end

			lib.registerContext({
				id = 'courtActive',
				title = LangClient['live_court_case_menu_header_one'],
				options = courtActive
			})  
			ContextMenu("courtActive")

		elseif nhc.AP then
			local apOptions = {}

			if check ~= nil then 	
				for k,v in pairs(check) do
					if v.state == 3 then
						table.insert(apOptions, {
							title = LangClient['live_court_case_menu_header_two']:format(v.casename),
							description = LangClient['live_court_case_menu_txt'],
							icon = "fas fa-gavel",
							event = "ap-court:client:activeCase",
							isServer = false,
							args = v
						})
					end
				end
			end

			MyUI.showContext(
				LangClient['live_court_case_menu_header_one'],
				apOptions,
				nil,
				10
			)
		end
	end)
end)

RegisterNetEvent('ap-court:client:activeCase', function(cc)
	if nhc.QB then
		local activeMenu = {
			{
				header = LangClient['active_case_menu_header_one']:format(cc.id),
				txt = LangClient['active_case_menu_txt_one']:format(cc.casename),
				isMenuHeader = true,
			},
			{
				header = LangClient['active_case_menu_header_two'],
				txt = LangClient['active_case_menu_txt_two']:format(cc.guilty,cc.not_guilty),
				isMenuHeader = true,
			},
			{
				header = LangClient['active_case_menu_header_three'],
				txt = LangClient['active_case_menu_txt_three']:format(cc.courtfees),
				params = {
					isServer = false,
					event = "ap-court:client:editFee",
					args = cc
				}
			},
			{
				header = LangClient['active_case_menu_header_four'],
				txt = LangClient['active_case_menu_txt_four'],
				params = {
					isServer = false,
					event = "ap-court:client:editOnCase",
					args = cc
				}
			},
			{
				header = LangClient['active_case_menu_header_seven'],
				txt = " ",
				params = {
					isServer = false,
					event = "ap-court:client:courtPayouts",
					args = cc
				}
			},
			{
				header = LangClient['active_case_menu_header_eight'],
				txt = " ",
				params = {
					isServer = true,
					event = "ap-court:server:adjournCourtCase",
					args = {
						id = cc.id,
						newDate = nil,
						menuType = false,
						disc = cc
					}
				}
			},
			{
				header = LangClient['active_case_menu_header_nine'],
				txt = " ",
				params = {
					isServer = true,
					event = "ap-court:server:finishProceedings",
					args = cc
				}
			},
		}

		if Config.CriminalRecordArchives then
			table.insert(activeMenu, {
				header = LangClient['active_case_menu_header_six'],
				txt = LangClient['active_case_menu_txt_six'],
				params = {
					isServer = false,
					event = "ap-court:client:addRecordArchives",
					args = cc
				}
			})
		end

		ContextMenu(activeMenu)

	elseif nhc.OX then
		local activeMenu = {
			{
				title = LangClient['active_case_menu_header_one']:format(cc.id),
				description = LangClient['active_case_menu_txt_one']:format(cc.casename),
				disabled = true
			},
			{
				title = LangClient['active_case_menu_header_two'],
				description = LangClient['active_case_menu_txt_two']:format(cc.guilty,cc.not_guilty),
				disabled = true
			},
			{
				title = LangClient['active_case_menu_header_three'],
				description = LangClient['active_case_menu_txt_three']:format(cc.courtfees),
				event = "ap-court:client:editFee",
				args = cc
			},
			{
				title = LangClient['active_case_menu_header_four'],
				description = LangClient['active_case_menu_txt_four'],
				event = "ap-court:client:editOnCase",
				args = cc
			},
			{
				title = LangClient['active_case_menu_header_seven'],
				description = " ",
				event = "ap-court:client:courtPayouts",
				args = cc
			},
			{
				title = LangClient['active_case_menu_header_eight'],
				description = " ",
				serverEvent = "ap-court:server:adjournCourtCase",
				args = {
					id = cc.id,
					newDate = nil,
					menuType = false,
					disc = cc
				}
			},
			{
				title = LangClient['active_case_menu_header_nine'],
				description = " ",
				serverEvent = "ap-court:server:finishProceedings",
				args = cc
			}
		}

		if Config.CriminalRecordArchives then
			table.insert(activeMenu, {
				title = LangClient['active_case_menu_header_six'],
				description = LangClient['active_case_menu_txt_six'],
				event = "ap-court:client:addRecordArchives",
				args = cc
			})
		end

		lib.registerContext({
			id = 'activeMenu',
			title = LangClient['active_case_title'],
			options = activeMenu
		})
		ContextMenu("activeMenu")

	elseif nhc.AP then
		local apOptions = {
			{
				title = LangClient['active_case_menu_header_one']:format(cc.id),
				description = LangClient['active_case_menu_txt_one']:format(cc.casename),
				disabled = true,
				icon = "fas fa-file-alt"
			},
			{
				title = LangClient['active_case_menu_header_two'],
				description = LangClient['active_case_menu_txt_two']:format(cc.guilty, cc.not_guilty),
				disabled = true,
				icon = "fas fa-balance-scale"
			},
			{
				title = LangClient['active_case_menu_header_three'],
				description = LangClient['active_case_menu_txt_three']:format(cc.courtfees),
				event = "ap-court:client:editFee",
				args = cc,
				isServer = false,
				icon = "fas fa-dollar-sign"
			},
			{
				title = LangClient['active_case_menu_header_four'],
				description = LangClient['active_case_menu_txt_four'],
				event = "ap-court:client:editOnCase",
				args = cc,
				isServer = false,
				icon = "fas fa-edit"
			},
			{
				title = LangClient['active_case_menu_header_seven'],
				description = " ",
				event = "ap-court:client:courtPayouts",
				args = cc,
				isServer = false,
				icon = "fas fa-hand-holding-usd"
			},
			{
				title = LangClient['active_case_menu_header_eight'],
				description = " ",
				event = "ap-court:server:adjournCourtCase",
				args = {
					id = cc.id,
					newDate = nil,
					menuType = false,
					disc = cc
				},
				isServer = true,
				icon = "fas fa-calendar-alt"
			},
			{
				title = LangClient['active_case_menu_header_nine'],
				description = " ",
				event = "ap-court:server:finishProceedings",
				args = cc,
				isServer = true,
				icon = "fas fa-check-circle"
			}
		}

		if Config.CriminalRecordArchives then
			table.insert(apOptions, {
				title = LangClient['active_case_menu_header_six'],
				description = LangClient['active_case_menu_txt_six'],
				event = "ap-court:client:addRecordArchives",
				args = cc,
				isServer = false,
				icon = "fas fa-archive"
			})
		end

		MyUI.showContext(
			LangClient['active_case_title'],
			apOptions,
			{
				event = "ap-court:client:proManagement",
				args = "",
				isServer = false
			},
			10
		)
	end

end)

RegisterNetEvent('ap-court:client:backgroundChecks', function()
	QBCore.Functions.TriggerCallback('ap-court:getBarMembers', function(check)
		if nhc.QB then
			local barBackground = {
				{
					header = LangClient['bar_background_checks_menu_header_one'],
					txt = " ",
					isMenuHeader = true,
				}
			}

			if check ~= nil then 	
				for k, v in pairs(check) do
					if v.bar_state == 2 then
						table.insert(barBackground, {
							header = LangClient['bar_background_checks_menu_header_two']:format(v.name),
							txt = LangClient['bar_background_checks_menu_txt'],
							params = {
								isServer = false,
								event = "ap-court:client:backgroundMenu",
								args = v
							}
						})
					end
				end
			end

			ContextMenu(barBackground)

		elseif nhc.OX then
			local barBackground = {}

			if check ~= nil then 	
				for k, v in pairs(check) do
					if v.bar_state == 2 then
						table.insert(barBackground, {
							title = LangClient['bar_background_checks_menu_header_two']:format(v.name),
							description = LangClient['bar_background_checks_menu_txt'],
							event = "ap-court:client:backgroundMenu",
							args = v
						})
					end
				end
			end

			lib.registerContext({
				id = 'barBackground',
				title = LangClient['bar_background_checks_menu_header_one'],
				options = barBackground
			})
			ContextMenu("barBackground")

		elseif nhc.AP then
			local apOptions = {}

			if check ~= nil then 	
				for k, v in pairs(check) do
					if v.bar_state == 2 then
						table.insert(apOptions, {
							title = LangClient['bar_background_checks_menu_header_two']:format(v.name),
							description = LangClient['bar_background_checks_menu_txt'],
							icon = "fa-user-check",
							isServer = false,
							event = "ap-court:client:backgroundMenu",
							args = v
						})
					end
				end
			end

			MyUI.showContext(LangClient['bar_background_checks_menu_header_one'], apOptions, {
				isServer = false,
				event = "ap-court:client:judgeMenu",
				args = ""
			})
		end
	end)
end)

RegisterNetEvent('ap-court:client:backgroundMenu', function(v)
	if nhc.QB then
		local backgroundMenu = ContextMenu({
			{
				header = LangClient['bar_background_a_d_menu_header_one'],
				txt = LangClient['bar_background_a_d_menu_txt_one']:format(v.name),
				isMenuHeader = true,
			},
			{
				header = LangClient['bar_background_a_d_menu_header_two'],
				txt = LangClient['bar_background_a_d_menu_txt_two'],
				params = {
					isServer = true,
					event = "ap-court:server:issueBarMembership",
					args = v
				}
			},
			{
				header = LangClient['bar_background_a_d_menu_header_three'],
				txt = LangClient['bar_background_a_d_menu_txt_three'],
				params = {
					isServer = false,
					event = "ap-court:client:denyBarMembership",
					args = v
				}
			},
		})

	elseif nhc.OX then
		lib.registerContext({
			id = 'backgroundMenu',
			title = LangClient['bar_background_a_d_title'],
			options = {
				{
					title = LangClient['bar_background_a_d_menu_header_one'],
					description = LangClient['bar_background_a_d_menu_txt_one']:format(v.name),
					disabled = true
				},
				{ 
					title = LangClient['bar_background_a_d_menu_header_two'],
					description = LangClient['bar_background_a_d_menu_txt_two'],
					serverEvent = "ap-court:server:issueBarMembership",
					args = v
				},
				{
					title = LangClient['bar_background_a_d_menu_header_three'],
					description = LangClient['bar_background_a_d_menu_txt_three'],
					event = "ap-court:client:denyBarMembership",
					args = v
				}
			}
		})  
		ContextMenu("backgroundMenu")

	elseif nhc.AP then
		local apOptions = {
			{
				title = LangClient['bar_background_a_d_menu_header_one'],
				description = LangClient['bar_background_a_d_menu_txt_one']:format(v.name),
				disabled = true,
				icon = "fa-user-shield"
			},
			{
				title = LangClient['bar_background_a_d_menu_header_two'],
				description = LangClient['bar_background_a_d_menu_txt_two'],
				event = "ap-court:server:issueBarMembership",
				isServer = true,
				icon = "fa-check-circle",
				args = v
			},
			{
				title = LangClient['bar_background_a_d_menu_header_three'],
				description = LangClient['bar_background_a_d_menu_txt_three'],
				event = "ap-court:client:denyBarMembership",
				isServer = false,
				icon = "fa-xmark-circle",
				args = v
			}
		}

		MyUI.showContext(LangClient['bar_background_a_d_title'], apOptions, {
			event = "ap-court:client:backgroundChecks",
			args = "",
			isServer = false
		})
	end
end)

RegisterNetEvent('ap-court:client:denyBarMembership', function(v)
	if Config.Dialog.QB then
		local dialog = exports[Config.ExportNames.input]:ShowInput({
			header = LangClient['bar_deny_membership_dialog_header'],
			submitText = "Submit",
			inputs = {
				{
					text = LangClient['bar_deny_membership_dialog_txt'],
					name = "reason",
					type = "text",
					isRequired = true
				},
			},
		})

		if dialog ~= nil then
			if dialog.reason == nil then
				TriggerEvent('ap-court:notify', 'You need to input all fields!')
			else
				TriggerServerEvent('ap-court:server:denyBarMembership', v, dialog.reason)
			end
		end

	elseif Config.Dialog.OX then
		local dialog = lib.inputDialog(
			LangClient['bar_deny_membership_dialog_header'],
			{ LangClient['bar_deny_membership_dialog_txt'] }
		)
		if dialog then
			if dialog[1] == nil then
				TriggerEvent('ap-court:notify', 'You need to input all fields!')
			else
				TriggerServerEvent('ap-court:server:denyBarMembership', v, dialog[1])
			end
		end

	elseif Config.Dialog.AP then
		MyUI.inputDialog(LangClient['bar_deny_membership_dialog_header'], {
			{
				label = LangClient['bar_deny_membership_dialog_txt'],
				type = "text",
				icon = "fa-circle-xmark",
				required = true
			}
		}, function(data)
			local reason = data[1]
			if not reason or reason == "" then
				TriggerEvent('ap-court:notify', 'You need to input all fields!')
			else
				TriggerServerEvent('ap-court:server:denyBarMembership', v, reason)
			end
		end, {
			event = "ap-court:client:backgroundMenu",
			args = v,
			isServer = false
		})
	end
end)

RegisterNetEvent('ap-court:client:barMembers', function()
	QBCore.Functions.TriggerCallback('ap-court:getBarMembers', function(check)
		if nhc.QB then
			local barMemberMenu = {
				{
					header = LangClient['bar_members_menu_header_one'],
					txt = " ",
					isMenuHeader = true,
				}
			}

			if check ~= nil then 	
				for k, v in pairs(check) do
					if v.bar_state == 4 or v.bar_state == 5 then
						table.insert(barMemberMenu, {
							header = LangClient['bar_members_menu_header_two']:format(v.name),
							txt = LangClient['bar_members_menu_txt'],
							params = {
								isServer = false,
								event = "ap-court:client:barMemberRemove",
								args = v
							}
						})
					end
				end
			end

			ContextMenu(barMemberMenu)

		elseif nhc.OX then
			local barMemberMenu = {}

			if check ~= nil then 	
				for k, v in pairs(check) do
					if v.bar_state == 4 or v.bar_state == 5 then
						table.insert(barMemberMenu, {
							title = LangClient['bar_members_menu_header_two']:format(v.name),
							description = LangClient['bar_members_menu_txt'],
							event = "ap-court:client:barMemberRemove",
							args = v
						})
					end
				end
			end

			lib.registerContext({
				id = 'barMemberMenu',
				title = LangClient['bar_members_menu_header_one'],
				options = barMemberMenu
			})
			ContextMenu("barMemberMenu")

		elseif nhc.AP then
			local apOptions = {}

			if check ~= nil then 	
				for k, v in pairs(check) do
					if v.bar_state == 4 or v.bar_state == 5 then
						table.insert(apOptions, {
							title = LangClient['bar_members_menu_header_two']:format(v.name),
							description = LangClient['bar_members_menu_txt'],
							icon = "fa-user-slash",
							event = "ap-court:client:barMemberRemove",
							isServer = false,
							args = v
						})
					end
				end
			end

			MyUI.showContext(LangClient['bar_members_menu_header_one'], apOptions, {
				event = "ap-court:client:judgeMenu",
				args = "",
				isServer = false 
			})
		end
	end)
end)

RegisterNetEvent('ap-court:client:barMemberRemove', function(v)
	if Config.Dialog.QB then
		local dialog = exports[Config.ExportNames.input]:ShowInput({
			header = LangClient['bar_removal_reason_dialog_header'],
			submitText = "Submit",
			inputs = {
				{
					text = LangClient['bar_removal_reason_dialog_txt'],
					name = "reasonz",
					type = "text",
					isRequired = true
				},
			},
		})

		if dialog ~= nil then
			if dialog.reasonz == nil then
				TriggerEvent('ap-court:notify', 'You need to input all fields!')
			else
				TriggerServerEvent('ap-court:server:barMemberRemove', v, dialog.reasonz)
			end
		end

	elseif Config.Dialog.OX then
		local dialog = lib.inputDialog(
			LangClient['bar_removal_reason_dialog_header'],
			{ LangClient['bar_removal_reason_dialog_txt'] }
		)
		if dialog then
			if dialog[1] == nil then
				TriggerEvent('ap-court:notify', 'You need to input all fields!')
			else
				TriggerServerEvent('ap-court:server:barMemberRemove', v, dialog[1])
			end
		end

	elseif Config.Dialog.AP then
		MyUI.inputDialog(LangClient['bar_removal_reason_dialog_header'], {
			{
				label = LangClient['bar_removal_reason_dialog_txt'],
				type = "text",
				icon = "fa-ban",
				required = true
			}
		}, function(data)
			local reason = data[1]
			if not reason or reason == "" then
				TriggerEvent('ap-court:notify', 'You need to input all fields!')
			else
				TriggerServerEvent('ap-court:server:barMemberRemove', v, reason)
			end
		end, {
			event = "ap-court:client:barMembers",
			args = "",
			isServer = false
		})
	end
end)

RegisterNetEvent('ap-court:client:barDecMembers', function()
	QBCore.Functions.TriggerCallback('ap-court:getBarMembers', function(check)
		if nhc.QB then
			local chance = nil
			local barDecMemberMenu = {
				{
					header = LangClient['bar_members_decline_menu_header_one'],
					txt = " ",
					isMenuHeader = true,
				}
			}
	
			if check ~= nil then 	
				for k,v in pairs(check) do
					if v.bar_state == 1 then
						chance = LangClient['bar_members_decline_menu_chance_one']
					elseif v.bar_state == 8 then
						chance = LangClient['bar_members_decline_menu_chance_two']
					end

					if v.bar_state == 1 or v.bar_state == 8 then
						table.insert(barDecMemberMenu,  {
							header = LangClient['bar_members_decline_menu_header_two']:format(v.name), 
							txt = chance,
							params = {
								isServer = true,
								event = "ap-court:server:updatePlayerRetakeJudge",
								args = v
							}
						})
					end
				end
			end

			ContextMenu(barDecMemberMenu)

		elseif nhc.OX then
			local chance = nil
			local barDecMemberMenu = {}

			if check ~= nil then 	
				for k,v in pairs(check) do
					if v.bar_state == 1 then
						chance = LangClient['bar_members_decline_menu_chance_one']
					elseif v.bar_state == 8 then
						chance = LangClient['bar_members_decline_menu_chance_two']
					end

					if v.bar_state == 1 or v.bar_state == 8 then
						table.insert(barDecMemberMenu,  {
							title = LangClient['bar_members_decline_menu_header_two']:format(v.name), 
							description = chance,
							serverEvent = "ap-court:server:updatePlayerRetakeJudge",
							args = v
						})
					end
				end
			end

			lib.registerContext({
				id = 'barDecMemberMenu',
				title = LangClient['bar_members_decline_menu_header_one'],
				options = barDecMemberMenu
			})  
			ContextMenu("barDecMemberMenu")

		elseif nhc.AP then
			local chance = nil
			local apOptions = {}

			if check ~= nil then 	
				for k,v in pairs(check) do
					if v.bar_state == 1 then
						chance = LangClient['bar_members_decline_menu_chance_one']
					elseif v.bar_state == 8 then
						chance = LangClient['bar_members_decline_menu_chance_two']
					end

					if v.bar_state == 1 or v.bar_state == 8 then
						table.insert(apOptions, {
							title = LangClient['bar_members_decline_menu_header_two']:format(v.name),
							description = chance,
							event = "ap-court:server:updatePlayerRetakeJudge",
							args = v,
							isServer = true
						})
					end
				end
			end

			MyUI.showContext(
				LangClient['bar_members_decline_menu_header_one'],
				apOptions,
				{
					event = "ap-court:client:judgeMenu",
					args = "",
					isServer = false
				}, 
				10  
			)
		end
	end)
end)

RegisterNetEvent('ap-court:client:judgeExamQuestions', function()
	QBCore.Functions.TriggerCallback('ap-court:getBarQuestionsJudge', function(check)
		if nhc.QB then
			local searchExamQuestions = {}

			if check ~= nil then 	
				for k, v in pairs(check) do
					table.insert(searchExamQuestions, {
						header = v.question,
						txt = "a: " .. v.a .. " | b: " .. v.b .. " | c: " .. v.c .. " | d: " .. v.d .. " | Answer: " .. v.answer,
						params = {
							isServer = false,
							event = "ap-court:client:ChangeJudgeExamQuestions",
							args = v
						}
					})
				end
			end

			ContextMenu(searchExamQuestions)

		elseif nhc.OX then
			local searchExamQuestions = {}

			if check ~= nil then 	
				for k, v in pairs(check) do
					table.insert(searchExamQuestions, {
						title = v.question,
						description = "a: " .. v.a .. " | b: " .. v.b .. " | c: " .. v.c .. " | d: " .. v.d .. " | Answer: " .. v.answer,
						event = "ap-court:client:ChangeJudgeExamQuestions",
						args = v
					})
				end
			end

			lib.registerContext({
				id = 'searchExamQuestions',
				title = LangClient['searchExamQuestions_title'],
				options = searchExamQuestions
			})
			ContextMenu("searchExamQuestions")

		elseif nhc.AP then
			local apOptions = {}

			if check ~= nil then 	
				for k, v in pairs(check) do
					table.insert(apOptions, {
						title = v.question,
						description = "a: " .. v.a .. " | b: " .. v.b .. " | c: " .. v.c .. " | d: " .. v.d .. " | Answer: " .. v.answer,
						icon = "fa-question-circle",
						isServer = false,
						event = "ap-court:client:ChangeJudgeExamQuestions",
						args = v
					})
				end
			end

			MyUI.showContext(LangClient['searchExamQuestions_title'], apOptions, {
				isServer = false,
				event = "ap-court:client:judgeMenu",
				args = ""
			})
		end
	end)
end)

RegisterNetEvent('ap-court:client:ChangeJudgeExamQuestions', function(v)
	if nhc.QB then	
		local backgroundMenu = ContextMenu({
			{
				header = LangClient['judge_exam_questions_menu_header_one']:format(v.last_changed_by),
				txt = " ",
				isMenuHeader = true,
			},
			{
				header = LangClient['judge_exam_questions_menu_header_two'],
				txt = v.question,
				params = {
					isServer = false,
					event = "ap-court:client:editJudgeExamQuestion",
					args = { id = v.id, input = v.question, answer = "Question" }
				}
			},
			{
				header = LangClient['judge_exam_questions_menu_header_three'],
				txt = v.a,
				params = {
					isServer = false,
					event = "ap-court:client:editJudgeExamQuestion",
					args = { id = v.id, input = v.a, answer = "Answer A" }
				}
			},
			{
				header = LangClient['judge_exam_questions_menu_header_four'],
				txt = v.b,
				params = {
					isServer = false,
					event = "ap-court:client:editJudgeExamQuestion",
					args = { id = v.id, input = v.b, answer = "Answer B" }
				}
			},
			{
				header = LangClient['judge_exam_questions_menu_header_five'],
				txt = v.c,
				params = {
					isServer = false,
					event = "ap-court:client:editJudgeExamQuestion",
					args = { id = v.id, input = v.c, answer = "Answer C" }
				}
			},
			{
				header = LangClient['judge_exam_questions_menu_header_six'],
				txt = v.d,
				params = {
					isServer = false,
					event = "ap-court:client:editJudgeExamQuestion",
					args = { id = v.id, input = v.d, answer = "Answer D" }
				}
			},
			{
				header = LangClient['judge_exam_questions_menu_header_seven'],
				txt = v.answer,
				params = {
					isServer = false,
					event = "ap-court:client:editJudgeExamQuestion",
					args = { id = v.id, input = v.answer, answer = "Correct Answer" }
				}
			},
		})

	elseif nhc.OX then
		lib.registerContext({
			id = 'backgroundMenu',
			title = LangClient['judge_exam_questions_title'],
			options = {
				{
					title = LangClient['judge_exam_questions_menu_header_one']:format(v.last_changed_by),
					description = " ",
					disabled = true
				},
				{
					title = LangClient['judge_exam_questions_menu_header_two'],
					description = v.question,
					event = "ap-court:client:editJudgeExamQuestion",
					args = { id = v.id, input = v.question, answer = "Question" }
				},
				{
					title = LangClient['judge_exam_questions_menu_header_three'],
					description = v.a,
					event = "ap-court:client:editJudgeExamQuestion",
					args = { id = v.id, input = v.a, answer = "Answer A" }
				},
				{
					title = LangClient['judge_exam_questions_menu_header_four'],
					description = v.b,
					event = "ap-court:client:editJudgeExamQuestion",
					args = { id = v.id, input = v.b, answer = "Answer B" }
				},
				{
					title = LangClient['judge_exam_questions_menu_header_five'],
					description = v.c,
					event = "ap-court:client:editJudgeExamQuestion",
					args = { id = v.id, input = v.c, answer = "Answer C" }
				},
				{
					title = LangClient['judge_exam_questions_menu_header_six'],
					description = v.d,
					event = "ap-court:client:editJudgeExamQuestion",
					args = { id = v.id, input = v.d, answer = "Answer D" }
				},
				{
					title = LangClient['judge_exam_questions_menu_header_seven'],
					description = v.answer,
					event = "ap-court:client:editJudgeExamQuestion",
					args = { id = v.id, input = v.answer, answer = "Correct Answer" }
				},
			}
		})
		ContextMenu("backgroundMenu")

	elseif nhc.AP then
		local apOptions = {
			{
				title = LangClient['judge_exam_questions_menu_header_two'],
				description = v.question,
				icon = "fa-pen-to-square",
				event = "ap-court:client:editJudgeExamQuestion",
				isServer = false,
				args = { id = v.id, input = v.question, answer = "Question", exam = v}
			},
			{
				title = LangClient['judge_exam_questions_menu_header_three'],
				description = v.a,
				icon = "fa-a",
				event = "ap-court:client:editJudgeExamQuestion",
				isServer = false,
				args = { id = v.id, input = v.a, answer = "Answer A", exam = v}
			},
			{
				title = LangClient['judge_exam_questions_menu_header_four'],
				description = v.b,
				icon = "fa-b",
				event = "ap-court:client:editJudgeExamQuestion",
				isServer = false,
				args = { id = v.id, input = v.b, answer = "Answer B", exam = v}
			},
			{
				title = LangClient['judge_exam_questions_menu_header_five'],
				description = v.c,
				icon = "fa-c",
				event = "ap-court:client:editJudgeExamQuestion",
				isServer = false,
				args = { id = v.id, input = v.c, answer = "Answer C", exam = v}
			},
			{
				title = LangClient['judge_exam_questions_menu_header_six'],
				description = v.d,
				icon = "fa-d",
				event = "ap-court:client:editJudgeExamQuestion",
				isServer = false,
				args = { id = v.id, input = v.d, answer = "Answer D", exam = v}
			},
			{
				title = LangClient['judge_exam_questions_menu_header_seven'],
				description = v.answer,
				icon = "fa-check",
				event = "ap-court:client:editJudgeExamQuestion",
				isServer = false,
				args = { id = v.id, input = v.answer, answer = LangClient['judge_exam_answer_label'], exam = v}
			}
		}

		MyUI.showContext(LangClient['judge_exam_questions_menu_header_one']:format(v.last_changed_by), apOptions, {
			event = "ap-court:client:judgeExamQuestions",
			args = "",
			isServer = false
		})
	end
end)

RegisterNetEvent('ap-court:client:editJudgeExamQuestion', function(q)
	if Config.Dialog.QB then
		local dialog = exports[Config.ExportNames.input]:ShowInput({
			header = q.answer,
			submitText = "Submit",
			inputs = {
				{
					text = q.input,
					name = "input",
					type = "text",
					isRequired = true
				},
			},
		})

		if dialog ~= nil then
			if dialog.input == nil then
				TriggerEvent('ap-court:notify', 'You need to input this field!')
			else
				TriggerServerEvent('ap-court:server:changeJudgeExamQuestions', q.id, q.input, q.answer, dialog.input)
			end
		end

	elseif Config.Dialog.OX then
		local dialog = lib.inputDialog(q.answer, { q.input })
		if dialog then
			if dialog[1] == nil then
				TriggerEvent('ap-court:notify', 'You need to input this field!')
			else
				TriggerServerEvent('ap-court:server:changeJudgeExamQuestions', q.id, q.input, q.answer, dialog[1])
			end
		end

	elseif Config.Dialog.AP then
		if q.answer == LangClient['judge_exam_answer_label'] then
			MyUI.inputDialog(q.answer, {
				{
					label = LangClient['judge_exam_answer_dialog_header'],
					type = "select",
					required = true,
					icon = "fa-list",
					default = q.input,
					options = {
						{ label = LangClient['judge_exam_answer_dialog_a'], value = "a" },
						{ label = LangClient['judge_exam_answer_dialog_b'], value = "b" },
						{ label = LangClient['judge_exam_answer_dialog_c'], value = "c" },
						{ label = LangClient['judge_exam_answer_dialog_d'], value = "d" },
					}
				}
			}, function(data)
				local inputValue = data[1]
				if not inputValue or inputValue == "" then
					TriggerEvent('ap-court:notify', 'You need to select an answer!')
				else
					TriggerServerEvent('ap-court:server:changeJudgeExamQuestions', q.id, q.input, q.answer, inputValue)
				end
			end, {
				event = "ap-court:client:ChangeJudgeExamQuestions",
				args = q.exam,
				isServer = false
			})
		else
			MyUI.inputDialog(q.answer, {
				{
					label = q.input,
					type = "text",
					required = true,
					default = q.input,
					icon = "fa-pen-to-square"
				}
			}, function(data)
				local inputValue = data[1]
				if not inputValue or inputValue == "" then
					TriggerEvent('ap-court:notify', 'You need to input this field!')
				else
					TriggerServerEvent('ap-court:server:changeJudgeExamQuestions', q.id, q.input, q.answer, inputValue)
				end
			end, {
				event = "ap-court:client:ChangeJudgeExamQuestions",
				args = q.exam,
				isServer = false
			})
		end
	end

end)

RegisterNetEvent('ap-court:client:courtPayouts', function(v)
	if nhc.QB then
		local courtPayouts = ContextMenu({
			{
				header = LangClient['court_payout_menu_header_one'],
				txt = LangClient['court_payout_menu_txt_one']:format(v.defendantn),
				params = {
					isServer = false,
					event = "ap-court:client:defendantPayoutsSubMenu",
					args = v
				}
			},
			{
				header = LangClient['court_payout_menu_header_two'],
				txt = LangClient['court_payout_menu_txt_two']:format(v.defensen),
				params = {
					isServer = false,
					event = "ap-court:client:defensePayoutsSubMenu",
					args = v
				}
			},
		})

	elseif nhc.OX then
		lib.registerContext({
			id = 'courtPayouts',
			title = LangClient['court_payout_title'],
			options = {
				{
					title = LangClient['court_payout_menu_header_one'],
					description = LangClient['court_payout_menu_txt_one']:format(v.defendantn),
					event = "ap-court:client:defendantPayoutsSubMenu",
					args = v
				},
				{
					title = LangClient['court_payout_menu_header_two'],
					description = LangClient['court_payout_menu_txt_two']:format(v.defensen),
					event = "ap-court:client:defensePayoutsSubMenu",
					args = v
				}
			}
		})
		ContextMenu("courtPayouts")

	elseif nhc.AP then
		local apOptions = {
			{
				title = LangClient['court_payout_menu_header_one'],
				description = LangClient['court_payout_menu_txt_one']:format(v.defendantn),
				event = "ap-court:client:defendantPayoutsSubMenu",
				args = v,
				isServer = false,
				icon = "fas fa-user-slash" 
			},
			{
				title = LangClient['court_payout_menu_header_two'],
				description = LangClient['court_payout_menu_txt_two']:format(v.defensen),
				event = "ap-court:client:defensePayoutsSubMenu",
				args = v,
				isServer = false,
				icon = "fas fa-user-shield"
			}
		}

		MyUI.showContext(
			LangClient['court_payout_title'],
			apOptions,
			{
				event = "ap-court:client:activeCase",
				args = v,
				isServer = false
			},
			5 
		)
	end

end)

RegisterNetEvent('ap-court:client:defendantPayoutsSubMenu', function(v)
	local backReturn = {
		event = "ap-court:client:courtPayouts",
		args = v,
		isServer = false
	}

	if v.no_show_state == 1 and v.settlement_state == 1 then
		if nhc.QB then
			ContextMenu({
				{
					header = "No Payment Options Available",
					txt = " ",
					isMenuHeader = true,
				},
			})
		elseif nhc.OX then
			lib.registerContext({
				id = 'defendantPayoutsSubMenu',
				title = "Payment Options",
				options = {
					{
						title = "No Payment Options Available",
						description = " ",
						disabled = true
					}
				}
			})
			ContextMenu("defendantPayoutsSubMenu")
		elseif nhc.AP then
			MyUI.showContext("Payment Options", {
				{
					title = "No Payment Options Available",
					description = " ",
					icon = "fas fa-ban",
					disabled = true
				}
			}, backReturn, 5)
		end

	elseif v.no_show_state == 0 and v.settlement_state == 1 then
		if nhc.QB then
			ContextMenu({
				{
					header = LangClient['defendant_payout_menu_header_one'],
					txt = LangClient['defendant_payout_menu_txt_one']:format(currency, Config.NoShowPenaltyAmount),
					params = {
						isServer = true,
						event = "ap-court:server:NoShowMenuPayout",
						args = {
							v = v,
							input = "Defendant",
							amount = tonumber(Config.NoShowPenaltyAmount)
						}
					}
				}
			})
		elseif nhc.OX then
			lib.registerContext({
				id = 'defendantPayoutsSubMenu',
				title = LangClient['defendant_payout_title'],
				options = {
					{
						title = LangClient['defendant_payout_menu_header_one'],
						description = LangClient['defendant_payout_menu_txt_one']:format(currency, Config.NoShowPenaltyAmount),
						serverEvent = "ap-court:server:NoShowMenuPayout",
						args = {
							v = v,
							input = "Defendant",
							amount = tonumber(Config.NoShowPenaltyAmount)
						}
					}
				}
			})
			ContextMenu("defendantPayoutsSubMenu")
		elseif nhc.AP then
			MyUI.showContext(LangClient['defendant_payout_title'], {
				{
					title = LangClient['defendant_payout_menu_header_one'],
					description = LangClient['defendant_payout_menu_txt_one']:format(currency, Config.NoShowPenaltyAmount),
					event = "ap-court:server:NoShowMenuPayout",
					args = {
						v = v,
						input = "Defendant",
						amount = tonumber(Config.NoShowPenaltyAmount),
						icon = "fa-solid fa-money-bill-wave"
					},
					isServer = true
				}
			}, backReturn, 5)
		end

	elseif v.no_show_state == 1 and v.settlement_state == 0 then
		if nhc.QB then
			ContextMenu({
				{
					header = LangClient['defendant_payout_menu_header_two'],
					txt = LangClient['defendant_payout_menu_txt_two']:format(currency, v.courtfees),
					params = {
						isServer = true,
						event = "ap-court:server:payoutsSettlement",
						args = {
							v = v,
							input = "Defendant"
						}
					}
				}
			})
		elseif nhc.OX then
			lib.registerContext({
				id = 'defendantPayoutsSubMenu',
				title = LangClient['defendant_payout_title'],
				options = {
					{
						title = LangClient['defendant_payout_menu_header_two'],
						description = LangClient['defendant_payout_menu_txt_two']:format(currency, v.courtfees),
						serverEvent = "ap-court:server:payoutsSettlement",
						args = {
							v = v,
							input = "Defendant"
						}
					}
				}
			})
			ContextMenu("defendantPayoutsSubMenu")
		elseif nhc.AP then
			MyUI.showContext(LangClient['defendant_payout_title'], {
				{
					title = LangClient['defendant_payout_menu_header_two'],
					description = LangClient['defendant_payout_menu_txt_two']:format(currency, v.courtfees),
					event = "ap-court:server:payoutsSettlement",
					args = {
						v = v,
						input = "Defendant"
					},
					isServer = true,
					icon = "fas fa-scale-balanced"
				}
			}, backReturn, 5)
		end

	elseif v.no_show_state == 0 and v.settlement_state == 0 then
		if nhc.QB then
			ContextMenu({
				{
					header = LangClient['defendant_payout_menu_header_one'],
					txt = LangClient['defendant_payout_menu_txt_one']:format(currency, Config.NoShowPenaltyAmount),
					params = {
						isServer = true,
						event = "ap-court:server:NoShowMenuPayout",
						args = {
							v = v,
							input = "Defendant",
							amount = tonumber(Config.NoShowPenaltyAmount)
						}
					}
				},
				{
					header = LangClient['defendant_payout_menu_header_two'],
					txt = LangClient['defendant_payout_menu_txt_two']:format(currency, v.courtfees),
					params = {
						isServer = true,
						event = "ap-court:server:payoutsSettlement",
						args = {
							v = v,
							input = "Defendant"
						}
					}
				}
			})
		elseif nhc.OX then
			lib.registerContext({
				id = 'defendantPayoutsSubMenu',
				title = LangClient['defendant_payout_title'],
				options = {
					{
						title = LangClient['defendant_payout_menu_header_one'],
						description = LangClient['defendant_payout_menu_txt_one']:format(currency, Config.NoShowPenaltyAmount),
						serverEvent = "ap-court:server:NoShowMenuPayout",
						args = {
							v = v,
							input = "Defendant",
							amount = tonumber(Config.NoShowPenaltyAmount)
						}
					},
					{
						title = LangClient['defendant_payout_menu_header_two'],
						description = LangClient['defendant_payout_menu_txt_two']:format(currency, v.courtfees),
						serverEvent = "ap-court:server:payoutsSettlement",
						args = {
							v = v,
							input = "Defendant"
						}
					}
				}
			})
			ContextMenu("defendantPayoutsSubMenu")
		elseif nhc.AP then
			MyUI.showContext(LangClient['defendant_payout_title'], {
				{
					title = LangClient['defendant_payout_menu_header_one'],
					description = LangClient['defendant_payout_menu_txt_one']:format(currency, Config.NoShowPenaltyAmount),
					event = "ap-court:server:NoShowMenuPayout",
					args = {
						v = v,
						input = "Defendant",
						amount = tonumber(Config.NoShowPenaltyAmount)
					},
					isServer = true,
					icon = "fas fa-money-bill-wave"
				},
				{
					title = LangClient['defendant_payout_menu_header_two'],
					description = LangClient['defendant_payout_menu_txt_two']:format(currency, v.courtfees),
					event = "ap-court:server:payoutsSettlement",
					args = {
						v = v,
						input = "Defendant"
					},
					isServer = true,
					icon = "fas fa-scale-balanced"
				}
			}, backReturn, 5)
		end
	end
end)

RegisterNetEvent('ap-court:client:defensePayoutsSubMenu', function(v)
	local backReturn = {
		event = "ap-court:client:courtPayouts",
		args = v,
		isServer = false
	}

	if v.no_show_state == 1 and v.settlement_state == 1 then
		if nhc.QB then
			ContextMenu({
				{
					header = "No Payment Options Available",
					txt = " ",
					isMenuHeader = true,
				},
			})
		elseif nhc.OX then
			lib.registerContext({
				id = 'defensePayoutsSubMenu',
				title = "Payment Options",
				options = {
					{
						title = "No Payment Options Available",
						description = " ",
						disabled = true
					}
				}
			})
			ContextMenu("defensePayoutsSubMenu")
		elseif nhc.AP then
			MyUI.showContext("Payment Options", {
				{
					title = "No Payment Options Available",
					description = " ",
				}
			}, backReturn, 5)
		end

	elseif v.no_show_state == 0 and v.settlement_state == 1 then
		if nhc.QB then
			ContextMenu({
				{
					header = LangClient['defense_payout_menu_header_one'],
					txt = LangClient['defense_payout_menu_txt_one']:format(currency, Config.NoShowPenaltyAmount),
					params = {
						isServer = true,
						event = "ap-court:server:NoShowMenuPayout",
						args = {
							v = v,
							input = "Defense",
							amount = tonumber(Config.NoShowPenaltyAmount)
						}
					}
				}
			})
		elseif nhc.OX then
			lib.registerContext({
				id = 'defensePayoutsSubMenu',
				title = LangClient['defense_payout_title'],
				options = {
					{
						title = LangClient['defense_payout_menu_header_one'],
						description = LangClient['defense_payout_menu_txt_one']:format(currency, Config.NoShowPenaltyAmount),
						serverEvent = "ap-court:server:NoShowMenuPayout",
						args = {
							v = v,
							input = "Defense",
							amount = tonumber(Config.NoShowPenaltyAmount)
						}
					}
				}
			})
			ContextMenu("defensePayoutsSubMenu")
		elseif nhc.AP then
			MyUI.showContext(LangClient['defense_payout_title'], {
				{
					title = LangClient['defense_payout_menu_header_one'],
					description = LangClient['defense_payout_menu_txt_one']:format(currency, Config.NoShowPenaltyAmount),
					event = "ap-court:server:NoShowMenuPayout",
					args = {
						v = v,
						input = "Defense",
						amount = tonumber(Config.NoShowPenaltyAmount)
					},
					isServer = true
				}
			}, backReturn, 5)
		end

	elseif v.no_show_state == 1 and v.settlement_state == 0 then
		if nhc.QB then
			ContextMenu({
				{
					header = LangClient['defense_payout_menu_header_two'],
					txt = LangClient['defense_payout_menu_txt_two']:format(currency, v.courtfees),
					params = {
						isServer = true,
						event = "ap-court:server:payoutsSettlement",
						args = {
							v = v,
							input = "Defense"
						}
					}
				}
			})
		elseif nhc.OX then
			lib.registerContext({
				id = 'defensePayoutsSubMenu',
				title = LangClient['defense_payout_title'],
				options = {
					{
						title = LangClient['defense_payout_menu_header_two'],
						description = LangClient['defense_payout_menu_txt_two']:format(currency, v.courtfees),
						serverEvent = "ap-court:server:payoutsSettlement",
						args = {
							v = v,
							input = "Defense"
						}
					}
				}
			})
			ContextMenu("defensePayoutsSubMenu")
		elseif nhc.AP then
			MyUI.showContext(LangClient['defense_payout_title'], {
				{
					title = LangClient['defense_payout_menu_header_two'],
					description = LangClient['defense_payout_menu_txt_two']:format(currency, v.courtfees),
					event = "ap-court:server:payoutsSettlement",
					args = {
						v = v,
						input = "Defense"
					},
					isServer = true
				}
			}, backReturn, 5)
		end

	elseif v.no_show_state == 0 and v.settlement_state == 0 then
		if nhc.QB then
			ContextMenu({
				{
					header = LangClient['defense_payout_menu_header_one'],
					txt = LangClient['defense_payout_menu_txt_one']:format(currency, Config.NoShowPenaltyAmount),
					params = {
						isServer = true,
						event = "ap-court:server:NoShowMenuPayout",
						args = {
							v = v,
							input = "Defense",
							amount = tonumber(Config.NoShowPenaltyAmount)
						}
					}
				},
				{
					header = LangClient['defense_payout_menu_header_two'],
					txt = LangClient['defense_payout_menu_txt_two']:format(currency, v.courtfees),
					params = {
						isServer = true,
						event = "ap-court:server:payoutsSettlement",
						args = {
							v = v,
							input = "Defense"
						}
					}
				}
			})
		elseif nhc.OX then
			lib.registerContext({
				id = 'defensePayoutsSubMenu',
				title = LangClient['defense_payout_title'],
				options = {
					{
						title = LangClient['defense_payout_menu_header_one'],
						description = LangClient['defense_payout_menu_txt_one']:format(currency, Config.NoShowPenaltyAmount),
						serverEvent = "ap-court:server:NoShowMenuPayout",
						args = {
							v = v,
							input = "Defense",
							amount = tonumber(Config.NoShowPenaltyAmount)
						}
					},
					{
						title = LangClient['defense_payout_menu_header_two'],
						description = LangClient['defense_payout_menu_txt_two']:format(currency, v.courtfees),
						serverEvent = "ap-court:server:payoutsSettlement",
						args = {
							v = v,
							input = "Defense"
						}
					}
				}
			})
			ContextMenu("defensePayoutsSubMenu")
		elseif nhc.AP then
			MyUI.showContext(LangClient['defense_payout_title'], {
				{
					title = LangClient['defense_payout_menu_header_one'],
					description = LangClient['defense_payout_menu_txt_one']:format(currency, Config.NoShowPenaltyAmount),
					event = "ap-court:server:NoShowMenuPayout",
					args = {
						v = v,
						input = "Defense",
						amount = tonumber(Config.NoShowPenaltyAmount)
					},
					isServer = true
				},
				{
					title = LangClient['defense_payout_menu_header_two'],
					description = LangClient['defense_payout_menu_txt_two']:format(currency, v.courtfees),
					event = "ap-court:server:payoutsSettlement",
					args = {
						v = v,
						input = "Defense"
					},
					isServer = true
				}
			}, backReturn, 5)
		end
	end
end)

RegisterNetEvent('ap-court:client:adjournCourtTime', function(id, v)
	if Config.Dialog.QB then
		local dialog = exports[Config.ExportNames.input]:ShowInput({
			header = LangClient['adjourn_date_dialog_header'],
			submitText = "Submit",
			inputs = {
				{
					text = LangClient['adjourn_date_dialog_txt_one'],
					name = "date",
					type = "text",
					isRequired = true
				},
				{
					text = LangClient['adjourn_date_dialog_txt_two'],
					name = "time",
					type = "text",
					isRequired = true
				},
			},
		})

		if dialog ~= nil then
			if not dialog.date or not dialog.time then
				TriggerEvent('ap-court:notify', 'You need to input a date & time!')
			else
				local payload = {
					id = id,
					menuType = true,
					newDate = dialog.date .. " " .. dialog.time,
					disc = v
				}
				TriggerServerEvent('ap-court:server:adjournCourtCase', payload)
			end
		end

	elseif Config.Dialog.OX then
		local dialog = lib.inputDialog(LangClient['adjourn_date_dialog_header'], {
			LangClient['adjourn_date_dialog_txt_one'],
			LangClient['adjourn_date_dialog_txt_two']
		})
		if dialog then
			if not dialog[1] or not dialog[2] then
				TriggerEvent('ap-court:notify', 'You need to input a date & time!')
			else
				local payload = {
					id = id,
					menuType = true,
					newDate = dialog[1] .. " " .. dialog[2],
					disc = v
				}
				TriggerServerEvent('ap-court:server:adjournCourtCase', payload)
			end
		end

	elseif Config.Dialog.AP then
		MyUI.inputDialog(LangClient['adjourn_date_dialog_header'], {
			{
				label = LangClient['adjourn_date_dialog_txt_one'],
				type = "date",
				icon = "fa-calendar-days",
				required = true
			},
			{
				label = LangClient['adjourn_date_dialog_txt_two'],
				type = "time",
				icon = "fa-clock",
				required = true
			}
		}, function(data)
			local date = data[1]
			local time = data[2]

			if not date or not time or date == "" or time == "" then
				TriggerEvent('ap-court:notify', 'You need to input a date & time!')
			else
				local payload = {
					id = id,
					menuType = true,
					newDate = date .. " " .. time,
					disc = v
				}
				TriggerServerEvent('ap-court:server:adjournCourtCase', payload)
			end
		end)
	end
end)

RegisterNetEvent('ap-court:client:appointmentRequests', function()
	QBCore.Functions.TriggerCallback('ap-court:getBarMembers', function(check)
		if nhc.QB then
			local appointmentRequests = {
				{
					header = LangClient['appointment_requests_menu_header_one'],
					txt = " ",
					isMenuHeader = true,
				}
			}

			if check ~= nil then 	
				for k,v in pairs(check) do
					if v.app_state == 1 then
						table.insert(appointmentRequests, {
							header = LangClient['appointment_requests_menu_header_two']:format(v.name),
							txt = LangClient['appointment_requests_menu_txt_one']:format(v.app_reason),
							params = {
								isServer = false,
								event = "ap-court:client:appSubMenu",
								args = v
							}
						})
					end
				end
			end

			ContextMenu(appointmentRequests)

		elseif nhc.OX then
			local appointmentRequests = {}

			if check ~= nil then 	
				for k,v in pairs(check) do
					if v.app_state == 1 then
						table.insert(appointmentRequests, {
							title = LangClient['appointment_requests_menu_header_two']:format(v.name),
							description = LangClient['appointment_requests_menu_txt_one']:format(v.app_reason),
							event = "ap-court:client:appSubMenu",
							args = v
						})
					end
				end
			end

			lib.registerContext({
				id = 'appointmentRequests',
				title = LangClient['appointment_requests_menu_header_one'],
				options = appointmentRequests
			})
			ContextMenu("appointmentRequests")

		elseif nhc.AP then
			local apOptions = {}

			if check ~= nil then 	
				for k,v in pairs(check) do
					if v.app_state == 1 then
						table.insert(apOptions, {
							title = LangClient['appointment_requests_menu_header_two']:format(v.name),
							description = LangClient['appointment_requests_menu_txt_one']:format(v.app_reason),
							icon = "fa-calendar-check",
							event = "ap-court:client:appSubMenu",
							args = v,
							isServer = false
						})
					end
				end
			end

			MyUI.showContext(LangClient['appointment_requests_menu_header_one'], apOptions, {
				isServer = false,
				event = "ap-court:client:judgeMenu",
				args = ""
			})
		end
	end)
end)

RegisterNetEvent('ap-court:client:appSubMenu', function(v)
	if nhc.QB then
		local appSubMenu = ContextMenu({
			{
				header = LangClient['appointment_sub_menu_header_one'],
				txt = LangClient['appointment_sub_menu_txt_one'],
				params = {
					isServer = false,
					event = "ap-court:client:ApproveAppointment",
					args = v
				}
			},
			{
				header = LangClient['appointment_sub_menu_header_two'],
				txt = LangClient['appointment_sub_menu_txt_two'],
				params = {
					isServer = true,
					event = "ap-court:server:DenyAppointment",
					args = v
				}
			},
		})

	elseif nhc.OX then
		lib.registerContext({
			id = 'appSubMenu',
			title = LangClient['appointment_sub_title'],
			options = {
				{
					title = LangClient['appointment_sub_menu_header_one'],
					description = LangClient['appointment_sub_menu_txt_one'],
					event = "ap-court:client:ApproveAppointment",
					args = v
				},
				{
					title = LangClient['appointment_sub_menu_header_two'],
					description = LangClient['appointment_sub_menu_txt_two'],
					serverEvent = "ap-court:server:DenyAppointment",
					args = v
				}
			}
		})
		ContextMenu("appSubMenu")

	elseif nhc.AP then
		local apOptions = {
			{
				title = LangClient['appointment_sub_menu_header_one'],
				description = LangClient['appointment_sub_menu_txt_one'],
				icon = "fa-check-circle",
				event = "ap-court:client:ApproveAppointment",
				args = v,
				isServer = false
			},
			{
				title = LangClient['appointment_sub_menu_header_two'],
				description = LangClient['appointment_sub_menu_txt_two'],
				icon = "fa-times-circle",
				event = "ap-court:server:DenyAppointment",
				args = v,
				isServer = true
			}
		}

		MyUI.showContext(LangClient['appointment_sub_title'], apOptions, {
			event = "ap-court:client:appointmentRequests",
			args = {},
			isServer = false
		})
	end
end)

RegisterNetEvent('ap-court:client:ApproveAppointment', function(v)
	if Config.Dialog.QB then
		local dialog = exports[Config.ExportNames.input]:ShowInput({
			header = LangClient['approve_appointment_dialog_header'],
			submitText = "Submit",
			inputs = {
				{
					text = LangClient['approve_appointment_dialog_txt_one'],
					name = "date",
					type = "text",
					isRequired = true
				},
				{
					text = LangClient['approve_appointment_dialog_txt_two'],
					name = "time",
					type = "text",
					isRequired = true
				},
			},
		})

		if dialog ~= nil then
			if dialog.date == nil or dialog.time == nil then
				TriggerEvent('ap-court:notify', 'You need to input a date & time!')
			else
				local date = dialog.date .. " " .. dialog.time
				TriggerServerEvent('ap-court:server:ApproveAppointment', v, date)
			end
		end

	elseif Config.Dialog.OX then
		local dialog = lib.inputDialog(
			LangClient['approve_appointment_dialog_header'],
			{
				LangClient['approve_appointment_dialog_txt_one'],
				LangClient['approve_appointment_dialog_txt_two']
			}
		)

		if dialog then
			if dialog[1] == nil or dialog[2] == nil then
				TriggerEvent('ap-court:notify', 'You need to input a date & time!')
			else
				local date = dialog[1] .. " " .. dialog[2]
				TriggerServerEvent('ap-court:server:ApproveAppointment', v, date)
			end
		end

	elseif Config.Dialog.AP then
		MyUI.inputDialog(LangClient['approve_appointment_dialog_header'], {
			{
				label = LangClient['approve_appointment_dialog_txt_one'],
				type = "date", 
				required = true,
				icon = "fa-calendar-days"
			},
			{
				label = LangClient['approve_appointment_dialog_txt_two'],
				type = "time", 
				required = true,
				icon = "fa-clock"
			}
		}, function(data)
			local date = data[1]
			local time = data[2]

			if not date or not time or date == "" or time == "" then
				TriggerEvent('ap-court:notify', 'You need to input a date & time!')
			else
				local combined = date .. " " .. time
				TriggerServerEvent('ap-court:server:ApproveAppointment', v, combined)
			end
		end, {
			event = "ap-court:client:appSubMenu",
			args = v,
			isServer = false
		})
	end
end)

RegisterNetEvent('ap-court:client:scheduledAppointments', function()
	QBCore.Functions.TriggerCallback('ap-court:getBarMembers', function(check)
		if nhc.QB then
			local scheduledAppointments = {
				{
					header = LangClient['scheduled_appointments_menu_header_one'],
					txt = " ",
					isMenuHeader = true,
				}
			}

			if check ~= nil then 	
				for k,v in pairs(check) do
					if v.app_state == 2 then
						table.insert(scheduledAppointments, {
							header = LangClient['scheduled_appointments_menu_header_two']:format(v.name), 
							txt = LangClient['scheduled_appointments_menu_txt_one']:format(v.app_reason, v.app_date),
							params = {
								isServer = false,
								event = "ap-court:client:scheduledAppointmentsSub",
								args = v
							}
						})
					end
				end
			end

			ContextMenu(scheduledAppointments)

		elseif nhc.OX then
			local scheduledAppointments = {}

			if check ~= nil then 	
				for k,v in pairs(check) do
					if v.app_state == 2 then
						table.insert(scheduledAppointments, {
							title = LangClient['scheduled_appointments_menu_header_two']:format(v.name), 
							description = LangClient['scheduled_appointments_menu_txt_one']:format(v.app_reason, v.app_date),
							event = "ap-court:client:scheduledAppointmentsSub",
							args = v
						})
					end
				end
			end

			lib.registerContext({
				id = 'scheduledAppointments',
				title = LangClient['scheduled_appointments_menu_header_one'],
				options = scheduledAppointments
			})
			ContextMenu("scheduledAppointments")

		elseif nhc.AP then
			local apOptions = {}

			if check ~= nil then 	
				for k,v in pairs(check) do
					if v.app_state == 2 then
						table.insert(apOptions, {
							title = LangClient['scheduled_appointments_menu_header_two']:format(v.name),
							description = LangClient['scheduled_appointments_menu_txt_one']:format(v.app_reason, v.app_date),
							icon = "fa-calendar-check",
							event = "ap-court:client:scheduledAppointmentsSub",
							args = v,
							isServer = false
						})
					end
				end
			end

			MyUI.showContext(LangClient['scheduled_appointments_menu_header_one'], apOptions, {
				event = "ap-court:client:judgeMenu",
				args = "",
				isServer = false
			})
		end
	end)
end)

RegisterNetEvent('ap-court:client:scheduledAppointmentsSub', function(v)
	if nhc.QB then
		local scheduledAppointmentsSub = ContextMenu({
			{
				header = LangClient['finish_appointment_menu_header'],
				txt = LangClient['finish_appointment_menu_txt'],
				params = {
					isServer = true,
					event = "ap-court:server:CloseAppointment",
					args = v
				}
			},
		})

	elseif nhc.OX then
		lib.registerContext({
			id = 'scheduledAppointmentsSub',
			title = LangClient['appointment_sub_title'],
			options = {
				{
					title = LangClient['finish_appointment_menu_header'],
					description = LangClient['finish_appointment_menu_txt'],
					serverEvent = "ap-court:server:CloseAppointment",
					args = v
				}
			}
		})  
		ContextMenu("scheduledAppointmentsSub")

	elseif nhc.AP then
		local apOptions = {
			{
				title = LangClient['finish_appointment_menu_header'],
				description = LangClient['finish_appointment_menu_txt'],
				icon = "fa-calendar-xmark",
				event = "ap-court:server:CloseAppointment",
				args = v,
				isServer = true
			}
		}

		MyUI.showContext(LangClient['appointment_sub_title'], apOptions, {
			event = "ap-court:client:scheduledAppointments",
			args = {},
			isServer = false
		})
	end
end)

local plateModel = "p_ld_id_card_002"
local animDict = "missfbi_s4mop"
local animName = "swipe_card"
local plate_net = nil
local open = false

RegisterNetEvent('ap-court:client:cardopen')
AddEventHandler('ap-court:client:cardopen', function(data)
	for _, v in pairs(data) do
		open = true

		SendNUIMessage({
			action = "open",
			name = v.name,
			barid = v.barid,
			date = v.date
		})

		deleteCardEntity()

		Citizen.Wait(10000)

		SendNUIMessage({ action = "close" })
		open = false
	end
end)

RegisterNetEvent('ap-court:client:showcard')
AddEventHandler('ap-court:client:showcard', function(isMeta, data)
	if not isMeta then
		QBCore.Functions.TriggerCallback('ap-court:getMembers', function(players)
			for _, v in pairs(players) do
				handleCard(v)
			end
		end)
	else
		handleCard(data)
	end
end)

RegisterNetEvent('ap-court:client:useCard')
AddEventHandler('ap-court:client:useCard', function(isMeta, data)
	TriggerEvent('ap-court:client:showcard', isMeta, data)
end)

RegisterNetEvent('ap-court:client:anim')
AddEventHandler('ap-court:client:anim', function()
	startAnim()
end)

function handleCard(card)
	if not card or card.bar_state == nil or card.bar_state < 4 or card.bar_state >= 7 then
		TriggerEvent('ap-court:notify', "This card seems to be tampered with.")
	elseif card.bar_state == 6 then
		TriggerEvent('ap-court:notify', "The bar licence has been blacklisted by the national bar association.")
	else
		local player, distance = QBCore.Functions.GetClosestPlayer()
		TriggerEvent('ap-court:client:anim')

		if distance ~= -1 and distance <= 2.0 and player ~= -1 then
			TriggerServerEvent('ap-court:server:cardopen', GetPlayerServerId(player), card)
		end

		TriggerServerEvent('ap-court:server:cardopen', GetPlayerServerId(PlayerId()), card)
		deleteCardEntity()
	end
end

function startAnim()
    local playerPed = PlayerPedId()
    local model = GetHashKey(plateModel)

    RequestModel(model)
    while not HasModelLoaded(model) do
        Citizen.Wait(100)
    end

    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do
        Citizen.Wait(100)
    end

    ClearPedSecondaryTask(playerPed)
    TaskPlayAnim(playerPed, animDict, animName, 1.0, 1.0, -1, 50, 0, false, false, false)

    Citizen.Wait(500) 

    local coords = GetOffsetFromEntityInWorldCoords(playerPed, 0.0, 0.0, -5.0)
    local obj = CreateObject(model, coords.x, coords.y, coords.z, true, false, false)

    plate_net = ObjToNet(obj)
    SetNetworkIdExistsOnAllMachines(plate_net, true)
    SetNetworkIdCanMigrate(plate_net, false)

    AttachEntityToEntity(obj, playerPed, GetPedBoneIndex(playerPed, 28422),
        0.0, 0.0, 0.0, 
        0.0, 0.0, 0.0, 
        true, true, false, true, 1, true)

    Citizen.Wait(3000)

    ClearPedSecondaryTask(playerPed)
    deleteCardEntity()
end

function deleteCardEntity()
	if plate_net then
		local obj = NetToObj(plate_net)
		if DoesEntityExist(obj) then
			DetachEntity(obj, true, true)
			DeleteEntity(obj)
		end
		plate_net = nil
	end
end

RegisterNetEvent('ap-court:client:fixphone', function()
  if Config.Phone.RoadPhone == true then
    ExecuteCommand("fixphone")
  end
end)

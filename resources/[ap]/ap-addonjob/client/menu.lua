local ctm = Config.Context

AddJobAddonData = {}

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

RegisterNetEvent('ap-addonjob:client:AdminMenu', function(data)
  if ctm.QB then
    ContextMenu({
      {
        header = "Addon Job Actions",
        icon = "fa-solid fa-circle-info",
        txt = " ",
        isMenuHeader = true
      },
      {
        header = "Add New Job Addon",
        icon = "fa-solid fa-plus",
        txt = "Click here to add a new job addon.",
        params = {
          isServer = false,
          event = "ap-addonjob:client:addNewAddonJob",
          args = data
        }
      },
      {
        header = "Edit Current Addons",
        icon = "fa-solid fa-pen-to-square",
        txt = "Click here to edit a job addon that has been made.",
        params = {
          isServer = false,
          event = "ap-addonjob:client:editAddonJob",
          args = data
        }
      }
    })
  elseif ctm.OX then
    ContextMenu({
      id = 'mainAddonJob',
      title = "Addon Job Actions",
      options = {
        {
          title = "Add New Job Addon",
          icon = {'fa', 'plus'},
          description = "Click here to add a new job addon.",
          event = "ap-addonjob:client:addNewAddonJob",
          args = data
        },
        {
          title = "Edit Current Addons",
          icon = {'fa', 'pen-to-square'},
          description = "Click here to edit a job addon that has been made.",
          event = "ap-addonjob:client:editAddonJob",
          args = data
        }
      }
    })
  end
end)

RegisterNetEvent('ap-addonjob:client:addNewAddonJob', function(data)
  QBCore.Functions.TriggerCallback('ap-addonjob:getJobsFromDatabase', function(db)
    if Config.Dialog.QB then
      local Jobs = {}
      for k,v in pairs(data.Jobs) do 
        if db[k] == nil and AddJobAddonData[k] == nil then
          table.insert(Jobs, {
            value = k, text = v.label
          })
        end
      end
      local dialog = exports[Config.ExportNames.input]:ShowInput({
        header = "New Job Addon",
        submitText = "Submit",
        inputs = {
          {
            text = "Enable From Creation:",
            name = "enable",
            type = "select",
            options = {
              {value = "true", text = "True"},
              {value = "false", text = "False"}
            },
          },
          {
            text = "Job:",
            name = "job",
            type = "select",
            options = Jobs,
          }
        },
      })
    
      if dialog ~= nil then
        if AddJobAddonData[dialog.job] then
          AddonJobNotify("This job you have tried to add is already added to the Current Addons.")
        else
          AddJobAddonData[dialog.job] = {
            enable = dialog.enable,
            job = dialog.job,
            coords = {}
          }
          ConfigureBoss(AddJobAddonData[dialog.job], data)
        end
      end
    elseif Config.Dialog.OX then
      local Jobs = {}
      for k,v in pairs(data.Jobs) do 
        if db[k] == nil and AddJobAddonData[k] == nil then
          table.insert(Jobs, {
            value = k, label = v.label
          })
        end
      end
      local input = lib.inputDialog('New Job Addon', {
        {type = 'select', label = 'Enable From Creation:', description = 'Set this to true if you want the creation of this addon to be enabled from creation, or set to false if you want to add this first and enable at a later date from the edit current addons menu!', required = true, options = {
          {value = "true", label = "True"},
          {value = "false", label = "False"},
        }},
        {type = 'select', label = 'Job:', description = 'Select the job that you want this addon to be applied to.', required = true, options = Jobs}
      })
      if input ~= nil then
        if AddJobAddonData[input[2]] then
          AddonJobNotify("This job you have tried to add is already added to the Current Addons.")
        else
          AddJobAddonData[input[2]] = {
            enable = input[1],
            job = input[2],
            coords = {}
          }
          ConfigureBoss(AddJobAddonData[input[2]], data)
        end
      end
    end
  end)
end)

ConfigureBoss = function(JobData, data)
  if Config.Dialog.QB then
    local Ranks = {}
    for k,v in pairs(data.Jobs[JobData.job].grades) do 
      table.insert(Ranks, {
        value = k, text = v.name
      })
    end
    local dialog = exports[Config.ExportNames.input]:ShowInput({
      header = "Configure Boss Rank",
      submitText = "Submit",
      inputs = {
        {
          text = "Boss Rank:",
          name = "grade",
          type = "select",
          options = Ranks,
        }
      },
    })
  
    if dialog ~= nil then
      JobData.grade = dialog.grade
      ConfigurePedLocation(JobData, data)
    end
  elseif Config.Dialog.OX then
    local Ranks = {}
    for k,v in pairs(data.Jobs[JobData.job].grades) do
      table.insert(Ranks, {
        value = k, label = v.name
      })
    end
    local input = lib.inputDialog('Configure Boss Rank', {
      {type = 'select', label = 'Boss Rank:', description = 'Select the rank of this job to have control of management actions.', required = true, options = Ranks}
    })
    if input ~= nil then
      JobData.grade = input[1]
      ConfigurePedLocation(JobData, data)
    end
  end
end

ConfigurePedLocation = function(JobData, data)
  local playerPed = PlayerPedId()
  local playerCoords = GetEntityCoords(playerPed)
  local playerHeading = GetEntityHeading(playerPed)
  local x, y, z = table.unpack(playerCoords)
  if Config.Dialog.QB then
    local dialog = exports[Config.ExportNames.input]:ShowInput({
      header = "Spawned Ped Location",
      submitText = "Submit",
      inputs = {
        {text = "X Coords:", name = "1", type = "text", isRequired = true, default = x},
        {text = "Y Coords:", name = "2", type = "text", isRequired = true, default = y},
        {text = "Z Coords:", name = "3", type = "text", isRequired = true, default = z},
        {text = "Heading Coords:", name = "4", type = "text", isRequired = true, default = playerHeading},
        {text = "Ped Settings:", name = "-1", type = "checkbox", options = {{ value = "5", text = "minusOne"}}},
        {text = "Ped Model:", name = "6", type = "text", isRequired = true, default = Config.DefaultPedModel},
        {text = "Discord Webhook Link:", name = "7", type = "text", isRequired = true},
      },
    })
  
    if dialog ~= nil then
      local newZ = nil
      if dialog["5"] == "true" then newZ = (tonumber(dialog["3"]) - 1) else newZ = tonumber(dialog["3"]) end
      JobData.coords = {x = tonumber(dialog["1"]), y = tonumber(dialog["2"]), z = tonumber(newZ), h = tonumber(dialog["4"])}
      JobData.ped = dialog["6"]
      JobData.webhook = dialog["7"]
      TriggerServerEvent('ap-addonjob:server:saveAddonJob', JobData)
      AddJobAddonData[JobData.job] = nil
    end
  elseif Config.Dialog.OX then
    local input = lib.inputDialog('Spawned Ped Location', {
      {type = 'input', label = 'X Coords:', description = 'Here by default will be the x coords of your current position.', required = true, default = x},
      {type = 'input', label = 'Y Coords:', description = 'Here by default will be the y coords of your current position.', required = true, default = y},
      {type = 'input', label = 'Z Coords:', description = 'Here by default will be the z coords of your current position.', required = true, default = z},
      {type = 'input', label = 'Heading Coords:', description = 'Here by default will be the heading of your current position.', required = true, default = playerHeading},
      {type = 'checkbox', label = 'minusOne Ped'},
      {type = 'input', label = 'Ped Model:', description = 'Use https://docs.fivem.net/docs/game-references/ped-models/ for ped models.', required = true, default = Config.DefaultPedModel},
      {type = 'input', label = 'Discord Webhook Link:', description = 'Put your discord webhook link here, all webhook data will be sent to that channel.', required = true, placeholder = "Webhook Link"},
    })
    if input ~= nil then
      local newZ = nil
      if input[5] == true then newZ = (tonumber(input[3]) - 1) else newZ = tonumber(input[3]) end
      JobData.coords = {x = tonumber(input[1]), y = tonumber(input[2]), z = tonumber(newZ), h = tonumber(input[4])}
      JobData.ped = input[6]
      JobData.webhook = input[7]
      TriggerServerEvent('ap-addonjob:server:saveAddonJob', JobData)
      AddJobAddonData[JobData.job] = nil
    end
  end
end

RegisterNetEvent('ap-addonjob:client:editAddonJob', function(data)
  QBCore.Functions.TriggerCallback('ap-addonjob:getJobsFromDatabase', function(db)
    if ctm.QB then
      local MenuData = {
        {
          header = "Edit Addon Jobs",
          icon = "fa-solid fa-circle-info",
          txt = " ",
          isMenuHeader = true
        },
      }
      if next(AddJobAddonData) ~= nil then
        table.insert(MenuData, {
          header = "Unfinished Addon Setup",
          icon = "fa-solid fa-circle-info",
          txt = "Jobs displayed below will be from what you have started to configure but havent finished.",
          isMenuHeader = true
        })
        for k,v in pairs(AddJobAddonData) do
          table.insert(MenuData, {
            header = "Job: "..k,
            icon = "fa-solid fa-print",
            txt = "Click here to edit this addon job",
            params = {
              isServer = false,
              event = "ap-addonjob:client:configureAddonJob",
              args = {k = k, v = v, oldData = data}
            }
          })
        end  
      end
      if next(db) ~= nil then
        table.insert(MenuData, {
          header = "Jobs From Database:",
          icon = "fa-solid fa-circle-info",
          txt = "Jobs displayed below will be from what has already been added from the database.",
          isMenuHeader = true
        })
        for k,v in pairs(db) do
          if not AddJobAddonData[k] then
            table.insert(MenuData, {
              header = "Job: "..k,
              icon = "fa-solid fa-print",
              txt = "Click here to edit this addon job",
              params = {
                isServer = false,
                event = "ap-addonjob:client:configureAddonJob",
                args = {k = k, v = v, oldData = data}
              }
            })
          end
        end
      end
      table.insert(MenuData, {
        header = "Back",
        icon = "fa-solid fa-arrow-left",
        txt = "Click here to go back.",
        params = {
          isServer = false,
          event = "ap-addonjob:client:AdminMenu",
          args = data
        }
      })
      ContextMenu(MenuData)
    elseif ctm.OX then
      local MenuData = {}
      if next(AddJobAddonData) ~= nil then
        table.insert(MenuData, {
          title = "Unfinished Addon Setup",
          icon = {'fa', 'circle-info'},
          description = "Jobs displayed below will be from what you have started to configure but havent finished.",
          disabled = true
        })
        for k,v in pairs(AddJobAddonData) do
          table.insert(MenuData, {
            title = "Job: "..k,
            icon = {'fa', 'print'},
            description = "Click here to edit this addon job",
            event = "ap-addonjob:client:configureAddonJob",
            args = {k = k, v = v, oldData = data}
          })
        end
      end
      if next(db) ~= nil then
        table.insert(MenuData, {
          title = "Jobs From Database:",
          icon = {'fa', 'circle-info'},
          description = "Jobs displayed below will be from what has already been added from the database.",
          disabled = true
        })
        for k,v in pairs(db) do
          if not AddJobAddonData[k] then
            table.insert(MenuData, {
              title = "Job: "..k,
              icon = {'fa', 'print'},
              description = "Click here to edit this addon job",
              event = "ap-addonjob:client:configureAddonJob",
              args = {k = k, v = v, oldData = data}
            })
          end
        end
      end
      table.insert(MenuData, {
        title = "Back",
        icon = {'fa', 'arrow-left'},
        description = "Click here to go back.",
        event = "ap-addonjob:client:AdminMenu",
        args = data
      })
      ContextMenu({
        id = 'editAddonJob',
        title = "Edit Addon Jobs",
        options = MenuData
      })
    end
  end)
end)

RegisterNetEvent('ap-addonjob:client:configureAddonJob', function(data)
  if ctm.QB then
    ContextMenu({
      {
        header = "Configure: "..data.v.job,
        icon = "fa-solid fa-circle-info",
        txt = " ",
        isMenuHeader = true
      },
      {
        header = "Edit AddonJob Data:",
        icon = "fa-solid fa-pen-to-square",
        txt = "Click here to change the setup to this addon job.",
        params = {
          isServer = false,
          event = "ap-addonjob:client:changeAddonJob",
          args = data
        }
      },
      {
        header = "Delete Addon Job",
        icon = "fa-solid fa-trash",
        txt = "Click here to delete from database & local.",
        params = {
          isServer = false,
          event = "ap-addonjob:client:deleteAddonJob",
          args = data
        }
      },
      {
        header = "Back",
        icon = "fa-solid fa-arrow-left",
        txt = "Click here to go back.",
        params = {
          isServer = false,
          event = "ap-addonjob:client:editAddonJob",
          args = data.oldData
        }
      }
    })
  elseif ctm.OX then
    ContextMenu({
      id = 'ConfigureEditAddonJob',
      title = "Configure: "..data.v.job,
      options = {
        {
          title = "Edit AddonJob Data:",
          icon = {'fa', 'pen-to-square'},
          description = "Click here to change the setup to this addon job.",
          event = "ap-addonjob:client:changeAddonJob",
          args = data
        },
        {
          title = "Delete Addon Job",
          icon = {'fa', 'trash'},
          description = "Click here to delete from database & local.",
          event = "ap-addonjob:client:deleteAddonJob",
          args = data
        },
        {
          title = "Back",
          icon = {'fa', 'arrow-left'},
          description = "Click here to go back.",
          event = "ap-addonjob:client:editAddonJob",
          args = data.oldData
        }
      }
    })
  end
end)

RegisterNetEvent('ap-addonjob:client:changeAddonJob', function(data)
  local playerPed = PlayerPedId()
  local playerCoords = GetEntityCoords(playerPed)
  local playerHeading = GetEntityHeading(playerPed)
  local x, y, z = table.unpack(playerCoords)
  local currentGrade, currentEnable, currentCoords, currentPed, currentWebhook = nil, nil, {}, nil, nil
  if data.v.enable then currentEnable = data.v.enable else currentEnable = "true" end
  if data.v.grade then currentGrade = data.v.grade else currentGrade = "0" end
  if data.v.coords.x then currentCoords = data.v.coords else currentCoords = {x = tostring(x), y = tostring(y), z = tostring(z), h = tostring(playerHeading)} end
  if data.v.ped then currentPed = data.v.ped else currentPed = Config.DefaultPedModel end
  if data.v.webhook then currentWebhook = data.v.webhook else currentPed = Config.DefaultPedModel end
  QBCore.Functions.TriggerCallback('ap-addonjob:getRanksFromJob', function(db)

    if Config.Dialog.QB then
      local Ranks = {}
      for k,v in pairs(db) do
        table.insert(Ranks, {
          value = k, text = v.name
        })
      end
      local dialog = exports[Config.ExportNames.input]:ShowInput({
        header = "Edit Current Addon",
        submitText = "Submit",
        inputs = {
          {text = "Enable From Creation:", name = "enable", type = "select", 
            options = {
              {value = "true", text = "True"},
              {value = "false", text = "False"}
            }, 
            default = currentEnable
          },
          {text = "Boss Rank:", name = "grade", type = "select", options = Ranks, default = currentGrade},
          {text = "X Coords:", name = "x", type = "text", isRequired = true, default = currentCoords.x},
          {text = "Y Coords:", name = "y", type = "text", isRequired = true, default = currentCoords.y},
          {text = "Z Coords:", name = "z", type = "text", isRequired = true, default = currentCoords.z},
          {text = "Heading Coords:", name = "h", type = "text", isRequired = true, default = currentCoords.h},
          {text = "Ped Settings:", name = "-1", type = "checkbox", options = {{ value = "minus", text = "minusOne"}}},
          {text = "Ped Model:", name = "ped", type = "text", isRequired = true, default = currentPed},
          {text = "Discord Webhook Link:", name = "webhook", type = "text", isRequired = true},
        },
      })
    
      if dialog ~= nil then
        if AddJobAddonData[data.v.job] then AddJobAddonData[data.v.job] = nil end
        local newZ = nil
        if dialog.minus == true then newZ = (tonumber(dialog.z) - 1) else newZ = tonumber(dialog.z) end
        local newData = {
          enable = dialog.enable,
          job = data.v.job,
          grade = dialog.grade,
          coords = {x = tonumber(dialog.x), y = tonumber(dialog.y), z = tonumber(newZ), h = tonumber(dialog.h)},
          ped = dialog.ped,
          webhook = dialog.webhook
        }
        if SetupPeds[data.v.job] then
          TriggerServerEvent('ap-addonjob:server:deletePeds', data.v.job)
        end
        TriggerServerEvent('ap-addonjob:server:changeAddonJob', newData)
      end
    elseif Config.Dialog.OX then
      local Ranks = {}
      for k,v in pairs(db) do
        table.insert(Ranks, {
          value = k, label = v.name
        })
      end
      local input = lib.inputDialog('Edit Current Addon', {
        {type = 'select', label = 'Enable From Creation:', description = 'Set this to true if you want the enable this addon job, or set to false if you want to disable this addon job!', required = true, default = currentEnable, options = {
          {value = "true", label = "True"},
          {value = "false", label = "False"},
        }},
        {type = 'select', label = 'Boss Rank:', description = 'Select the rank of this job to have control of management actions.', required = true, default = currentGrade, options = Ranks},
        {type = 'input', label = 'X Coords:', description = 'Here by default will be the x coords of your current position.', required = true, default = currentCoords.x},
        {type = 'input', label = 'Y Coords:', description = 'Here by default will be the y coords of your current position.', required = true, default = currentCoords.y},
        {type = 'input', label = 'Z Coords:', description = 'Here by default will be the z coords of your current position.', required = true, default = currentCoords.z},
        {type = 'input', label = 'Heading Coords:', description = 'Here by default will be the heading of your current position.', required = true, default = currentCoords.h},
        {type = 'checkbox', label = 'minusOne Ped'},
        {type = 'input', label = 'Ped Model:', description = 'Use https://docs.fivem.net/docs/game-references/ped-models/ for ped models.', required = true, default = currentPed},
        {type = 'input', label = 'Discord Webhook Link:', required = true, default = currentWebhook, placeholder = "Webhook Link"},
      })
      if input ~= nil then
        if AddJobAddonData[data.v.job] then AddJobAddonData[data.v.job] = nil end
        local newZ = nil
        if input[7] == true then newZ = (tonumber(input[5]) - 1) else newZ = tonumber(input[5]) end
        local newData = {
          enable = input[1],
          job = data.v.job,
          grade = input[2],
          coords = {x = tonumber(input[3]), y = tonumber(input[4]), z = tonumber(newZ), h = tonumber(input[6])},
          ped = input[8],
          webhook = input[9]
        }
        if SetupPeds[data.v.job] then
          TriggerServerEvent('ap-addonjob:server:deletePeds', data.v.job)
        end
        TriggerServerEvent('ap-addonjob:server:changeAddonJob', newData)
      end
    end
  end, data.v.job)
end)

RegisterNetEvent('ap-addonjob:client:deleteAddonJob', function(data)
  if ctm.QB then
    ContextMenu({
      {
        header = "Delete Addon Job",
        icon = "fa-solid fa-circle-info",
        txt = "Click below to delete this addon job, once you delete it all data saved to the database will be removed from this addon job.",
        isMenuHeader = true
      },
      {
        header = "Confirm Delete",
        icon = "fa-solid fa-trash",
        txt = "Click here to delete from database & local.",
        params = {
          isServer = false,
          event = "ap-addonjob:client:deleteAddonJobNow",
          args = data
        }
      },
      {
        header = "Back",
        icon = "fa-solid fa-arrow-left",
        txt = "Click here to go back.",
        params = {
          isServer = false,
          event = "ap-addonjob:client:configureAddonJob",
          args = data
        }
      }
    })
  elseif ctm.OX then
    ContextMenu({
      id = 'ConfigureDeleteAddonJob',
      title = "Delete Addon Job",
      options = {
        {
          title = "Confirm Delete",
          icon = {'fa', 'trash'},
          description = "Click here to delete this addon job, once you delete it all data saved to the database will be removed from this addon job.",
          event = "ap-addonjob:client:deleteAddonJobNow",
          args = data
        },
        {
          title = "Back",
          icon = {'fa', 'arrow-left'},
          description = "Click here to go back.",
          event = "ap-addonjob:client:configureAddonJob",
          args = data
        }
      }
    })
  end
end)

RegisterNetEvent('ap-addonjob:client:publicMenu', function(data)
  TriggerEvent('ap-addonjob:client:publicJobMenu', data.args.job)
end)

RegisterNetEvent('ap-addonjob:client:publicJobMenu', function(job)
  QBCore.Functions.TriggerCallback('ap-addonjob:getAddonJobData', function(data)
    if ctm.QB then
      local MenuData = {
        {
          header = data.joblabel.." Reception",
          icon = "fa-solid fa-circle-info",
          txt = "Here you will be able to apply for a job with this company & also making an appointment with someone from the company.",
          isMenuHeader = true
        }
      }
      if data.management.appointments then
        table.insert(MenuData, {
          header = "Appointments",
          icon = "fa-solid fa-calendar-check",
          txt = "Click here to view appointments.",
          params = {
            isServer = false,
            event = "ap-addonjob:client:appointments",
            args = data
          }
        })
      end
      if data.management.applications or isPlayerApplied(GetIdentifier(), data.applications) then
        table.insert(MenuData, {
          header = "Job Application",
          icon = "fa-solid fa-file-contract",
          txt = "Click here to apply for a job.",
          params = {
            isServer = false,
            event = "ap-addonjob:client:jobapplication",
            args = data
          }
        })
      end
      if data.management.applications ~= true and data.management.appointments ~= true and isPlayerApplied(GetIdentifier(), data.applications) ~= true then
        table.insert(MenuData, {
          header = "No Public Actions Available",
          icon = "fa-solid fa-ban",
          txt = "There is no actions for you to complete here, please come back later!",
          isMenuHeader = true
        })
      end
      if checkJob(data.job, tonumber(data.boss_rank)) or CheckPlayerManagement(data.management.staff) then
        table.insert(MenuData, {
          header = "Management Options",
          icon = "fa-solid fa-people-roof",
          txt = "Click here to view the management options.",
          params = {
            isServer = false,
            event = "ap-addonjob:client:managementOptions",
            args = data
          }
        })
      end
      ContextMenu(MenuData)
    elseif ctm.OX then
      local MenuData = {}
      if data.management.appointments then
        table.insert(MenuData, {
          title = "Appointments",
          description = "Click here to view appointments.",
          icon = {'fa', 'calendar-check'},
          event = "ap-addonjob:client:appointments",
          args = data
        })
      end
      if data.management.applications or isPlayerApplied(GetIdentifier(), data.applications) then
        table.insert(MenuData, {
          title = "Job Application",
          description = "Click here to apply for a job.",
          icon = {'fa', 'file-contract'},
          event = "ap-addonjob:client:jobapplication",
          args = data
        })
      end
      if data.management.applications ~= true and data.management.appointments ~= true and isPlayerApplied(GetIdentifier(), data.applications) ~= true then
        table.insert(MenuData, {
          title = "No Public Actions Available",
          description = "There is no actions for you to complete here, please come back later!",
          icon = {'fa', 'ban'},
          disabled = true
        })
      end
      if checkJob(data.job, tonumber(data.boss_rank)) or CheckPlayerManagement(data.management.staff) then
        table.insert(MenuData, {
          title = "Management Options",
          description = "Click here to view the management options.",
          icon = {'fa', 'people-roof'},
          event = "ap-addonjob:client:managementOptions",
          args = data
        })
      end
      ContextMenu({
        id = 'MainPublicAddonJob',
        title = data.joblabel.." Reception",
        options = MenuData
      })
    end
  end, job)
end)

RegisterNetEvent('ap-addonjob:client:appointments', function(data)
  local appointmentsJob, AppointmentData = {}, data.appointments
  if ctm.QB then
    table.insert(appointmentsJob, {
      header = "Appointments",
      icon = "fa-solid fa-circle-info",
      txt = " ",
      isMenuHeader = true
    })
    if AppointmentData[GetIdentifier()] == nil then
      table.insert(appointmentsJob, {
        header = "Request Appointment",
        icon = "fa-solid fa-paper-plane",
        txt = "Click here to request an appointment",
        params = {
          isServer = false,
          event = "ap-addonjob:client:appointmentReason",
          args = data
        }
      })
    elseif AppointmentData[GetIdentifier()].state == 1 then
      table.insert(appointmentsJob, {
        header = "Appointment Status: [<span style='color:MediumSeaGreen;'>PENDING</span>]",
        icon = "fa-solid fa-spinner",
        txt = "Your appointment is pending the waiting list, once an appointment has been confirmed your status will change.",
        isMenuHeader = true
      }) 
      table.insert(appointmentsJob, {
        header = 'Cancel Appointment',
        icon = "fa-solid fa-folder-minus",
        txt = 'Click here to cancel the appointment.',
        params = {
          isServer = true,
          event = "ap-addonjob:server:cancelAppointment",
          args = data
        }
      })
    elseif AppointmentData[GetIdentifier()].state == 2 then
      table.insert(appointmentsJob, {
        header = 'Appointment Reason:',
        icon = "fa-solid fa-clipboard",
        txt = AppointmentData[GetIdentifier()].reason,
        isMenuHeader = true
      }) 
      table.insert(appointmentsJob, {
        header = 'Date & Time:',
        icon = "fa-solid fa-calendar-days",
        txt = AppointmentData[GetIdentifier()].date,
        isMenuHeader = true
      }) 
      table.insert(appointmentsJob, {
        header = "Your Appointment is with:",
        icon = "fa-solid fa-comments",
        txt = AppointmentData[GetIdentifier()].staffname,
        isMenuHeader = true
      })
      table.insert(appointmentsJob, {
        header = 'Cancel Appointment',
        icon = "fa-solid fa-folder-minus",
        txt = 'Click here to cancel the appointment.',
        params = {
          isServer = true,
          event = "ap-addonjob:server:cancelAppointment",
          args = data
        }
      })
    end
    table.insert(appointmentsJob, {
      header = 'Back',
      icon = "fa-solid fa-arrow-left",
      txt = 'Click here to go back to main menu.',
      params = {
        isServer = false,
        event = "ap-addonjob:client:publicJobMenu",
        args = data.job
      }
    })
    ContextMenu(appointmentsJob)
  elseif ctm.OX then
    if AppointmentData[GetIdentifier()] == nil then
      table.insert(appointmentsJob, {
        title = "Request Appointment",
        icon = {'fa', 'paper-plane'},
        description = "Click here to request an appointment",
        event = "ap-addonjob:client:appointmentReason",
        args = data
      })
    elseif AppointmentData[GetIdentifier()].state == 1 then
      table.insert(appointmentsJob, {
        title = "Appointment Status: PENDING",
        icon = {'fa', 'spinner'},
        description = "Your appointment is pending the waiting list, once an appointment has been confirmed your status will change.",
        disabled = true
      }) 
      table.insert(appointmentsJob, {
        title = 'Cancel Appointment',
        icon = {'fa', 'folder-minus'},
        description = 'Click here to cancel the appointment.',
        serverEvent = "ap-addonjob:server:cancelAppointment",
        args = data
      })
    elseif AppointmentData[GetIdentifier()].state == 2 then
      table.insert(appointmentsJob, {
        title = 'Appointment Reason:',
        icon = {'fa', 'clipboard'},
        description = AppointmentData[GetIdentifier()].reason,
        disabled = true
      }) 
      table.insert(appointmentsJob, {
        title = 'Date & Time:',
        icon = {'fa', 'calendar-days'},
        description = AppointmentData[GetIdentifier()].date,
        disabled = true
      }) 
      table.insert(appointmentsJob, {
        title = "Your Appointment is with:",
        icon = {'fa', 'comments'},
        description = AppointmentData[GetIdentifier()].staffname,
        disabled = true
      })
      table.insert(appointmentsJob, {
        title = 'Cancel Appointment',
        icon = {'fa', 'folder-minus'},
        description = 'Click here to cancel the appointment.',
        serverEvent = "ap-addonjob:server:cancelAppointment",
        args = data
      })
    end
    table.insert(appointmentsJob, {
      title = 'Back',
      icon = {'fa', 'arrow-left'},
      description = 'Click here to go back to main menu.',
      event = "ap-addonjob:client:publicJobMenu",
      args = data.job
    })
    ContextMenu({
      id = 'JobAppointmentsAddon',
      title = "Appointments",
      options = appointmentsJob
    })
  end
end)

RegisterNetEvent('ap-addonjob:client:appointmentReason', function(data)
  if Config.Dialog.QB then
    local dialog = exports[Config.ExportNames.input]:ShowInput({
      header = "Request Appointment",
      submitText = "Submit",
      inputs = {
        {
          text = "Appointment Reason:",
          name = "reason",
          type = "text",
          isRequired = true
        }
      }
    })
    
    if dialog ~= nil then
      TriggerServerEvent('ap-addonjob:server:submitAppointment', dialog.reason, data)
    end
  elseif Config.Dialog.OX then
    local input = lib.inputDialog('Request Appointment', {
      {type = 'input', label = 'Appointment Reason:'}
    })
    if input ~= nil then
      TriggerServerEvent('ap-addonjob:server:submitAppointment', input[1], data)
    end
  end
end)

RegisterNetEvent('ap-addonjob:client:jobapplication', function(data)
  local ApplicationData = data.applications
  if ctm.QB then
    local MenuData = {
      {
        header = "Job Application",
        icon = "fa-solid fa-circle-info",
        txt = " ",
        isMenuHeader = true
      },
    }
    if ApplicationData[GetIdentifier()] == nil then
      table.insert(MenuData, {
        header = "Apply Now!",
        icon = "fa-solid fa-paper-plane",
        txt = "Click to apply for a job.",
        params = {
          isServer = false,
          event = "ap-addonjob:client:applyjob",
          args = data
        }
      })
    elseif ApplicationData[GetIdentifier()].state == 0 then
      table.insert(MenuData, {
        header = "Processing Application",
        icon = "fa-solid fa-spinner",
        txt = "Your application is currently being processed, you will be notified via email if an interview has been scheduled.",
        isMenuHeader = true
      })
      table.insert(MenuData, {
        header = "Cancel Application",
        icon = "fa-solid fa-folder-minus",
        txt = "Click to cancel your application.",
        params = {
          isServer = true,
          event = "ap-addonjob:server:canceljobapplication",
          args = data
        }
      })
    elseif ApplicationData[GetIdentifier()].state == 1 then
      table.insert(MenuData, {
        header = "Interview Time & Date:",
        icon = "fa-solid fa-calendar-days",
        txt = "Here is the scheduled time and date for your job interview; "..ApplicationData[GetIdentifier()].date..", please make sure you turn up 10 minutes before your scheduled time.",
        isMenuHeader = true
      })
      table.insert(MenuData, {
        header = "Cancel Application",
        icon = "fa-solid fa-folder-minus",
        txt = "Click to cancel your application.",
        params = {
          isServer = true,
          event = "ap-addonjob:server:canceljobapplication",
          args = data
        }
      })
    elseif ApplicationData[GetIdentifier()].state == 2 then
      table.insert(MenuData, {
        header = "Offer Of Employment",
        icon = "fa-solid fa-handshake",
        txt = "Congratulations you have been offered the position of "..ApplicationData[GetIdentifier()].offer.name..".",
        isMenuHeader = true
      })
      table.insert(MenuData, {
        header = "Accept Job Offer",
        icon = "fa-solid fa-check",
        txt = "Click here to start your new job.",
        params = {
          isServer = true,
          event = "ap-addonjob:server:startJob",
          args = data
        }
      })
      table.insert(MenuData, {
        header = "Decline Job Offer",
        icon = "fa-solid fa-trash",
        txt = "Click here to decline the job offer.",
        params = {
          isServer = true,
          event = "ap-addonjob:server:declineJobOffer",
          args = data
        }
      })
    end
    table.insert(MenuData, {
      header = 'Back',
      icon = "fa-solid fa-arrow-left",
      txt = 'Click here to go back to main menu.',
      params = {
        isServer = false,
        event = "ap-addonjob:client:publicJobMenu",
        args = data.job
      }
    })
    ContextMenu(MenuData)
  elseif ctm.OX then
    local MenuData = {}
    if ApplicationData[GetIdentifier()] == nil then
      table.insert(MenuData, {
        title = "Apply Now!",
        icon = {'fa', 'paper-plane'},
        description = "Click to apply for a job.",
        event = "ap-addonjob:client:applyjob",
        args = data
      })
    elseif ApplicationData[GetIdentifier()].state == 0 then
      table.insert(MenuData, {
        title = "Processing Application",
        icon = {'fa', 'spinner'},
        description = "Your application is currently being processed, you will be notified via email if an interview has been scheduled.",
        disabled = true
      })
      table.insert(MenuData, {
        title = "Cancel Application",
        icon = {'fa', 'folder-minus'},
        description = "Click to cancel your application.",
        serverEvent = "ap-addonjob:server:canceljobapplication",
        args = data
      })
    elseif ApplicationData[GetIdentifier()].state == 1 then
      table.insert(MenuData, {
        title = "Interview Time & Date:",
        icon = {'fa', 'calendar-days'},
        description = "Here is the scheduled time and date for your job interview; "..ApplicationData[GetIdentifier()].date..", please make sure you turn up 10 minutes before your scheduled time.",
        disabled = true
      })
      table.insert(MenuData, {
        title = "Cancel Application",
        icon = {'fa', 'folder-minus'},
        description = "Click to cancel your application.",
        serverEvent = "ap-addonjob:server:canceljobapplication",
        args = data
      })
    elseif ApplicationData[GetIdentifier()].state == 2 then
      table.insert(MenuData, {
        title = "Offer Of Employment",
        icon = {'fa', 'handshake'},
        description = "Congratulations you have been offered the position of "..ApplicationData[GetIdentifier()].offer.name..".",
        disabled = true
      })
      table.insert(MenuData, {
        title = "Accept Job Offer",
        icon = {'fa', 'check'},
        description = "Click here to start your new job.",
        serverEvent = "ap-addonjob:server:startJob",
        args = data
      })
      table.insert(MenuData, {
        title = "Decline Job Offer",
        icon = {'fa', 'trash'},
        description = "Click here to decline the job offer.",
        serverEvent = "ap-addonjob:server:declineJobOffer",
        args = data
      })
    end
    table.insert(MenuData, {
      title = 'Back',
      icon = {'fa', 'arrow-left'},
      description = 'Click here to go back to main menu.',
      event = "ap-addonjob:client:publicJobMenu",
      args = data.job
    })
    ContextMenu({
      id = 'JobApplicationAddon',
      title = "Job Application",
      options = MenuData
    })
  end
end)

RegisterNetEvent('ap-addonjob:client:applyjob', function(data)
  QBCore.Functions.TriggerCallback('ap-addonjob:getApplicationData', function(db)
    if Config.Dialog.QB then
      local Ranks = {}
      for k,v in pairs(data.management.positions) do
        if v.enable then
          table.insert(Ranks, {
            value = v.name, text = v.name
          })
        end
      end
      local dialog = exports[Config.ExportNames.input]:ShowInput({
        header = "Job Position",
        submitText = "Submit",
        inputs = {
          {text = "Job Roles:", name = "1", type = "select", options = Ranks}
        },
      })
    
      if dialog ~= nil then
        local JobRole = dialog["1"]
        db.position = JobRole
        local Application = {
          type = "create",
          title = Config.JobApplicationForm.title,
          logo = data.management.logo,
          description = Config.JobApplicationForm.description,
          information = {
            { id = "i1", label = Config.JobApplicationForm.information[1], type = "text_input", required = "true", value = db.name },
            { id = "i2", label = Config.JobApplicationForm.information[2], type = "text_input", required = "true", value = db.date },
            { id = "i3", label = Config.JobApplicationForm.information[3], type = "text_input", required = "true", value = db.job },
            { id = "i4", label = Config.JobApplicationForm.information[4], type = "text_input", required = "true", value = JobRole },
          },
          extended_information = {
            data.template.q1,
            data.template.q2,
            data.template.q3,
            data.template.q4,
            data.template.q5,
            data.template.q6,
          }
        }
        OpenApplicationUI(Application, db, data)
      end
    elseif Config.Dialog.OX then
      local Ranks = {}
      for k,v in pairs(data.management.positions) do
        if v.enable then
          table.insert(Ranks, {
            value = v.name, label = v.name
          })
        end
      end
      local input = lib.inputDialog('Job Position', {
        {type = 'select', label = 'Job Roles:', description = 'Select the role you would like to apply for.', required = true, options = Ranks},
      })
      if input ~= nil then
        local JobRole = input[1]
        db.position = JobRole
        local Application = {
          type = "create",
          title = Config.JobApplicationForm.title,
          logo = data.management.logo,
          description = Config.JobApplicationForm.description,
          information = {
            { id = "i1", label = Config.JobApplicationForm.information[1], type = "text_input", required = "true", value = db.name },
            { id = "i2", label = Config.JobApplicationForm.information[2], type = "text_input", required = "true", value = db.date },
            { id = "i3", label = Config.JobApplicationForm.information[3], type = "text_input", required = "true", value = db.job },
            { id = "i4", label = Config.JobApplicationForm.information[4], type = "text_input", required = "true", value = JobRole },
          },
          extended_information = {
            data.template.q1,
            data.template.q2,
            data.template.q3,
            data.template.q4,
            data.template.q5,
            data.template.q6,
          }
        }
        OpenApplicationUI(Application, db, data)
      end
    end
  end, data.job)
end)

RegisterNetEvent('ap-addonjob:client:manageApplication', function(data)
  local JobData, cid, appdata = data.JobData, data.cid, data.appdata
  if ctm.QB then
    local MenuData = {
      {
        header = "Applicant: "..appdata.name,
        icon = "fa-solid fa-circle-info",
        txt = "Here you will be able to manage the applicants application.",
        isMenuHeader = true
      },
    }
    if appdata.state ~= 2 then
      table.insert(MenuData, {
        header = "View Job Application",
        icon = "fa-solid fa-eye",
        txt = "Click here to view "..appdata.name.." job application.",
        params = {
          isServer = true,
          event = "ap-addonjob:server:viewJobApplication",
          args = {JobData = JobData, Player = appdata}
        }
      })
    end
    if appdata.state == 0 then
      table.insert(MenuData, {
        header = "Issue Interview",
        icon = "fa-solid fa-clipboard",
        txt = "Click here to issue a interview with "..appdata.name..".",
        params = {
          isServer = false,
          event = "ap-addonjob:client:issueJobInterview",
          args = {JobData = JobData, Player = appdata}
        }
      })
      table.insert(MenuData, {
        header = "Reject Application",
        icon = "fa-solid fa-trash",
        txt = "Click here to reject "..appdata.name.."'s Application.'",
        params = {
          isServer = true,
          event = "ap-addonjob:server:rejectJobApplication",
          args = {JobData = JobData, Player = appdata}
        }
      })
    elseif appdata.state == 1 then
      table.insert(MenuData, {
        header = "Interview Data & Time:",
        icon = "fa-solid fa-calendar-days",
        txt = appdata.date,
        params = {
          isServer = false,
          event = "ap-addonjob:client:changeInterviewDate",
          args = {JobData = JobData, Player = appdata}
        }
      })
      table.insert(MenuData, {
        header = "Accept Job Application",
        icon = "fa-solid fa-check",
        txt = "Click here to accept "..appdata.name.."'s application.",
        params = {
          isServer = false,
          event = "ap-addonjob:client:acceptApplication",
          args = {JobData = JobData, Player = appdata}
        }
      })
      table.insert(MenuData, {
        header = "Reject Application",
        icon = "fa-solid fa-trash",
        txt = "Click here to reject "..appdata.name.."'s Application.'",
        params = {
          isServer = true,
          event = "ap-addonjob:server:rejectJobApplication",
          args = {JobData = JobData, Player = appdata}
        }
      })
    end
    table.insert(MenuData, {
      header = "Back",
      icon = "fa-solid fa-arrow-left",
      txt = "Click to go back a menu.",
      params = {
        isServer = false,
        event = "ap-addonjob:client:managementApplications",
        args = JobData
      }
    })
    ContextMenu(MenuData)
  elseif ctm.OX then
    local MenuData = {}
    if appdata.state ~= 2 then
      table.insert(MenuData, {
        title = "View Job Application",
        icon = {'fa', 'eye'},
        description = "Click here to view "..appdata.name.." job application.",
        serverEvent = "ap-addonjob:server:viewJobApplication",
        args = {JobData = JobData, Player = appdata}
      })
    end
    if appdata.state == 0 then
      table.insert(MenuData, {
        title = "Issue Interview",
        icon = {'fa', 'clipboard'},
        description = "Click here to issue a interview with "..appdata.name..".",
        event = "ap-addonjob:client:issueJobInterview",
        args = {JobData = JobData, Player = appdata}
      })
      table.insert(MenuData, {
        title = "Reject Application",
        icon = {'fa', 'trash'},
        description = "Click here to reject "..appdata.name.."'s Application.'",
        serverEvent = "ap-addonjob:server:rejectJobApplication",
        args = {JobData = JobData, Player = appdata}
      })
    elseif appdata.state == 1 then
      table.insert(MenuData, {
        title = "Interview Data & Time:",
        icon = {'fa', 'calendar-days'},
        description = appdata.date,
        event = "ap-addonjob:client:changeInterviewDate",
        args = {JobData = JobData, Player = appdata}
      })
      table.insert(MenuData, {
        title = "Accept Job Application",
        icon = {'fa', 'check'},
        description = "Click here to accept "..appdata.name.."'s application.",
        event = "ap-addonjob:client:acceptApplication",
        args = {JobData = JobData, Player = appdata}
      })
      table.insert(MenuData, {
        title = "Reject Application",
        icon = {'fa', 'trash'},
        description = "Click here to reject "..appdata.name.."'s Application.'",
        serverEvent = "ap-addonjob:server:rejectJobApplication",
        args = {JobData = JobData, Player = appdata}
      })
    end
    table.insert(MenuData, {
      title = "Back",
      icon = {'fa', 'arrow-left'},
      description = "Click to go back a menu.",
      event = "ap-addonjob:client:managementApplications",
      args = JobData
    })
    ContextMenu({
      id = 'JobApplicationsMain',
      title = "Applicant: "..appdata.name,
      options = MenuData
    })
  end
end)

RegisterNetEvent('ap-addonjob:client:changeInterviewDate', function(data)
  if Config.Dialog.QB then
    local dialog = exports[Config.ExportNames.input]:ShowInput({
      header = "Change Interview Date",
      submitText = "Issue New Date",
      inputs = {
        {
          text = "Date (e.g 01/02/2023)",
          name = "date",
          type = "text",
          isRequired = true
        },
        {
          text = "Time (e.g 14:00 PM)",
          name = "time",
          type = "text",
          isRequired = true
        }
      },
    })
  
    if dialog ~= nil then
      local newDate = dialog.date.." "..dialog.time
      TriggerServerEvent('ap-addonjob:server:changeJobInterview', data, newDate)
    else
      TriggerEvent('ap-addonjob:client:changeInterviewDate', data)
    end
  elseif Config.Dialog.OX then
    local input = lib.inputDialog('Change Interview Date', {
      {type = 'date', label = 'Date Of Interview', icon = {'far', 'calendar'}, required = true, default = true, format = "DD/MM/YYYY"},
      {type = 'time', label = 'Time Of Interview', icon = {'far', 'clock'}, required = true, format = "24"}
    })
    if input then
      local decodeDate, decodeTime = math.floor(input[1] / 1000), math.floor(input[2] / 1000)
      TriggerServerEvent('ap-addonjob:server:changeJobInterview', data, {date = decodeDate, time = decodeTime})
    end
  end
end)

RegisterNetEvent('ap-addonjob:client:issueJobInterview', function(data)
  if Config.Dialog.QB then
    local dialog = exports[Config.ExportNames.input]:ShowInput({
      header = "Interview Date",
      submitText = "Issue Interview",
      inputs = {
        {
          text = "Date (e.g 01/02/2023)",
          name = "date",
          type = "text",
          isRequired = true
        },
        {
          text = "Time (e.g 14:00 PM)",
          name = "time",
          type = "text",
          isRequired = true
        }
      },
    })
  
    if dialog ~= nil then
      local newDate = dialog.date.." "..dialog.time
      TriggerServerEvent('ap-addonjob:server:createJobInterview', data, newDate)
    else
      TriggerEvent('ap-addonjob:client:issueJobInterview', data)
    end
  elseif Config.Dialog.OX then
    local input = lib.inputDialog('Interview Date', {
      {type = 'date', label = 'Date Of Interview', icon = {'far', 'calendar'}, required = true, default = true, format = "DD/MM/YYYY"},
      {type = 'time', label = 'Time Of Interview', icon = {'far', 'clock'}, required = true, format = "24"}
    })
    if input then
      local decodeDate, decodeTime = math.floor(input[1] / 1000), math.floor(input[2] / 1000)
      TriggerServerEvent('ap-addonjob:server:createJobInterview', data, {date = decodeDate, time = decodeTime})
    end
  end
end)

RegisterNetEvent('ap-addonjob:client:acceptApplication', function(data)
  if Config.Dialog.QB then
    local options = {}
    for k,v in pairs(data.JobData.management.positions) do
      if v.enable then
        table.insert(options, {
          value = k, text = v.name
        })
      end
    end
    local dialog = exports[Config.ExportNames.input]:ShowInput({
      header = "Accept Job Application",
      submitText = "Issue Job",
      inputs = {
        {
          text = "Select the job role in which you want to assign "..data.Player.name..".",
          name = "job",
          type = "select",
          options = options,
        }
      },
    })
  
    if dialog ~= nil then
      local JobInfo = data.JobData.management.positions[dialog.job]
      TriggerServerEvent('ap-addonjob:server:awardjob', data, JobInfo)
    end
  elseif Config.Dialog.OX then
    local options = {}
    for k,v in pairs(data.JobData.management.positions) do
      if v.enable then
        table.insert(options, {
          value = k, label = v.name
        })
      end
    end
    local input = lib.inputDialog('Accept Job Application', {
      {type = 'select', label = 'Select the job role in which you want to assign '..data.Player.name..'.', options = options}
    })
    if input ~= nil then
      local JobInfo = data.JobData.management.positions[input[1]]
      TriggerServerEvent('ap-addonjob:server:awardjob', data, JobInfo)
    end
  end
end)


RegisterNetEvent('ap-addonjob:client:managementOptions', function(data)
  local isBoss = checkJob(data.job, tonumber(data.boss_rank))
  if ctm.QB then
    local MenuData = {
      {
        header = "Management",
        icon = "fa-solid fa-circle-info",
        txt = "Here you will be able to manage the reception.",
        isMenuHeader = true
      }
    }
    if isBoss or GetPlayerManagementData(data.management.staff).appointments then
      table.insert(MenuData, {
        header = "Appointments",
        icon = "fa-solid fa-calendar-check",
        txt = "Click here to view requested/scheduled appointments.",
        params = {
          isServer = false,
          event = "ap-addonjob:client:managementAppointments",
          args = data
        }
      })
    end
    if isBoss or GetPlayerManagementData(data.management.staff).applications then
      table.insert(MenuData, {
        header = "Job Applications/Interviews",
        icon = "fa-solid fa-file-contract",
        txt = "Click here to view applications/interviews",
        params = {
          isServer = false,
          event = "ap-addonjob:client:managementApplications",
          args = data
        }
      })
    end
    if isBoss or GetPlayerManagementData(data.management.staff).management then
      table.insert(MenuData, {
        header = "Management Settings",
        icon = "fa-solid fa-gear",
        txt = "Click here to manage all settings",
        params = {
          isServer = false,
          event = "ap-addonjob:client:managementSettings",
          args = data
        }
      })
    end
    table.insert(MenuData, {
      header = "Back",
      icon = "fa-solid fa-arrow-left",
      txt = "Click to go back a menu.",
      params = {
        isServer = false,
        event = "ap-addonjob:client:publicJobMenu",
        args = data.job
      }
    })
    ContextMenu(MenuData)
  elseif ctm.OX then
    local MenuData = {}
    if isBoss or GetPlayerManagementData(data.management.staff).appointments then
      table.insert(MenuData, {
        title = "Appointments",
        icon = {'fa', 'calendar-check'},
        description = "Click here to view requested/scheduled appointments.",
        event = "ap-addonjob:client:managementAppointments",
        args = data
      })
    end
    if isBoss or GetPlayerManagementData(data.management.staff).applications then
      table.insert(MenuData, {
        title = "Job Applications/Interviews",
        icon = {'fa', 'file-contract'},
        description = "Click here to view applications/interviews",
        event = "ap-addonjob:client:managementApplications",
        args = data
      })
    end
    if isBoss or GetPlayerManagementData(data.management.staff).management then
      table.insert(MenuData, {
        title = "Management Settings",
        icon = {'fa', 'gear'},
        description = "Click here to manage all settings",
        event = "ap-addonjob:client:managementSettings",
        args = data
      })
    end
    table.insert(MenuData, {
      title = "Back",
      icon = {'fa', 'arrow-left'},
      description = "Click to go back a menu.",
      event = "ap-addonjob:client:publicJobMenu",
      args = data.job
    })
    ContextMenu({
      id = 'ManagementOptionsAddon',
      title = "Management",
      options = MenuData
    })
  end
end)

RegisterNetEvent('ap-addonjob:client:managementApplications', function(data)
  if ctm.QB then
    local MenuData = {
      {
        header = "Job Applicants",
        icon = "fa-solid fa-circle-info",
        txt = "Here you will find all the applicants that have apply for a job.",
        isMenuHeader = true
      },
    }
    if data.applications then
      for k,v in pairs(data.applications) do
        local state = ''
        if v.state == 0 then state = 'Click here to view this new job application.' elseif v.state == 1 then state = 'Click here to manage this applicants interview details.' end
        if v.state ~= 2 then
          table.insert(MenuData, {
            header = v.name,
            icon = "fa-solid fa-person",
            txt = state,
            params = {
              isServer = false,
              event = 'ap-addonjob:client:manageApplication',
              args = {JobData = data, cid = k, appdata = v}
            }
          })
        end
      end
    end
    table.insert(MenuData, {
      header = "Back",
      icon = "fa-solid fa-arrow-left",
      txt = "Click to go back a menu.",
      params = {
        isServer = false,
        event = "ap-addonjob:client:managementOptions",
        args = data
      }
    })
    ContextMenu(MenuData)
  elseif ctm.OX then
    local MenuData = {}
    if data.applications then
      for k,v in pairs(data.applications) do
        local state = ''
        if v.state == 0 then state = 'Click here to view this new job application.' elseif v.state == 1 then state = 'Click here to manage this applicants interview details.' end
        if v.state ~= 2 then
          table.insert(MenuData, {
            title = v.name,
            icon = {'fa', 'person'},
            description = state,
            event = 'ap-addonjob:client:manageApplication',
            args = {JobData = data, cid = k, appdata = v}
          })
        end
      end
    end
    table.insert(MenuData, {
      title = "Back",
      icon = {'fa', 'arrow-left'},
      description = "Click to go back a menu.",
      event = "ap-addonjob:client:managementOptions",
      args = data
    })
    ContextMenu({
      id = 'ManagementApplicationData',
      title = "Applications",
      options = MenuData
    })
  end
end)

RegisterNetEvent('ap-addonjob:client:managementAppointments', function(data)
  if ctm.QB then
    ContextMenu({
      {
        header = "Appointments",
        icon = "fa-solid fa-circle-info",
        txt = " ",
        isMenuHeader = true
      },
      {
        header = "Requested Appointments",
        icon = "fa-solid fa-envelope",
        txt = "Here you will be able to view appointments that have been requested.",
        params = {
          isServer = false,
          event = "ap-addonjob:client:requestedAppointments",
          args = data
        }
      },
      {
        header = "Scheduled Appointments",
        icon = "fa-solid fa-inbox",
        txt = "Here you will see the appointments you have scheduled for yourself.",
        params = {
          isServer = false,
          event = "ap-addonjob:client:scheduledAppointments",
          args = data
        }
      },
      {
        header = "Back",
        icon = "fa-solid fa-arrow-left",
        txt = "Click to go back a menu.",
        params = {
          isServer = false,
          event = "ap-addonjob:client:managementOptions",
          args = data
        }
      }
    })
  elseif ctm.OX then
    ContextMenu({
      id = 'ManagementAppointmentData',
      title = "Appointments",
      options = {
        {
          title = "Requested Appointments",
          icon = {'fa', 'envelope'},
          description = "Here you will be able to view appointments that have been requested.",
          event = "ap-addonjob:client:requestedAppointments",
          args = data
        },
        {
          title = "Scheduled Appointments",
          icon = {'fa', 'inbox'},
          description = "Here you will see the appointments you have scheduled for yourself.",
          event = "ap-addonjob:client:scheduledAppointments",
          args = data
        },
        {
          title = "Back",
          icon = {'fa', 'arrow-left'},
          description = "Click to go back a menu.",
          event = "ap-addonjob:client:managementOptions",
          args = data
        }
      }
    })
  end
end)

RegisterNetEvent('ap-addonjob:client:requestedAppointments', function(data)
  if ctm.QB then
    local MenuData = {
      {
        header = "Requested Appointments",
        icon = "fa-solid fa-circle-info",
        txt = " ",
        isMenuHeader = true
      },
    }
    if data.appointments ~= nil then
      for k,v in pairs(data.appointments) do
        if v.state == 1 then
          table.insert(MenuData, {
            header = v.name,
            icon = "fa-solid fa-clipboard",
            txt = "Appointment Reason: "..v.reason,
            params = {
              isServer = false,
              event = "ap-addonjob:client:registerAppointment",
              args = {db = data, v = v, k = k}
            }
          })
        end
      end
    end
    table.insert(MenuData, {
      header = "Back",
      icon = "fa-solid fa-arrow-left",
      txt = "Click to go back to appointments.",
      params = {
        isServer = false,
        event = "ap-addonjob:client:managementAppointments",
        args = data
      }
    })
    ContextMenu(MenuData)
  elseif ctm.OX then
    local MenuData = {}
    if data.appointments ~= nil then
      for k,v in pairs(data.appointments) do
        if v.state == 1 then
          table.insert(MenuData, {
            title = v.name,
            icon = {'fa', 'clipboard'},
            description = "Appointment Reason: "..v.reason,
            event = "ap-addonjob:client:registerAppointment",
            args = {db = data, v = v, k = k}
          })
        end
      end
    end
    table.insert(MenuData, {
      title = "Back",
      icon = {'fa', 'arrow-left'},
      description = "Click to go back to appointments.",
      event = "ap-addonjob:client:managementAppointments",
      args = data
    })
    ContextMenu({
      id = 'JobManagementAppointmentsRequested',
      title = "Requested Appointments",
      options = MenuData
    })
  end
end)

RegisterNetEvent('ap-addonjob:client:registerAppointment', function(data)
  if ctm.QB then
  local MenuData = {
    {
      header = "Appointment Details",
      icon = "fa-solid fa-circle-info",
      txt = " ",
      isMenuHeader = true
    },
    {
      header = "Name: "..data.v.name,
      icon = "fa-solid fa-clipboard",
      txt = "Name of person who is submitting the appointment.",
      isMenuHeader = true
    },
    {
      header = "Mobile Number:",
      icon = "fa-solid fa-phone",
      txt = data.v.phone,
      isMenuHeader = true
    },
    {
      header = "Appointment Reason:",
      icon = "fa-solid fa-comments",
      txt = data.v.reason,
      isMenuHeader = true
    },
    {
      header = "Issue Appointment",
      icon = "fa-solid fa-check",
      txt = "Click here to issue the appointment",
      params = {
        isServer = false,
        event = "ap-addonjob:client:issueappointment",
        args = data
      }
    },
    {
      header = "Cancel Appointment",
      icon = "fa-solid fa-trash",
      txt = "Click here to cancel the appointment",
      params = {
        isServer = true,
        event = "ap-addonjob:server:cancelappointmentJob",
        args = data
      }
    },
    {
      header = "Back",
      icon = "fa-solid fa-arrow-left",
      txt = "Click here to go back to main menu.",
      params = {
        isServer = false,
        event = "ap-addonjob:client:requestedAppointments",
        args = data.db
      }
    }
  }
  ContextMenu(MenuData)
  elseif ctm.OX then
    local MenuData = {
      {
        title = "Name: "..data.v.name,
        icon = {'fa', 'clipboard'},
        description = "Name of person who is submitting the appointment.",
        disabled = true
      },
      {
        title = "Mobile Number:",
        icon = {'fa', 'phone'},
        description = data.v.phone,
        disabled = true
      },
      {
        title = "Appointment Reason:",
        icon = {'fa', 'comments'},
        description = data.v.reason,
        disabled = true
      },
      {
        title = "Issue Appointment",
        icon = {'fa', 'check'},
        description = "Click here to issue the appointment",
        event = "ap-addonjob:client:issueappointment",
        args = data
      },
      {
        title = "Cancel Appointment",
        icon = {'fa', 'trash'},
        description = "Click here to cancel the appointment",
        serverEvent = "ap-addonjob:server:cancelappointmentJob",
        args = data
      },
      {
        title = "Back",
        icon = {'fa', 'arrow-left'},
        description = "Click here to go back to main menu.",
        event = "ap-addonjob:client:requestedAppointments",
        args = data.db
      }
    }
    ContextMenu({
      id = 'ManagerAppointmentsSubmit',
      title = "Appointment Details",
      options = MenuData
    })
  end
end)

RegisterNetEvent('ap-addonjob:client:issueappointment', function(data)
  if Config.Dialog.QB then
    local dialog = exports[Config.ExportNames.input]:ShowInput({
      header = "Issue Appointment",
      submitText = "Confirm",
      inputs = {
        {
          text = "Date:",
          name = "date",
          type = "text",
          isRequired = true
        },
        {
          text = "Time:",
          name = "time",
          type = "text",
          isRequired = true
        },
      }
    })
    
    if dialog ~= nil then
      TriggerServerEvent('ap-addonjob:server:issueappointment', dialog.date.." "..dialog.time, data)
    end
  elseif Config.Dialog.OX then
    local input = lib.inputDialog('Request Appointment', {
      {type = 'date', label = 'Date Of Appointment', icon = {'far', 'calendar'}, required = true, default = true, format = "DD/MM/YYYY"},
      {type = 'time', label = 'Time Of Appointment', icon = {'far', 'clock'}, required = true, format = "24"}

    })
    if input ~= nil then
      local decodeDate, decodeTime = math.floor(input[1] / 1000), math.floor(input[2] / 1000)
      TriggerServerEvent('ap-addonjob:server:issueappointment', {date = decodeDate, time = decodeTime}, data)
    end
  end
end)

RegisterNetEvent('ap-addonjob:client:scheduledAppointments', function(data)
  if ctm.QB then
    local MenuData = {
      {
        header = "Scheduled Appointments",
        icon = "fa-solid fa-circle-info",
        txt = " ",
        isMenuHeader = true
      },
    }
    if data.appointments ~= nil then
      for k,v in pairs(data.appointments) do
        if v.state == 2 and v.staff == GetIdentifier() then
          table.insert(MenuData, {
            header = v.name,
            icon = "fa-solid fa-clipboard",
            txt = "Appointment Date: "..v.date,
            params = {
              isServer = false,
              event = "ap-addonjob:client:appointmentDetails",
              args = {db = data, k = k, v = v}
            }
          })
        end
      end
    end
    table.insert(MenuData, {
      header = "Back",
      icon = "fa-solid fa-arrow-left",
      txt = "Click to go back to appointments.",
      params = {
        isServer = false,
        event = "ap-addonjob:client:managementAppointments",
        args = data
      }
    })
    ContextMenu(MenuData)
  elseif ctm.OX then
    local MenuData = {}
    if data.appointments ~= nil then
      for k,v in pairs(data.appointments) do
        if v.state == 2 and v.staff == GetIdentifier() then
          table.insert(MenuData, {
            title = v.name,
            icon = {'fa', 'clipboard'},
            description = "Appointment Date: "..v.date,
            event = "ap-addonjob:client:appointmentDetails",
            args = {db = data, k = k, v = v}
          })
        end
      end
    end
    table.insert(MenuData, {
      title = "Back",
      icon = {'fa', 'arrow-left'},
      description = "Click to go back to appointments.",
      event = "ap-addonjob:client:managementAppointments",
      args = data
    })
    ContextMenu({
      id = 'firmAppointmentsScheduled',
      title = "Scheduled Appointments",
      options = MenuData
    })
  end
end)

RegisterNetEvent('ap-addonjob:client:appointmentDetails', function(data)
  if ctm.QB then
    local MenuData = {
      {
        header = "Scheduled Appointment",
        icon = "fa-solid fa-circle-info",
        txt = " ",
        isMenuHeader = true
      },
      {
        header = "Name: "..data.v.name,
        icon = "fa-solid fa-clipboard",
        txt = "Name of person who made the appointment.",
        isMenuHeader = true
      },
      {
        header = "Mobile Number:",
        icon = "fa-solid fa-phone",
        txt = data.v.phone,
        isMenuHeader = true
      },
      {
        header = "Appointment Reason:",
        icon = "fa-solid fa-comments",
        txt = data.v.reason,
        isMenuHeader = true
      },
      {
        header = "Scheduled Date & Time:",
        icon = "fa-solid fa-calendar-days",
        txt = data.v.date,
        isMenuHeader = true
      },
    }
    table.insert(MenuData, {
      header = "Finish Appointment",
      icon = "fa-solid fa-check",
      txt = "Click here to close the appointment.",
      params = {
        isServer = true,
        event = "ap-addonjob:server:finishappointment",
        args = data
      }
    })
    table.insert(MenuData, {
      header = "Back",
      icon = "fa-solid fa-arrow-left",
      txt = "Click to go back to appointments.",
      params = {
        isServer = false,
        event = "ap-addonjob:client:scheduledAppointments",
        args = data.db
      }
    })
    ContextMenu(MenuData)
  elseif ctm.OX then
    local MenuData = {
      {
        title = "Name: "..data.v.name,
        icon = {'fa', 'clipboard'},
        description = "Name of person who made the appointment.",
        disabled = true
      },
      {
        title = "Mobile Number:",
        icon = {'fa', 'phone'},
        description = data.v.phone,
        disabled = true
      },
      {
        title = "Appointment Reason:",
        icon = {'fa', 'comments'},
        description = data.v.reason,
        disabled = true
      },
      {
        title = "Scheduled Date & Time:",
        icon = {'fa', 'calendar-days'},
        description = data.v.date,
        disabled = true
      },
    }
    table.insert(MenuData, {
      title = "Finish Appointment",
      icon = {'fa', 'check'},
      description = "Click here to close the appointment.",
      serverEvent = "ap-addonjob:server:finishappointment",
      args = data
    })
    table.insert(MenuData, {
      title = "Back",
      icon = {'fa', 'arrow-left'},
      description = "Click to go back to appointments.",
      event = "ap-addonjob:client:scheduledAppointments",
      args = data.db
    })
    ContextMenu({
      id = 'JobAppointmentsScheduledSub',
      title = "Scheduled Appointment",
      options = MenuData
    })
  end
end)

RegisterNetEvent('ap-addonjob:client:managementSettings', function(data)
  local hiringTitle, hiringDescription, appointmentTitle, appointmentDescription = nil, nil, nil, nil
  if ctm.QB then
    local MenuData = {
      {
        header = "Settings",
        icon = "fa-solid fa-circle-info",
        txt = " ",
        isMenuHeader = true
      },
    }
    table.insert(MenuData, {
      header = "Manage Reception Staff",
      icon = "fa-solid fa-person",
      txt = "Click here to manage staff.",
      params = {
        isServer = false,
        event = "ap-addonjob:client:manageReceptionStaff",
        args = data
      }
    })
    if data.management.appointments == true then 
      appointmentTitle, appointmentDescription = "Disable Appointments", "Click this to disable appointments for the firm."
    else 
      appointmentTitle, appointmentDescription = "Enable Appointments", "Click this to enable appointments for the firm."
    end
    table.insert(MenuData, {
      header = appointmentTitle,
      icon = "fa-solid fa-toggle-on",
      txt = appointmentDescription,
      params = {
        isServer = true,
        event = "ap-addonjob:server:appointmenttoggle",
        args = data
      }
    })
    if data.management.applications == true then 
      hiringTitle, hiringDescription = "Disable Job Applications", "Click this to disable job applications for the firm."
    else 
      hiringTitle, hiringDescription = "Enable Job Applications", "Click this to enable job applications for the firm."
    end
    table.insert(MenuData, {
      header = hiringTitle,
      icon = "fa-solid fa-toggle-on",
      txt = hiringDescription,
      params = {
        isServer = true,
        event = "ap-addonjob:server:hiringtoggle",
        args = data
      }
    })
    table.insert(MenuData, {
      header = "Application Questions",
      icon = "fa-solid fa-circle-question",
      txt = "Click here to view/edit application questions.",
      params = {
        isServer = false,
        event = "ap-addonjob:client:manageApplicationQuestions",
        args = data
      }
    })
    if checkJob(data.job, data.boss_rank) then
      table.insert(MenuData, {
        header = "Application Positions",
        icon = "fa-solid fa-ranking-star",
        txt = "Click here to view/edit application positions.",
        params = {
          isServer = false,
          event = "ap-addonjob:client:manageApplicationPositions",
          args = data
        }
      })
      table.insert(MenuData, {
        header = "Application Logo",
        icon = "fa-solid fa-eye",
        txt = "Click here to change/view logo.",
        params = {
          isServer = false,
          event = "ap-addonjob:client:OpenLogoUI",
          args = data
        }
      })
    end
    table.insert(MenuData, {
      header = "Back",
      icon = "fa-solid fa-arrow-left",
      txt = "Click to go back a menu.",
      params = {
        isServer = false,
        event = "ap-addonjob:client:managementOptions",
        args = data
      }
    })
    ContextMenu(MenuData)
  elseif ctm.OX then
    local MenuData = {}
    table.insert(MenuData, {
      title = "Manage Reception Staff",
      icon = {'fa', 'person'},
      description = "Click here to manage staff.",
      event = "ap-addonjob:client:manageReceptionStaff",
      args = data
    })
    if data.management.appointments == true then 
      appointmentTitle, appointmentDescription = "Disable Appointments", "Click this to disable appointments for the firm."
    else 
      appointmentTitle, appointmentDescription = "Enable Appointments", "Click this to enable appointments for the firm."
    end
    table.insert(MenuData, {
      title = appointmentTitle,
      icon = {'fa', 'toggle-on'},
      description = appointmentDescription,
      serverEvent = "ap-addonjob:server:appointmenttoggle",
      args = data
    })
    if data.management.applications == true then 
      hiringTitle, hiringDescription = "Disable Job Applications", "Click this to disable job applications for the firm."
    else 
      hiringTitle, hiringDescription = "Enable Job Applications", "Click this to enable job applications for the firm."
    end
    table.insert(MenuData, {
      title = hiringTitle,
      icon = {'fa', 'toggle-on'},
      description = hiringDescription,
      serverEvent = "ap-addonjob:server:hiringtoggle",
      args = data
    })
    table.insert(MenuData, {
      title = "Application Questions",
      icon = {'fa', 'circle-question'},
      description = "Click here to view/edit application questions.",
      event = "ap-addonjob:client:manageApplicationQuestions",
      args = data
    })
    if checkJob(data.job, data.boss_rank) then
      table.insert(MenuData, {
        title = "Application Positions",
        icon = {'fa', 'ranking-star'},
        description = "Click here to view/edit application positions.",
        event = "ap-addonjob:client:manageApplicationPositions",
        args = data
      })
      table.insert(MenuData, {
        title = "Application Logo",
        icon = {'fa', 'eye'},
        description = "Click here to change/view logo.",
        event = "ap-addonjob:client:OpenLogoUI",
        args = data
      })
    end
    table.insert(MenuData, {
      title = "Back",
      icon = {'fa', 'arrow-left'},
      description = "Click to go back a menu.",
      event = "ap-addonjob:client:managementOptions",
      args = data
    })
    ContextMenu({
      id = 'ManagementSettingsData',
      title = "Settings",
      options = MenuData
    })
  end
end)

RegisterNetEvent('ap-addonjob:client:manageApplicationPositions', function(data)
  if ctm.QB then
    local MenuData = {
      {
        header = "Application Positions",
        icon = "fa-solid fa-circle-info",
        txt = "Here you will be able to select the job positions you allow to be applied for."
      },
    }
    for k,v in pairs(data.management.positions) do
      table.insert(MenuData, {
        header = k,
        icon = "fa-solid fa-ranking-star",
        txt = "Available Position: "..tostring(v.enable),
        params = {
          isServer = true,
          event = "ap-addonjob:server:manageApplicationPositions",
          args = {db = data, k = k, v = v}
        }
      })
    end
    table.insert(MenuData, {
      header = "Back",
      icon = "fa-solid fa-arrow-left",
      txt = "Click to go back a menu.",
      params = {
        isServer = false,
        event = "ap-addonjob:client:managementSettings",
        args = data
      }
    })
    ContextMenu(MenuData)
  elseif ctm.OX then
    local MenuData = {}
    for k,v in pairs(data.management.positions) do
      table.insert(MenuData, {
        title = k,
        icon = {'fa', 'ranking-star'},
        description = "Available Position: "..tostring(v.enable),
        serverEvent = "ap-addonjob:server:manageApplicationPositions",
        args = {db = data, k = k, v = v}
      })
    end
    table.insert(MenuData, {
      title = "Back",
      icon = {'fa', 'arrow-left'},
      description = "Click to go back a menu.",
      event = "ap-addonjob:client:managementSettings",
      args = data
    })
    ContextMenu({
      id = 'ManagementSettingsPositionsActiveData',
      title = "Application Positions",
      options = MenuData
    })
  end
end)

RegisterNetEvent('ap-addonjob:client:manageApplicationQuestions', function(data)
  if ctm.QB then
    local MenuData = {
      {
        header = "Job Application Questions",
        icon = "fa-solid fa-circle-info",
        txt = "Here you will be able to change/view questions for your application.",
        isMenuHeader = true
      }
    }
    for k,v in pairs(data.template) do
      table.insert(MenuData, {
        header = "Question: #"..v.id,
        icon = "fa-solid fa-question",
        txt = v.label,
        params = {
          isServer = false,
          event = "ap-addonjob:client:changeQuestionJob",
          args = {db = data, k = k, v = v}
        }
      })
    end
    table.insert(MenuData, {
      header = "Back",
      icon = "fa-solid fa-arrow-left",
      txt = "Click to go back a menu.",
      params = {
        isServer = false,
        event = "ap-addonjob:client:managementSettings",
        args = data
      }
    })
    ContextMenu(MenuData)
  elseif ctm.OX then
    local MenuData = {}
    for k,v in pairs(data.template) do
      table.insert(MenuData, {
        title = "Question: #"..v.id,
        icon = {'fa', 'question'},
        description = v.label,
        event = "ap-addonjob:client:changeQuestionJob",
        args = {db = data, k = k, v = v}
      })
    end
    table.insert(MenuData, {
      title = "Back",
      icon = {'fa', 'arrow-left'},
      description = "Click to go back a menu.",
      event = "ap-addonjob:client:managementSettings",
      args = data
    })
    ContextMenu({
      id = 'ManagementSettingsApplicationQuestions',
      title = "Job Application Questions",
      options = MenuData
    })
  end
end)

RegisterNetEvent('ap-addonjob:client:changeQuestionJob', function(data)
  if Config.Dialog.QB then
    local dialog = exports[Config.ExportNames.input]:ShowInput({
      header = "Edit Current Question",
      submitText = "Submit",
      inputs = {
        {text = "Question:", name = "1", type = "text", isRequired = true, default = data.v.label},
        {text = "Size of text box:", name = "2", type = "select", 
          options = {
            {value = "text_area", text = "Big Input Box"},
            {value = "text_input", text = "Small Input Box"}
          }
        },
      },
    })
    if dialog ~= nil then
      data.db.template[data.k].label = dialog["1"]
      data.db.template[data.k].type = dialog["2"]
      TriggerServerEvent('ap-addonjob:server:changeQuestionJob', data, data.db.template[data.k])
    end
  elseif Config.Dialog.OX then
    local input = lib.inputDialog('Edit Current Question', {
      {type = 'textarea', label = "Question:", required = true, placeholder = data.v.label, autosize = true},
      {type = 'select', label = 'Size of text box:', description = 'Set this to small if you belive there will only be a small answer & set to big if you belive there will be a big answer.', required = true, options = {
        {value = "text_area", label = "Big Input Box"},
        {value = "text_input", label = "Small Input Box"},
      }}
    })
    if input ~= nil then
      data.db.template[data.k].label = input[1]
      data.db.template[data.k].type = input[2]
      TriggerServerEvent('ap-addonjob:server:changeQuestionJob', data, data.db.template[data.k])
    end
  end
end)

RegisterNetEvent('ap-addonjob:client:manageReceptionStaff', function(data)
  if ctm.QB then
    ContextMenu({
      {
        header = "Reception Staff",
        icon = "fa-solid fa-circle-info",
        txt = " ",
        isMenuHeader = true
      },
      {
        header = "Add New Reception Staff",
        icon = "fa-solid fa-plus",
        txt = "Here you will be able to add a new staff member to your staffing team, make sure there with you so they will show up on adding.",
        params = {
          isServer = false,
          event = "ap-addonjob:client:addNewReceptionMember",
          args = data
        }
      },
      {
        header = "Manage Current Staff",
        icon = "fa-solid fa-pen-to-square",
        txt = "Here you will be able to change perms/remove staff.",
        params = {
          isServer = false,
          event = "ap-addonjob:client:manageCurrentStaff",
          args = data
        }
      },
      {
        header = "Back",
        icon = "fa-solid fa-arrow-left",
        txt = "Click to go back a menu.",
        params = {
          isServer = false,
          event = "ap-addonjob:client:managementSettings",
          args = data
        }
      }
    })
  elseif ctm.OX then
    ContextMenu({
      id = 'ManagementReceptionStaff',
      title = "Reception Staff",
      options = {
        {
          title = "Add New Reception Staff",
          icon = {'fa', 'plus'},
          description = "Here you will be able to add a new staff member to your staffing team, make sure there with you so they will show up on adding.",
          event = "ap-addonjob:client:addNewReceptionMember",
          args = data
        },
        {
          title = "Manage Current Staff",
          icon = {'fa', 'pen-to-square'},
          description = "Here you will be able to change perms/remove staff.",
          event = "ap-addonjob:client:manageCurrentStaff",
          args = data
        },
        {
          title = "Back",
          icon = {'fa', 'arrow-left'},
          description = "Click to go back a menu.",
          event = "ap-addonjob:client:managementSettings",
          args = data
        }
      }
    })
  end
end)

RegisterNetEvent('ap-addonjob:client:addNewReceptionMember', function(data)
  QBCore.Functions.TriggerCallback('ap-addonjob:server:getOnlinePlayers', function(players)
    if ctm.QB then
      local MenuData = {
        {
          header = "Add To Staff",
          icon = "fa-solid fa-circle-info",
          txt = " ",
          isMenuHeader = true
        },
      }
      if players ~= nil then
        for k,v in pairs(players) do
          if isPlayerManagement(v.identifier, data.management.staff) ~= true then
            table.insert(MenuData, {
              header = v.name,
              icon = "fa-solid fa-plus",
              txt = "Click here to add this player to the staff team.",
              params = {
                isServer = false,
                event = "ap-addonjob:client:configureStaffPerms",
                args = {db = data, Player = v}
              }
            })
          end
        end
      end
      table.insert(MenuData, {
        header = "Back",
        icon = "fa-solid fa-arrow-left",
        txt = "Click to go back a menu.",
        params = {
          isServer = false,
          event = "ap-addonjob:client:manageReceptionStaff",
          args = data
        }
      })
      ContextMenu(MenuData)
    elseif ctm.OX then
      local MenuData = {}
      if players ~= nil then
        for k,v in pairs(players) do
          if isPlayerManagement(v.identifier, data.management.staff) ~= true then
            table.insert(MenuData, {
              title = v.name,
              icon = {'fa', 'plus'},
              description = "Click here to add this player to the staff team.",
              event = "ap-addonjob:client:configureStaffPerms",
              args = {db = data, Player = v}
            })
          end
        end
      end
      table.insert(MenuData, {
        title = "Back",
        icon = {'fa', 'arrow-left'},
        description = "Click to go back a menu.",
        event = "ap-addonjob:client:manageReceptionStaff",
        args = data
      })
      ContextMenu({
        id = 'ManagementAddReceptionStaff',
        title = "Add To Staff",
        options = MenuData
      })
    end
  end, data.job)
end)

RegisterNetEvent('ap-addonjob:client:configureStaffPerms', function(data)
  if Config.Dialog.QB then
    local options = {
      [1] = {value = 'appointments', text = 'Manage Appointments'},
      [2] = {value = 'applications', text = 'Manage Job Applications'},
    }
    if checkJob(data.db.job, tonumber(data.db.boss_rank)) then
      table.insert(options, 3, {value = 'management', text = 'Reception Management'})
    end
    local dialog = exports[Config.ExportNames.input]:ShowInput({
      header = data.Player.name.."'s Permissions",
      submitText = "Submit",
      inputs = {
        {text = "Staff Settings:", name = "1", type = "checkbox", options = options},
      },
    })
    if dialog ~= nil then
      local boss = false
      if toboolean(dialog.management) ~= false then boss = toboolean(dialog.management) end
      data.db.management.staff[data.Player.identifier] = {
        name = data.Player.name,
        identifier = data.Player.identifier,
        appointments = toboolean(dialog.appointments),
        applications = toboolean(dialog.applications),
        management = boss
      }
      TriggerServerEvent('ap-addonjob:server:addNewStaff', {db = data.db, management = data.db.management, player = data.Player})
    end
  elseif Config.Dialog.OX then
    local options = {
      [1] = {type = 'checkbox', label = 'View/Issue Appointments'},
      [2] = {type = 'checkbox', label = 'View/Manage Job Applications'},
    }
    if checkJob(data.db.job, tonumber(data.db.boss_rank)) then
      table.insert(options, 3, {type = 'checkbox', label = 'Reception Management'})
    end
    local input = lib.inputDialog(data.Player.name.."'s Permissions", options)
    if input ~= nil then
      local boss = false
      if input[3] ~= false then boss = input[3] end
      data.db.management.staff[data.Player.identifier] = {
        name = data.Player.name,
        identifier = data.Player.identifier,
        appointments = input[1],
        applications = input[2],
        management = boss
      }
      TriggerServerEvent('ap-addonjob:server:addNewStaff', {db = data.db, management = data.db.management, player = data.Player})
    end
  end
end)

RegisterNetEvent('ap-addonjob:client:manageCurrentStaff', function(data)
  if ctm.QB then
    local MenuData = {
      {
        header = "Manage Reception Staff",
        icon = "fa-solid fa-circle-info",
        txt = " ",
        isMenuHeader = true
      },
    }
    if data.management.staff ~= nil then
      for k,v in pairs(data.management.staff) do
        table.insert(MenuData, {
          header = v.name,
          icon = "fa-solid fa-pen-to-square",
          txt = "Click here to manage this staff member.",
          params = {
            isServer = false,
            event = "ap-addonjob:client:manageMemberProfile",
            args = {db = data, player = v}
          }
        })
      end
    end
    table.insert(MenuData, {
      header = "Back",
      icon = "fa-solid fa-arrow-left",
      txt = "Click to go back a menu.",
      params = {
        isServer = false,
        event = "ap-addonjob:client:manageReceptionStaff",
        args = data
      }
    })
    ContextMenu(MenuData)
  elseif ctm.OX then
    local MenuData = {}
    if data.management.staff ~= nil then
      for k,v in pairs(data.management.staff) do
        table.insert(MenuData, {
          title = v.name,
          icon = {'fa', 'pen-to-square'},
          description = "Click here to manage this staff member.",
          event = "ap-addonjob:client:manageMemberProfile",
          args = {db = data, player = v}
        })
      end
    end
    table.insert(MenuData, {
      title = "Back",
      icon = {'fa', 'arrow-left'},
      description = "Click to go back a menu.",
      event = "ap-addonjob:client:manageReceptionStaff",
      args = data
    })
    ContextMenu({
      id = 'ManagementManageReceptionStaff',
      title = "Manage Reception Staff",
      options = MenuData
    })
  end
end)

RegisterNetEvent('ap-addonjob:client:manageMemberProfile', function(data)
  if ctm.QB then
    ContextMenu({
      {
        header = "Manage "..data.player.name,
        icon = "fa-solid fa-circle-info",
        txt = " ",
        isMenuHeader = true
      },
      {
        header = "Change Permissions",
        icon = "fa-solid fa-pen-to-square",
        txt = "Click here to change this staff members permissions.",
        params = {
          isServer = false,
          event = "ap-addonjob:client:changePlayersPermissions",
          args = data
        }
      },
      {
        header = "Remove "..data.player.name,
        icon = "fa-solid fa-trash",
        txt = "Click here to remove this player from the reception staff.",
        params = {
          isServer = true,
          event = "ap-addonjob:server:removeStaffReception",
          args = data
        }
      },
      {
        header = "Back",
        icon = "fa-solid fa-arrow-left",
        txt = "Click to go back a menu.",
        params = {
          isServer = false,
          event = "ap-addonjob:client:manageCurrentStaff",
          args = data.db
        }
      }
    })
  elseif ctm.OX then
    ContextMenu({
      id = 'ManagementReceptionChangeStaff',
      title = "Manage "..data.player.name,
      options = {
        {
          title = "Change Permissions",
          icon = {'fa', 'pen-to-square'},
          description = "Click here to change this staff members permissions.",
          event = "ap-addonjob:client:changePlayersPermissions",
          args = data
        },
        {
          title = "Remove "..data.player.name,
          icon = {'fa', 'trash'},
          description = "Click here to remove this player from the reception staff.",
          serverEvent = "ap-addonjob:server:removeStaffReception",
          args = data
        },
        {
          title = "Back",
          icon = {'fa', 'arrow-left'},
          description = "Click to go back a menu.",
          event = "ap-addonjob:client:manageCurrentStaff",
          args = data.db
        }
      }
    })
  end
end)

RegisterNetEvent('ap-addonjob:client:changePlayersPermissions', function(data)
  local staff = data.db.management.staff[data.player.identifier]
  if Config.Dialog.QB then
    local options = {
      [1] = {value = 'appointments', text = 'Manage Appointments', checked = staff.appointments},
      [2] = {value = 'applications', text = 'Manage Job Applications', checked = staff.applications},
    }
    if checkJob(data.db.job, tonumber(data.db.boss_rank)) then
      table.insert(options, 3, {value = 'management', text = 'Reception Management', checked = staff.management})
    end
    local dialog = exports[Config.ExportNames.input]:ShowInput({
      header = data.player.name.."'s Permissions",
      submitText = "Submit",
      inputs = {
        {text = "Change Staff Settings:", name = "1", type = "checkbox", options = options},
      },
    })
    if dialog ~= nil then
      local boss = false
      if toboolean(dialog.management) ~= false then boss = toboolean(dialog.management) end
      data.db.management.staff[data.player.identifier] = {
        name = data.player.name,
        identifier = data.player.identifier,
        appointments = toboolean(dialog.appointments),
        applications = toboolean(dialog.applications),
        management = boss
      }
      TriggerServerEvent('ap-addonjob:server:changeStaffPerms', {db = data.db, management = data.db.management, player = data.player})
    end
  elseif Config.Dialog.OX then
    local options = {
      [1] = {type = 'checkbox', label = 'View/Issue Appointments', checked = staff.appointments},
      [2] = {type = 'checkbox', label = 'View/Manage Job Applications', checked = staff.applications},
    }
    if checkJob(data.db.job, tonumber(data.db.boss_rank)) then
      table.insert(options, 3, {type = 'checkbox', label = 'Reception Management', checked = staff.management})
    end
    local input = lib.inputDialog(data.player.name.."'s Permissions", options)
    if input ~= nil then
      local boss = false
      if input[3] ~= false then boss = input[3] end
      data.db.management.staff[data.player.identifier] = {
        name = data.player.name,
        identifier = data.player.identifier,
        appointments = input[1],
        applications = input[2],
        management = boss
      }
      TriggerServerEvent('ap-addonjob:server:changeStaffPerms', {db = data.db, management = data.db.management, player = data.player})
    end
  end
end)
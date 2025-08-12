local documentTable = nil

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

if Config.Inventory.OX then
  exports.ox_inventory:displayMetadata({
    documentidentifier = Config.OXMetaDisplay.documentidentifier,
    documentname = Config.OXMetaDisplay.documentname,
    documentcreator = Config.OXMetaDisplay.documentcreator,
  })
end

checkJob = function(table, job)
  for k, v in pairs(table) do
	if v == "all" then
      if job.name == k then
	    return true
	  end
	else
	  for _, e in pairs(v) do
        if job.name == k and job.grade == tonumber(e) then
	      return true
	    end
      end
	end
  end
  return false   
end

checkGang = function(table, gang)
  for k, v in pairs(table) do
	if v == "all" then
		if gang.name == k then
		  return true
		end
	else
	  for _, e in pairs(v) do
        if gang.name == k and gang.grade >= tonumber(e) then
	      return true
	    end
      end
	end
  end
  return false   
end

checkCitizenid = function(table, data)
  for _, v in pairs(table) do
    if data.citizenid == v then
	    return true
    end
  end
  return false   
end

RegisterNetEvent('ap-documents:client:OnUpdate', function(tableName, values)
    for key, value in pairs(values) do
        Shared[tableName][key] = value
    end
end)

RegisterNetEvent('ap-documents:client:uploadData', function(data)
  documentTable = data.document
  local signiture = false
  signiture = data.nonSignature
  SendNUIMessage({
    type  = "openDocumentUI",
	lawfirms = true,
	firmdocument = data.type,
    document = data.document,
	signiture = signiture,
    identifier = data.cid,
    firmID = data.args,
	docname = data.docname
  })
  SetNuiFocus(true,true)
end)

RegisterNetEvent('ap-documents:client:t1gerUI', function(data)
	documentTable = data.document
	SendNUIMessage({
	  type  = "openDocumentUI",
	  document = data.document,
	  isT1ger = true,
      tigerData = data
	})
	SetNuiFocus(true,true)
  end)

RegisterNUICallback('close', function()
  SetNuiFocus(false, false)
end)

RegisterNetEvent('ap-documents:client:closeUI', function()
  SetNuiFocus(false, false)
end)

RegisterNetEvent('ap-documents:client:openDocument', function(table)
  if table.type == true then
	documentTable = table.doc
  else
    documentTable = table
  end
  SendNUIMessage({
	  type  = "openDocumentUI",
	})
	SetNuiFocus(true,true)
end)

RegisterNetEvent('ap-documents:client:showMetaDocument', function(table)
	documentTable = table
	SendNUIMessage({
		type  = "openDocumentUI",
	  })
	  SetNuiFocus(true,true)
  end)

RegisterNUICallback('getDocumentConfig', function(data,cb)
  cb(documentTable)
end)

RegisterNUICallback("printDoc",function(info)
  CreateDocument(info)
end)

RegisterNUICallback("tigerclose",function(info)
  SetNuiFocus(false, false)
  TriggerClientEvent(info.T1gerData.event, info.T1gerData.args)
end)

CreateDocument = function(info)
	if documentTable["information"][1] then
		documentTable["information"][1]["value"] = info["information"]["i1"]
	end
	if documentTable["information"][2] then
		documentTable["information"][2]["value"] = info["information"]["i2"]
	end
	if documentTable["information"][3] then
		documentTable["information"][3]["value"] = info["information"]["i3"]
	end
	if documentTable["information"][4] then
		documentTable["information"][4]["value"] = info["information"]["i4"]
	end
	if documentTable["information"][5] then
	    documentTable["information"][5]["value"] = info["information"]["i5"]
	end
	if documentTable["information"][6] then
		documentTable["information"][6]["value"] = info["information"]["i6"]
	end
	if documentTable["information"][7] then
		documentTable["information"][7]["value"] = info["information"]["i7"]
	end
	if documentTable["information"][8] then
	    documentTable["information"][8]["value"] = info["information"]["i8"]
	end
	if documentTable["information"][9] then
		documentTable["information"][9]["value"] = info["information"]["i9"]
	end
	if documentTable["information"][10] then
		documentTable["information"][10]["value"] = info["information"]["i10"]
	end

	if documentTable["extended_information"][1] then
		documentTable["extended_information"][1]["value"] = info["extended_information"]["e1"]
	end
	if documentTable["extended_information"][2] then
		documentTable["extended_information"][2]["value"] = info["extended_information"]["e2"]
	end
	if documentTable["extended_information"][3] then
		documentTable["extended_information"][3]["value"] = info["extended_information"]["e3"]
	end
	if documentTable["extended_information"][4] then
		documentTable["extended_information"][4]["value"] = info["extended_information"]["e4"]
	end
	if documentTable["extended_information"][5] then
	    documentTable["extended_information"][5]["value"] = info["extended_information"]["e5"]
	end
	if documentTable["extended_information"][6] then
		documentTable["extended_information"][6]["value"] = info["extended_information"]["e6"]
	end
	if documentTable["extended_information"][7] then
		documentTable["extended_information"][7]["value"] = info["extended_information"]["e7"]
	end
	if documentTable["extended_information"][8] then
	    documentTable["extended_information"][8]["value"] = info["extended_information"]["e8"]
	end
	if documentTable["extended_information"][9] then
		documentTable["extended_information"][9]["value"] = info["extended_information"]["e9"]
	end
	if documentTable["extended_information"][10] then
		documentTable["extended_information"][10]["value"] = info["extended_information"]["e10"]
	end

	documentTable["type"] = "show"
	documentTable["sign"] = info["sign"]

	showDialog(documentTable)
end
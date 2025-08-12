QBCore = exports[Config.FrameworkExport]:GetCoreObject()

Citizen.CreateThread(function ()
    if GetResourceState(GetCurrentResourceName()) == 'started' then
      print('[INFO] Join Discord for support and information, https://discord.gg/8Cn3EjfzrM') 
    end
end)

local function AddDocuments(documents)
  local shouldContinue = true

  for key, value in pairs(documents) do
      if type(key) ~= "string" then
          shouldContinue = false
          break
      end

      if Shared.Documents[key] then
          shouldContinue = false
          break
      end

      Shared.Documents[key] = value
  end

  if not shouldContinue then return false end
  TriggerClientEvent('ap-documents:client:OnUpdate', -1, 'Documents', documents)
  return true
end
exports('AddDocuments', AddDocuments)

QBCore.Functions.CreateCallback('ap-documents:getDocuments',function(source, cb)
  local Player = QBCore.Functions.GetPlayer(source)
  local result = MySQL.Sync.fetchAll('SELECT * FROM `ap_documents` WHERE identifier = @identifier', {['@identifier'] = Player.PlayerData.citizenid})
  cb(result)
end)

RegisterServerEvent('ap-documents:server:createDocument')
AddEventHandler('ap-documents:server:createDocument', function(name, type, table)
  local Player = QBCore.Functions.GetPlayer(source)
  local documentid = QBCore.Shared.RandomInt(2) .. QBCore.Shared.RandomStr(3) .. QBCore.Shared.RandomInt(1) .. QBCore.Shared.RandomStr(2) .. QBCore.Shared.RandomInt(3) .. QBCore.Shared.RandomStr(4)
  MySQL.Async.execute('INSERT INTO ap_documents (documentid, identifier, document, name, catergory) VALUES (@documentid, @identifier, @document, @name, @catergory)', {
    ['@documentid'] = documentid,
    ['@identifier'] = Player.PlayerData.citizenid,
    ['@document'] = json.encode(table),
    ['@name'] = name,
    ['@catergory'] = type, 
  })
  if Config.UseItem.MetaData then
    local info = {}
    info.documentidentifier = documentid
    info.documentname = name
    info.documentcreator = getName(Player.PlayerData.citizenid)
    if Config.Debug then
      print('[NEW DOCUMENT METADATA] Item Metadata Below.', json.encode(info, {indent = true}))
    end
    if Config.Inventory.OX then
      if not exports.ox_inventory:AddItem(Player.PlayerData.source, Config.UseItem.DocumentItem.item, 1, info) then return end
    elseif Config.Inventory.QB then
      if not Player.Functions.AddItem(Config.UseItem.DocumentItem.item, 1, nil, info) then return end
      TriggerClientEvent('inventory:client:ItemBox', Player.PlayerData.source, QBCore.Shared.Items[Config.UseItem.DocumentItem.item], 'add')
    elseif Config.Inventory.Other then
      CreateDocumentCustom(Player.PlayerData.source, Config.UseItem.DocumentItem.item, info)
    end
  end
  TriggerClientEvent('ap-documents:notify', Player.PlayerData.source, "You have created a document: "..name..".")
end)

RegisterServerEvent('ap-documents:server:printCopy')
AddEventHandler('ap-documents:server:printCopy', function(meta)
  local Player = QBCore.Functions.GetPlayer(source)
  if Config.UseItem.MetaData then
    local info = {}
    info.documentidentifier = meta.documentidentifier
    info.documentname = meta.documentname
    info.documentcreator = meta.documentcreator
    if Config.Debug then
      print('[NEW DOCUMENT METADATA] Item Metadata Below.', json.encode(info, {indent = true}))
    end
    if Config.Inventory.OX then
      if not exports.ox_inventory:AddItem(Player.PlayerData.source, Config.UseItem.DocumentItem.item, 1, info) then return end
    elseif Config.Inventory.QB then
      if not Player.Functions.AddItem(Config.UseItem.DocumentItem.item, 1, nil, info) then return end
      TriggerClientEvent('inventory:client:ItemBox', Player.PlayerData.source, QBCore.Shared.Items[Config.UseItem.DocumentItem.item], 'add')
    elseif Config.Inventory.Other then
      CreateReprintedDocumentCustom(Player.PlayerData.source, Config.UseItem.DocumentItem.item, info)
    end
  end
  TriggerClientEvent('ap-documents:notify', Player.PlayerData.source, "You have made a copy of: "..meta.documentname..".")
end)

if Config.Inventory.QB then
  QBCore.Functions.CreateUseableItem(Config.UseItem.DocumentItem.item, function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
    if Config.Debug then
      print('[DOCUMENTS ITEM] Item Metadata Below.', json.encode(item.info, {indent = true}))
    end
    local result = MySQL.Sync.fetchAll('SELECT * FROM `ap_documents` WHERE documentid = @documentid', {['@documentid'] = item.info.documentidentifier})
    local hasItem = Player.Functions.GetItemByName(Config.UseItem.PortableDocumentCopier.item)
    TriggerClientEvent('ap-documents:client:showDocumentOptions', Player.PlayerData.source, json.decode(result[1].document), result[1].name, hasItem, item.info)
  end)
elseif Config.Inventory.OX then
  if Config.OXInventoryFix ~= true then
    QBCore.Functions.CreateUseableItem(Config.UseItem.DocumentItem.item, function(source, item)
      local Player = QBCore.Functions.GetPlayer(source)
      local hasItem = false
      local result = MySQL.Sync.fetchAll('SELECT * FROM `ap_documents` WHERE documentid = @documentid', {['@documentid'] = item.metadata.documentidentifier})
      local getItem = Player.Functions.GetItemByName(Config.UseItem.PortableDocumentCopier.item)
      if Config.Debug then
        print('[DOCUMENTS ITEM] Item Metadata Below.', json.encode(item.metadata, {indent = true}))
      end
      if getItem.count >= 1 then
        hasItem = true
      end
      TriggerClientEvent('ap-documents:client:showDocumentOptions', Player.PlayerData.source, json.decode(result[1].document), result[1].name, hasItem, item.metadata)
    end)
  end
elseif Config.Inventory.Other then
  CreateUseableDocumentItemCustom()
end

RegisterServerEvent('ap-documents:server:useItemDocument')
AddEventHandler('ap-documents:server:useItemDocument', function(data)
  local Player = QBCore.Functions.GetPlayer(source)
  local hasItem = false
  local Item = exports["ox_inventory"]:GetSlot(Player.PlayerData.source, data.slot)
  local result = MySQL.Sync.fetchAll('SELECT * FROM `ap_documents` WHERE documentid = @documentid', {['@documentid'] = Item.metadata.documentidentifier})
  local getItem = exports["ox_inventory"]:Search(Player.PlayerData.source, 'count', Config.UseItem.PortableDocumentCopier.item)
  if Config.Debug then
    print('[DOCUMENTS ITEM] Item Metadata Below.', json.encode(Item.metadata, {indent = true}))
  end
  if getItem >= 1 then
    hasItem = true
  end
  TriggerClientEvent('ap-documents:client:showDocumentOptions', Player.PlayerData.source, json.decode(result[1].document), result[1].name, hasItem, Item.metadata) 
end)



RegisterServerEvent('ap-documents:server:showMetaDocument')
AddEventHandler('ap-documents:server:showMetaDocument', function(document)
  local PlayerPed = GetPlayerPed(source)
  local PlayerCoords = GetEntityCoords(PlayerPed)
  for _, v in pairs(QBCore.Functions.GetPlayers()) do
    local TargetPed = GetPlayerPed(v)
    local dist = #(PlayerCoords - GetEntityCoords(TargetPed))
    if dist < 3.0 then
      TriggerClientEvent('ap-documents:client:showMetaDocument', v, document)
    end
  end
end)

if Config.Inventory.QB then
  QBCore.Functions.CreateUseableItem(Config.UseItem.CreateDocument.item, function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
    if Config.Debug then
      print('[ITEM INFO] Item Info Below.', json.encode(item, {indent = true}))
    end
    TriggerClientEvent('ap-documents:client:showEmptyDocuments', Player.PlayerData.source, {name = Player.PlayerData.job.name, grade = Player.PlayerData.job.grade.level}, {name = Player.PlayerData.gang.name, grade = Player.PlayerData.gang.grade.level}, Player.PlayerData.citizenid)
  end)
elseif Config.Inventory.OX then
  if Config.OXInventoryFix ~= true then
    QBCore.Functions.CreateUseableItem(Config.UseItem.CreateDocument.item, function(source, item)
      local Player = QBCore.Functions.GetPlayer(source)
      if Config.Debug then
        print('[ITEM INFO] Item Info Below.', json.encode(item, {indent = true}))
      end
      TriggerClientEvent('ap-documents:client:showEmptyDocuments', Player.PlayerData.source, {name = Player.PlayerData.job.name, grade = Player.PlayerData.job.grade.level}, {name = Player.PlayerData.gang.name, grade = Player.PlayerData.gang.grade.level}, Player.PlayerData.citizenid)
    end)
  end
elseif Config.Inventory.Other then
  CreateUseableBlankDocumentItemCustom()
end

RegisterServerEvent('ap-documents:server:showEmptyDocuments')
AddEventHandler('ap-documents:server:showEmptyDocuments', function()
  local Player = QBCore.Functions.GetPlayer(source)
  if Config.Debug then
    print('[Source] '..Player.PlayerData.source..' [Job Name] '..Player.PlayerData.job.name..' [Job Grade] '..Player.PlayerData.job.grade.level..' [Gang Name] '..Player.PlayerData.gang.name..' [Gang Grade] '..Player.PlayerData.gang.grade.level..' [Identifier] '..Player.PlayerData.citizenid)
  end
  TriggerClientEvent('ap-documents:client:showEmptyDocuments', Player.PlayerData.source, {name = Player.PlayerData.job.name, grade = Player.PlayerData.job.grade.level}, {name = Player.PlayerData.gang.name, grade = Player.PlayerData.gang.grade.level}, Player.PlayerData.citizenid)
end)

RegisterServerEvent('ap-documents:server:refreshDocs')
AddEventHandler('ap-documents:server:refreshDocs', function()
  local Player = QBCore.Functions.GetPlayer(source)
  TriggerClientEvent('ap-documents:client:showEmptyDocuments', Player.PlayerData.source, {name = Player.PlayerData.job.name, grade = Player.PlayerData.job.grade.level}, {name = Player.PlayerData.gang.name, grade = Player.PlayerData.gang.grade.level}, Player.PlayerData.citizenid)
end)

if Config.UseItem.QBItemCreation then
  exports[Config.FrameworkExport]:AddItems({
    [Config.UseItem.DocumentItem.item] = {
        name = Config.UseItem.DocumentItem.item,
        label = Config.UseItem.DocumentItem.label,
        weight = Config.UseItem.DocumentItem.weight,
        type = 'item',
        image = Config.UseItem.DocumentItem.image,
        unique = true,
        useable = true,
        shouldClose = true,
        combinable = nil,
        description = Config.UseItem.DocumentItem.description
    },
    [Config.UseItem.CreateDocument.item] = {
        name = Config.UseItem.CreateDocument.item,
        label = Config.UseItem.CreateDocument.label,
        weight = Config.UseItem.CreateDocument.weight,
        type = 'item',
        image = Config.UseItem.CreateDocument.image,
        unique = true,
        useable = true,
        shouldClose = true,
        combinable = nil,
        description = Config.UseItem.CreateDocument.description
    },
    [Config.UseItem.PortableDocumentCopier.item] = {
      name = Config.UseItem.PortableDocumentCopier.item,
      label = Config.UseItem.PortableDocumentCopier.label,
      weight = Config.UseItem.PortableDocumentCopier.weight,
      type = 'item',
      image = Config.UseItem.PortableDocumentCopier.image,
      unique = true,
      useable = false,
      shouldClose = false,
      combinable = nil,
      description = Config.UseItem.PortableDocumentCopier.description
  }
  })
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
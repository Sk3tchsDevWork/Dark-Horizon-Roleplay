CreateDocumentCustom = function(source, item, metadata)
  -- source = Player ID
  -- item = Item Spawn Name
  -- metadata = Created Metadata
end

CreateReprintedDocumentCustom = function(source, item, metadata)
  -- source = Player ID
  -- item = Item Spawn Name
  -- metadata = Created Metadata
end

CreateUseableDocumentItemCustom = function()
  -- Add Usable Item for the item document, Example Below

  -- QBCore.Functions.CreateUseableItem(Config.UseItem.DocumentItem.item, function(source, item)
  --   local Player = QBCore.Functions.GetPlayer(source)
  --   local result = MySQL.Sync.fetchAll('SELECT * FROM `ap_documents` WHERE documentid = @documentid', {['@documentid'] = item.metadata.documentidentifier})
  --   local getItem, hasItem = Player.Functions.GetItemByName(Config.UseItem.PortableDocumentCopier.item), false
  --   if getItem.count >= 1 then
  --     hasItem = true
  --   end
  --   TriggerClientEvent('ap-documents:client:showDocumentOptions', Player.PlayerData.source, json.decode(result[1].document), result[1].name, hasItem, item.metadata)
  -- end)
end

CreateUseableBlankDocumentItemCustom = function()
-- Add Usable Item for the blank document item, Example Below

  -- QBCore.Functions.CreateUseableItem(Config.UseItem.CreateDocument.item, function(source, item)
  --   local Player = QBCore.Functions.GetPlayer(source)
  --   TriggerClientEvent('ap-documents:client:showEmptyDocuments', Player.PlayerData.source, {name = Player.PlayerData.job.name, grade = Player.PlayerData.job.grade.level}, {name = Player.PlayerData.gang.name, grade = Player.PlayerData.gang.grade.level}, Player.PlayerData.citizenid)
  -- end)
end
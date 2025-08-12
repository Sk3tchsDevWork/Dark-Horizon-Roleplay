Config = {
	FrameworkExport = "qb-core", -- Set this too your core name, only change this if you have a custom version of QBCore. 
	Debug = false, -- Set the webhooks you want to use to true.
	Inventory = {QB = true, OX = false, Other = false}, -- Set QB to true if you use an inventory that uses QB functionality Otherwise use OX if you have that or Other and add compat to your own inventory in server\custominventory.lua.
	Context = {QB = true, OX = false},
	Dialog = {QB = true, OX = false},
	ExportNames = {menu = "qb-menu", input = "qb-input"},
	UseItem = {
		QBItemCreation = true,
		MetaData = true, 
		DocumentItem = {
			item = "document", 
			label = "Document",
			weight = 10,
			image = "printerdocument.png",
			description = "This is a custom document which has been made."
		}, 
		CreateDocument = {
			item = "emptydocuments", 
			label = "Blank Documents",
			weight = 10,
			image = "emptydocuments.png",
			description = "These are blank documents which you can use to fill them out."
		},
		PortableDocumentCopier = {
			item = "portablecopier", 
			label = "Portable Document Copier",
			weight = 10,
			image = "portablecopier.png",
			description = "If you have this machine you will be able to duplicate documents."
		},
	}
}

Config.OXMetaDisplay = { -- Edit the strings for how this is displayed in the ox inventory.
  documentidentifier = 'Document ID',
  documentname = 'Document Name',
  documentcreator = 'Creator'
}

Config.OXInventoryFix = false -- Set to true if your OX inventory requires you to add the usable item events in ox_inventory\modules\items\client.lua. If you use this add the example below in the file at the bottom!

-- Item('document', function(data, slot)
--   ox_inventory:useItem(data, function(data)
--     if data ~= nil then
--       TriggerServerEvent('ap-documents:server:useItemDocument', data)
--     end
--   end)
-- end)
  
-- Item('emptydocuments', function(data, slot)
--   ox_inventory:useItem(data, function(data)
--     if data ~= nil then
--       TriggerServerEvent('ap-documents:server:showEmptyDocuments')
--     end
--   end)
-- end)
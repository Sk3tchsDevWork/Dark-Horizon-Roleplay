RegisterNetEvent('ap-documents:client:openDocumentMenu', function()
  if Config.Context.QB then
	local documentMain = {
		{
			header = "Document Types",
			isMenuHeader = true,
		},
	}
	
	for k in pairs(Shared.Documents) do
    table.insert(documentMain,  {
      header = k, 
      txt = "Click to make a Document.",
      params = {
        isServer = false,
        event = "ap-documents:client:openDocument",
        args = {
			doc = Shared.Documents[k],
			type = true
		}
      }
    }) 			
	end
	ContextMenu(documentMain)
  elseif Config.Context.OX then
    local documentMain = {}
    for k in pairs(Shared.Documents) do
      table.insert(documentMain,  {
        title = k, 
        description = "Click to make a Document.",
        event = "ap-documents:client:openDocument",
        args = {doc = Shared.Documents[k], type = true}
      }) 			
    end
    ContextMenu({
      id = 'documentMain',
      title = "Document Types",
      options = documentMain
    })
  end
end)

RegisterNetEvent('ap-documents:client:myDocuments', function()
  QBCore.Functions.TriggerCallback('ap-documents:getDocuments', function(db)
    if Config.Context.QB then
      local myDocument = {
        {
          header = "My Documents",
          isMenuHeader = true,
        },
      }
      
      for _, v in pairs(db) do
        table.insert(myDocument,  {
          header = v.name, 
          txt = v.catergory,
          params = {
            isServer = false,
            event = "ap-documents:client:openDocument",
            args = json.decode(v.document)
          }
        }) 			
      end
      ContextMenu(myDocument)
    elseif Config.Context.OX then
        local myDocument = {}
        for _, v in pairs(db) do
          table.insert(myDocument,  {
            title = v.name, 
            description = v.catergory,
            event = "ap-documents:client:openDocument",
            args = json.decode(v.document)
          }) 			
        end
        ContextMenu({
          id = 'myDocument',
          title = "My Documents",
          options = myDocument
        })
    end
  end)
end)

RegisterNetEvent('ap-documents:client:showDocumentOptions', function(document, docname, hasCopier, itemMeta)
  if Config.Context.QB then
    local myDocument = {
        {
          header = "Document: "..docname,
          txt = "Document description: "..document['description'],
          isMenuHeader = true,
        },
        {
          header = "View Document",
          txt = "View this document, you will only be able to see this.",
          params = {
            isServer = false,
            event = "ap-documents:client:showMetaDocument",
            args = document
          }
        },
        {
          header = "Show Document",
          txt = "Show this document to people around you, including yourself.",
          params = {
            isServer = true,
            event = "ap-documents:server:showMetaDocument",
            args = document
          }
        },
    }
    if hasCopier then
        table.insert(myDocument, {
            header = "Reprint Document",
            txt = "Use this to make a copy of the document to give to someone else or as a copy.",
            params = {
                isServer = true,
                event = "ap-documents:server:printCopy",
                args = itemMeta
            }
        }) 
    end
    ContextMenu(myDocument)
  elseif Config.Context.OX then
    local myDocument = {
      {
        title = "View Document",
        description = "View this document, you will only be able to see this.",
        event = "ap-documents:client:showMetaDocument",
        args = document
      },
      {
        title = "Show Document",
        description = "Show this document to people around you, including yourself.",
        serverEvent = "ap-documents:server:showMetaDocument",
        args = document
      },
    }
    if hasCopier then
      table.insert(myDocument, {
        title = "Reprint Document",
        description = "Use this to make a copy of the document to give to someone else or as a copy.",
        serverEvent = "ap-documents:server:printCopy",
        args = itemMeta
      }) 
    end
    ContextMenu({
      id = 'showDocs',
      title = "Document: "..docname,
      options = myDocument
    })
  end
end)

RegisterNetEvent('ap-documents:client:showEmptyDocuments', function(job, gang, citizenid)
  if Config.Context.QB then
    local DocumentCreation = {
        {
          header = "Unrestricted Documents",
          txt = "Here will be all the documents you can create.",
          params = {
            isServer = false,
            event = "ap-documents:client:unrestrictedDocuments",
            args = {}
          }
        },
        {
          header = "Restricted Documents",
          txt = "Here will be documents assigned to you, for you to create.",
          params = {
            isServer = false,
            event = "ap-documents:client:restrictedDocuments",
            args = {
                job = job,
                gang = gang,
                citizenid = citizenid
            }
          }
        }
    }
    ContextMenu(DocumentCreation)
  elseif Config.Context.OX then
    print("Hello")
    ContextMenu({
      id = 'DocumentCreation',
      title = "Document Templates",
      options = {
        {
          title = "Unrestricted Documents",
          description = "Here will be all the documents you can create.",
          event = "ap-documents:client:unrestrictedDocuments",
          args = {}
        },
        {
          title = "Restricted Documents",
          description = "Here will be documents assigned to you, for you to create.",
          event = "ap-documents:client:restrictedDocuments",
          args = {job = job, gang = gang, citizenid = citizenid}
        }
      }  
    })
  end
end)

RegisterNetEvent('ap-documents:client:unrestrictedDocuments', function()
  if Config.Context.QB then
    local UnrestrictedDocumentCreation = {
        {
          header = "Document Types",
          isMenuHeader = true
        },
    }
    for k, v in pairs(Shared.Documents) do
      if v.restriction.job.enable == false and v.restriction.gang.enable == false and v.restriction.citizenid.enable == false then
        table.insert(UnrestrictedDocumentCreation, {
            header = k,
            txt = v.description,
            params = {
                isServer = false,
                event = "ap-documents:client:openDocument",
                args = {
                    doc = Shared.Documents[k],
			        type = true
                }
            }
        }) 
      end
    end
    table.insert(UnrestrictedDocumentCreation, {
        header = "Back",
        txt = "Back to main menu.",
        params = {
            isServer = true,
            event = "ap-documents:server:refreshDocs",
            args = {}
        }
    }) 
    ContextMenu(UnrestrictedDocumentCreation)
  elseif Config.Context.OX then
    local UnrestrictedDocumentCreation = {}
    for k, v in pairs(Shared.Documents) do
      if v.restriction.job.enable == false and v.restriction.gang.enable == false and v.restriction.citizenid.enable == false then
        table.insert(UnrestrictedDocumentCreation, {
          title = k,
          description = v.description,
          event = "ap-documents:client:openDocument",
          args = {doc = Shared.Documents[k], type = true}
        }) 
      end
    end
    table.insert(UnrestrictedDocumentCreation, {
      title = "Back",
      description = "Back to main menu.",
      serverEvent = "ap-documents:server:refreshDocs",
      args = {}
    }) 
    ContextMenu({
      id = 'UnrestrictedDocumentCreation',
      title = "Document Types",
      options = UnrestrictedDocumentCreation
    })
  end
end)

RegisterNetEvent('ap-documents:client:restrictedDocuments', function(data)
    local JobType, GangType, CitizenType = false, false, false
    for k, v in pairs(Shared.Documents) do
      if v.restriction.job.enable and checkJob(v.restriction.job.jobs, data.job)  then
        JobType = true
      end
      if v.restriction.gang.enable and checkGang(v.restriction.gang.gangs, data.gang) then
        GangType = true
      end
      if v.restriction.citizenid.enable and checkCitizenid(v.restriction.citizenid.id, data) then
        CitizenType = true
      end
    end
    if Config.Context.QB then
        local RestrictedDocumentCreation = {
            {
              header = "Restricted Document Types",
              isMenuHeader = true
            },
        }
        if JobType then
            table.insert(RestrictedDocumentCreation, {
                header = "Job Documents",
                txt = "You will be able to access your job documents here.",
                params = {
                    isServer = false,
                    event = "ap-documents:client:jobDocs",
                    args = data
                }
            })     
        end
        if GangType then
            table.insert(RestrictedDocumentCreation, {
                header = "Gang Documents",
                txt = "You will be able to access your gang documents here.",
                params = {
                    isServer = false,
                    event = "ap-documents:client:gangDocs",
                    args = data
                }
            })     
        end
        if CitizenType then
            table.insert(RestrictedDocumentCreation, {
                header = "Private Documents",
                txt = "You will be able to access your private documents here.",
                params = {
                    isServer = false,
                    event = "ap-documents:client:privateDocs",
                    args = data
                }
            })     
        end
        table.insert(RestrictedDocumentCreation, {
            header = "Back",
            txt = "Back to main menu.",
            params = {
                isServer = true,
                event = "ap-documents:server:refreshDocs",
                args = {}
            }
        }) 
        ContextMenu(RestrictedDocumentCreation)
    elseif Config.Context.OX then
        local RestrictedDocumentCreation = {}
        if JobType then
          table.insert(RestrictedDocumentCreation, {
            title = "Job Documents",
            description = "You will be able to access your job documents here.",
            event = "ap-documents:client:jobDocs",
            args = data
          })     
        end
        if GangType then
          table.insert(RestrictedDocumentCreation, {
            title = "Gang Documents",
            description = "You will be able to access your gang documents here.",
            event = "ap-documents:client:gangDocs",
            args = data
          })     
        end
        if CitizenType then
          table.insert(RestrictedDocumentCreation, {
            title = "Private Documents",
            description = "You will be able to access your private documents here.",
            event = "ap-documents:client:privateDocs",
            args = data
          })     
        end
        table.insert(RestrictedDocumentCreation, {
          title = "Back",
          description = "Back to main menu.",
          serverEvent = "ap-documents:server:refreshDocs",
          args = {}
        })
        ContextMenu({
          id = 'RestrictedDocumentCreation',
          title = "Restricted Document Types",
          options = RestrictedDocumentCreation
        })
    end
end)

RegisterNetEvent('ap-documents:client:jobDocs', function(data)
  if Config.Context.QB then
    local JobDocumentsCreate = {
        {
          header = "Job Document Types",
          isMenuHeader = true
        },
    }
    for k, v in pairs(Shared.Documents) do
        if v.restriction.job.enable and checkJob(v.restriction.job.jobs, data.job) then
            table.insert(JobDocumentsCreate, {
                header = k,
                txt = v.description,
                params = {
                    isServer = false,
                    event = "ap-documents:client:openDocument",
                    args = {
                        doc = Shared.Documents[k],
			            type = true
                    }
                }
            })   
        end
    end
    table.insert(JobDocumentsCreate, {
        header = "Back",
        txt = "Back to restricted Documents.",
        params = {
            isServer = false,
            event = "ap-documents:client:restrictedDocuments",
            args = data
        }
    }) 
    ContextMenu(JobDocumentsCreate)
  elseif Config.Context.OX then
    local JobDocumentsCreate = {}
    for k, v in pairs(Shared.Documents) do
      if v.restriction.job.enable and checkJob(v.restriction.job.jobs, data.job) then
        table.insert(JobDocumentsCreate, {
          header = k,
          txt = v.description,
          event = "ap-documents:client:openDocument",
          args = {doc = Shared.Documents[k], type = true}
        })   
      end
    end
    table.insert(JobDocumentsCreate, {
      header = "Back",
      txt = "Back to restricted Documents.",
      event = "ap-documents:client:restrictedDocuments",
      args = data
    }) 
    ContextMenu({
      id = 'JobDocumentsCreate',
      title = "Job Document Types",
      options = JobDocumentsCreate
    })
  end
end)

RegisterNetEvent('ap-documents:client:gangDocs', function(data)
  if Config.Context.QB then
    local GangDocumentsCreate = {
        {
          header = "Gang Document Types",
          isMenuHeader = true
        },
    }
    for k, v in pairs(Shared.Documents) do
        if v.restriction.gang.enable and checkGang(v.restriction.gang.gangs, data.gang) then
            table.insert(GangDocumentsCreate, {
                header = k,
                txt = v.description,
                params = {
                    isServer = false,
                    event = "ap-documents:client:openDocument",
                    args = {
                        doc = Shared.Documents[k],
			            type = true
                    }
                }
            })   
        end
    end
    table.insert(GangDocumentsCreate, {
        header = "Back",
        txt = "Back to restricted Documents.",
        params = {
            isServer = false,
            event = "ap-documents:client:restrictedDocuments",
            args = data
        }
    }) 
    ContextMenu(GangDocumentsCreate)
  elseif Config.Context.OX then
    local GangDocumentsCreate = {}
    for k, v in pairs(Shared.Documents) do
      if v.restriction.gang.enable and checkGang(v.restriction.gang.gangs, data.gang) then
        table.insert(GangDocumentsCreate, {
          title = k,
          description = v.description,
          event = "ap-documents:client:openDocument",
          args = {doc = Shared.Documents[k], type = true}
        })   
      end
    end
    table.insert(GangDocumentsCreate, {
      title = "Back",
      description = "Back to restricted Documents.",
      event = "ap-documents:client:restrictedDocuments",
      args = data
    }) 
    ContextMenu({
      id = 'GangDocumentsCreate',
      title = "Gang Document Types",
      options = GangDocumentsCreate
    })
  end
end)

RegisterNetEvent('ap-documents:client:privateDocs', function(data)
  if Config.Context.QB then
    local PrivateDocumentsCreate = {
        {
          header = "Private Document Types",
          isMenuHeader = true
        },
    }
    for k, v in pairs(Shared.Documents) do
        if v.restriction.citizenid.enable and checkCitizenid(v.restriction.citizenid.id, data) then
            table.insert(PrivateDocumentsCreate, {
                header = k,
                txt = v.description,
                params = {
                    isServer = false,
                    event = "ap-documents:client:openDocument",
                    args = {
                        doc = Shared.Documents[k],
			            type = true
                    }
                }
            })   
        end
    end
    table.insert(PrivateDocumentsCreate, {
        header = "Back",
        txt = "Back to restricted Documents.",
        params = {
            isServer = false,
            event = "ap-documents:client:restrictedDocuments",
            args = data
        }
    }) 
    ContextMenu(PrivateDocumentsCreate)
  elseif Config.Context.OX then
    local PrivateDocumentsCreate = {}
    for k, v in pairs(Shared.Documents) do
      if v.restriction.citizenid.enable and checkCitizenid(v.restriction.citizenid.id, data) then
        table.insert(PrivateDocumentsCreate, {
          title = k,
          description = v.description,
          event = "ap-documents:client:openDocument",
          args = {doc = Shared.Documents[k], type = true}
        })   
      end
    end
    table.insert(PrivateDocumentsCreate, {
      title = "Back",
      description = "Back to restricted Documents.",
      event = "ap-documents:client:restrictedDocuments",
      args = data
    }) 
    ContextMenu({
      id = 'PrivateDocumentsCreate',
      title = "Private Document Types",
      options = PrivateDocumentsCreate
    })
  end
end)

showDialog = function(documentTable)
  if Config.Dialog.QB then
    local dialog = exports[Config.ExportNames.input]:ShowInput({
		header = "Document Information",
		submitText = "Create Document",
		inputs = {
			{
				text = "Document Name",
				name = "name",
				type = "text",
				isRequired = true
			},
			{
				text = "Document Type",
				name = "type",
				type = "text",
				isRequired = true
			}
		}
	})
	
	if dialog ~= nil then
	  TriggerServerEvent('ap-documents:server:createDocument', dialog.name, dialog.type, documentTable)
	end    
  elseif Config.Dialog.OX then
    local input = lib.inputDialog('Document Information', {
      {type = 'input', label = 'Document Name', required = true},
      {type = 'input', label = 'Document Type', required = true}
    })
    if input ~= nil then
      TriggerServerEvent('ap-documents:server:createDocument', input[1], input[2], documentTable)
    end
  end
end
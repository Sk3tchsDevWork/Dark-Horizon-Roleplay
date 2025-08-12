---@meta

---**`Framework` `server`**
---#### Framework Module
---@class FrameworkServer : Framework
Framework = {}

---**`Framework` `server`**
---[Documentation](https://dev.reflow-store.com/bridge/framework/server#createcallback)
---
---#### Function Creates Server Callback
---
---```lua
---Framework.CreateCallback('servercallbackname', function(source, cb, value1, value2)
---    cb(value1, value2)
---end
---```
---
---@param name string 
---@param cb fun(source: number, cb : function, ...)
function Framework.CreateCallback(name, cb) end

---**`Framework` `server`**
---[Documentation](https://dev.reflow-store.com/bridge/framework/server#triggercallback)
---
---#### Function Triggers Client Callback
---
---```lua
---Framework.TriggerCallback(source, 'clientcallbackname', function(result1, result2)
---    print(result1, result2)
---end, value1, value2)
---```
---
---@param source number 
---@param name string 
---@param cb fun(...)
function Framework.TriggerCallback(source, name, cb, ...) end

---**`Framework` `server`**
---[Documentation](https://dev.reflow-store.com/bridge/framework/server#triggercallbackawait)
---
---#### Function Triggers Client Callback Await
---
---```lua
---local result1, result2 = Framework.TriggerCallback.Await(source, 'clientcallbackname', value1, value2)
---```
---
---@param source number 
---@param name string 
---@return ...
function Framework.TriggerCallback.Await(source, name, ...) end

---**`Framework` `server`**
---[Documentation](https://dev.reflow-store.com/bridge/framework/server#createuseableitem)
---
---#### Creates A Useable item
---
---```lua
---Framework.CreateUseableItem('itemname', function(source, item, data)
---    -- Item Is Useable
---end)
---```
---
---@param name string 
---@param cb fun(source: number, item: string, data: { weight : number, count : number, slot: number, name: string, metadata: table, label: string })
function Framework.CreateUseableItem(name, cb) end

---**`Framework` `server`**
---[Documentation](https://dev.reflow-store.com/bridge/framework/server#getplayer)
---
---#### Get Player
---
---```lua
---Framework.GetPlayer(source)
---```
---
---@param source number 
---@return PlayerServer | nil
function Framework.GetPlayer(source) end

---**`Framework` `server`**
---[Documentation](https://dev.reflow-store.com/bridge/framework/server#getplayerbyidentifier)
---
---#### Get Player By Identifier
---
---```lua
---Framework.GetPlayerByIdentifier(identifier)
---```
---
---@param identifier string 
---@return PlayerServer | nil
function Framework.GetPlayerByIdentifier(identifier) end

---**`Framework` `server`**
---[Documentation](https://dev.reflow-store.com/bridge/framework/server#jobs)
---
---#### Get Jobs
---
---```lua
---Framework.Jobs()
---```
---
---@return { [string]: Job }
function Framework.Jobs() end

---**`Framework` `server`**
---[Documentation](https://dev.reflow-store.com/bridge/framework/server#doesjobexist)
---
---#### Check If A Job Exist
---
---```lua
---Framework.DoesJobExist('jobname', 0)
---```
---
---@param job string 
---@param grade string | number
---@return boolean
function Framework.DoesJobExist(job, grade) end

---**`Framework` `server`**
---[Documentation](https://dev.reflow-store.com/bridge/framework/server#doesgangexist)
---
---#### Check If A Gang Exist
---
---```lua
---Framework.DoesGangExist('gangname', 0)
---```
---
---@param gang string 
---@param grade string | number
---@return boolean
function Framework.DoesGangExist(gang, grade) end

---**`Framework` `server`**
---[Documentation](https://dev.reflow-store.com/bridge/framework/server#registersociety)
---
---#### Register Society
---
---```lua
---Framework.RegisterSociety('police', 'job')
---```
---
---@param name string 
---@param type "job" | "gang"
function Framework.RegisterSociety(name, type) end

---**`Framework` `server`**
---[Documentation](https://dev.reflow-store.com/bridge/framework/server#societygetmoney)
---
---#### Get Money From Society
---
---```lua
---Framework.SocietyGetMoney('police', 'job')
---```
---
---@param name string 
---@param type "job" | "gang"
---@return number
function Framework.SocietyGetMoney(name, type) end

---**`Framework` `server`**
---[Documentation](https://dev.reflow-store.com/bridge/framework/server#societyaddmoney)
---
---#### Add Money To Society
---
---```lua
---Framework.SocietyAddMoney('police', 'job', 100)
---```
---
---@param name string 
---@param type "job" | "gang"
---@param amount number
---@return boolean
function Framework.SocietyAddMoney(name, type, amount) end

---**`Framework` `server`**
---[Documentation](https://dev.reflow-store.com/bridge/framework/server#societyremovemoney)
---
---#### Remove Money From Society
---
---```lua
---Framework.SocietyRemoveMoney('police', 'job', 100)
---```
---
---@param name string 
---@param type "job" | "gang"
---@param amount number
---@return boolean
function Framework.SocietyRemoveMoney(name, type, amount) end

---**`Framework` `server`**
---[Documentation](https://dev.reflow-store.com/bridge/framework/server#notify)
---
---#### Show Notification Message
---
---```lua
---Framework.Notify(source, 'My Notification Message', 'info', 5000)
---```
---
---@param source number 
---@param message string
---@param type "info" | "success" | "error"
---@param length number
function Framework.Notify(source, message, type, length) end

---**`Framework` `server`**
---[Documentation](https://dev.reflow-store.com/bridge/framework/server#isplayerdead)
---
---#### Check If Player Is Dead
---
---```lua
---Framework.IsPlayerDead(source)
---```
---
---@param source number
---@return boolean
function Framework.IsPlayerDead(source) end

---**`Framework` `server`**
---[Documentation](https://dev.reflow-store.com/bridge/framework/server#haspermission)
---
---#### Check If A Player Has Specific Permissions
---
---```lua
---Framework.HasPermission(source, "admin")
---```
---
---@param source number
---@param permission string | table
---@return boolean
function Framework.HasPermission(source, permission) end

---**`Framework` `server`**
---[Documentation](https://dev.reflow-store.com/bridge/framework/server#spawnvehicle)
---
---#### Function Spawns Vehicle
---
---```lua
---local netid = Framework.SpawnVehicle('dominator', vector4(0, 0, 0, 0))
---```
---
---@param model number | string
---@param coords vector3 | vector4
---@return number netid, number entity
function Framework.SpawnVehicle(model, coords, warp) end
---@meta

---**`Framework` `client`**
---#### Framework Module
---@class FrameworkClient
---**`Framework` `client`**
---[Documentation](https://dev.reflow-store.com/bridge/framework/client#player)
---
---#### Get Player
---
---**`client`** 
---```lua
---Framework.Player
---```
---
---@field Player PlayerClient
Framework = {}

---**`Framework` `client`**
---[Documentation](https://dev.reflow-store.com/bridge/framework/client#createcallback)
---
---#### Function Creates Client Callback
---
---```lua
---Framework.CreateCallback('clientcallbackname', function(cb, value1, value2)
---    cb(value1, value2)
---end
---```
---
---@param name string 
---@param cb fun(cb : function, ...)
function Framework.CreateCallback(name, cb) end

---**`Framework` `client`**
---[Documentation](https://dev.reflow-store.com/bridge/framework/client#triggercallback)
---
---#### Function Triggers Server Callback
---
---```lua
---Framework.TriggerCallback('servercallbackname', function(result1, result2)
---    print(result1, result2)
---end, value1, value2)
---```
---
---@param name string 
---@param cb fun(...)
function Framework.TriggerCallback(name, cb, ...) end

---**`Framework` `client`**
---[Documentation](https://dev.reflow-store.com/bridge/framework/client#triggercallbackawait)
---
---#### Function Triggers Server Callback Await
---
---```lua
---local result1, result2 = Framework.TriggerCallback.Await('servercallbackname', value1, value2)
---```
---
---@param name string 
---@return ...
function Framework.TriggerCallback.Await(name, ...) end

---**`Framework` `client`**
---[Documentation](https://dev.reflow-store.com/bridge/framework/client#spawnvehicle)
---
---#### Function Spawns Vehicle
---
---```lua
---Framework.SpawnVehicle(function(netid)
---    local vehicle = NetToVeh(netid)
---    SetVehicleNumberPlateText(vehicle, 'MYPLATE')
---end, 'dominator')
---```
---
---@param cb fun(netid : number)
---@param model number | string
---@param coords? vector3 | vector4
---@param warp? boolean
function Framework.SpawnVehicle(cb, model, coords, warp) end

---**`Framework` `client`**
---[Documentation](https://dev.reflow-store.com/bridge/framework/client#toggleduty)
---
---#### Toggle Job Duty
---
---```lua
---Framework.ToggleDuty()
---```
---
function Framework.ToggleDuty() end

---**`Framework` `client`**
---[Documentation](https://dev.reflow-store.com/bridge/framework/client#notify)
---
---#### Show Notification Message
---
---```lua
---Framework.Notify('My Notification Message', 'info', 5000)
---```
---
---@param message string
---@param type "info" | "success" | "error"
---@param length number
function Framework.Notify(message, type, length) end

---**`Framework` `client`**
---[Documentation](https://dev.reflow-store.com/bridge/framework/client#isplayerdead)
---
---#### Check If Player Is Dead
---
---```lua
---Framework.IsPlayerDead()
---```
---
---@return boolean
function Framework.IsPlayerDead() end

---**`Framework` `client`**
---[Documentation](https://dev.reflow-store.com/bridge/framework/client#getstatus)
---
---#### Get Player Status
---
---```lua
---Framework.GetStatus('hunger')
---```
---
---@param key string
---@return number
function Framework.GetStatus(key) end

---**`Framework` `client`**
---[Documentation](https://dev.reflow-store.com/bridge/framework/client#opensociety)
---
---#### Open Society Menu
---
---```lua
---Framework.OpenSociety('police', 'job')
---```
---
---@param name string
---@param type "job" | "gang"
function Framework.OpenSociety(name, type) end
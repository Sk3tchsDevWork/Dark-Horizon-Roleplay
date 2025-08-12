---@meta

---**`Utilities` `client`**
---[Documentation](https://dev.reflow-store.com/bridge/utilities/client#loadmodel)
---
---#### Load a model when called from a thread it will yield until loaded
---
---@param model number | string 
function Framework.LoadModel(model) end

---**`Utilities` `client`**
---[Documentation](https://dev.reflow-store.com/bridge/utilities/client#loadanimdict)
---
---#### Load a animation dictionary when called from a thread it will yield until loaded
---
---@param animDict string 
function Framework.LoadAnimDict(animDict) end

---**`Utilities` `client`**
---[Documentation](https://dev.reflow-store.com/bridge/utilities/client#loadanimset)
---
---#### Load a animation clipset when called from a thread it will yield until loaded
---
---@param animSet string 
function Framework.LoadAnimSet(animSet) end

---**`Utilities` `client`**
---[Documentation](https://dev.reflow-store.com/bridge/utilities/client#loadambientaudiobank)
---
---#### Load a ambient audio bank when called from a thread it will yield until loaded
---
---@param bank string 
function Framework.LoadAmbientAudioBank(bank) end

---**`Utilities` `client`**
---[Documentation](https://dev.reflow-store.com/bridge/utilities/client#loadmissionaudiobank)
---
---#### Load a mission audio bank when called from a thread it will yield until loaded
---
---@param bank string 
function Framework.LoadMissionAudioBank(bank) end

---**`Utilities` `client`**
---[Documentation](https://dev.reflow-store.com/bridge/utilities/client#loadscriptaudiobank)
---
---#### Load a script audio bank when called from a thread it will yield until loaded
---
---@param bank string 
function Framework.LoadScriptAudioBank(bank) end

---**`Utilities` `client`**
---[Documentation](https://dev.reflow-store.com/bridge/utilities/client#loadparticledict)
---
---#### Load a particle dictionary when called from a thread it will yield until loaded
---
---@param bank string 
function Framework.LoadParticleDict(bank) end

---**`Utilities` `client`**
---[Documentation](https://dev.reflow-store.com/bridge/utilities/client#getpeds)
---
---#### Get the Game Ped Pool
---
function Framework.GetPeds() end

---**`Utilities` `client`**
---[Documentation](https://dev.reflow-store.com/bridge/utilities/client#getobjects)
---
---#### Get the Game Object Pool
---
function Framework.GetObjects() end

---**`Utilities` `client`**
---[Documentation](https://dev.reflow-store.com/bridge/utilities/client#getvehicles)
---
---#### Get the Game Vehicle Pool
---
function Framework.GetVehicles() end

---**`Utilities` `client`**
---[Documentation](https://dev.reflow-store.com/bridge/utilities/client#getpickups)
---
---#### Get the Game Pickup Pool
---
function Framework.GetPickups() end

---**`Utilities` `client`**
---[Documentation](https://dev.reflow-store.com/bridge/utilities/client#getclosestped)
---
---#### Get the ped and coords closest to set coords and distance
---@param coords vector3 
---@param distance? number
---@return number?, vector3?
function Framework.GetClosestPed(coords, distance) end

---**`Utilities` `client`**
---[Documentation](https://dev.reflow-store.com/bridge/utilities/client#getclosestplayer)
---
---#### Get the player, ped and coords closest to set coords and distance
---@param coords vector3 
---@param distance? number
---@param includeLocal? boolean
---@return number?, number?, vector3?
function Framework.GetClosestPlayer(coords, distance, includeLocal) end

---**`Utilities` `client`**
---[Documentation](https://dev.reflow-store.com/bridge/utilities/client#getclosestobject)
---
---#### Get the object and coords closest to set coords and distance
---@param coords vector3 
---@param distance? number
---@return number?, vector3?
function Framework.GetClosestObject(coords, distance) end

---**`Utilities` `client`**
---[Documentation](https://dev.reflow-store.com/bridge/utilities/client#getclosestvehicle)
---
---#### Get the vehicle and coords closest to set coords and distance
---@param coords vector3 
---@param distance? number
---@param includeLocal? boolean
---@return number?, vector3?
function Framework.GetClosestVehicle(coords, distance, includeLocal) end

---**`Utilities` `client`**
---[Documentation](https://dev.reflow-store.com/bridge/utilities/client#getclosestpickup)
---
---#### Get the pickup and coords closest to set coords and distance
---@param coords vector3 
---@param distance? number
---@return number?, vector3?
function Framework.GetClosestPickup(coords, distance) end

---**`Utilities` `client`**
---[Documentation](https://dev.reflow-store.com/bridge/utilities/client#getnearbypeds)
---
---#### Get all peds and coords in range of set coords and distance
---@param coords vector3 
---@param distance? number
---@return { ped : number, coords : vector3 }[]
function Framework.GetNearbyPeds(coords, distance) end

---**`Utilities` `client`**
---[Documentation](https://dev.reflow-store.com/bridge/utilities/client#getnearbyplayers)
---
---#### Get all players, peds and coords in range of set coords and distance
---@param coords vector3 
---@param distance? number
---@param includeLocal? boolean
---@return { id : number, ped : number, coords : vector3 }[]
function Framework.GetNearbyPlayers(coords, distance, includeLocal) end

---**`Utilities` `client`**
---[Documentation](https://dev.reflow-store.com/bridge/utilities/client#getnearbyobjects)
---
---#### Get all objects and coords in range of set coords and distance
---@param coords vector3 
---@param distance? number
---@return { object : number, coords : vector3 }[]
function Framework.GetNearbyObjects(coords, distance) end

---**`Utilities` `client`**
---[Documentation](https://dev.reflow-store.com/bridge/utilities/client#getnearbyvehicles)
---
---#### Get all vehicles and coords in range of set coords and distance
---@param coords vector3 
---@param distance? number
---@param includeLocal? boolean
---@return { vehicle : number, coords : vector3 }[]
function Framework.GetNearbyVehicles(coords, distance, includeLocal) end

---**`Utilities` `client`**
---[Documentation](https://dev.reflow-store.com/bridge/utilities/client#getnearbypickups)
---
---#### Get all pickups and coords in range of set coords and distance
---@param coords vector3 
---@param distance? number
---@return { pickup : number, coords : vector3 }[]
function Framework.GetNearbyPickups(coords, distance) end

---ProgressBar Options
---@class ProgressBarOptions
---@field duration number
---@field label string
---@field canCancel? boolean
---@field useWhileDead? boolean
---@field anim? { dict? : string, clip? : string, flag? : number, scenario? : string }
---@field disable? {move? : boolean, vehicle? : boolean, combat? : boolean, mouse? : boolean }
---@field props? { model : string, bone? : number, pos : vector3, rot : vector3 }[] | { model : string, bone? : number, pos : vector3, rot : vector3 }
---@field onFinish? fun()
---@field onCancel? fun()

---**`Utilities` `client`**
---[Documentation](https://dev.reflow-store.com/bridge/utilities/client#progressbar)
---
---#### Displays a running progress bar
---@param data ProgressBarOptions
function Framework.ProgressBar(data) end

---**`Utilities` `client`**
---[Documentation](https://dev.reflow-store.com/bridge/utilities/client#networkrequestcontrolofnetworkid)
---
---#### Request network control of network id
---@param netid number
function Framework.NetworkRequestControlOfNetworkId(netid) end

---**`Utilities` `client`**
---[Documentation](https://dev.reflow-store.com/bridge/utilities/client#networkrequestcontrolofentity)
---
---#### Request network control of entity
---@param entity number
function Framework.NetworkRequestControlOfEntity(entity) end

---**`Utilities` `client`**
---[Documentation](https://dev.reflow-store.com/bridge/utilities/client#networkrequestcontrolofdoor)
---
---#### Request network control of door
---@param entity number
function Framework.NetworkRequestControlOfDoor(entity) end
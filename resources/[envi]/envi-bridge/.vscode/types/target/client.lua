---@meta

---**`Target` `client`**
---#### Target Module
---@class Target
Target = {}

---**`Target` `client`**
---#### Target Options
---@class TargetOptions
---@field label string
---@field icon? string
---@field distance? number
---@field job? string | string[] | table<string, number>
---@field gang? string | string[] | table<string, number>
---@field items? string | string[] | table<string, number>
---@field canInteract? fun(entity?: number, coords?: vector3, distance?: number, data?: table) : boolean
---@field onSelect? fun(data?: { entity: number, coords: vector3, distance: number, [string]: any })
---@field export? string
---@field event? string
---@field serverEvent? string
---@field command? string
---@field [string] any

---**`Target` `client`**
---#### Target Box Zone Options
---@class TargetBoxZoneOptions
---@field debug? boolean
---@field name string
---@field coords vector3
---@field size vector3
---@field rotation number
---@field options TargetOptions[]

---**`Target` `client`**
---#### Target Poly Zone Options
---@class TargetPolyZoneOptions
---@field debug? boolean
---@field name string
---@field height? number
---@field points vector3[]
---@field options TargetOptions[]

---**`Target` `client`**
---#### Target Sphere Zone Options
---@class TargetSphereZoneOptions
---@field debug? boolean
---@field name string
---@field coords vector3
---@field radius number
---@field options TargetOptions[]

---**`Target` `client`**
---[Documentation](https://dev.reflow-store.com/bridge/target#disabletarget)
---
---#### Disables target
---
---@param state boolean
function Target.DisableTarget(state) end

---**`Target` `client`**
---[Documentation](https://dev.reflow-store.com/bridge/target#addglobalobject)
---
---#### Create Global Object Target
---
---@param options TargetOptions[]
function Target.AddGlobalObject(options) end

---**`Target` `client`**
---[Documentation](https://dev.reflow-store.com/bridge/target#removeglobalobject)
---
---#### Remove Global Object Target
---
---@param labels string | string[]
function Target.RemoveGlobalObject(labels) end

---**`Target` `client`**
---[Documentation](https://dev.reflow-store.com/bridge/target#addglobalped)
---
---#### Create Global Ped Target
---
---@param options TargetOptions[]
function Target.AddGlobalPed(options) end

---**`Target` `client`**
---[Documentation](https://dev.reflow-store.com/bridge/target#removeglobalped)
---
---#### Remove Global Ped Target
---
---@param labels string | string[]
function Target.RemoveGlobalPed(labels) end

---**`Target` `client`**
---[Documentation](https://dev.reflow-store.com/bridge/target#addglobalplayer)
---
---#### Create Global Player Target
---
---@param options TargetOptions[]
function Target.AddGlobalPlayer(options) end

---**`Target` `client`**
---[Documentation](https://dev.reflow-store.com/bridge/target#removeglobalplayer)
---
---#### Remove Global Player Target
---
---@param labels string | string[]
function Target.RemoveGlobalPlayer(labels) end

---**`Target` `client`**
---[Documentation](https://dev.reflow-store.com/bridge/target#addglobalvehicle)
---
---#### Create Global Vehicle Target
---
---@param options TargetOptions[]
function Target.AddGlobalVehicle(options) end

---**`Target` `client`**
---[Documentation](https://dev.reflow-store.com/bridge/target#removeglobalvehicle)
---
---#### Remove Global Vehicle Target
---
---@param labels string | string[]
function Target.RemoveGlobalVehicle(labels) end

---**`Target` `client`**
---[Documentation](https://dev.reflow-store.com/bridge/target#addmodel)
---
---#### Create Model Target
---
---@param models number | string | table<number | string>
---@param options TargetOptions[]
function Target.AddModel(models, options) end

---**`Target` `client`**
---[Documentation](https://dev.reflow-store.com/bridge/target#removemodel)
---
---#### Remove Model Target
---
---@param models number | string | table<number | string>
---@param labels string | string[]
function Target.RemoveModel(models, labels) end

---**`Target` `client`**
---[Documentation](https://dev.reflow-store.com/bridge/target#addentity)
---
---#### Create Model Target
---
---@param entities number | table<number>
---@param options TargetOptions[]
function Target.AddEntity(entities, options) end

---**`Target` `client`**
---[Documentation](https://dev.reflow-store.com/bridge/target#removeentity)
---
---#### Remove Model Target
---
---@param entities number | table<number>
---@param labels string | string[]
function Target.RemoveEntity(entities, labels) end

---**`Target` `client`**
---[Documentation](https://dev.reflow-store.com/bridge/target#addbone)
---
---#### Create Bone Target
---
---@param bones string | table<string>
---@param options TargetOptions[]
function Target.AddBone(bones, options) end

---**`Target` `client`**
---[Documentation](https://dev.reflow-store.com/bridge/target#removebone)
---
---#### Remove Bone Target
---
---@param bones string | table<string>
---@param labels string | string[]
function Target.RemoveBone(bones, labels) end

---**`Target` `client`**
---[Documentation](https://dev.reflow-store.com/bridge/target/boxzone)
---
---#### Creates Targetable BoxZone
---
---@param data TargetBoxZoneOptions
function Target.AddBoxZone(data) end

---**`Target` `client`**
---[Documentation](https://dev.reflow-store.com/bridge/target/polyzone)
---
---#### Creates Targetable PolyZone
---
---@param data TargetPolyZoneOptions
function Target.AddPolyZone(data) end

---**`Target` `client`**
---[Documentation](https://dev.reflow-store.com/bridge/target/spherezone)
---
---#### Creates Targetable SphereZone
---
---@param data TargetSphereZoneOptions
function Target.AddSphereZone(data) end

---**`Target` `client`**
---[Documentation](https://dev.reflow-store.com/bridge/target#removezone)
---
---#### Removes a target zone
---
---@param id number | string
function Target.RemoveZone(id) end
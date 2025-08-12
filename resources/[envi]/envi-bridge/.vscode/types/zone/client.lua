---@meta

---**`Zone` `client`**
---#### Zone Module
---@class Zone
Zone = {}

---@class CZone
---@field id number
---@field coords fun() : vector3
---@field distance fun() : number
---@field remove fun()
---@field contains fun(coords: vector3): boolean
---@field [string] any

---@class BoxZone
---@field debug? boolean
---@field coords vector3
---@field size vector3
---@field rotation number
---@field onEnter? fun(self: CZone)
---@field onExit? fun(self: CZone)
---@field inside? fun(self: CZone)
---@field [string] any
---@return CZone

---@class PolyZone
---@field debug? boolean
---@field height? number
---@field points vector3[]
---@field onEnter? fun(self: CZone)
---@field onExit? fun(self: CZone)
---@field inside? fun(self: CZone)
---@field [string] any
---@return CZone

---@class SphereZone
---@field debug? boolean
---@field coords vector3
---@field radius number
---@field onEnter? fun(self: CZone)
---@field onExit? fun(self: CZone)
---@field inside? fun(self: CZone)
---@field [string] any
---@return CZone

---**`Zone` `client`**
---[Documentation](https://dev.reflow-store.com/bridge/zone/boxzone)
---
---#### Creates BoxZone
---
---@param data BoxZone
function Zone.BoxZone(data) end

---**`Zone` `client`**
---[Documentation](https://dev.reflow-store.com/bridge/zone/polyzone)
---
---#### Creates PolyZone
---
---@param data PolyZone
function Zone.PolyZone(data) end

---**`Zone` `client`**
---[Documentation](https://dev.reflow-store.com/bridge/zone/spherezone)
---
---#### Creates SphereZone
---
---@param data SphereZone
function Zone.SphereZone(data) end
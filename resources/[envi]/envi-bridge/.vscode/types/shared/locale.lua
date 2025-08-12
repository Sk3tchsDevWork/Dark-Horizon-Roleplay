---@meta

---**`Framework` `server` `client`**
---[Documentation](https://dev.reflow-store.com/bridge/framework/locale#locales)
---
---#### Get Language Table
---
---```lua
---Framework.Locales()
---```
---
---@return table
function Framework.Locales() end

---**`Framework` `server` `client`**
---[Documentation](https://dev.reflow-store.com/bridge/framework/locale#locale)
---
---#### Get Specific Language String
---
---```lua
---Framework.Locale('mykey', {  myvalue = 'My Value' })
---```
---
---@param key string 
---@param params table
---@return string
function Framework.Locale(key, params) end
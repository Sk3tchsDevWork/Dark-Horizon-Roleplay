---@meta

---Creates a deep copy of a table, including all nested tables and their contents
---@param tbl table
---@return table
function table.deepclone(tbl) end

---@param tbl1 any
---@param tbl2 any
---@return boolean
---Compares if two values are equal, iterating over tables and matching both keys and values.
function table.matches(tbl1, tbl2) end

---@param tbl1 any
---@param tbl2 any
---@return boolean
---Checks if tbl1 contains the given values.
function table.contains(tbl1, tbl2) end

---@param tbl1 any
---@param tbl2 any
---@return table
---Checks if tbl1 contains the given values.
function table.merge(tbl1, tbl2) end
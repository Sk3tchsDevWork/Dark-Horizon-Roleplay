if Config.Framework ~= "standalone" then
    return
end

---@param source number
---@param amount integer
---@return boolean
function RemoveMoney(source, amount)
    return true
end

---@param billerIdentifier string
---@param billedIdentifier string
---@param job "police" | "ambulance"
---@param amount number
---@param reason? string
---@return boolean success
function FrameworkBillPlayer(billerIdentifier, billedIdentifier, job, amount, reason)
    return true
end

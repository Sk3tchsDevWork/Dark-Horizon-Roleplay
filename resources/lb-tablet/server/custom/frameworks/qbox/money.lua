if Config.Framework ~= "qbox" then
    return
end

while not QB do
    Wait(0)
end

---@param source number
---@return integer
function GetBalance(source)
    local qPlayer = QB.Functions.GetPlayer(tonumber(source))

    if not qPlayer then
        return 0
    end

    return qPlayer.Functions.GetMoney("bank") or 0
end

---@param source any
---@param amount integer
---@return boolean
function AddMoney(source, amount)
    local qPlayer = QB.Functions.GetPlayer(source)
    if not qPlayer or amount < 0 then
        return false
    end

    qPlayer.Functions.AddMoney("bank", math.floor(amount + 0.5), "Tablet")
    return true
end

---@param source any
---@param amount integer
---@return boolean
function RemoveMoney(source, amount)
    if amount < 0 or GetBalance(source) < amount then
        return false
    end

    local qPlayer = QB.Functions.GetPlayer(tonumber(source))

    if not qPlayer then
        return false
    end

    qPlayer.Functions.RemoveMoney("bank", math.floor(amount + 0.5), "Tablet")

    return true
end

---@param billerIdentifier string
---@param billedIdentifier string
---@param job "police" | "ambulance"
---@param amount number
---@param reason? string
---@return boolean success
function FrameworkBillPlayer(billerIdentifier, billedIdentifier, job, amount, reason)
    local target = QB.Functions.GetPlayerByCitizenId(billedIdentifier)

    if not target then
        return false
    end

    target.Functions.RemoveMoney("bank", amount, "paid-bills")

    exports["Renewed-Banking"]:addAccountMoney(job, amount)

    return true
end

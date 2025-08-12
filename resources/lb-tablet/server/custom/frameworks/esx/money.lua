if Config.Framework ~= "esx" then
    return
end

while not ESX do
    Wait(500)
end

---@param source number
---@param amount integer
---@return boolean
function RemoveMoney(source, amount)
    local xPlayer = ESX.GetPlayerFromId(source)

    if not xPlayer or amount < 0 or xPlayer.getAccount("bank").money < amount then
        return false
    end

    xPlayer.removeAccountMoney("bank", amount)

    return true
end

---@param billerIdentifier string
---@param billedIdentifier string
---@param job "police" | "ambulance"
---@param amount number
---@param reason? string
---@return boolean success
function FrameworkBillPlayer(billerIdentifier, billedIdentifier, job, amount, reason)
    local societyName = "society_" .. job

    exports.esx_billing:BillPlayerByIdentifier(billedIdentifier, billerIdentifier, societyName, reason or job, amount)

    return true
end

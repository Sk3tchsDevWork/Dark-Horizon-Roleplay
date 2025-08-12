---@param veh Vehicle
---@param amount number
function Functions.setFuel(veh, amount)
    if (FuelSystem == "ps-fuel") then return exports["ps-fuel"]:SetFuel(veh, amount) end
    if (FuelSystem == "OX") then Entity(veh).state.fuel = amount return end
    if (FuelSystem == "CDNFuel") then return exports["cdn-fuel"]:SetFuel(veh, amount) end

    SetVehicleFuelLevel(veh, amount)
end

return Functions.setFuel
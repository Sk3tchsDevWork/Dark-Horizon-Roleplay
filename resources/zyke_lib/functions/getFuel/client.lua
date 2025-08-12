---@param veh integer
---@return number
function Functions.getFuel(veh)
    if (FuelSystem == "ps-fuel") then return Functions.numbers.round(exports["ps-fuel"]:GetFuel(veh), 1) end
    if (FuelSystem == "OX") then return Functions.numbers.round(GetVehicleFuelLevel(veh), 1) end
    if (FuelSystem == "CDNFuel") then return Functions.numbers.round(exports["cdn-fuel"]:GetFuel(veh), 1) end

    return Functions.numbers.round(GetVehicleFuelLevel(veh), 1)
end

return Functions.getFuel
---@param item string
---@return CigaretteSettings | RefillableSettings | nil
function GetItemSettings(item)
    if (Config.Cigarettes[item]) then return Config.Cigarettes[item] end
    if (Config.Refillables[item]) then return Config.Refillables[item] end

    return nil
end

function AwaitLoader()
    while (not HasLoaderFinished) do
        Wait(10)
    end
end
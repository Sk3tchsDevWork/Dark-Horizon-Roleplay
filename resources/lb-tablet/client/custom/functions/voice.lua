local talking = false

function IsTalking()
    return MumbleIsPlayerTalking(PlayerId())
end

ReactCallback("isTalking", function()
    return IsTalking()
end)

local function ConvertProximityToUnits(proximity)
    return -0.3045 * proximity^2 + 5.016 * proximity - 2.5919
end

---@return number
function GetVoiceMaxDistance()
    local proximity = MumbleGetTalkerProximity()

    return ConvertProximityToUnits(proximity)
end

while true do
    Wait(100)

    local isTalking = IsTalking()

    if isTalking and not talking then
        talking = true

        SendReactMessage("camera:toggleMicrophone", talking)
    elseif not isTalking and talking then
        talking = false

        SendReactMessage("camera:toggleMicrophone", talking)
    end
end

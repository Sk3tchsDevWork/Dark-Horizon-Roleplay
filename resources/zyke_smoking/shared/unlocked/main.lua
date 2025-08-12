-- Checks if you are using zyke_status to enhance the effects (Free)
-- https://github.com/ZykeWasTaken/zyke_status

local zykeStatusResState = GetResourceState("zyke_status")

UsingStatus = false
if (zykeStatusResState == "started" or zykeStatusResState == "starting") then
    UsingStatus = true
end
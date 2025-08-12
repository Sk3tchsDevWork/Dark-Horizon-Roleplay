TargetUtils = {}

TargetUtils.loadModel = function(model)
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(0)
    end
end

TargetUtils.spawnPed = function(model, coords, freeze, invincible)
    TargetUtils.loadModel(model)
    local ped = CreatePed(4, model, coords.x, coords.y, coords.z, coords.w, false, false)
    FreezeEntityPosition(ped, freeze)
    TaskSetBlockingOfNonTemporaryEvents(ped, true)
    SetEntityInvincible(ped, invincible)
    return ped
end

TargetUtils.hasJob = function(playerJob, configJob)
    if type(configJob) == "string" then
        return playerJob.name == configJob
    elseif type(configJob) == "table" then
        return playerJob.name == configJob.name and playerJob.grade.level >= (configJob.grade or 0)
    end
    return false
end


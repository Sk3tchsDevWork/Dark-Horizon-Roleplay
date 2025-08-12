-- Used for av_business, we need a list of all available jobs on your server
jobsList = {}

function jobListCheck()
    if GetResourceState("av_business") == "missing" or GetResourceState("av_cameras") == "missing" then return end
    while not Core and not Config.Framework do Wait(10) end -- Wait for Core to load
    if Config.Framework == "qb" then
        if Core.Shared and Core.Shared.Jobs then
            for k, v in pairs(Core.Shared.Jobs) do
                jobsList[#jobsList + 1] = k
            end
        end
    end
    if Config.Framework == "qbox" then
        local jobs = exports.qbx_core:GetJobs()
        if jobs and next(jobs) then
            for k, v in pairs(jobs) do
                jobsList[#jobsList + 1] = k
            end
        end
    end
    if Config.Framework == "esx" then
        lib.callback('av_laptop:getJobs', false, function(data)
            if data and next(data) then
                for k, v in pairs(data) do
                    jobsList[#jobsList+1] = k
                end
            end
        end)
    end
end

function getJobs()
    dbug('getJobs()')
    while not Core do Wait(10) end
    if jobsList and next(jobsList) then
        dbug("return jobsList")
        return jobsList
    end
    if Config.Framework == "qb" then
        for k, v in pairs(Core.Shared.Jobs) do
            jobsList[#jobsList+1] = k
        end
    elseif Config.Framework == "qbox" then
        local jobs = exports.qbx_core:GetJobs()
        if jobs and next(jobs) then
            for k, v in pairs(jobs) do
                jobsList[#jobsList + 1] = k
            end
        end
    elseif Config.Framework == "esx" then
        local data = lib.callback.await('av_laptop:getJobs', false)
        for k, v in pairs(data) do
            jobsList[#jobsList+1] = k
        end
    end
    return jobsList
end

exports("getJobsList", function()
    dbug("getJobsList export")
    return getJobs()
end)
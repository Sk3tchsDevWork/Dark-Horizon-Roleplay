lib.callback.register('av_laptop:getJobs', function(source) -- returns a list of all available jobs in your ESX
    return Core.GetJobs()
end)
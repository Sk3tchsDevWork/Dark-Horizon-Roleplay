-- Notification
RegisterNetEvent('av_laptop:notification', function(title, description, type, position)
    lib.notify({
        title = title,
        description = description,
        type = type,
        position = position
    })
end)
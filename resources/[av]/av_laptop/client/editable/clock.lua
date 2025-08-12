AddEventHandler('av_weather:timeUpdated', function(hour,minutes,seconds)
    if LocalPlayer.state.inLaptop and Config.UseGameClock then
        SendNUIMessage({
            action = "clock",
            data = {
                hour = hour,
                minutes = minutes
            }
        })
    end
end)
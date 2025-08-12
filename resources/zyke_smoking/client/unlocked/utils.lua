function DisplayControls()
    AddTextEntry('helpNotification', CurrentControls)
    BeginTextCommandDisplayHelp('helpNotification')
    EndTextCommandDisplayHelp(0, false, false, -1)
end
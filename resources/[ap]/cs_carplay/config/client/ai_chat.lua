-- In-Built AI Chat Config --

CodeStudio.AI_Chat = {
    {
        Questions = {'hello', 'hi', 'welcome', 'hey there', 'greetings'},
        Answer = 'Hello! How can I assist you today?',
    },
    {
        Questions = {'What is the Discord for this server?', 'Discord for this server', 'What is the server Discord?'},
        Answer = 'The Discord for this server is CodeStudio',
    },
    {
        Questions = {'What is the Server Name?', 'Server Name', 'What is Server'},
        Answer = 'The Server is CodeStudio',
    },
    {
        Questions = {'Open Map', 'Show Map', 'Display Map'},
        Answer = 'Ok',
        CloseUI = true,
        action = function(entity)
            openMap() -- Your function here
        end
    },
    {
        Questions = {'Open All Doors', 'Open All Car Doors', 'Unlock All Doors'},
        Answer = 'Ok Opened All Doors',
        CloseUI = flash,
        action = function(entity)
            vehicleDoor('all')
        end
    },
    {
        Questions = {'Close All Doors', 'Close All Car Doors', 'Lock All Doors'},
        Answer = 'Ok Closed All Doors',
        CloseUI = flash,
        action = function(entity)
            vehicleDoor('closeall')
        end
    },
    {
        Questions = {'Open Hood', 'Open Car Hood'},
        Answer = 'Ok Hood is now open',
        action = function(entity)
            vehicleDoor(4)
        end
    },
    {
        Questions = {'Close Hood', 'Close Car Hood'},
        Answer = 'Ok Hood is now closed',
        action = function(entity)
            vehicleDoor(4)
        end
    },
    {
        Questions = {'Open Trunk', 'Open Car Trunk'},
        Answer = 'Ok Trunk is now open',
        action = function(entity)
            vehicleDoor(5)
        end
    },
    {
        Questions = {'Close Trunk', 'Close Car Trunk'},
        Answer = 'Ok Trunk is now closed',
        action = function(entity)
            vehicleDoor(5)
        end
    },
    {
        Questions = {'Engine Off', 'Turn Off Engine', 'Switch Off Engine'},
        Answer = 'Ok Engine is now off',
        action = function(entity)
            vehicleDoor('engineOff')
        end
    },
    {
        Questions = {'Car Name', 'Vehicle Name', 'What is my car name?'},
        Answer = 'Your Vehicle Name is: ' .. GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsIn(PlayerPedId()))),
    },
    {
        Questions = {'Play Music', 'Play this Music', 'Can you play this'},
        Answer = 'Ok Playing',
        MusicURL = true     --MusicURL = true: If this question contains music url it will play that
    },
}

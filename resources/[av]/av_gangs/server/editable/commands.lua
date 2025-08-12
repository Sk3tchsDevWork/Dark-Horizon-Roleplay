if Config.AdminCommand then
    lib.addCommand(Config.AdminCommand, {
        help = 'Gangs Admin Command',
        params = {},
        restricted = {'group.admin', 'group.god'}
    }, function(source)
        TriggerClientEvent('av_gangs:openAdmin',source)
    end)
end

if Config.ShellCommand then
    lib.addCommand(Config.ShellCommand, {
        help = 'Gangs Shell Command',
        params = {
            {
                name = "shell",
                type = "string",
                help = "Shell model"
            }
        },
        restricted = {'group.admin', 'group.god'}
    }, function(source,args)
        dbug('ShellCommand(model)', args['shell'])
        TriggerClientEvent('av_gangs:testShell', source, args['shell'])
    end)
end


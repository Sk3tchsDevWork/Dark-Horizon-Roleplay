Config = {}
Config.Debug = true
Config.AdminLevel = "admin" -- Admin rank needed to open admin menu
Config.AdminCommand = "admin:gangs" -- Admin menu command
Config.ShellCommand = "shell" -- Spawn test shell
Config.BlipsCommand = "gangs:blips" -- Command to show/hide gang territory on map, only gang members can use it
Config.PurityField = "purity" -- Metadata field name for drugs produced in lab
Config.ShowTerritoriesByDefault = true -- show/hide territories blips by default, gang members can use command to toggle it
Config.Target = exports['av_laptop']:getTarget()
Config.DailyLimitXP = 500 -- Max XP a gang can receive per server restart
Config.LevelXP = 2500 -- Needed XP points for level
Config.MaxMembers = 10 -- Max members a gang can have
Config.UseGangNPC = true -- If set to true, local NPCs will spawn as gang members; if false, default NPC models will remain.
Config.App = {
    name = "gang",
    label = "Gangs", -- You can rename the app by editing this field
    isEnabled = function()
        return exports['av_gangs']:getGang()
    end
}

function dbug(...)
    if Config.Debug then print ('^3[DEBUG]^7', ...) end
end
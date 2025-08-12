Config = {}

Config.Limit = 5 -- Maximum number of jobs a player can have, set to -1 for unlimited
Config.Command = 'multijob'
Config.UnemployedJob = 'unemployed' -- The name of the unemployed job
Config.HoursUpdateInterval = 10 * 60000
Config.UseBuiltinAccounts = true -- Will use qb-management or esx_society if set to false
Config.DefaultDuty = {
    Enabled = false, -- Uses last saved state if false
    State = false -- The default duty state after joining
}

-- ['add'/'replace']
-- 'add' = Adds the job to the slots and sets it as active (The previously active job will be removed if all of the slots are full)
-- 'replace' = Removes previously active job and adds the new one
Config.SetJobBehaviour = 'add'

Config.BossMenu = {
    -- Add all of your boss grades here
    Grades = {
        ['boss'] = true,
        ['staff1'] = true,
        ['staff2'] = true,
        ['staff3'] = true,
    },
    -- Whether to add new job or replace the current when hiring an employee
    HireBehaviour = 'add', -- ['add'/'replace']
    MaxHireDistance = 20.0,
    WeeklyGoal = {
        Default = 5, -- The default week hours goal for every grade
        Max = 20
    }
}

Config.Bonus = {
    Account = 'bank',
    Min = 100,
    Max = 50000
}

Config.Locations = {
    -- Example of adding locations, you can just replace your current boss menu for ease of use though
    ['unicorn'] = {
        vector3(421.4227, -961.8232, 29.3840),
    },
    -- ['sheriff'] = {
    --     vector3(0.0, 0.0, 0.0),
    --     vector3(0.0, 0.0, 0.0),
    -- },
}

if not IsDuplicityVersion() then
    lib.addKeybind({
        name = 'open_multijob',
        description = 'Opens the multijob menu',
        defaultMapper = 'keyboard',
        defaultKey = 'F5',
        onReleased = function()
            ExecuteCommand(Config.Command)
        end
    })
end
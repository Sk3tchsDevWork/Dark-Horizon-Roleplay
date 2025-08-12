Config = Config or {}
Config.UsePendrives = true -- true/false use pendrives as storage
Config.PendrivesItems = { -- Add as many as u want, they will all do the same
    ["pendrive"] = true,
}

Config.DeletePendrive = 10 -- After X days, if the memory isn't used at all it will removed from DB to avoid having too many info on table
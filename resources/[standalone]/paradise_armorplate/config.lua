Config = {}

Config.ArmorPlates = {
    criminal = {
        item = "armor_plate1",
        armorIncrease = 25,
        maxArmor = 75,
        useTime = 3000,
        jobs = nil
    },
    police = {
        item = "armor_plate2",
        armorIncrease = 35,
        maxArmor = 100,
        useTime = 2000,
        jobs = {
            ["police"] = true
        }
    }
}

Config.RequiredVest = "armor_vest"
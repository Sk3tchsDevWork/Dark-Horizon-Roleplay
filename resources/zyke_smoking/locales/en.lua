return {
    ["isOccupied"] = {msg = "You're already occupied with something else.", type = "error"},
    ["playerOccupied"] = {msg = "This player is already occupied with something else.", type = "error"},
    ["noItem"] = {msg = "You don't have the items for this.", type = "error"},
    ["notActive"] = {msg = "There's nothing to transfer.", type = "error"},
    ["noItemSettings"] = {msg = "There are no settings for this item.", type = "error"},
    ["noModel"] = {msg = "This model does not exist, %s.", type = "error"}, -- %s = model
    ["noLighter"] = {msg = "You are missing a lighter.", type = "error"},
    ["canNotUse"] = {msg = "You can't use this item right now.", type = "error"},
    ["noIdentifier"] = {msg = "Could not find an identifier for the player.", type = "error"},
    ["samePlayer"] = {msg = "This is the same player.", type = "error"},
    ["noPlayerClose"] = {msg = "There's no one close to you.", type = "error"},
    ["noAmountInPack"] = {msg = "This pack is empty.", type = "error"},
    ["armedWhenSmoking"] = {msg = "You can't smoke with a weapon out.", type = "error"},
    ["lighterEmpty"] = {msg = "The lighter is empty.", type = "error"},
    ["invalidAnim"] = {msg = "The animation you attempted to execute is invalid.", type = "error"},
    ["isDead"] = {msg = "You can not do this when you are dead.", type = "error"},
    ["inWater"] = {msg = "You can not do this while swimming.", type = "error"},
    ["unpackedCigarette"] = {msg = "You unpacked a %s."}, -- %s = item label
    ["noActiveItem"] = {msg = "There's nothing equipped.", type = "error"},
    ["invalidItem"] = {msg = "This is not a valid item.", type = "error"},
    ["noCartridgeInserted"] = {msg = "There's no cartridge inserted.", type = "error"},

    ["noAmountInBong"] = {msg = "Your bong is empty.", type = "error"},
    ["noWaterInBong"] = {msg = "You need to refill your bong with water.", type = "error"},

    ["noAmountInVape"] = {msg = "You don't have any flavour remaining.", type = "error"},
    ["noBattery"] = {msg = "Your vape has no battery.", type = "error"},
    ["installedNewBattery"] = {msg = "You installed a new battery.", type = "success"},

    -- Controls
    ["controls:hit:description"] = "Take Hit (Hold)",
    ["controls:switchPlacement:description"] = "Switch Cigarette Placement",
    ["controls:cancel:description"] = "Stop Using Item",
    ["controls:transferItem:description"] = "Transfer Item",

    ["cigarettePack:amount"] = "Remaining: %s", -- %s = amount
    ["lighter:description"] = "Fluid Remaining: %s%%", -- %s = amount
    ["vapeCartridge:description"] = "Remaining: %s%%", -- %s = amount

    -- Disclaimer
    ["disclaimer:header"] = "First Time Smoking?",
    ["disclaimer:defaultKeybinds"] = "Default keybinds",
    ["disclaimer:content"] = "Keybinds can be changed in your settings.",
    ["disclaimer:defaultHit"] = "%s Hit",
    ["disclaimer:defaultLight"] = "%s Light",
    ["disclaimer:defaultSwitchPlacement"] = "%s Switch Placement",
    ["disclaimer:defaultStop"] = "%s Stop",
    ["disclaimer:footer"] = "This pop-up will not show again."
}
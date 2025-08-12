Loc = Loc or {} 

Loc['en'] = {
    -- Client Side
    ["AlreadyPlacingBench"] = "You're already placing a bench!",
    ["InvalidPlacement"] = "Invalid item for placement!",
    ["MoveTooFar"] = "You moved too far from the placement area. Placement canceled.",
    ["PlacementCancel"] = "Placement cancelled. Your item was not removed.",
    ["PickUpTableTarget"] = "Pick Up Bench",

    -- Server Side
    ["MissingMaterials"] = "You are missing materials!",

    ["CraftedTitle"] = "Crafting Success",
    ["CraftedDesc"] = "You successfully crafted %sx %s!",
    ["EarnXPTitle"] = "Crafting XP Earned!",
    ["EarnXPDesc"] = "You've gained %s XP for your crafting skills!",

    -- Webhooks -- 

    -- Table Place
    ["PlacedTitle"] = "Bench Placed.",
    ["PlacedDesc"] = "%s Bench placed.",
    ["License"] = "License",
    ["PlayerId"] = "Player ID",
    ["Coords"] = "Coords",
    -- Table Craft
    ["CraftTitle"] = "Player has crafted an item",
    ["CraftDesc"] = "%s Crafted!",
    ["Bench"] = "Bench",
    ["ItemCrafted"] = "Item Crafted",
    ["QuantityCrafted"] = "Quantity Crafted",
    -- Table Pick up
    ["PickupTitle"] = "Player has picked up a bench",
    ["PickupDesc"] = "%s Picked Up!",

    -- Command
    ["SetlevelUsage"] = "Usage: /setcraftlevel [playerID] [XP]",
    ["NoPermissions"] = "You do not have permission to use this command!",

    -- Progressbars
    ["PBCraft"] = "Crafting...",
    ["PBPickup"] = "Picking up Bench..",
    ["PBPlace"] = "Placing bench..",

    ["NoBlueprint"] = "You don't have the blueprint for this item!",

    -- Tip Tool
    ['HoldR'] = '[Hold R] - Rotate Object  \n',
    ['ENTER'] = '[ENTER] - Place Object  \n',
    ['RightClick'] = '[Right Click] - Cancel Placement  \n',
}
Config = Config or {}
Config.PlaceSprayTime = 30 --in seconds
Config.RemoveSprayTime = 30 -- in seconds
Config.ProgressType = "progressCircle" -- "progressCircle" or "progressBar"
Config.RemoveDistance = 7 -- distance needed to remove a graffiti
Config.ZoneRadius = 109.0 -- Gang zone radius created around the spray, applies for both zone and blip.
Config.MinMembersForRemover = 1 -- Min members online to remove their graffiti
Config.SprayGivesXP = 500 -- Gang receives XP when creating a graffiti or false
Config.RemoveSprayGivesXP = 1000 -- Remove other Gang Spray will give you XP or false
Config.LoseGraffitiXP = 1000 -- If your graffiti is removed, you will lose XP or false
Config.ShopAccount = 'bank' -- Account used to pay for items
Config.SprayTime = 6 -- (hours) Time before the spray item becomes totally unusable
Config.RemoveSprayOnUse = true -- true it will remove spray item on use, player will lose the item even if he decides not to place the graffiti
Config.ItemNames = {
    spray = "spray", -- Used to apply graffiti
    remover = "spray_remover" -- Used to remove graffiti
}
Config.Prices = { ['spray'] = 1000, ['remover'] = 20000 }
Config.ItemCooldown = { -- Cooldown in hours, gangs can buy this item every X hours
    [Config.ItemNames['spray']] = 7,
    [Config.ItemNames['remover']] = 7,
}
Config.SprayMultiplier = 1.25 -- Multiplier for spray price (SprayPrice * SprayMultiplier * Graffitis Count)
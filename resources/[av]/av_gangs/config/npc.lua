Config = Config or {}
Config.SellItems = {
    ['meth1g'] = { -- item the npc can sell
        -- item name, and the min/max amount u will receive per item sold
        itemName = "money", amount = {min = 20, max = 50} -- qbcore uses money and esx cash
    },
}
Config.Slots = 5 -- amount of slots for gang member stash
Config.Weight = 10000 -- (10000 = 10kg) stash weight
Config.SellTime = 15 -- Every X minutes random npc gang will sell their items
Config.RobAccount = "cash" -- Your money account, used when you rob a gang member (cash for qbcore or money for esx)
Config.RobMoney = {min = 25, max = 100} -- Amount of money you can rob from a rival gang NPC
Config.GangLoseXP = 200 -- Removes XP from the npc gang
Config.GangWinsXP = 200 -- Adds XP to the gang of the player who robbed the rival NPC
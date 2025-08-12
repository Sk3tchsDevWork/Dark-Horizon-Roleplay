Loc = Loc or {} 

Loc['fr'] = {
    -- Client Side
    ["AlreadyPlacingBench"] = "Vous placez déjà un établi !",
    ["InvalidPlacement"] = "Objet invalide pour le placement !",
    ["MoveTooFar"] = "Vous vous êtes trop éloigné de la zone de placement. Placement annulé.",
    ["PlacementCancel"] = "Placement annulé. Votre objet n'a pas été supprimé.",
    ["PickUpTableTarget"] = "Ramasser l'établi",

    -- Server Side
    ["MissingMaterials"] = "Il vous manque des matériaux !",

    ["CraftedTitle"] = "Fabrication réussie",
    ["CraftedDesc"] = "Vous avez fabriqué avec succès %sx %s !",
    ["EarnXPTitle"] = "XP de fabrication gagnée !",
    ["EarnXPDesc"] = "Vous avez gagné %s XP pour vos compétences en fabrication !",

    -- Webhooks -- 

    -- Table Place
    ["PlacedTitle"] = "Établi placé.",
    ["PlacedDesc"] = "%s Établi placé.",
    ["License"] = "Licence",
    ["PlayerId"] = "ID du joueur",
    ["Coords"] = "Coordonnées",
    -- Table Craft
    ["CraftTitle"] = "Le joueur a fabriqué un objet",
    ["CraftDesc"] = "%s Fabriqué !",
    ["Bench"] = "Établi",
    ["ItemCrafted"] = "Objet fabriqué",
    ["QuantityCrafted"] = "Quantité fabriquée",
    -- Table Pick up
    ["PickupTitle"] = "Le joueur a ramassé un établi",
    ["PickupDesc"] = "%s Ramassé !",

    -- Command
    ["SetlevelUsage"] = "Utilisation : /setcraftlevel [ID joueur] [XP]",
    ["NoPermissions"] = "Vous n'avez pas la permission d'utiliser cette commande !",

    -- Progressbars
    ["PBCraft"] = "Fabrication en cours...",
    ["PBPickup"] = "Ramassage de l'établi...",
    ["PBPlace"] = "Placement de l'établi...",

    ["NoBlueprint"] = "Vous n'avez pas le plan pour cet objet!",

    -- Tip Tool
    ['HoldR'] = '[Maintenir R] - Faire pivoter l\'objet  \n',
    ['ENTER'] = '[ENTER] - Placer l\'objet  \n',
    ['RightClick'] = '[Clic droit] - Annuler le placement  \n',
}
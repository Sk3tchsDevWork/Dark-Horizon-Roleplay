Loc = Loc or {} 

Loc['de'] = {
    -- Client Side
    ["AlreadyPlacingBench"] = "Du platzierst bereits eine Werkbank!",
    ["InvalidPlacement"] = "Ungültiges Objekt für die Platzierung!",
    ["MoveTooFar"] = "Du bist zu weit vom Platzierungsbereich entfernt. Platzierung abgebrochen.",
    ["PlacementCancel"] = "Platzierung abgebrochen. Dein Gegenstand wurde nicht entfernt.",
    ["PickUpTableTarget"] = "Werkbank aufheben",

    -- Server Side
    ["MissingMaterials"] = "Dir fehlen Materialien!",

    ["CraftedTitle"] = "Herstellung Erfolgreich",
    ["CraftedDesc"] = "Du hast erfolgreich %sx %s hergestellt!",
    ["EarnXPTitle"] = "Handwerks-XP verdient!",
    ["EarnXPDesc"] = "Du hast %s XP für deine Handwerksfähigkeiten erhalten!",

    -- Webhooks -- 

    -- Table Place
    ["PlacedTitle"] = "Werkbank platziert.",
    ["PlacedDesc"] = "%s Werkbank platziert.",
    ["License"] = "Lizenz",
    ["PlayerId"] = "Spieler-ID",
    ["Coords"] = "Koordinaten",
    -- Table Craft
    ["CraftTitle"] = "Spieler hat einen Gegenstand hergestellt",
    ["CraftDesc"] = "%s Hergestellt!",
    ["Bench"] = "Werkbank",
    ["ItemCrafted"] = "Gegenstand hergestellt",
    ["QuantityCrafted"] = "Menge hergestellt",
    -- Table Pick up
    ["PickupTitle"] = "Spieler hat eine Werkbank aufgehoben",
    ["PickupDesc"] = "%s Aufgehoben!",

    -- Command
    ["SetlevelUsage"] = "Verwendung: /setcraftlevel [SpielerID] [XP]",
    ["NoPermissions"] = "Du hast keine Berechtigung, diesen Befehl zu benutzen!",

    -- Progressbars
    ["PBCraft"] = "Wird hergestellt...",
    ["PBPickup"] = "Werkbank wird aufgehoben...",
    ["PBPlace"] = "Werkbank wird platziert...",

    ["NoBlueprint"] = "Du hast den Bauplan für diesen Gegenstand nicht!",
    
    -- Tip Tool
    ['HoldR'] = '[Halte R] - Objekt drehen  \n',
    ['ENTER'] = '[ENTER] - Objekt platzieren  \n',
    ['RightClick'] = '[Rechtsklick] - Platzierung abbrechen  \n',
}
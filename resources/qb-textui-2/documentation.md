---
description: Lumo Text UI 2 Installation Document
---

# Installation
## How to use ?

## Creating Normal Zone (Only Client)
```lua
Put this on top of your client side and you don't need to do anything else. This is for classic cordinates

This is for spesific coord text-ui
CreateThread(function()
    exports['qb-textui-2']:create3DTextUI("qb-test", {
        coords = vector3(-1461.18, -31.48, 54.63),
        displayDist = 6.0,
        interactDist = 2.0,
        enableKeyClick = true, -- If true when you near it and click key it will trigger the event that you write inside triggerData
        keyNum = 38,
        key = "E",
        text = "Lumo Test",
        theme = "green", -- or red
        triggerData = {
            triggerName = "",
            args = {}
        }
    })
end)
```

## qb-core/client/drawtext.lua
```lua
    exports['qb-core']:DrawText() => exports["qb-textui-2"]:displayTextUI(text, position)

    exports['qb-core']:HideText() => exports["qb-textui-2"]:hideTextUI()

    exports['qb-core']:KeyPressed() => Dont change it

    exports['qb-core']:ChangeText() => exports['qb-textui-2']:changeText(text, position)
```
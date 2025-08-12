---@diagnostic disable: duplicate-doc-alias, duplicate-doc-field

/*  

    All of the types that might help you in creating jobs.
    You need to have this vscode plugin to get the code suggestions: https://marketplace.visualstudio.com/items?itemName=overextended.cfxlua-vscode
    Also make sure to open the whole lunar_unijob folder in vscode otherwise this file won't load into the language server.

*/

---@alias AnimProps { dict?: string, clip: string, flag?: number, blendIn?: number, blendOut?: number, duration?: number, playbackRate?: number, lockX?: boolean, lockY?: boolean, lockZ?: boolean, scenario?: string, playEnter?: boolean }

---@class AnimPropProps
---@field model string
---@field bone? number
---@field position vector3
---@field rotation vector3

---@class UsableItem
---@field progress string
---@field duration integer
---@field animation AnimProps?
---@field prop AnimPropProps | AnimPropProps | nil
---@field hunger integer?
---@field thirst integer?

---@alias LocationData vector3 | vector4

---@class Job
---@field name string
---@field label string
---@field type string? Only useful for QBCore
---@field defaultDuty boolean? Only useful for QBCore
---@field offDutyPay boolean? Only useful for QBCore
---@field whitelisted boolean? Only useful for ESX
---@field canWash boolean? Only useful for esx_society
---@field playerActions PlayerActions?
---@field vehicleActions VehicleActions?
---@field grades GradeData[]
---@field bossMenus BossMenu[]?
---@field blips BlipData[]?
---@field cloakrooms CloakroomData[]?
---@field collecting CollectingData[]?
---@field advancedCollecting AdvancedCollectingData[]?
---@field crafting CraftingData[]?
---@field garages GarageData[]?
---@field selling SellingData[]?
---@field shops ShopData[]?
---@field stashes StashData[]?
---@field alarms AlarmData[]?
---@field registers RegisterData[]?
---@field animationZones AnimationZoneData[]?
---@field musicPlayers MusicPlayerData[]?
---@field teleports TeleportData[]?

---@class GradeData
---@field name string
---@field label string
---@field salary integer
---@field bossActions boolean?

---@class ItemData
---@field name string
---@field count integer | { min: integer, max: integer }

---@class PlayerActions
---@field steal boolean?
---@field handcuff 'both' | 'handcuffs' | 'zipties' | false | nil
---@field drag boolean?
---@field carry boolean?
---@field tackle boolean?
---@field bill boolean | { item: string, removeAfterUse: boolean } | nil
---@field revive boolean | { item: string, removeAfterUse: boolean } | nil
---@field heal boolean | { item: string, removeAfterUse: boolean } | nil

---@class VehicleActions
---@field putInsideVehicle boolean?
---@field takeOutOfVehicle boolean?
---@field hijack boolean | { item: string, removeAfterUse: boolean } | nil
---@field repair boolean | { item: string, removeAfterUse: boolean } | nil
---@field clean boolean | { item: string, removeAfterUse: boolean } | nil
---@field impound boolean | { item: string, removeAfterUse: boolean } | nil

---@class AlarmData
---@field label string?
---@field target boolean?
---@field global boolean?
---@field radius number?
---@field cooldown integer The cooldown before triggering it again in milliseconds
---@field prop PropArgs | PropArgs[] | nil
---@field ped PedArgs | PedArgs[] | nil
---@field locations LocationData[]

---@class AnimationZoneData
---@field label string
---@field stop string? The stop action message
---@field icon string
---@field radius number?
---@field target boolean?
---@field duration integer?
---@field progress string? Duration needs to defined
---@field notify string?
---@field animation AnimProps
---@field animationProp AnimPropProps | AnimPropProps[] | nil
---@field checkOccupied boolean Checks whether the animation zone is already occupied by a player
---@field move boolean? Moves the player to the position
---@field back boolean? If it should teleport the player back to the original position
---@field disableFreeze boolean? Doesn't freeze the players position when set to true
---@field global boolean
---@field offset vector3? Offsets all of the locations by this value, added for ease of use
---@field locations LocationData[]

---@class BlipData
---@field coords vector3
---@field name string
---@field sprite integer
---@field size number
---@field color integer
---@field global boolean?

---@class BossMenu
---@field radius number?
---@field icon string?
---@field target boolean?
---@field prop PropArgs | PropArgs[] | nil
---@field ped PedArgs | PedArgs[] | nil
---@field locations LocationData[]

---@class CloakroomData
---@field radius number?
---@field target boolean?
---@field prop PropArgs | PropArgs[] | nil
---@field ped PedArgs | PedArgs[] | nil
---@field locations LocationData[]

---@class CollectingData
---@field label string?
---@field progress string
---@field icon string?
---@field radius number?
---@field duration integer
---@field items ItemData[]
---@field animation AnimProps?
---@field animationProp AnimProps | AnimPropProps[] | nil
---@field requiredItem string?
---@field max integer?
---@field recover integer?
---@field target boolean?
---@field prop PropArgs | PropArgs[] | nil
---@field ped PedArgs | PedArgs[] | nil
---@field locations LocationData[]

---@class AdvancedCollectingData
---@field label string?
---@field progress string
---@field icon string?
---@field radius number? Interaction radius
---@field duration integer
---@field items ItemData[]
---@field animation AnimProps?
---@field animationProp AnimProps | AnimPropProps[] | nil
---@field requiredItem string?
---@field propModel string | number
---@field interactionOffset vector3?
---@field target boolean?
---@field locations { coords: vector3, radius: number, interval: integer, maxSpawned: integer? }[]

---@class CraftingEntry
---@field label string?
---@field icon string?
---@field image string?
---@field blueprint string? The required blueprint
---@field duration integer
---@field progress string
---@field animation AnimProps? Deprecated
---@field animationProp AnimPropProps? Deprecated
---@field requiredItems { name: string, count: integer }[]
---@field giveItems { name: string, count: integer }[] 

---@class CraftingData
---@field label string?
---@field grade integer?
---@field icon string?
---@field radius number?
---@field entries CraftingEntry[]
---@field target boolean?
---@field animation AnimProps? Used instead of entry based animation
---@field animationProp AnimPropProps? Used instead of entry based animationProp
---@field prop PropArgs | PropArgs[] | nil
---@field ped PedArgs | PedArgs[] | nil
---@field locations LocationData[]

---@class GarageVehicleData
---@field model string
---@field label string?
---@field price integer?
---@field grade integer?
---@field props VehicleProperties?

---@class GarageLocationData
---@field coords vector3 | vector4
---@field spawnCoords vector4

---@class GarageData
---@field label string
---@field vehicleType string
---@field type 'normal' | 'buy' | 'temporary'
---@field shared boolean? Makes a difference for normal/buy
---@field vehicles GarageVehicleData[]? Should only be present for temporary or buy
---@field radius number? The interact radius
---@field saveRadius number
---@field target boolean?
---@field prop PropArgs | PropArgs[] | nil
---@field ped PedArgs | PedArgs[] | nil
---@field locations GarageLocationData[]

---@class MusicPlayerData
---@field label string?
---@field icon string?
---@field radius number?
---@field target boolean?
---@field soundDistance number? Overrides the default defined in xsound
---@field prop PropArgs | PropArgs[] | nil
---@field ped PedArgs | PedArgs[] | nil
---@field locations LocationData[]

---@class RegisterData
---@field employeePercentage false | number the percentage of the transaction you want to give to the employee
---@field radius number?
---@field target boolean?
---@field prop PropArgs | PropArgs[] | nil
---@field ped PedArgs | PedArgs[] | nil
---@field locations LocationData[]

---@class SellItem
---@field name string
---@field price integer | { min: integer, max: integer }
---@field currency string?
---@field icon string?
---@field image string?

---@class SellingData
---@field label string?
---@field progress string
---@field icon string?
---@field radius number?
---@field grade integer?
---@field animation AnimProps?
---@field animationProp AnimProps | AnimPropProps[] | nil
---@field duration integer
---@field sellAtOnce boolean Opens a dialog with amount
---@field items SellItem[]
---@field employeePercentage number? Gives an employee a percentage if the chosen account is society
---@field target boolean?
---@field prop PropArgs | PropArgs[] | nil
---@field ped PedArgs | PedArgs[] | nil
---@field locations LocationData[]

---@class ShopData
---@field label string
---@field icon string?
---@field grade integer?
---@field items { name: string, price: number, currency?: string, icon: string?, image: string?, grade: integer? }[]
---@field radius number?
---@field target boolean?
---@field prop PropArgs | PropArgs[] | nil
---@field ped PedArgs | PedArgs[] | nil
---@field locations LocationData[]

---@class StashData
---@field label string
---@field name string? This is used instead of the index if defined
---@field grade integer?
---@field shared boolean
---@field icon string?
---@field slots integer
---@field maxWeight integer
---@field global boolean?
---@field radius number?
---@field target boolean?
---@field prop PropArgs | PropArgs[] | nil
---@field ped PedArgs | PedArgs[] | nil
---@field locations LocationData[]

---@class TeleportData
---@field from { label: string?, icon: string?, target: vector3, coords: vector4 }
---@field to { label: string?, icon: string?, target: vector3, coords: vector4 }
---@field disableAnim boolean?
---@field routingBucket integer?
---@field radius number?
---@field grade integer?
---@field target boolean?
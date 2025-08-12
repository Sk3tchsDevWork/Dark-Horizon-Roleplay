---@class Authorized @Caching players and authorized items to prevent exploitation
---@field id string @Generated id to be matched
---@field item string @Item ID
---@field time number @os.time() when authorized

---@class ActiveSmoking
---@field playerId integer @Player Id
---@field identifier string @Player identifier
---@field item string @Item name
---@field data CigaretteData | CigaretteData | BongData | VapeData @Data for the item
---@field lastFetchedClose number @os.time() when last fetched close players
---@field lastSaved integer @os.time() when last saved to database
---@field closePlayers table<integer> @Close player ids
---@field type string @Type of itemm, joint, cigar, bong, vape
---@field propModel string @Model of the prop
---@field objectNetId integer? @Net id of the object, is set when prop is created
---@field isInhaling boolean | "auto" @Is player inhaling, track to prevent passive particles when inhaling
---@field savingDb integer? @os.time() when saving to database, used to prevent deadlocking

---@class CigaretteData
---@field hasLit boolean
---@field amount number @Amount of cigarette left

---@class BongData
---@field water number @Water level
---@field item ItemData
---@field amount number

---@class VapeData
---@field amount number @Amount of flavour left
---@field battery number @Battery level
---@field item ItemData | nil @Current capsule item, nil if none, the taste of the vape

---@class ParticleData
---@field objectNetId integer? @Net id of the object, used for passive
---@field playerId integer? @Player Id, used for exhale
---@field offset table @Offset of the particle
---@field particleSize number @Size of the smoke particle
---@field baseSize number @Base size of the particle
---@field color "rainbow" | {[1]: integer, [2]: integer, [3]: integer, [4]: number} @Color of the particle

---@class PlayerEffect
---@field screen string?
---@field movement string?
---@field duration number

---@class PlayerEffectsData
---@field isActive boolean
---@field lastDecay number @Last time the effect decayed, in os
---@field totalDuration number @Total durations to avoid constantly calculation it from all tables
---@field effects PlayerEffect[]

---@class ItemData
---@field name string
---@field label string
---@field metadata table
---@field amount integer? @Exists when the item is used, but it is not saved after use
---@field slot integer? @Exists when the item is used, but it is not saved after use

---@class EffectSettings
---@field health? number
---@field armor? number
---@field screenEffect? string
---@field walkEffect? string
---@field clientFunc? function
---@field serverFunc? function
---@field multiplier? number

---@class CigaretteSettings
---@field type string
---@field prop string
---@field color? "rainbow" | {[1]: integer, [2]: integer, [3]: integer, [4]: number}
---@field effects EffectSettings

---@class RefillableSettings
---@field type string
---@field prop string

---@alias Success boolean
---@alias FailReason string
---@alias PlayerId integer
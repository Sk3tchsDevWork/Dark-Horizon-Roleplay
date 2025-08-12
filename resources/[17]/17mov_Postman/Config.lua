Config = {}

Config.useModernUI = true               -- In March 2023 the jobs have passed huge rework, and the UI has been changed. Set it to false, to use OLD no longer supported UI.
    Config.splitReward = false          -- This option work's only when useModernUI is false. If this option is true, the payout is: (Config.OnePercentWorth * Progress ) / PartyCount, if false then: (Config.OnePercentWorth * Progress)
Config.UseBuiltInNotifications = true   -- Set to false if you want to use ur framework notification style. Otherwise, the built in modern notifications will be used.=

Config.letBossSplitReward = true                    -- If it's true, then boss can manage whole party rewards percent in menu. If you'll set it to false, then everybody will get same amount.
Config.multiplyRewardWhileWorkingInGroup = true     -- If it's false, then reward will stay by default. For example $1000 for completing whole job. If you'll set it to true, then the payout will depend on how many players is there in the group. For example, if for full job there's $1000, then if player will work in 4 member group, the reward will be $4000. (baseReward * partyCount)

Config.MailboxRenewalTime = 45000 * 60      -- Only one letter can be taken from one box. This is global, so if one player takes from one mailbox, then the next player can no longer take from it. This is the renewal time, in this case after 45 minutes you will be able to take letters from that particular mailbox again
Config.SyncMailboxStatus = true        -- If it's true, then when one player will collect letters from one box, then the second player will see information about the box is empty. If it's false, then every player has his own mailbox status. 
Config.Props = {
    --Props from which letters can be collected
    
    `prop_postbox_01a`,
    -- Add more if u want!
}

Config.UseTarget = true                        -- Change it to true if you want to use a target system. All setings about the target system are under target.lua file.
Config.RequiredJob = "none"                     -- Set to "none" if you dont want using jobs. If you are using target, you have to set "job" parameter inside every export in target.lua
Config.RequireJobAlsoForFriends = true          -- If it's false, then only host needs to have the job, if it's true then everybody from group needs to have the Config.RequiredJob
Config.RequiredItem = "none"                    -- Required Item needed to start the job. Set to "none", if you dont want to use RequiredItem
Config.RequireOneFriendMinimum = false          -- Set to true if you want to force players to create teams
Config.Scenario = "prop_human_parking_meter"    -- An animation that plays while searching a crate. Note: this must be a Scenario, not an animation
Config.JobVehicleModel = "17mov_PostmanCar"              -- Vehicle Job Model
Config.Price = 2                                -- 2$ per one letter

Config.RequireWorkClothes = true                   -- Set it to true, to change players clothes everytime when they're starting job.
Config.RequireItemFromWholeTeam = true              -- If it's false, then only host needs to have the required item, otherwise all team needs it.

Config.EnableVehicleTeleporting = true          -- If its true, then the script will teleport the host to the company vehicle. If its false, then the company vehicle will apeear, but the whole squad need to go enter the car manually
Config.PenaltyAmount = 500                      -- Penalty that is levied when a player finishes work without a company vehicle
Config.DontPayRewardWithoutVehicle = false      -- Set to true if you want to dont pay reward to players who want's to end without company vehicle (accepting the penalty)
Config.DeleteVehicleWithPenalty = false         -- Delete Vehicle even if its not company veh
Config.JobCooldown = 0 * 60 -- 10 * 60            -- 0 minutes cooldown between making jobs (in brackets there's example for 10 minutes)
Config.GiveKeysToAllLobby = true                -- Set to false if you want to give keys only for group creator while starting job
Config.ProgressBarOffset = "25px"                   -- Value in px of counter offset on screen
Config.ProgressBarAlign = "bottom-right"            -- Align of the progressbar

-- ^ Options: top-left, top-center, top-right, bottom-left, bottom-center, bottom-right

Config.RewardItemsToGive = {
    -- {
    --     item_name = "water",
    --     chance = 100,
    --     amountPerMailbox = 1,
    -- },
}

Config.RestrictBlipToRequiredJob = false            -- Set to true, to hide job blip for players, who dont have RequiredJob. If requried job is "none", then this option will not have any effect.
Config.Blips = {                                -- Here you can configure Company blip.
    [1] = {
        Sprite = 365,
        Color = 44,
        Scale = 0.8,
        Pos = vector3(-232.16, -915.15, 32.31),
        Label = 'Postman Job'
    },
}

Config.MarkerSettings = {                       -- used only when Config.UseTarget = true. Colors of the marker. Active = when player stands inside the marker.
    Active = {
        r = 88, 
        g = 105,
        b = 255,
        a = 200,
    },
    UnActive = {
        r = 43,
        g = 57,
        b = 181,
        a = 200,
    }
}

Config.Locations = {                            -- Here u can change all of the base job locations. 
    DutyToggle = {
        Coords = {
            vector3(-232.16, -915.15, 32.31),
        },
        CurrentAction = 'open_dutyToggle',
        CurrentActionMsg = 'Press ~INPUT_CONTEXT~ to ~y~start/finish~s~ work.',
        type = 'duty',
        scale = {x = 1.0, y = 1.0, z = 1.0}
    },
    FinishJob = {
        Coords = {
            vector3(-276.66, -894.68, 31.08),
        },
        CurrentAction = 'finish_job',
        CurrentActionMsg = 'Press ~INPUT_CONTEXT~ to ~y~end ~s~working.',
        scale = {x = 3.0, y = 3.0, z = 3.0}
    },

}

Config.SpawnPoint = vector4(-276.66, -894.68, 31.08, 337.31)  -- Vehicle spawn point
Config.EnableCloakroom = true                                 -- Set to false if you want to hide the "CLoakroom" button under WorkMenu

Config.Clothes = {
    male = {
        ["mask"] = {clotheId = 0, variation = 0},
        ["arms"] = {clotheId = 0, variation = 0},
        ["pants"] = {clotheId = 10, variation = 0},
        ["bag"] = {clotheId = 0, variation = 0},
        ["shoes"] = {clotheId = 36, variation = 0},
        ["t-shirt"] = {clotheId = 15, variation = 0},
        ["torso"] = {clotheId = 250, variation = 0},
        ["decals"] = {clotheId = 0, variation = 0},
        ["kevlar"] = {clotheId = 0, variation = 0},
    },
    
    female = {
        ["mask"] = {clotheId = 0, variation = 0},
        ["arms"] = {clotheId = 14, variation = 0},
        ["pants"] = {clotheId = 6, variation = 0},
        ["bag"] = {clotheId = 0, variation = 0},
        ["shoes"] = {clotheId = 0, variation = 0},
        ["t-shirt"] = {clotheId = 15, variation = 0},
        ["torso"] = {clotheId = 258, variation = 0},
        ["decals"] = {clotheId = 0, variation = 0},
        ["kevlar"] = {clotheId = 0, variation = 0},
    }
}

Config.Lang = {

    -- Here you can changea all translations used in client.lua, and server.lua. Dont forget to translate it also under the HTML and JS file.

    -- Client
    ["no_permission"] = "Only the party owner can do that!",
    ["keybind"] = 'Marker Interaction',
    ["too_far"] = "Your party has started work, but you are too far from headquarters. You can still join them.",
    ["kicked"] = "You kicked %s out of the party",
    ["alreadyWorking"] = "First, complete the previous order.",
    ["quit"] = "You have left the Team",
    ["cantSpawnVeh"] = "The truck spawn site is occupied.",
    ["nobodyNearby"] = "There is no one around",
    ["pickLetter"] = "Collect letters",
    ["checking"] = "You're checking the mailbox",
    ["spawnpointOccupied"] = "The car's spawn site is occupied",
    ["notADriver"] = "You need to be a driver of vehicle to end the job",
    ["cantInvite"] = "To be able to invite more people, you must first finish the job",
    ["tutorial"] = "The job involves collecting letters from mailboxes. Hurry, one mailbox can be collected only once in a while, don't let the competition overtake you! You can find those mailboxes near the main roades",
    ["wrongReward1"] = "The payout percentage should be between 0 and 100",
    ["wrongReward2"] = "The total percentage of all payouts exceeded 100%",
    ["partyIsFull"] = "Failed to send an invite, your group is full",
    ["inviteSent"] = "Invite Sent!",
    ["cantLeaveLobby"] = "You can't leave the lobby while you're working. First, end the job.",
    ["wrongVeh"] = "Your last vehicle is not your company vehicle. You have to drive company vehicle",
    
    -- Server
    ["isAlreadyHost"] = "This player leads his team.",
    ["isBusy"] = "This player already belongs to another team.", 
    ["hasActiveInvite"] = "This Player already has an active invitation from someone.",
    ["HaveActiveInvite"] = "You already have an active invitation to join the team.",
    ["InviteDeclined"] = "Your invitation has been declined.",
    ["InviteAccepted"] = "Your invitation has been accepted!",
    ["error"] = "There was a Problem joining a team. Please try again later.",
    ["kickedOut"] = "You've been kicked out of the team!",
    ["reward"] = "You have received a payout of $",
    ["RequireOneFriend"] = "This job requires at least one team member",
    ["deposit"] = "We collected deposit for the car",
    ["depositReturned"] = "We have returned the deposit for the car",
    ["empty"] = "Someone has already collected letters from this mailbox, try again later",
    ["collected"] = "You have collected letters",
    ["broken"] = "The mailbox was damaged. The letters cannot be collected from it",
    ["dontHaveReqItem"] = "You or someone from your team do not have the required item to start work",
    ["penalty"] = "You paid a fine in the amount of ",
    ["clientsPenalty"] = "The team's host accepted the punishment. You have not received the payment",
    ["notEverybodyHasRequiredJob"] = "Not every of your friends have the required job",
    ["someoneIsOnCooldown"] = "%s can't start the job now (cooldown: %s)", 
    ["hours"] = "h",
    ["minutes"] = "m",
    ["seconds"] = "s",
    ["newBoss"] = "The previous lobby boss has left the server. You are now the team leader",
} 
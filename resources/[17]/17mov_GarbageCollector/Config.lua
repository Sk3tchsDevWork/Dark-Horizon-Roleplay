Config = {}

Config.Lang = "en" -- Here you can set language from locales directory
Config.UseModernUI = true               -- In March 2023 the jobs have passed huge rework, and the UI has been changed. Set it to false, to use OLD no longer supported UI.
Config.SplitReward = false          -- This option work's only when useModernUI is false. If this option is true, the payout is: (Config.OnePercentWorth * Progress ) / PartyCount, if false then: (Config.OnePercentWorth * Progress)

Config.UseBuiltInNotifications = true   -- Set to false if you want to use ur framework notification style. Otherwise, the built in modern notifications will be used.=
Config.LetBossSplitReward = true                    -- If it's true, then boss can manage whole party rewards percent in menu. If you'll set it to false, then everybody will get same amount.
Config.MultiplyRewardWhileWorkingInGroup = true     -- If it's false, then reward will stay by default. For example $1000 for completing whole job. If you'll set it to true, then the payout will depend on how many players is there in the group. For example, if for full job there's $1000, then if player will work in 4 member group, the reward will be $4000. (baseReward * partyCount)
Config.Price = 2            -- Price per one bag inside trashmaster. 100 is maximum so full trash = 200$ / partyCount
Config.UseTarget = true                 -- Change it to true if you want to use a target system. All setings about the target system are under target.lua file.
Config.RequiredJob = "none"             -- Set to "none" if you dont want using jobs. If you are using target, you have to set "job" parameter inside every export in target.lua
Config.RequireJobAlsoForFriends = true          -- If it's false, then only host needs to have the job, if it's true then everybody from group needs to have the Config.RequiredJob
Config.RequireOneFriendMinimum = false  -- Set to true if you want to force players to create teams
Config.EnableGamePoolDeleting = true    -- Set to false only when using old versions of FXServer. May cause bag removal errors

Config.BlockBagsRespawning = true
Config.BagRespawnTime = 10 * 60 * 1000

Config.JobVehicleModel = "trash"                -- Model of the company car
Config.VehicleBackBone = "seat_dside_r1"        -- Bone used only when Config.UseTarget = true. 3D text is displayed on the coordinates of this bone telling us to put the bag in the trunk
Config.VehicleBackBoneCenter = "brakelight_l"   -- Bone used only when Config.UseTarget = true. On the cords of this bone, a player walks up to throw the bag
Config.PenaltyAmount = 500                      -- Penalty that is levied when a player finishes work without a company vehicle
Config.DeleteVehicleWithPenalty = false         -- Delete Vehicle even if its not company veh
Config.DontPayRewardWithoutVehicle = false      -- Set to true if you want to dont pay reward to players who want's to end without company vehicle (accepting the penalty)
Config.EnableVehicleTeleporting = true          -- If its true, then the script will teleport the host to the company vehicle. If its false, then the company vehicle will apeear, but the whole squad need to go enter the car manually
Config.EnableVehicleCrewMembersTeleporting = true   -- If its true, then the script will teleport all crew members to the company vehicle.
Config.JobCooldown = 0 * 60 -- 10 * 60            -- 0 minutes cooldown between making jobs (in brackets there's example for 10 minutes)
Config.GiveKeysToAllLobby = true                -- Set to false if you want to give keys only for group creator while starting job
Config.ProgressBarOffset = "25px"                   -- Value in px of counter offset on screen
Config.ProgressBarAlign = "bottom-right"            -- Align of the progressbar
-- ^ Options: top-left, top-center, top-right, bottom-left, bottom-center, bottom-right

Config.EnableBins = true                        -- if set to false, user's want be able to pick trash from trashbins
Config.FixBinsPosition = true                   -- experimental, fixing bins rotation
Config.HighlightOnTutorial = true               -- if set to true, all objects that users can pick will be highlighted on tutorial
Config.EnableUnloadStage = true                 -- if set to true, after ending job, user will have to unload vehicle
Config.BagsCountToFullUnload = 15               -- how many bags will be created with 100% progress to unload
Config.BinsRestartingDelay = {
    min = 10 * 60,
    max = 15 * 60
}                 -- how many seconds will it take for bin to restart taken trash bag

Config.UnloadZone = {
    coords = vec3(-351.819092, -1541.140869, 27.428465),
    rotation = vec3(0.339711, -0.048754, -0.072852)
}

Config.Animation = {
    start_coords = vec3(-351.824158, -1547.076904, 27.609995),
    end_coords_offset = vec3(0.0, 0.0, 14.0),
    rotation = vec3(0.0, 90.0, 0.0),
    duration = 3800,
    max_bags_on_line = 6,
    model = 'hei_prop_heist_binbag',
}

Config.KeybindSettings = {
    bagsInteractionKey = 38,
    bagsInteractionkeyString = "~r~[E] | ~s~"
}

Config.RewardItemsToGive = {
    -- {
    --     item_name = "water",
    --     chance = 100,
    --     amountPerBag = 1,
    -- },
}

Config.RequiredItem = "none"                        -- Set it to anything you want, to require players to have some item in their inventory before they start the job
Config.RequireItemFromWholeTeam = true              -- If it's false, then only host needs to have the required item, otherwise all team needs it.

Config.RequireFullJob = false                       -- Set it to true, if you want players first to have 100% of progress, otherwise they'll not be able to end job.
Config.RequireWorkClothes = false                   -- Set it to true, to change players clothes everytime when they're starting job.

Config.RestrictBlipToRequiredJob = false            -- Set to true, to hide job blip for players, who dont have RequiredJob. If requried job is "none", then this option will not have any effect.
Config.Blips = { -- Here you can configure Company blip.
    [1] = {
        Sprite = 318,
        Color = 52,
        Scale = 0.8,
        Pos = vector3(-329.47, -1538.23, 31.43),
        Label = 'Garbage Job'
    },
}

Config.MarkerSettings = {   -- used only when Config.UseTarget = true. Colors of the marker. Active = when player stands inside the marker.
    Active = {
        r = 89,
        g = 198,
        b = 100,
        a = 200,
    },
    UnActive = {
        r = 34,
        g = 117,
        b = 42,
        a = 200,
    }
}


Config.TargetPedOptions = {
    model = 'a_m_y_genstreet_01',
    coords = vector3(-329.47, -1538.23, 31.43),
    heading = 90.0,
}

Config.Locations = {       -- Here u can change all of the base job locations.
    DutyToggle = {
        Coords = {
            vector3(-329.47, -1538.23, 31.43),
        },
        CurrentAction = 'open_dutyToggle',
        CurrentActionMsg = _L("Job.Markers.DutyToggle"),
        type = 'duty',
        scale = { x = 1.0, y = 1.0, z = 1.0 }
    },
    FinishJob = {
        Coords = {
            vector3(-329.48, -1522.98, 27.53),
        },
        CurrentAction = 'finish_job',
        CurrentActionMsg = _L("Job.Markers.FinishJob"),
        scale = { x = 3.0, y = 3.0, z = 3.0 }
    },

}

Config.SpawnPoint = vector4(-316.98, -1537.58, 26.64, 338.0)  -- Company car spawn point
Config.EnableCloakroom = true                                 -- if false, then you can't see the Cloakroom button under Work Menu
Config.Clothes = {
    -- Here you can configure clothes. More information on: https://docs.fivem.net/natives/?_0xD4F7B05C. Under this link you can see what id means what component.
    male = {
        ["mask"] = {clotheId = 0, variation = 0},
        ["arms"] = {clotheId = 30, variation = 0},
        ["pants"] = {clotheId = 36, variation = 0},
        ["bag"] = {clotheId = 0, variation = 0},
        ["shoes"] = {clotheId = 56, variation = 1},
        ["t-shirt"] = {clotheId = 59, variation = 1},
        ["torso"] = {clotheId = 56, variation = 0},
        ["decals"] = {clotheId = 0, variation = 0},
        ["kevlar"] = {clotheId = 0, variation = 0},
    },
    female = {
        ["mask"] = {clotheId = 0, variation = 0},
        ["arms"] = {clotheId = 57, variation = 0},
        ["pants"] = {clotheId = 35, variation = 0},
        ["bag"] = {clotheId = 0, variation = 0},
        ["shoes"] = {clotheId = 59, variation = 1},
        ["t-shirt"] = {clotheId = 36, variation = 1},
        ["torso"] = {clotheId = 49, variation = 1},
        ["decals"] = {clotheId = 0, variation = 0},
        ["kevlar"] = {clotheId = 0, variation = 0},
    }
}

Config.BagAttachments = {
    [`bkr_prop_fakeid_binbag_01`] = {
        offset = vec3(0.5128798484802, -0.3899130821228, -0.061923664063215),
        rotation = vec3(-49.78881072998, -69.82479858398, 27.380029678345),
        counterValue = 1,
    },
    [`hei_prop_heist_binbag`] = {
        offset = vec3(0.11030727624893, -0.015525032766163, -0.046225301921368),
        rotation = vec3(-28.24030685424, -78.76949310302, 24.484218597412),
        counterValue = 1,
    },
    [`prop_cs_rub_binbag_01`] = {
        offset = vec3(0.093124, -0.014298, -0.028950),
        rotation = vec3(-30.728870, -56.827114, 20.127888),
        counterValue = 1,
    },
    [`prop_cs_street_binbag_01`] = {
        offset = vec3(0.444981, -0.132261, -0.019885),
        rotation = vec3(-98.415436, 13.830777, 71.450897),
        counterValue = 1,
    },
    [`prop_ld_rub_binbag_01`] = {
        offset = vec3(0.384783, -0.147489, -0.134954),
        rotation = vec3(-30.008329, -58.360416, 20.631702),
        counterValue = 1,
    },
    [`prop_rub_binbag_01`] = {
        offset = vec3(0.443036, -0.237512, 0.003951),
        rotation = vec3(-16.469851, -87.421234, 7.540201),
        counterValue = 1,
    },

    [`prop_rub_binbag_04`] = {
        offset = vec3(0.912093, -0.544255, -0.016079),
        rotation = vec3(-32.461769, -80.153793, 20.617262),
        counterValue = 1,
    },
    [`prop_rub_binbag_05`] = {
        offset = vec3(0.758000, -0.022000, -0.161000),
        rotation = vec3(1.350526, -77.211212, -168.416992),
        counterValue = 1,
    },
    [`prop_rub_binbag_sd_01`] = {
        offset = vec3(0.513000, -0.134000, -0.065000),
        rotation = vec3(0.000000, -83.960419, 0.000000),
        counterValue = 1,
    },
    [`prop_rub_binbag_sd_02`] = {
        offset = vec3(0.509000, -0.127000, -0.047000),
        rotation = vec3(0.000000, -83.228851, 0.000000),
        counterValue = 1,
    },
    [`p_binbag_01_s`] = {
        offset = vec3(0.408000, -0.168000, -0.029000),
        rotation = vec3(-23.795959, -82.635666, 23.621243),
        counterValue = 1,
    },
    [`p_rub_binbag_test`] = {
        offset = vec3(0.477000, -0.105000, -0.066000),
        rotation = vec3(92.451553, -10.887776, -102.771141),
        counterValue = 1,
    },
    [`prop_rub_binbag_06`] = {
        offset = vec3(0.644000, -0.228000, -0.176000),
        rotation = vec3(-20.425049, -87.962196, -3.816112),
        counterValue = 1,
    },
    [`prop_rub_binbag_08`] = {
        offset = vec3(0.437000, -0.194000, -0.119000),
        rotation = vec3(0.000000, -71.260628, 0.000000),
        counterValue = 1,
    },
    [`prop_rub_binbag_01b`] = {
        offset = vec3(0.442000, -0.118000, -0.055000),
        rotation = vec3(0.000000, -84.545776, 0.000000),
        counterValue = 1,
    },
    [`prop_rub_binbag_03`] = {
        offset = vec3(0.303000, -0.667000, 0.067000),
        rotation = vec3(-130.519180, 77.479706, 0.466558),
        counterValue = 1,
    },
    [`prop_rub_binbag_03b`] = {
        offset = vec3(0.708000, -0.470000, 0.133000),
        rotation = vec3(-85.900436, -15.666203, 55.107498),
        counterValue = 1,
    },
}
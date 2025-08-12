Config = {}
Config.RenderDistance = 15.0
Config.Context = 'ox_lib' --['ox_lib'/'qb-menu']

--Add additional blips here
Config.Blips = {
	{
		Name = 'Jewelry',
		Coords  = vector3(-624.7777, -232.6970, 38.0570),
		Sprite  = 617,
		Display = 4,
		Size   = 1.0,
		Color  = 53
	},
}

Config.CarRobbery = {
	MinPolice = 1,
	MaxDuration = 15 * 60000, --The robbery will end after this.
	Start = {
		Ped = `a_m_m_eastsa_01`,
		RequiredItem = false, --The required item to start the robbery.
		--The ped will spawn at one random locations.
		Locations = {
			vector4(-326.8956, -1264.3597, 31.2957, 90.0),
		},
	},
	Spawn = {
		Vehicles = {
			`xa21`,
			`italigtb2`,
			`turismor`,
			`italigtb`,
			`prototipo`,
		},
		--Locations in which the car will spawn.
		Locations = {
			vector4(-329.9410, -904.7358, 31.0786, 163.5576),
			vector4(-607.6656, -1000.4374, 21.7865, 93.5966),
			vector4(-500.6935, -66.3289, 39.7466, 154.9051),
			vector4(-1087.1201, -298.6375, 37.6474, 104.7148),
			vector4(-1400.5356, 35.4848, 53.1325, 239.9356),
			vector4(-1276.5840, -1152.3511, 6.2557, 116.1418),
			vector4(-1178.4586, -1488.8977, 4.3797, 302.6398),
			vector4(-1057.5189, -1418.5897, 5.4254, 69.3938),
			vector4(-910.4540, -1293.9712, 5.0161, 19.4804),
			vector4(-794.4026, -1293.0938, 5.0004, 348.7646),
			vector4(-330.2180, -1495.0282, 30.6705, 355.6039),
		}
	},
	Delivery = {
		Marker = {
			Type = 1, --Set to -1 if you don't want to use a marker.
			Size = vector3(2.0, 2.0, 0.75),
			Offset = vector3(0.0, 0.0, -1.0),
			Color = { r = 255, g = 255, b = 0, a = 120 },
			BobUpAndDown = false,
			Rotate = false
		},
		Account = 'money', --['money'/'black_money'/'bank']
		Reward = { min = 15000, max = 35000 }, --Money reward minimum and maximum.
		--Player will finish delivery at one of those random places.
		Locations = {
			vector3(2499.3750, 4202.4785, 39.8996),
			vector3(1403.3407, 3657.9978, 34.1259),
			vector3(918.7093, 3567.4236, 33.7632),
			vector3(185.0010, 2776.1750, 45.6552),
			vector3(-84.8244, 1880.2327, 197.2937),
			vector3(-2174.1606, 4270.1455, 48.9554),
			vector3(-35.6021, 6417.0713, 31.4904),
			vector3(2698.2456, 4336.4038, 45.8675),
			vector3(2660.7156, 3276.3237, 55.2405),
			vector3(2051.6179, 3191.9607, 45.1864),
			vector3(1741.6196, -1633.6544, 112.4762),
			vector3(998.4977, -1860.0343, 30.8897),
			vector3(-3214.5903, 913.5268, 13.9890),
		}
	},
	Dispatch = {
		Code = '10-16',
		Title = 'Vehicle Robbery',
		Message = 'A luxurious vehicle has been stolen. It has been marked on your GPS.',
		Blip = { --The blip attached to the vehicle
			UpdateInterval = 5000, --Blip update interval in milliseconds, lowering this value will make your server lag.
			Text = 'Stolen vehicle',
			Sprite  = 225,
			Display = 2,
			Scale   = 1.0,
			Colour  = 1
		}
	}
}

Config.Jewelry = {
	Zone = {
		Coords = vector3(-624.35, -230.2, 38.0),
        Size = vector3(19.0, 20.15, 3.55),
        Rotation = 35.0
	},
	MinPolice = 5,
	Delay = 30 * 60000, --Delay between new jewelry robbery in milliseconds.
	Duration = 30 * 60000, --Max jewelry robbery duration milliseconds.
	AnimationDuration = 2000, --The break case animation duration.
	AlarmDuration = 120000, --Duration in case the robbery still wasn't finished.
	AlarmRange = 100.0, -- Set to 0.0 to disable alarm.
	--Items that you randomly get.
	Items = {
		{ name = 'bracelet', min = 2, max = 5 },
		{ name = 'ring', min = 1, max = 3 },
		{ name = 'watch', min = 1, max = 2 },
	},
	--Display case locations.
	Locations = {
		vector3(-627.6625, -234.3647, 38.0438),
		vector3(-626.4905, -233.5936, 38.0438),
		vector3(-626.1096, -234.1151, 38.0438),
		vector3(-627.1075, -234.9377, 38.0438),
		vector3(-626.3471, -238.9773, 38.0438),
		vector3(-625.3168, -238.2181, 38.0438),
		vector3(-622.6808, -232.5159, 38.0438),
		vector3(-620.5223, -232.9005, 38.0438),
		vector3(-620.1735, -230.7588, 38.0438),
		vector3(-621.5255, -228.9800, 38.0438),
		vector3(-623.5814, -228.5530, 38.0438),
		vector3(-623.9259, -230.7126, 38.0438),
		vector3(-625.2843, -227.4058, 38.0438),
		vector3(-624.2427, -226.5963, 38.0438),
		vector3(-618.8686, -234.0777, 38.0438),
		vector3(-619.9063, -234.8166, 38.0438),
		vector3(-620.0458, -226.2449, 38.0438),
		vector3(-619.1899, -227.2642, 38.0438),
		vector3(-617.8919, -229.1574, 38.0438),
		vector3(-617.2272, -230.2273, 38.0438),
	},
	Dispatch = {
		Code = '10-68',
		Title = 'Jewelry Robbery',
		Message = 'Ongoing jewelry robbery.'
	}
}

Config.Buyers = {
	{
		Label = 'Pawnshop',
		Blip = { --[Blip table/false]
			Name = 'Pawnshop',
			Sprite  = 272,
			Display = 4,
			Size   = 1.0,
			Color  = 69
		},
		Account = 'money',
		Items = {
			{ name = 'ring', price = 4000 },
			{ name = 'bracelet', price = 2000 },
			{ name = 'watch', price = 8000 },
			{ name = 'monitor', price = 2000 },
			{ name = 'keyboard', price = 1000 },
			{ name = 'microwave', price = 1500 },
			{ name = 'laptop', price = 3500 },
			{ name = 'bong', price = 500 },
		},
		Ped = `u_m_o_taphillbilly`,
		Locations = {
			vector4(412.2779, 314.8604, 103.1327, 210.7887),
		}
	},
}

Config.Shops = {
	Blip = { --[Blip table/false]
		Name = 'Shop Robbery',
		Sprite  = 156,
		Display = 4,
		Scale   = 0.5,
		Color  = 0
	},
	MinPolice = 3,
	RequireArmed = true,
	-- RequireArmed = {
	-- 	[`WEAPON_PISTOL`] = true,
	-- 	[`WEAPON_COMBATPISTOL`] = true,
	-- 	[`WEAPON_ASSAULTRIFLE`] = true,
	-- },
	UnlockDuration = 30000, --Miliseconds
	Duration = 10 * 60000, --How long the player can take money from the safe.
	Delay = 20 * 60000, --Delay between shop robberies
	Account = 'money',
	MoneyPerTake = { min = 150, max = 250 },
	Balance = { min = 15000, max = 20000 }, --The safe balance after open it.
	Locations = {
		--Shops
		vector3(28.18, -1338.59, 28.90),
		vector3(-3048.4, 585.41, 7.3),
		vector3(-3250.62, 1004.45, 12.2),
		vector3(1735.08, 6421.36, 34.4),
		vector3(1708.23, 4920.94, 41.4),
		vector3(1958.95, 3749.43, 31.7),
		vector3(546.51, 2662.21, 41.5),
		vector3(2672.24, 3286.9, 54.6),
		vector3(2548.65, 384.88, 108.0),
		vector3(378.29, 333.96, 103.0),
		--Liquor stores
		vector3(1126.74, -979.81, 45.36),
		vector3(-1221.09, -916.17, 11.25),
		vector3(-1478.71, -375.64, 39.11),
		vector3(-2959.64, 386.80, 13.99),
		vector3(1169.58, 2717.82, 37.10),
	},
	Dispatch = {
		Code = '10-68',
		Title = 'Shop Robbery',
		Message = 'Ongoing shop robbery.'
	}
}

Config.Banks = {
	Blip = { --[Blip table/false]
		Name = 'Bank Robbery',
		Sprite  = 150,
		Display = 4,
		Size   = 0.5,
		Colour  = 0
	},
	MinPolice = 0,
	RequireArmed = true,
	-- RequireArmed = {
	-- 	[`WEAPON_PISTOL`] = true,
	-- 	[`WEAPON_COMBATPISTOL`] = true,
	-- 	[`WEAPON_ASSAULTRIFLE`] = true,
	-- },
	RequiredItem = 'usb_drive', --['item name'/false]
	RemoveItemAfterUse = true, --Remove required item after use
	Account = 'money',
	OpenDelay = false, --Time in milliseconds or false
	GiveInterval = 1020, --Interval in which player receives the money.
	Amount = 2000, --Amount of money per one take.
	TotalCount = 45, --Money count on the trolley.
	Duration = 60 * 60000, --The vault will close after this duration.
	Offsets = {
		First = vector3(3.85, 1.25, -1.20),
		Second = vector3(3.85, 2.35, -1.20),
		Third = vector3(3.85, 3.45, -1.20),
		Heading = 90
	},
	VaultModel = `v_ilev_gb_vauldr`,
	Locations = {
		vector3(1175.65, 2712.90, 38.35),
		vector3(147.18, -1046.22, 29.65),
		vector3(311.51, -284.59, 54.40),
		vector3(-353.54, -55.45, 49.33),
		vector3(-1210.47, -336.44, 38.06),
	},
	GabzLocations = { --Support for gabz fleeca bank
		vector3(1176.077148, 2713.113525, 38.326550),
		vector3(146.734390, -1046.288818, 29.621313),
		vector3(311.061127, -284.653564, 54.423439),
		vector3(-353.974213, -55.526978, 49.287125),
		vector3(-1210.730347, -336.815582, 38.033108),
		vector3(-2956.311523, 481.630432, 15.932784),
	},
	Dispatch = {
		Code = '10-68',
		Title = 'Bank Robbery',
		Message = 'Ongoing bank robbery.'
	}
}

Config.ATMs = {
	MinPolice = 0,
	Models = { `prop_atm_01`, `prop_atm_02`, `prop_atm_03`, `prop_fleeca_atm` }, --ATM prop models.
	RequiredItem = 'usb_drive', --['item name'/false]
	RemoveItemAfterUse = false, --Remove required item after use
	Account = 'money', --['money'/'black_money'/'bank']
	MoneyPerTake = { min = 300, max = 500 },
	Balance = { min = 4000, max = 6000 }, --The ATM balance after you hack it.
	OpenDuration = 300000, --The ATM will refill after this duration. (Milliseconds)
	Limit = -1, -- You can limit the amount of concurrent ATMs here
	Dispatch = {
		BeforeHack = false,
		Code = '10-68',
		Title = 'ATM Robbery',
		Message = 'Ongoing ATM robbery.'
	}
}

Config.House = {
	MinPolice = 0,
	MaxActive = 0, --Leave this at 0 to allow infinite number of house robberies at the same time.
	Duration = 30 * 60000, --30 minutes
	RequiredItem = 'lockpick', --['item name'/false]
	RemoveItemAfterUse = true, --Remove required item after use
	EnableLocking = false, -- Enable the police to lock the door if no one is inside.
	Locations = {
		{
			Coords = vector4(231.7865, 673.0365, 189.9457, 43.1425),
			Entrance = vector3(232.5494, 671.8068, 190.0474), --Target coords
			Interior = 'high_tier'
		},
		{
			Coords = vector4(-109.6565, 503.4175, 143.3149, 347.4750),
			Entrance = vector3(-110.1454, 501.3711, 143.6460), --Target coords
			Interior = 'high_tier'
		},
		{
			Coords = vector4(316.1672, 500.2806, 153.1797, 197.2403),
			Entrance = vector3(315.7508, 502.2453, 153.1590), --Target coords
			Interior = 'high_tier'
		},
	},
	Interiors = {
		['high_tier'] = {
			InteriorId = 207105, --https://github.com/Bob74/bob74_ipl/blob/master/gta_online/house_hi_1.lua, used to refresh props
			Coords = vector4(-174.0666, 496.4730, 137.6669, 194.7890),
			Exit = vector3(-174.3980, 498.1899, 137.7588), --Target coords
			Loot = {
				{
					Label = 'Search closet',
					Progress = 'Searching closet...',
					Icon = 'fa-solid fa-magnifying-glass',
					Coords = vector3(-172.1232, 486.6920, 136.9652),
					Items = { --You have to provide count or min and max.
						{ name = 'weapon_snspistol', count = 1, chance = 50 },
						{ name = 'money', min = 500, max = 1000 }
					}
				},
				{
					Label = 'Search closet',
					Progress = 'Searching closet...',
					Icon = 'fa-solid fa-magnifying-glass',
					Coords = vector3(-171.1154, 482.4599, 136.8367),
					Items = { --You have to provide count or min and max.
						{ name = 'weapon_pistol', count = 1, chance = 25 },
						{ name = 'money', min = 500, max = 1000 }
					}
				},
				{
					Label = 'Search closet',
					Progress = 'Searching closet...',
					Icon = 'fa-solid fa-magnifying-glass',
					Coords = vector3(-170.846878, 481.954803, 133.422211),
					Items = { --You have to provide count or min and max.
						{ name = 'weapon_knife', count = 1, chance = 50 },
						{ name = 'money', min = 500, max = 1000 }
					}
				},
				{
					Label = 'Search closet',
					Progress = 'Searching closet...',
					Icon = 'fa-solid fa-magnifying-glass',
					Coords = vector3(-175.4622, 489.6720, 129.3880),
					Items = { --You have to provide count or min and max.
						{ name = 'weapon_combatpistol', count = 1, chance = 25 },
						{ name = 'money', min = 1000, max = 3500 }
					}
				},
				{
					Label = 'Search wardrobe',
					Progress = 'Searching wardrobe...',
					Icon = 'fa-solid fa-magnifying-glass',
					Coords = vector3(-167.6694, 488.6797, 133.9791),
					Items = { --You have to provide count or min and max.
						{ name = 'money', min = 100, max = 200 },
						{ name = 'bandage', min = 1, max = 2, chance = 50 },
					}
				},
				{
					Label = 'Search refrigerator',
					Progress = 'Searching refrigerator...',
					Icon = 'fa-solid fa-magnifying-glass',
					Coords = vector3(-170.3485, 496.3442, 137.8943),
					Items = { --You have to provide count or min and max.
						{ name = 'burger', min = 1, max = 3 },
						{ name = 'water', min = 1, max = 4 },
						{ name = 'cola', min = 1, max = 3 },
						{ name = 'mustard', min = 1, max = 2, chance = 25 },
					}
				},
				{
					Label = 'Search for ammunition',
					Progress = 'Searching for ammunition...',
					Icon = 'fa-solid fa-magnifying-glass',
					Coords = vector3(-176.672348, 491.897461, 130.194458),
					Items = { --You have to provide count or min and max.
						{ name = 'ammo-9', min = 30, max = 90 },
						{ name = 'ammo-45', min = 30, max = 60 },
						{ name = 'ammo-rifle', min = 20, max = 40 }
					}
				},
				{
					Label = 'Take monitor',
					Progress = 'Taking monitor...',
					Icon = 'fa-solid fa-desktop',
					RemoveProp = `prop_monitor_w_large`,
					Coords = vector3(-169.107544, 493.102234, 130.157806),
					Items = { --You have to provide count or min and max.
						{ name = 'monitor', count = 1 }
					}
				},
				{
					Label = 'Take monitor',
					Progress = 'Taking monitor...',
					Icon = 'fa-solid fa-desktop',
					RemoveProp = `prop_monitor_w_large`,
					Coords = vector3(-168.975555, 492.264038, 130.151062),
					Items = { --You have to provide count or min and max.
						{ name = 'monitor', count = 1 }
					}
				},
				{
					Label = 'Take keyboard',
					Progress = 'Taking keyboard...',
					Icon = 'fa-solid fa-keyboard',
					RemoveProp = `prop_keyboard_01b`,
					Coords = vector3(-169.336121, 492.851044, 129.796936),
					Items = { --You have to provide count or min and max.
						{ name = 'keyboard', count = 1 }
					}
				},
				{
					Label = 'Take laptop',
					Progress = 'Taking laptop...',
					Icon = 'fa-solid fa-laptop',
					RemoveProp = `prop_laptop_01a`,
					Coords = vector3(-169.751175, 490.136475, 129.788208),
					Items = { --You have to provide count or min and max.
						{ name = 'laptop', count = 1 }
					}
				},
				{
					Label = 'Take bong',
					Progress = 'Taking bong...',
					Icon = 'fa-solid fa-bong',
					RemoveProp = `prop_bong_01`,
					Coords = vector3(-166.398056, 482.312927, 136.862656),
					Items = { --You have to provide count or min and max.
						{ name = 'bong', count = 1 }
					}
				},
				{
					Label = 'Take microwave',
					Progress = 'Taking microwave...',
					Icon = 'fa-solid fa-box',
					RemoveProp = `prop_micro_02`,
					Coords = vector3(-164.572800, 494.546204, 137.774277),
					Items = { --You have to provide count or min and max.
						{ name = 'microwave', count = 1 }
					}
				},
			}
		},
	},
	Dispatch = {
		Code = '10-69',
		Title = 'House Robbery',
		Message = 'A suspect has broken into a house.'
	}
}
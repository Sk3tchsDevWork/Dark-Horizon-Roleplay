Config = {}
Config.RenderDistance = 30.0

Config.Freelancer = true --Allows you to work without a job.

Config.Marker = {
	Type = 1,
	Size = vector3(5.0, 5.0, 0.5), --X and Y doesn't matter, it will be collect Radius.
	VerticalOffset = -1.0, --Z axis offset
	Color = { r = 255, g = 255, b = 0, a = 150 },
	BobUpAndDown = false,
	Rotate = false
}

Config.Blip = {
	Text = 'Truck Contracter',
	Sprite = 477,
	Size = 0.6,
	Color = 47,
	Display = 4
}

Config.Account = 'money'
Config.PricePerMeter = 0.5 --Payout per meter in air distance

Config.Locations = {
	['clucking_bell'] = {
		Label = 'Clucking bell farms',
		Icon = 'fa-solid fa-bell',
		Image =  Utils.getImageUrl('clucking_bell_low.png'),
		Destinations = {
			'you_tool',
			'korean',
			'ron'
		},
		Ped = {
			Model = `a_m_m_farmer_01`,
			Coords = vector4(-6.0140, 6274.6406, 31.3880, 212.6071)
		},
		Truck = `phantom`,
		Trailer = `trailers2`,
		TrailerLiveryIndex = 2,
		Coords = {
			Start = vector4(-20.4445, 6278.7573, 31.2315, 32.7469),
			Delivery = vector3(9.1955, 6270.4263, 31.2833)
		}
	},
	['you_tool'] = {
		Label = 'You tool',
		Icon = 'fa-solid fa-wrench',
		Image =  Utils.getImageUrl('you_tool_low.png'),
		Destinations = {
			'power_station',
			'ron',
			'ls_gas',
		},
		Ped = {
			Model = `s_m_m_gaffer_01`,
			Coords = vector4(2679.5464, 3520.8186, 52.8431, 68.8285)
		},
		Truck = `phantom3`,
		Trailer = `trailers2`,
		TrailerLiveryIndex = 1,
		Coords = {
			Start = vector4(2675.1062, 3537.2039, 51.8766, 339.8938),
			Delivery = vector3(2673.7546, 3519.0815, 52.7121)
		}
	},
	['ron'] = {
		Label = 'RON',
		Icon = 'fa-solid fa-gas-pump',
		Image = Utils.getImageUrl('ron_low.png'),
		Destinations = {
			'korean',
			'you_tool',
			'clucking_bell'
		},
		Ped = {
			Model = `s_m_m_highsec_01`,
			Coords = vector4(166.8865, -1553.3414, 29.2617, 225.0)
		},
		Truck = `phantom`,
		Trailer = `trailers2`,
		TrailerLiveryIndex = 1,
		Coords = {
			Start = vector4(185.0426, -1553.6445, 29.2052, 216.8362),
			Delivery = vector3(169.9579, -1557.1073, 29.2327)
		}
	},
	['ls_gas'] = {
		Label = 'LS gas company',
		Icon = 'fa-solid fa-oil-can',
		Image = Utils.getImageUrl('ls_gas_low.png'),
		Destinations = {
			'ron',
			'power_station',
			'clucking_bell'
		},
		Ped = {
			Model = `s_m_y_dockwork_01`,
			Coords = vector4(503.0044, -2133.3882, 5.9175, 215.7643)
		},
		Truck = `phantom3`,
		Trailer = `tanker`,
		TrailerLiveryIndex = 0,
		Coords = {
			Start = vector4(506.7596, -2149.1804, 5.9175, 208.4094),
			Delivery = vector3(524.8972, -2106.3181, 5.9853)
		}
	},
	['korean'] = {
		Label = 'Korean restaurant',
		Icon = 'fa-solid fa-utensils',
		Image =  Utils.getImageUrl('korean_low.png'),
		Destinations = {
			'ls_gas',
			'you_tool',
			'clucking_bell'
		},
		Ped = {
			Model = `g_m_m_korboss_01`,
			Coords = vector4(-634.9490, -1208.0613, 12.6818, 184.2092)
		},
		Truck = `packer`,
		Trailer = `trailers4`,
		TrailerLiveryIndex = 5,
		Coords = {
			Start = vector4(-640.0378, -1193.4564, 13.1012, 127.9973),
			Delivery = vector3(-627.0770, -1209.6938, 13.2744)
		}
	},
	['power_station'] = {
		Label = 'Power station',
		Icon = 'fa-solid fa-bolt-lightning',
		Image =  Utils.getImageUrl('power_station_low.png'),
		Destinations = {
			'ron',
			'you_tool',
			'clucking_bell',
		},
		Ped = {
			Model = `s_m_m_dockwork_01`,
			Coords = vector4(2830.7024, 1672.5562, 24.6405, 88.7420)
		},
		Truck = `phantom`,
		Trailer = `trailers4`,
		TrailerLiveryIndex = 5,
		Coords = {
			Start = vector4(2802.0940, 1703.2080, 24.6881, 92.2528),
			Delivery = vector3(2823.1357, 1671.1958, 24.7110)
		}
	}
}
QBShared = QBShared or {}
QBShared.ForceJobDefaultDutyAtLogin = true -- true: Force duty state to jobdefaultDuty | false: set duty state from database last saved
QBShared.Jobs = {
	unemployed = { label = 'Civilian', defaultDuty = true, offDutyPay = false, grades = { ['0'] = { name = 'Freelancer', payment = 10 } } },
	bus = { label = 'Bus', defaultDuty = true, offDutyPay = false, grades = { ['0'] = { name = 'Driver', payment = 50 } } },
	judge = { label = 'Honorary', defaultDuty = true, offDutyPay = false, grades = { ['0'] = { name = 'Judge', payment = 100 } } },
	lawyer = { label = 'Law Firm', defaultDuty = true, offDutyPay = false, grades = { ['0'] = { name = 'Associate', payment = 50 } } },
	reporter = { label = 'Reporter', defaultDuty = true, offDutyPay = false, grades = { ['0'] = { name = 'Journalist', payment = 50 } } },
	trucker = { label = 'Trucker', defaultDuty = true, offDutyPay = false, grades = { ['0'] = { name = 'Driver', payment = 50 } } },
	tow = { label = 'Towing', defaultDuty = true, offDutyPay = false, grades = { ['0'] = { name = 'Driver', payment = 50 } } },
	garbage = { label = 'Garbage', defaultDuty = true, offDutyPay = false, grades = { ['0'] = { name = 'Collector', payment = 50 } } },
	vineyard = { label = 'Vineyard', defaultDuty = true, offDutyPay = false, grades = { ['0'] = { name = 'Picker', payment = 50 } } },
	hotdog = { label = 'Hotdog', defaultDuty = true, offDutyPay = false, grades = { ['0'] = { name = 'Sales', payment = 50 } } },

	police = {
		label = 'Law Enforcement',
		type = 'leo',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
			['0'] = { name = 'Recruit', payment = 50 },
			['1'] = { name = 'Officer', payment = 75 },
			['2'] = { name = 'Sergeant', payment = 100 },
			['3'] = { name = 'Lieutenant', payment = 125 },
			['4'] = { name = 'Chief', isboss = true, bankAuth = true, payment = 150 },
		},
	},
	ambulance = {
		label = 'ambulance',
		type = 'ambulance',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
			['0'] = { name = 'Recruit', payment = 50 },
			['1'] = { name = 'Paramedic', payment = 75 },
			['2'] = { name = 'Doctor', payment = 100 },
			['3'] = { name = 'Surgeon', payment = 125 },
			['4'] = { name = 'Chief', isboss = true, bankAuth = true, payment = 150 },
		},
	},
	realestate = {
		label = 'Real Estate',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
			['0'] = { name = 'Recruit', payment = 50 },
			['1'] = { name = 'House Sales', payment = 75 },
			['2'] = { name = 'Business Sales', payment = 100 },
			['3'] = { name = 'Broker', payment = 125 },
			['4'] = { name = 'Manager', isboss = true, bankAuth = true, payment = 150 },
		},
	},
	taxi = {
		label = 'Taxi',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
			['0'] = { name = 'Recruit', payment = 50 },
			['1'] = { name = 'Driver', payment = 75 },
			['2'] = { name = 'Event Driver', payment = 100 },
			['3'] = { name = 'Sales', payment = 125 },
			['4'] = { name = 'Manager', isboss = true, bankAuth = true, payment = 150 },
		},
	},
	cardealer = {
		label = 'Vehicle Dealer',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
			['0'] = { name = 'Recruit', payment = 50 },
			['1'] = { name = 'Showroom Sales', payment = 75 },
			['2'] = { name = 'Business Sales', payment = 100 },
			['3'] = { name = 'Finance', payment = 125 },
			['4'] = { name = 'Manager', isboss = true, bankAuth = true, payment = 150 },
		},
	},
	['electrician'] = {
	label = 'Electrician',
	defaultDuty = true,
	grades = {
		['0'] = {
			name = 'Employee',
			payment = 100
		},
	},
},
	beeker = {
		label = 'Beeker\'s Garage',
		type = 'mechanic',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
			['0'] = { name = 'Recruit', payment = 50 },
			['1'] = { name = 'Novice', payment = 75 },
			['2'] = { name = 'Experienced', payment = 100 },
			['3'] = { name = 'Advanced', payment = 125 },
			['4'] = { name = 'Manager', isboss = true, payment = 150 },
		},
	},
	['trucker'] = {
	label = 'Trucker',
	defaultDuty = true,
	grades = {
		['0'] = {
			name = 'Employee',
			payment = 100
		},
	},
},
	['ems'] = {
	label = 'EMS',
	type = 'ambulance',
	defaultDuty = true,
	defaultDuty = true,
		offDutyPay = false,
		grades = {
			['0'] = { name = 'Recruit', payment = 50 },
			['1'] = { name = 'Paramedic', payment = 75 },
			['2'] = { name = 'Doctor', payment = 100 },
			['3'] = { name = 'Surgeon', payment = 125 },
			['4'] = { name = 'Chief', isboss = true, bankAuth = true, payment = 150 },
	},
},
	['yellowjack'] = {
	label = 'yellowjack',
	defaultDuty = true,
	grades = {
		    ['0'] = { name = 'Employee', payment = 650 },
			['1'] = { name = 'Tender', payment = 800 },
			['2'] = { name = 'Mixologist', payment = 1000 },
			['3'] = { name = 'Assistant Manager', payment = 1500 },
			['4'] = { name = 'Operations Manager', isboss = true, payment = 1700 },
			['5'] = { name = 'Owner', isboss = true, bankAuth = true, payment = 3000 },
	},
},
	['harmony'] = {
	label = 'harmony',
	defaultDuty = true,
	grades = {
		    ['0'] = { name = 'Lube Mechanic', payment = 1000 },
			['1'] = { name = 'Mechanic', payment = 1000 },
			['2'] = { name = 'Master Mechanic', payment = 1000 },
			['3'] = { name = 'Manager', payment = 1000 },
			['4'] = { name = 'Boss', isboss = true, bankAuth = true, payment = 1000 },
	},
},
	['bcso'] = {
	label = 'bcso',
	type = 'leo',
	defaultDuty = true,
	grades = {
		    ['0'] = { name = 'Deputy Cadet', payment = 500 },
			['1'] = { name = 'Deputy', payment = 800 },
			['2'] = { name = 'Senior Deputy', payment = 1000 },
			['3'] = { name = 'Corporal', payment = 1300 },
			['4'] = { name = 'Sergeant', payment = 1400 },
			['5'] = { name = 'Lieutenant', payment = 1500 },
			['6'] = { name = 'Captain',  payment = 1600 },
			['7'] = { name = 'Commander', isboss = true, payment = 1800 },
			['8'] = { name = 'Chief Deputy', isboss = true, payment = 2000 },
			['9'] = { name = 'Assistant Sheriff', isboss = true, payment = 2200 },
			['10'] = { name = 'Under Sheriff', isboss = true, payment = 2500 },
			['11'] = { name = 'Sherrif', isboss = true, bankAuth = true, payment = 3000 },
	},
},

	bennys = {
		label = 'Benny\'s Original Motor Works',
		type = 'mechanic',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
			['0'] = { name = 'Recruit', payment = 50 },
			['1'] = { name = 'Novice', payment = 75 },
			['2'] = { name = 'Experienced', payment = 100 },
			['3'] = { name = 'Advanced', payment = 125 },
			['4'] = { name = 'Manager', isboss = true, payment = 150 },
		},
	},
}


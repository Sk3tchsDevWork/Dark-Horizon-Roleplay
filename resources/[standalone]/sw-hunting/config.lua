Locale = {}
Config = {

	Debug = false,
	Target = 'ox',														-- 'qb' (qb-target) | 'ox' (ox_target)
	ProgressBar = 'ox',													-- 'qb' (progressbar) | 'ox' (ox_lib)
	Language = 'en',													-- Locale file you want to use

	UseMonkey = false,													-- Whether to add Chimps and Rhesus to the hunting list
	UsePets = true,														-- Whether to add Cats and Dogs to the hunting list
	
	SkinningTime = 8,													-- Seconds it takes to skin hunted animals
	SkinAnimation = 'mechanic4',										-- Animation used to skin animal
	ButcheringTime = 8,													-- Seconds it takes to butcher an animal in the slaughterhouse
	ButcheringCoords = vector4(983.09, -2125.29, 29.48, 356.26),		-- Location of butchering table in the slaughterhouse
	
	SellHuntingWeapon = false,											-- Whether the peds should sell the hunting weapon or not
	WeaponName = 'weapon_huntingrifle',									-- Item name of the hunting weapon
	HuntingWeapon = 750,												-- Price to buy the hunting weapon
	Knife = 250,														-- Price to buy the knife
	
	HunterBlipSprite = 442,
	HunterBlipColour = 1,
	HunterBlipName = 'Hunting Cabin',
	
	SlaughterhouseBlipSprite = 273,
	SlaughterhouseBlipColour = 1,
	SlaughterhouseBlipName = 'Raven Slaughterhouse',
}

Hunter = {
	[1] = { location = vector4(-702.27, 5790.03, 17.52, 67.05), seller = 'legal', model = `s_m_y_ammucity_01`, scenario = 'WORLD_HUMAN_CLIPBOARD', },
	[2] = { location = vector4(1002.92, -2158.43, 30.55, 175.02), seller = 'exotic', model = `csb_dix`, scenario = 'WORLD_HUMAN_CLIPBOARD', },
	[3] = { location = vector4(981.27, -2124.4, 30.48, 135.47), seller = 'slaughterhouse', model = `s_m_y_factory_01`, scenario = 'WORLD_HUMAN_CLIPBOARD', },
}

Animals = {
	[1] = { model = 'a_c_deer', },										-- Ped names for huntable animals
	[2] = { model = 'a_c_boar', },
	[3] = { model = 'a_c_mtlion', },
	[4] = { model = 'a_c_coyote', },
	[5] = { model = 'a_c_rabbit_01', },
	[6] = { model = 'a_c_pigeon', },
	[7] = { model = 'a_c_seagull', },
	[8] = { model = 'a_c_crow', },
	[9] = { model = 'a_c_cormorant', },
	[10] = { model = 'a_c_chickenhawk', },
	[11] = { model = 'a_c_chimp', },
	[12] = { model = 'a_c_rhesus', },
	[13] = { model = 'a_c_rat', },
	[14] = { model = 'a_c_chop', },
	[15] = { model = 'a_c_husky', },
	[16] = { model = 'a_c_poodle', },
	[17] = { model = 'a_c_pug', },
	[18] = { model = 'a_c_retriever', },
	[19] = { model = 'a_c_rottweiler', },
	[20] = { model = 'a_c_shepherd', },
	[21] = { model = 'a_c_westy', },
	[22] = { model = 'a_c_cat_01', },
}

Prices = {
	Boar = { weight = { 165, 220 }, multiplier = 3.15 },
	Cat = { weight = { 8, 15 }, multiplier = 2.4 },
	ChickenHawk = { weight = { 1, 3 }, multiplier = 3.75 },
	Chimpanzee = { weight = { 60, 154 }, multiplier = 0.3 },
	Cormorant = { weight = { 1, 6 }, multiplier = 3.75 },
	Coyote = { weight = { 34, 50 }, multiplier = 1.2 },
	Crow = { weight = { 1, 3 }, multiplier = 3.75 },
	Deer = { weight = { 150, 300 }, multiplier = 0.15 },
	Husky = { weight = { 45, 60 }, multiplier = 0.5 },
	MountainLion = { weight = { 135, 175 }, multiplier = 0.4 },
	Pigeon = { weight = { 1, 5 }, multiplier = 3.75 },
	Poodle = { weight = { 40, 70 }, multiplier = 0.5 },
	Pug = { weight = { 14, 18 }, multiplier = 0.5 },
	Rabbit = { weight = { 8, 12 }, multiplier = 2.4 },
	Rat = { weight = { 1, 5 }, multiplier = 6 },
	Retriever = { weight = { 55, 75 }, multiplier = 0.5 },
	Rhesus = { weight = { 60, 154 }, multiplier = 0.3 },
	Rottweiler = { weight = { 80, 120 }, multiplier = 0.5 },
	Seagull = { weight = { 1, 4 }, multiplier = 3.75 },
	Shepherd = { weight = { 50, 70 }, multiplier = 0.5 },
	Westy = { weight = { 16, 20 }, multiplier = 0.5 },
}

WeaponTypes = {
	`WEAPON_KNIFE`,														-- Hunting weapons - Only these weapon can achieve a 3-star carcass
	`WEAPON_HUNTINGRIFLE`,
}

-- IGNORE

--[[Animals = {
	{ name = 'a_c_deer', price = 50, weight = {150, 300} },
	{ name = 'a_c_boar', price = 50, weight = {165, 220} },
	{ name = 'a_c_mtlion', price = 50, weight = {135, 175} },
	{ name = 'a_c_coyote', price = 50, weight = {34, 50} },
	{ name = 'a_c_rabbit_01', price = 50, weight = {8, 12} },
	{ name = 'a_c_pigeon', price = 50, weight = {1, 5} },
	{ name = 'a_c_seagull', price = 50, weight = {1, 4} },
	{ name = 'a_c_crow', price = 50, weight = {1, 3} },
	{ name = 'a_c_cormorant', price = 50, weight = {1, 6} },
	{ name = 'a_c_chickenhawk', price = 50, weight = {1, 3} },
	{ name = 'a_c_chimp', price = 50, weight = {60, 154} },
	{ name = 'a_c_rhesus', price = 50, weight = {60, 154} },
	{ name = 'a_c_rat', price = 50, weight = {1, 5} },
	{ name = 'a_c_chop', price = 50, weight = {80, 120} },
	{ name = 'a_c_husky', price = 50, weight = {45, 60} },
	{ name = 'a_c_poodle', price = 50, weight = {40, 70} },
	{ name = 'a_c_pug', price = 50, weight = {14, 18} },
	{ name = 'a_c_retriever', price = 50, weight = {55, 75} },
	{ name = 'a_c_rottweiler', price = 50, weight = {80, 120} },
	{ name = 'a_c_shepherd', price = 50, weight = {50, 70} },
	{ name = 'a_c_westy', price = 50, weight = {16, 20} },
	{ name = 'a_c_cat_01', price = 50, weight = {8, 15} },
}]]
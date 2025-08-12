-- This runs every sunday 23:59, make sure your server is on, otherwise the week won't reset
lib.cron.new('59 23 * * SUN', function(task, date)
    DB.resetWeek()
end)

-- You can implement your own logic here
-- For example more slots for certain identifiers
function GetPlayerSlots(source, identifier)
    return Config.Limit
end

MySQL.ready(function()
	MySQL.query([[
		CREATE TABLE IF NOT EXISTS `lunar_multijob` (
			`identifier` varchar(60) NOT NULL,
			`name` varchar(30) NOT NULL,
			`grade` tinyint(4) NOT NULL,
			`active` BOOLEAN NOT NULL,
			`total` int(11) NOT NULL DEFAULT 0,
			`week` int(11) NOT NULL DEFAULT 0,
			PRIMARY KEY (`identifier`, `name`),
			INDEX `idx_identifier` (`identifier`)
		) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
	]])
		
	MySQL.query([[
		CREATE TABLE IF NOT EXISTS `lunar_multijob_duty` (
			`identifier` varchar(60) NOT NULL,
			`on_duty` tinyint(1) NOT NULL,
		PRIMARY KEY (`identifier`)
		) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci ROW_FORMAT=DYNAMIC;
	]])
		
	MySQL.query([[
		CREATE TABLE IF NOT EXISTS `lunar_multijob_bonus` (
		  `identifier` varchar(60) NOT NULL,
		  `amount` int(11) NOT NULL DEFAULT 0,
		PRIMARY KEY (`identifier`)
		) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci ROW_FORMAT=DYNAMIC;
	]])
		
	MySQL.query([[
		CREATE TABLE IF NOT EXISTS `lunar_multijob_goals` (
			`name` varchar(60) NOT NULL,
			`grade` tinyint(4) NOT NULL,
			`goal` tinyint(4) NOT NULL,
		UNIQUE KEY `Index` (`name`,`grade`) USING BTREE
		) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci ROW_FORMAT=DYNAMIC;
	]])
		
	MySQL.query([[
		CREATE TABLE IF NOT EXISTS `lunar_multijob_accounts` (
			`name` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_general_ci',
			`balance` INT(11) NOT NULL,
			PRIMARY KEY (`name`) USING BTREE
		) COLLATE='utf8mb4_general_ci' ENGINE=InnoDB;
	]])
end)
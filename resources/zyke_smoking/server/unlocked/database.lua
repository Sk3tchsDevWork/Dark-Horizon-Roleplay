HasInitializedDatabase = false

local queries = {
	[[
		CREATE TABLE IF NOT EXISTS `zyke_smoking` (
			`identifier` VARCHAR(50) NOT NULL,
			`item` TINYTEXT NOT NULL,
			`data` TEXT NOT NULL,
			PRIMARY KEY (`identifier`)
		);
	]]
}

local totalQueries = #queries
for i = 1, #queries do
	MySQL.query.await(queries[i])
	Z.debug("^3Executed query: " .. i .. "/" .. totalQueries .. ".^7")
end

Z.debug("^2Database initialized successfully.^7")

HasInitializedDatabase = true
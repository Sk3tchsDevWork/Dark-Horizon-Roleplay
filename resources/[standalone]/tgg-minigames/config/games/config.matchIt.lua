Config = Config or {}

Config.MatchIt = {
    description = 'Match the colored tiles with the correct circle sectors by rotating!',

    defaultNumberOfStages = 3,
    progressiveDifficulty = true,
    instantFail = false,

    stages = {
        {
            tilesCount = 10,          -- Number of tiles to match
            tileSpawnInterval = 1300, -- Time between tile spawns
            tileSpeed = 2,            -- Speed of tile movement
            stageTimer = 45,          -- Time limit for this stage in seconds
            penaltySeconds = 3,       -- Penalty for wrong match
        },
        {
            tilesCount = 15,
            tileSpawnInterval = 1150,
            tileSpeed = 3,
            stageTimer = 40,
            penaltySeconds = 4,
        },
        {
            tilesCount = 20,
            tileSpawnInterval = 950,
            tileSpeed = 4,
            stageTimer = 35,
            penaltySeconds = 5,
        },
    },
    progression = {
        [1] = {
            tilesIncrease = 2,      -- Increase number of tiles
            speedIncrease = 0.2,    -- Increase speed
            timerIncrease = 1,      -- Increase time limit
            intervalDecrease = 100, -- Decrease spawn interval
            penaltyIncrease = 0.2,  -- Increase penalty
        },
        [2] = {
            tilesIncrease = 3,
            speedIncrease = 0.3,
            timerIncrease = 0.5,
            intervalDecrease = 150,
            penaltyIncrease = 0.3,
        },
        [3] = {
            tilesIncrease = 4,
            speedIncrease = 0.4,
            timerIncrease = 0,
            intervalDecrease = 200,
            penaltyIncrease = 0.4,
        }
    },

    labels = {
        instructions = 'Rotate the circle to match incoming tile colors with the correct sectors!',
        stage = 'Stage',
        completed = 'Stage completed!',
        failed = 'Stage failed!',
        allCompleted = 'All Stages Complete!',
        remaining = 'Remaining',
        controls = {
            rotate = 'Use A/D or ← → to rotate the circle',
        },
    }
}

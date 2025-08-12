Config.Dash = {
    description = 'Navigate your arrow through falling lines by hitting the colored openings!',

    defaultNumberOfStages = 3,
    progressiveDifficulty = true,

    stages = {
        {
            lineSpeed = 0.5,     -- Speed of lines falling down
            openingSize = 30,    -- Size of the "opening" (colored part) as percentage of line width
            movementSpeed = 0.5, -- Speed of arrow movement (and auto-centering)
            linesRequired = 8,   -- Number of lines to complete this stage
            lineSpawnMin = 1000, -- Minimum time between line spawns (ms)
            lineSpawnMax = 1500, -- Maximum time between line spawns (ms)
        },
        {
            lineSpeed = 0.7,
            openingSize = 25,
            movementSpeed = 0.75,
            linesRequired = 12,
            lineSpawnMin = 900,
            lineSpawnMax = 1300,
        },
        {
            lineSpeed = 0.9,
            openingSize = 22,
            movementSpeed = 1.0,
            linesRequired = 15,
            lineSpawnMin = 800,
            lineSpawnMax = 1200,
        },
    },

    progression = {
        [1] = {
            lineSpeedIncrease = 0.1,     -- Increase line speed
            openingSizeDecrease = 2,     -- Decrease opening size
            movementSpeedIncrease = 0.1, -- Increase movement speed
            linesRequiredIncrease = 2,   -- Increase lines required
            spawnTimeDecrease = 50,      -- Decrease spawn time
        },
        [2] = {
            lineSpeedIncrease = 0.15,
            openingSizeDecrease = 3,
            movementSpeedIncrease = 0.15,
            linesRequiredIncrease = 3,
            spawnTimeDecrease = 75,
        },
        [3] = {
            lineSpeedIncrease = 0.2,
            openingSizeDecrease = 4,
            movementSpeedIncrease = 0.2,
            linesRequiredIncrease = 4,
            spawnTimeDecrease = 100,
        }
    },

    labels = {
        instructions = 'Use A/D or Arrow Keys to move. Hit the green openings in the falling lines!',
        stage = 'Stage',
        completed = 'Stage completed!',
        failed = 'Stage failed!',
        allCompleted = 'All Stages Complete!',
        gameOver = 'Game Over!',
        victory = 'Victory!',
        time = 'Time',
    }
}

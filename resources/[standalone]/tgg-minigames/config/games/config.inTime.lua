Config = Config or {}

Config.InTime = {
    description = 'Destroy falling blocks by pressing the correct keys before they reach the bottom!',

    defaultNumberOfStages = 3,
    progressiveDifficulty = true,
    instantFail = false,

    stages = {
        {
            blocksPerStage = 15,      -- Number of blocks to destroy
            spawnFrequencyMin = 1250, -- Minimum spawn frequency
            spawnFrequencyMax = 2500, -- Maximum spawn frequency
            timeLimit = 15,           -- Time limit for this stage in seconds
            fallSpeed = 1.75,         -- Speed of falling blocks
            penaltySeconds = 2,       -- Penalty for wrong key press
        },
        {
            blocksPerStage = 20,
            spawnFrequencyMin = 1200,
            spawnFrequencyMax = 2000,
            timeLimit = 17.5,
            fallSpeed = 2.0,
            penaltySeconds = 2,
        },
        {
            blocksPerStage = 25,
            spawnFrequencyMin = 1000,
            spawnFrequencyMax = 1750,
            timeLimit = 20,
            fallSpeed = 2.25,
            penaltySeconds = 2,
        },
    },

    progression = {
        [1] = {
            blocksIncrease = 5,         -- Increase number of blocks
            spawnFreqMinDecrease = 100, -- Decrease minimum spawn frequency
            spawnFreqMaxDecrease = 150, -- Decrease maximum spawn frequency
            timeLimitIncrease = 1,      -- Increase time limit
            fallSpeedIncrease = 0.1,    -- Increase fall speed
            penaltyIncrease = 0.15,     -- Increase penalty
        },
        [2] = {
            blocksIncrease = 5,
            spawnFreqMinDecrease = 150,
            spawnFreqMaxDecrease = 200,
            timeLimitIncrease = 1.5,
            fallSpeedIncrease = 0.10,
            penaltyIncrease = 0.2,
        },
        [3] = {
            blocksIncrease = 5,
            spawnFreqMinDecrease = 150,
            spawnFreqMaxDecrease = 200,
            timeLimitIncrease = 2.5,
            fallSpeedIncrease = 0.15,
            penaltyIncrease = 0.25,
        }
    },

    labels = {
        instructions = 'Press the letter or number keys to destroy falling blocks before they reach the bottom!',
        stage = 'Stage',
        completed = 'Stage completed!',
        failed = 'Stage failed!',
        allCompleted = 'All Stages Complete!',
        blocksDestroyed = 'Blocks Destroyed',
        target = 'Target',
    }
}

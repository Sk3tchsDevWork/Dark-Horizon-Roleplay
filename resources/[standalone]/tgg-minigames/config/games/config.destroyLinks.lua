Config = Config or {}

Config.DestroyLinks = {
    description = 'Destroy blocks from the bottom of the tower by matching the mark directions!',

    defaultNumberOfStages = 3,
    progressiveDifficulty = true,
    instantFail = false,

    stages = {

        {
            timeLimit = 8,      -- Time limit for this stage in seconds
            targetBlocks = 25,  -- Number of blocks to destroy
            penaltySeconds = 1, -- Seconds deducted per wrong move when penalty mode is enabled
        },

        {
            timeLimit = 10,
            targetBlocks = 30,
            penaltySeconds = 1,
        },

        {
            timeLimit = 11,
            targetBlocks = 34,
            penaltySeconds = 1,
        },
    },
    progression = {
        [1] = {
            timeIncrease = 2,      -- Increase time limit
            blocksIncrease = 5,    -- Increase target blocks
            penaltyIncrease = 0.1, -- Increase penalty
        },
        [2] = {
            timeIncrease = 1.5,
            blocksIncrease = 7,
            penaltyIncrease = 0.2,
        },
        [3] = {
            timeIncrease = 1,
            blocksIncrease = 8,
            penaltyIncrease = 0.35,
        }
    },

    labels = {
        instructions = 'Use A/D or ← → to destroy blocks from the bottom! Match the mark direction.',
        stage = 'Stage',
        completed = 'Stage completed!',
        failed = 'Stage failed!',
        allCompleted = 'All Stages Complete!',
        remaining = 'Remaining',
        controls = {
            destroy = 'A/← destroys left marks, D/→ destroys right marks',
        },
    }
}

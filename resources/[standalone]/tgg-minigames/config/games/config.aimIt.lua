Config = Config or {}

Config.AimIt = {
    description = 'Aim at the targets before they disappear!',

    defaultNumberOfStages = 3,
    progressiveDifficulty = true,
    instantFail = false,

    stages = {
        {
            targetsCount = 8,      -- Number of targets to hit in this stage
            targetSize = 85,       -- Size of targets in pixels
            stageTimer = 6,        -- Time limit for this stage in seconds
            penaltySeconds = 0.25, -- Seconds deducted per miss when penalty mode is enabled
        },
        {
            targetsCount = 12,
            targetSize = 75,
            stageTimer = 10,
            penaltySeconds = 0.5,
        },
        {
            targetsCount = 15,
            targetSize = 65,
            stageTimer = 12,
            penaltySeconds = 0.75,
        },
    },

    progression = {
        [1] = {
            targetsIncrease = 2,   -- Increase number of targets
            timerIncrease = 1,     -- Increase time limit
            penaltyIncrease = 0.1, -- Increase penalty
            targetSizeDecrease = 1 -- Decrease target size
        },
        [2] = {
            targetsIncrease = 3,
            timerIncrease = 1.5,
            penaltyIncrease = 0.15,
            targetSizeDecrease = 2
        },
        [3] = {
            targetsIncrease = 4,
            timerIncrease = 2,
            penaltyIncrease = 0.3,
            targetSizeDecrease = 5
        }
    },

    labels = {
        instructions = 'Click on the targets to hit them!',
        remaining = 'Remaining',
        stage = 'Stage',
        hit = 'Hit!',
        miss = 'Miss!',
        timeUp = 'Time\'s up!',
        completed = 'Stage completed!',
        failed = 'Stage failed!',
        allCompleted = 'All Stages Complete!',
        score = 'Score',
        accuracy = 'Accuracy',
    }
}

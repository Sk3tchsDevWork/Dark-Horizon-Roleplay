Config.Keys = {
    description = 'Press the keys in the correct order from left to right, row by row!',

    defaultNumberOfStages = 3,
    progressiveDifficulty = true,
    instantFail = true,

    -- Key generation settings
    useLetters = true, -- Include letters (A-Z)
    useNumbers = true, -- Include numbers (0-9)

    stages = {
        {
            timePerStage = 45, -- Time limit for this stage in seconds
            numberOfKeys = 9,  -- Number of keys to press in order to complete the stage
            penaltySeconds = 2 -- Time penalty for mistakes (when instantFail is false)
        },
        {
            timePerStage = 35,
            numberOfKeys = 12,
            penaltySeconds = 3
        },
        {
            timePerStage = 30,
            numberOfKeys = 16,
            penaltySeconds = 4
        },
    },

    progression = {
        [1] = {
            timeDecrease = 2,
            keysIncrease = 1,
            penaltyIncrease = 0.2
        },
        [2] = {
            timeDecrease = 3,
            keysIncrease = 2,
            penaltyIncrease = 0.3
        },
        [3] = {
            timeDecrease = 3,
            keysIncrease = 2,
            penaltyIncrease = 0.4
        },
    },

    labels = {
        instructions = 'Press the keys in the correct order from left to right, row by row!',
        stage = 'Stage',
        completed = 'Stage Complete!',
        failed = 'Wrong key!',
        allCompleted = 'Perfect Order!',
        timeUp = "Time's up!",
        remaining = 'Next:'
    }
}

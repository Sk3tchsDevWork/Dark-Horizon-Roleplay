Config.Numbers = {
    description = "Click the numbers in ascending order (1, 2, 3, etc.) as fast as you can!",

    defaultNumberOfStages = 3,
    progressiveDifficulty = true,
    instantFail = true,

    stages = {
        {
            gridSize = 3,      -- Size of the grid
            timePerStage = 25, -- Time limit for this stage in seconds
            penaltySeconds = 2 -- Time penalty for wrong clicks (when instantFail is false)
        },
        {
            gridSize = 4,
            timePerStage = 30,
            penaltySeconds = 3
        },
        {
            gridSize = 5,
            timePerStage = 35,
            penaltySeconds = 4
        },
    },

    progression = {
        [1] = {
            gridSizeIncrease = 1, -- Increase grid size
            timeIncrease = 5,     -- Increase time limit (Increase because the grid size is increasing)
            penaltyIncrease = 1 -- Increase penalty time
        },
        [2] = {
            gridSizeIncrease = 1,
            timeIncrease = 3,
            penaltyIncrease = 1
        },
        [3] = {
            gridSizeIncrease = 1,
            timeIncrease = 2,
            penaltyIncrease = 1
        }
    },

    labels = {
        instructions = "Click the numbers in ascending order (1, 2, 3, etc.) as fast as you can!",
        stage = "Stage",
        completed = "Stage Complete!",
        failed = "Wrong number!",
        allCompleted = "Perfect Order!",
        timeUp = "Time's up!",
        remaining = "Next:",
    }
}

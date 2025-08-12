Config.CrackIt = {
    description = 'Crack the PIN code within the time limit using color-coded feedback!',

    defaultNumberOfStages = 3,
    progressiveDifficulty = true,

    stages = {
        {
            pinSize = 4,       -- Size of the PIN
            timePerStage = 45  -- Time limit for this stage in seconds
        },
        {
            pinSize = 5,
            timePerStage = 35
        },
        {
            pinSize = 6,
            timePerStage = 45
        }
    },

    progression = {
        [1] = {
            pinSizeIncrease = 1,      -- Increase PIN size
            timePerStageDecrease = 3  -- Decrease time limit
        },
        [2] = {
            pinSizeIncrease = 1,
            timePerStageDecrease = 4
        },
        [3] = {
            pinSizeIncrease = 1,
            timePerStageDecrease = 5
        }
    },

    labels = {
        instructions = 'Enter numbers to crack the PIN. Green = correct position, Yellow = wrong position, Red = not in PIN',
        stage = 'Stage',
        completed = 'Stage completed!',
        failed = 'Stage failed!',
        allCompleted = 'All Stages Complete!',
    }
}

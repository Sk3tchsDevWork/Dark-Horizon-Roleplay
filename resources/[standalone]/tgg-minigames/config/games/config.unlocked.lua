Config.Unlocked = {
    description = 'Match colored dots with their corresponding colored lines by rotating the circles. A/D = rotate active circle, W = cycle circles, SPACE = check solution.',

    defaultNumberOfStages = 3,
    progressiveDifficulty = true,
    instantFail = false,

    stages = {
        {
            totalCircles = 3,          -- Number of circles
            emptySpacePercentage = 30, -- Percentage of empty space
            timerPerStage = 30,        -- Time limit for this stage in seconds
            penaltySeconds = 3         -- Time penalty for wrong solution (when instantFail is false)
        },
        {
            totalCircles = 4,
            emptySpacePercentage = 30,
            timerPerStage = 45,
            penaltySeconds = 4
        },
        {
            totalCircles = 5,
            emptySpacePercentage = 30,
            timerPerStage = 60,
            penaltySeconds = 5
        }
    },
    progression = {
        [1] = {
            totalCirclesIncrease = 1,         -- Increase number of circles
            emptySpacePercentageIncrease = 0, -- Increase percentage of empty space
            timerPerStageIncrease = 5,        -- Increase time limit
            penaltyIncrease = 0.5             -- Increase penalty time
        },
        [2] = {
            totalCirclesIncrease = 1,
            emptySpacePercentageIncrease = 0,
            timerPerStageIncrease = 10,
            penaltyIncrease = 0.5
        },
        [3] = {
            totalCirclesIncrease = 1,
            emptySpacePercentageIncrease = 0,
            timerPerStageIncrease = 15,
            penaltyIncrease = 0.5
        }
    },

    controls = {
        rotateLeft = 'A or Arrow Left',
        rotateRight = 'D or Arrow Right',
        cycleCircle = 'W or Arrow Up',
        lockIn = 'Space or Enter'
    },

    labels = {
        instructions = 'Rotate dot circles one at a time to match colors with lines. A/D = rotate active circle, W = cycle circles, SPACE = check solution.',
        stage = 'Stage',
        completed = 'Stage Complete!',
        failed = 'Wrong solution!',
        allCompleted = 'All Stages Complete!',
        timeUp = 'Time\'s Up!',
        time = 'Time',
        circlesRemaining = 'Circles Remaining'
    }
}

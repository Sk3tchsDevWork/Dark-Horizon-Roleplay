Config.Pathing = {
    description = 'Connect all dots by selecting the next closest one in sequence',

    defaultNumberOfStages = 3,
    progressiveDifficulty = true,

    stages = {
        {
            numberOfDots = 6,  -- Number of dots to connect
            timeLimit = 10     -- Time limit for this stage in seconds
        },
        {
            numberOfDots = 8,
            timeLimit = 10
        },
        {
            numberOfDots = 10,
            timeLimit = 12
        }
    },

    progression = {
        [1] = {
            numberOfDotsIncrease = 1, -- Increase number of dots
            timeLimitIncrease = 2     -- Increase time limit (Increase because the number of dots is increasing)
        },
        [2] = {
            numberOfDotsIncrease = 2,
            timeLimitIncrease = 2
        },
        [3] = {
            numberOfDotsIncrease = 2,
            timeLimitIncrease = 2
        }
    },

    labels = {
        instructions = 'Go to the next point closest point.',
        stage = 'Stage',
        completed = 'Path Complete!',
        failed = 'Path Failed!',
        allCompleted = 'All Paths Complete!',
    }
}

Config.AMess = {
    description = 'Untangle the mess by dragging dots to eliminate line crossings',

    defaultNumberOfStages = 3,
    progressiveDifficulty = true,

    stages = {
        {
            numberOfDots = 5,     -- Number of dots to drag
            minCrossingLines = 3, -- Minimum number of crossing lines
            timeLimit = 10        -- Time limit for this stage in seconds
        },
        {
            numberOfDots = 8,
            minCrossingLines = 5,
            timeLimit = 12.5
        },
        {
            numberOfDots = 10,
            minCrossingLines = 7,
            timeLimit = 15
        }
    },

    progression = {
        [1] = {
            numberOfDotsIncrease = 1,     -- Increase number of dots
            minCrossingLinesIncrease = 1, -- Increase minimum number of crossing lines
            timeLimitDecrease = 2         -- Decrease time limit
        },
        [2] = {
            numberOfDotsIncrease = 2,
            minCrossingLinesIncrease = 2,
            timeLimitDecrease = 3
        },
        [3] = {
            numberOfDotsIncrease = 1,
            minCrossingLinesIncrease = 2,
            timeLimitDecrease = 5
        }
    },

    labels = {
        instructions = 'Make sure none of the lines intersect each other.',
        stage = 'Stage',
        completed = 'Mess Cleaned!',
        failed = 'Tangle Failed!',
        allCompleted = 'All Messes Untangled!',
    }
}

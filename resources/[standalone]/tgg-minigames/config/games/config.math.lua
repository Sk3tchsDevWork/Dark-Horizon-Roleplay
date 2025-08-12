Config.Math = {
    description = "Compare mathematical expressions - calculate and choose if the second is greater, less, or equal to the first",

    defaultNumberOfStages = 3,
    progressiveDifficulty = true,
    instantFail = false,

    stages = {
        {
            timeLimit = 12,                  -- Time limit for this stage in seconds
            expressionsPerRound = 1,         -- Number of expressions per round
            allowedOperators = { "+", "-" }, -- Allowed mathematical operators
            minResult = 2,                   -- Minimum result for the expression
            maxResult = 15,                  -- Maximum result for the expression
            maxDifference = 8,               -- Maximum difference between the two expressions
            penaltySeconds = 6,              -- Penalty for wrong answer (when instantFail is false)
        },
        {
            timeLimit = 10,
            expressionsPerRound = 1,
            allowedOperators = { "+", "-", "*" },
            minResult = 2,
            maxResult = 25,
            maxDifference = 5,
            penaltySeconds = 5,
        },
        {
            timeLimit = 8,
            expressionsPerRound = 1,
            allowedOperators = { "+", "-", "*", "/" },
            minResult = 2,
            maxResult = 50,
            maxDifference = 3,
            penaltySeconds = 3,
        },
    },
    progression = {
        [1] = {
            timeLimitDecrease = 0.5, -- Decrease time limit
            expressionsIncrease = 0, -- Increase number of expressions
            maxResultIncrease = 2,   -- Increase maximum result
            penaltyIncrease = 0.1,   -- Increase penalty
        },
        [2] = {
            timeLimitDecrease = 1,
            expressionsIncrease = 0,
            maxResultIncrease = 5,
            penaltyIncrease = 0.2,
        },
        [3] = {
            timeLimitDecrease = 1,
            expressionsIncrease = 0,
            maxResultIncrease = 10,
            penaltyIncrease = 0.3,
        }
    },

    labels = {
        instructions = "Calculate both expressions mentally and compare: > (greater), < (less), or = (equal)",
        stage = "Stage",
        completed = "Round Complete!",
        failed = "Wrong Answer!",
        allCompleted = "All Rounds Complete!",
        timeUp = "Time's Up!",
        correct = "Correct!",
        incorrect = "Incorrect!",
        greater = "Greater (>)",
        less = "Less (<)",
        equal = "Equal (=)",
    }
}

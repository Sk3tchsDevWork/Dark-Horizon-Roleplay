Config = Config or {}

Config.Game20471 = {
    description = 'Slide numbered tiles to combine them and reach the target number!',

    defaultNumberOfStages = 3,
    progressiveDifficulty = false,

    stages = {
        {
            targetNumber = 128,     -- Target number to reach
            stageTimer = 90,        -- Time limit for this stage in seconds
            fourProbability = 0.15, -- Probability of spawning a 4
        },
        {
            targetNumber = 256,
            stageTimer = 180,
            fourProbability = 0.2,
        },
        {
            targetNumber = 512,
            stageTimer = 270,
            fourProbability = 0.25,
        },
    },

    progression = {
        [1] = {
            targetNumberMultiplier = 2,     -- Increase target number
            stageTimerIncrease = 60,        -- Increase time limit
            fourProbabilityIncrease = 0.05, -- Increase four spawn chance
        },
        [2] = {
            targetNumberMultiplier = 2,
            stageTimerIncrease = 90,
            fourProbabilityIncrease = 0.05,
        },
        [3] = {
            targetNumberMultiplier = 2,
            stageTimerIncrease = 120,
            fourProbabilityIncrease = 0.05,
        }
    },

    labels = {
        instructions = 'Use WASD or arrow keys to slide tiles. Combine matching numbers to reach the target!',
        stage = 'Stage',
        completed = 'Stage completed!',
        failed = 'Stage failed!',
        allCompleted = 'All Stages Complete!',
        stageDescription = 'Combine tiles to reach {target}!',
        score = 'Score',
        target = 'Target',
        timeLeft = 'Time',
        gameComplete = 'All Stages Complete! You are a 2047+1 Master!',
        gameOver = 'Game Over - No more moves possible',
        timeUp = 'Time\'s Up! Try again.',
    }
}

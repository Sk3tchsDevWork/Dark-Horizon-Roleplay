Config = Config or {}

Config.Breaker = {
    description = 'Break all the blocks by bouncing the ball with your paddle! Collect power-ups for special abilities.',

    progressiveDifficulty = false,
    numberOfStages = 3,

    -- Block colors
    regularBlockColors = {
        '#ef4444', -- Red
        '#f97316', -- Orange
        '#eab308', -- Yellow
        '#22c55e', -- Green
        '#3b82f6', -- Blue
        '#8b5cf6', -- Purple
        '#ec4899', -- Pink
    },

    stages = {
        {
            -- Block generation settings
            blocksPerRow = 6, -- Number of blocks per row
            numberOfRows = 3, -- Number of rows of blocks

            -- Block type percentages (out of 100)
            explodingBlockPercent = 15,   -- Percentage of exploding blocks
            multiBallBlockPercent = 8,    -- Percentage of multi-ball blocks
            paddleExpandBlockPercent = 8, -- Percentage of paddle expand blocks
            extraLifeBlockPercent = 5,    -- Percentage of extra life blocks
            doubleHitBlockPercent = 3,    -- Percentage of blocks that need 2 hits

            -- Game mechanics
            platformSpeed = 6, -- Speed of the player paddle
            ballSpeed = 4,     -- Speed of the ball
            defaultLives = 5,  -- Starting number of lives

            -- Timing settings
            paddleExpandDuration = 8,   -- Duration of paddle expansion in seconds
            paddleExpandMultiplier = 2, -- Multiplier for paddle size expansion

            -- Progression
            timeLimit = 180,    -- Time limit in seconds per stage
        },
        {
            blocksPerRow = 8,
            numberOfRows = 4,
            explodingBlockPercent = 12,
            multiBallBlockPercent = 6,
            paddleExpandBlockPercent = 6,
            extraLifeBlockPercent = 4,
            doubleHitBlockPercent = 3,
            platformSpeed = 7,
            ballSpeed = 5,
            defaultLives = 4,
            paddleExpandDuration = 7,
            paddleExpandMultiplier = 2,
            timeLimit = 150,
        },
        {
            blocksPerRow = 10,
            numberOfRows = 5,
            explodingBlockPercent = 10,
            multiBallBlockPercent = 4,
            paddleExpandBlockPercent = 4,
            extraLifeBlockPercent = 3,
            doubleHitBlockPercent = 3,
            platformSpeed = 8,
            ballSpeed = 6,
            defaultLives = 3,
            paddleExpandDuration = 6,
            paddleExpandMultiplier = 2,
            timeLimit = 120,
        },
    },

    progression = {
        [1] = {
            ballSpeedIncrease = 0.5,             -- Increase ball speed
            platformSpeedIncrease = 0.5,         -- Increase platform speed
            numberOfRowsIncrease = 0.5,          -- Increase number of rows
            timeLimitDecrease = 10,              -- Decrease time limit
            explodingBlockPercentDecrease = 1,   -- Decrease exploding block percentage
            multiBallBlockPercentDecrease = 0.5, -- Decrease multi-ball block percentage
        },
        [2] = {
            ballSpeedIncrease = 0.8,
            platformSpeedIncrease = 0.8,
            numberOfRowsIncrease = 0.8,
            timeLimitDecrease = 15,
            explodingBlockPercentDecrease = 1.5,
            multiBallBlockPercentDecrease = 0.8,
        },
        [3] = {
            ballSpeedIncrease = 1.0,
            platformSpeedIncrease = 1.0,
            numberOfRowsIncrease = 1.0,
            timeLimitDecrease = 20,
            explodingBlockPercentDecrease = 2,
            multiBallBlockPercentDecrease = 1,
        },
    },

    language = {
        title = "Breaker",
        instructions = "Break all the blocks by bouncing the ball with your paddle! Collect power-ups for special abilities.",
        stage = "Stage",
        completed = "All Blocks Destroyed!",
        failed = "Game Over!",
        allCompleted = "Perfect Breaker!",
        timeUp = "Time's up!",
        lives = "Lives",
        score = "Score",
    },
}

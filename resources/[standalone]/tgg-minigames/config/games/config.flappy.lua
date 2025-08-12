Config = Config or {}

Config.Flappy = {
    description = 'Control your bird through horizontal pipes by tapping space to flap and stay airborne!',

    defaultNumberOfStages = 3,
    progressiveDifficulty = true,

    stages = {
        {
            jumpPower = 0.8,   -- How much the bird jumps upward (vertical movement)
            fallSpeed = 0.025, -- Speed of gravity/falling down
            scrollSpeed = 0.5, -- Auto-moving speed to the right
            openingSize = 120, -- Size of the opening between pipes (in pixels)
            pipeSpacing = 350, -- Horizontal distance between pipe pairs
            pipesRequired = 8, -- Number of pipes to complete this stage
            penaltySeconds = 1,
        },

        {
            jumpPower = 0.8,
            fallSpeed = 0.03,
            scrollSpeed = 0.55,
            openingSize = 110,
            pipeSpacing = 300,
            pipesRequired = 12,
            penaltySeconds = 2,
        },

        {
            jumpPower = 0.8,
            fallSpeed = 0.035,
            scrollSpeed = 0.6,
            openingSize = 100,
            pipeSpacing = 280,
            pipesRequired = 15,
            penaltySeconds = 3,
        },
    },
    progression = {
        [1] = {
            fallSpeedIncrease = 0.005,  -- Increase fall speed
            scrollSpeedIncrease = 0.05, -- Increase scroll speed
            openingSizeDecrease = 5,    -- Decrease opening size
            pipeSpacingDecrease = 25,   -- Decrease pipe spacing
            pipesRequiredIncrease = 3,  -- Increase pipes required
            penaltyIncrease = 0.2,      -- Increase penalty
        },
        [2] = {
            fallSpeedIncrease = 0.008,
            scrollSpeedIncrease = 0.08,
            openingSizeDecrease = 8,
            pipeSpacingDecrease = 35,
            pipesRequiredIncrease = 4,
            penaltyIncrease = 0.3,
        },
        [3] = {
            fallSpeedIncrease = 0.01,
            scrollSpeedIncrease = 0.1,
            openingSizeDecrease = 10,
            pipeSpacingDecrease = 40,
            pipesRequiredIncrease = 5,
            penaltyIncrease = 0.4,
        }
    },

    labels = {
        instructions = 'Press SPACE to flap your wings! Navigate through the horizontal pipes!',
        stage = 'Stage',
        completed = 'Stage completed!',
        failed = 'Stage failed!',
        allCompleted = 'All Stages Complete!',
        gameOver = 'Game Over!',
        victory = 'Victory!',
        time = 'Time',
    }
}

Config.OnTheDot = {
    description = 'Match falling ball colors with your deflectors - avoid mismatched collisions!',

    defaultNumberOfStages = 3,
    progressiveDifficulty = true,

    stages = {
        {
            ballSpeed = 1.5,    -- Speed of falling balls (pixels per frame)
            ballSpacing = 50,   -- Space between falling balls (pixels)
            deflectorSpeed = 8, -- Speed of the 2 movable balls when moving to sides
            ballsPerStage = 8,  -- Number of balls to destroy to complete the stage
        },
        {
            ballSpeed = 2.0,
            ballSpacing = 35,
            deflectorSpeed = 10,
            ballsPerStage = 12,
        },
        {
            ballSpeed = 2.5,
            ballSpacing = 25,
            deflectorSpeed = 12,
            ballsPerStage = 15,
        }
    },

    progression = {
        [1] = {
            ballSpeedIncrease = 0.2,    -- Increase ball speed
            ballSpacingDecrease = 2,    -- Decrease ball spacing
            deflectorSpeedIncrease = 1, -- Increase deflector speed
            ballsPerStageIncrease = 2,  -- Increase number of balls to destroy
        },
        [2] = {
            ballSpeedIncrease = 0.3,
            ballSpacingDecrease = 3,
            deflectorSpeedIncrease = 1,
            ballsPerStageIncrease = 3,
        },
        [3] = {
            ballSpeedIncrease = 0.4,
            ballSpacingDecrease = 4,
            deflectorSpeedIncrease = 2,
            ballsPerStageIncrease = 4,
        }
    },

    labels = {
        instructions = 'Match falling ball colors with your deflectors - press SPACE to move side balls away!',
        stage = 'Stage',
        completed = 'Stage completed!',
        failed = 'Stage failed!',
        allCompleted = 'All Stages Complete!',
    }
}

Config.ToTheSky = {
    description = 'Doodle Jump style game - bounce on platforms to reach the sky!',

    defaultNumberOfStages = 3,
    progressiveDifficulty = true,

    stages = {
        {
            maxGeneratedTiles = 120, -- Maximum number of tiles to generate
            moveSpeed = 1.8,         -- Speed of the player
            platformWidth = 70,      -- Width of the platforms
            gravity = 0.10           -- Gravity
        },
        {
            maxGeneratedTiles = 160,
            moveSpeed = 1.6,
            platformWidth = 60,
            gravity = 0.12
        },
        {
            maxGeneratedTiles = 200,
            moveSpeed = 1.4,
            platformWidth = 50,
            gravity = 0.15
        },
    },

    progression = {
        [1] = {
            maxGeneratedTilesIncrease = 10, -- Increase maximum number of tiles to generate
            moveSpeedDecrease = 0.1,        -- Decrease speed of the player
            platformWidthDecrease = 2,      -- Decrease width of the platforms
            gravityIncrease = 0.01          -- Increase gravity
        },
        [2] = {
            maxGeneratedTilesIncrease = 15,
            moveSpeedDecrease = 0.1,
            platformWidthDecrease = 3,
            gravityIncrease = 0.015
        },
        [3] = {
            maxGeneratedTilesIncrease = 20,
            moveSpeedDecrease = 0.1,
            platformWidthDecrease = 4,
            gravityIncrease = 0.02
        },
    },

    labels = {
        instructions = 'Use A/D or Arrow Keys to move left/right. Land on platforms to bounce higher! Reach the sky!',
        stage = 'Stage',
        completed = 'Stage completed!',
        failed = 'Fell to Earth!',
        allCompleted = 'Reached the Sky!',
    }
}

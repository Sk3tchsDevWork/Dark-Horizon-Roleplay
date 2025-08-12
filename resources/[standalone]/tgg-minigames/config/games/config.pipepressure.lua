Config.PipePressure = {
    description = 'Rotate pipe segments during the delay countdown, then watch the flow travel from start to end',

    defaultNumberOfStages = 3,
    progressiveDifficulty = true,

    stages = {
        {
            gridSize = 6,        -- Size of the grid
            flowSpeed = 100,     -- Very slow - 100ms per pipe fill
            delayTime = 20,      -- Time to prepare
            fluidType = 'water', -- Type of fluid (water or gas)
            complexity = 1,      -- Complexity of the stage
        },
        {
            gridSize = 7,
            flowSpeed = 80,
            delayTime = 25,
            fluidType = 'water',
            complexity = 2,
        },
        {
            gridSize = 8,
            flowSpeed = 60,
            delayTime = 30,
            fluidType = 'gas',
            complexity = 3,
        },
    },

    progression = {
        [1] = {
            gridSizeIncrease = 1,   -- Increase grid size
            flowSpeedDecrease = 3,  -- Decrease flow speed
            delayTimeIncrease = 5,  -- Increase delay time (Increase because the grid size is increasing)
            complexityIncrease = 0, -- Increase complexity
        },
        [2] = {
            gridSizeIncrease = 1,
            flowSpeedDecrease = 5,
            delayTimeIncrease = 5,
            complexityIncrease = 0,
        },
        [3] = {
            gridSizeIncrease = 1,
            flowSpeedDecrease = 8,
            delayTimeIncrease = 10,
            complexityIncrease = 1,
        },
    },

    labels = {
        title = 'PIPE PRESSURE',
        instructions = 'Click pipes to rotate them. Connect the flow from start to end.',
        gameOver = 'Pressure Failed!',
        victory = 'All Pipes Connected!',
        stageComplete = 'Flow Complete!',
        pipeBurst = 'Pipe Burst!',
        timeUp = 'Pressure Overload!',
        connecting = 'Flow in Progress...',
        waterFlow = 'Water Flow',
        gasFlow = 'Gas Flow'
    }
}

Config.Echo = {
    description = 'Memory game - count colored boxes and answer questions about what you saw',

    defaultNumberOfStages = 3,
    progressiveDifficulty = true,

    stages = {
        {
            gridSize = 8,                      -- Size of the grid
            timePerStage = 12,                 -- Time limit for this stage in seconds
            colorRanges = {
                red = { min = 2, max = 5 },    -- Range of red boxes
                green = { min = 2, max = 5 },  -- Range of green boxes
                blue = { min = 2, max = 5 },   -- Range of blue boxes
                yellow = { min = 2, max = 5 }, -- Range of yellow boxes
            },
        },
        {
            gridSize = 10,
            timePerStage = 10,
            colorRanges = {
                red = { min = 3, max = 5 },
                green = { min = 4, max = 7 },
                blue = { min = 3, max = 6 },
                yellow = { min = 3, max = 7 },
            },
        },
        {
            gridSize = 12,
            timePerStage = 8,
            colorRanges = {
                red = { min = 5, max = 8 },
                green = { min = 6, max = 10 },
                blue = { min = 5, max = 9 },
                yellow = { min = 5, max = 10 },
            },
        },
    },
    progression = {
        [1] = {
            gridSizeIncrease = 1,     -- Increase grid size
            timePerStageDecrease = 1, -- Decrease time limit
            colorRangeIncrease = 1,   -- Increase color range
        },
        [2] = {
            gridSizeIncrease = 1,
            timePerStageDecrease = 1,
            colorRangeIncrease = 2,
        },
        [3] = {
            gridSizeIncrease = 1,
            timePerStageDecrease = 1,
            colorRangeIncrease = 3,
        }
    },

    labels = {
        instructions = 'Memorize the colored boxes, then answer how many of each color you saw',
        stage = 'Stage',
        completed = 'Stage completed!',
        failed = 'Stage failed!',
        allCompleted = 'All Stages Complete!',
        memorizePhase = 'Memorize the grid...',
        questionPhase = 'Answer the question:',
        howManyBoxes = 'How many {color} boxes were there?',
        timeUp = 'Time\'s Up!',
        wrongAnswer = 'Wrong Answer!',
        roundComplete = 'Round Complete!',
        answerKeys = 'Press 1, 2, or 3 to select your answer',
    }
}

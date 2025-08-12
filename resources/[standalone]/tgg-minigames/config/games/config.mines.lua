Config.Mines = {
    description = 'Remember the mine positions and find them all after they disappear!',

    defaultNumberOfStages = 3,
    progressiveDifficulty = true,

    stages = {
        {
            gridSize = 4,    -- Size of the grid
            minesCount = 3,  -- Number of mines to remember
            previewTime = 5, -- Time in seconds to show mine positions
            stageTime = 15,  -- Time in seconds to complete the stage (find all mines)
            maxFails = 3     -- Maximum wrong clicks allowed before stage fails
        },
        {
            gridSize = 5,
            minesCount = 5,
            previewTime = 4,
            stageTime = 12,
            maxFails = 2
        },
        {
            gridSize = 7,
            minesCount = 8,
            previewTime = 3,
            stageTime = 10,
            maxFails = 1
        }
    },

    progression = {
        [1] = {
            gridSizeIncrease = 1,      -- Increase grid size
            minesCountIncrease = 1,    -- Increase number of mines
            previewTimeDecrease = 0.5, -- Decrease preview time
            stageTimeDecrease = 1,     -- Decrease stage time
            maxFailsDecrease = 0       -- Decrease maximum fails
        },
        [2] = {
            gridSizeIncrease = 1,
            minesCountIncrease = 1,
            previewTimeDecrease = 0.5,
            stageTimeDecrease = 1,
            maxFailsDecrease = 0
        },
        [3] = {
            gridSizeIncrease = 1,
            minesCountIncrease = 2,
            previewTimeDecrease = 0.3,
            stageTimeDecrease = 1,
            maxFailsDecrease = 0
        }
    },

    labels = {
        instructions = 'Remember the mine positions, then find them all when they disappear!',
        stage = 'Stage',
        completed = 'Stage completed!',
        failed = 'Stage failed!',
        allCompleted = 'All Stages Complete!',
    }
}

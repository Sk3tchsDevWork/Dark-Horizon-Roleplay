Config.SequenceMemory = {
    description = 'Watch the sequence of highlighted boxes, then click them in the same order. Each round adds more boxes to remember.',

    defaultNumberOfStages = 3,
    progressiveDifficulty = true,

    stages = {
        {
            maxBoxesPerStage = 5, -- Maximum number of boxes per stage
            revealTime = 400,     -- Time in milliseconds to reveal the boxes
            gridSize = 3,         -- Size of the grid
            timePerStage = 90     -- Time limit for this stage in seconds
        },
        {
            maxBoxesPerStage = 6,
            revealTime = 400,
            gridSize = 4,
            timePerStage = 60
        },
        {
            maxBoxesPerStage = 8,
            revealTime = 400,
            gridSize = 5,
            timePerStage = 45
        }
    },

    progression = {
        [1] = {
            maxBoxesPerStageIncrease = 1, -- Increase maximum number of boxes per stage
            gridSizeIncrease = 1,         -- Increase grid size
            timePerStageDecrease = 5      -- Decrease time limit
        },
        [2] = {
            maxBoxesPerStageIncrease = 1,
            gridSizeIncrease = 1,
            timePerStageDecrease = 10
        },
        [3] = {
            maxBoxesPerStageIncrease = 2,
            gridSizeIncrease = 1,
            timePerStageDecrease = 15
        }
    },

    labels = {
        instructions = 'Watch the sequence of highlighted boxes, then click them in the same order. Each round adds more boxes to remember.',
        stage = 'Stage',
        completed = 'Sequence Mastered!',
        failed = 'Wrong sequence!',
        allCompleted = 'Memory Master!',
        watchSequence = 'Watch the sequence...',
        yourTurn = 'Your turn! Click the boxes in order',
        correct = 'Correct!',
        timeUp = 'Time\'s up!'
    }
}

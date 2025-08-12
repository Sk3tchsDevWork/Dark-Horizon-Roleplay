Config.ElectricalBox = {
    description = 'Fix the electrical system by finding the correct breaker switch combination!',

    defaultNumberOfStages = 3,
    progressiveDifficulty = true,

    stages = {
        {
            timePerStage = 20,        -- Time limit for this stage in seconds
            simonSequenceLength = 3,  -- Length of the sequence to follow
            lockCombinationLength = 3 -- Length of the combination to unlock
        },
        {
            timePerStage = 15,
            simonSequenceLength = 4,
            lockCombinationLength = 4
        },
        {
            timePerStage = 10,
            simonSequenceLength = 5,
            lockCombinationLength = 5
        },
    },

    progression = {
        [1] = {
            timePerStageDecrease = 1,         -- Decrease time limit
            simonSequenceLengthIncrease = 1,  -- Increase sequence length
            lockCombinationLengthIncrease = 1 -- Increase combination length
        },
        [2] = {
            timePerStageDecrease = 1,
            simonSequenceLengthIncrease = 1,
            lockCombinationLengthIncrease = 1
        },
        [3] = {
            timePerStageDecrease = 1,
            simonSequenceLengthIncrease = 1,
            lockCombinationLengthIncrease = 1
        },
    },

    labels = {
        instructions = 'Toggle breaker switches to find the correct combination and restore power to the system!',
        stage = 'Circuit',
        completed = 'Circuit Complete!',
        failed = 'Circuit Failed!',
        allCompleted = 'Power Restored!',
        switchesLabel = 'Breaker Switches:',
        statusLabel = 'System Status:',
        systemOnline = 'System Online!',
        timeUp = "Time's Up - System Overload!",
        generatingPuzzle = 'Generating Circuit...',
        testingConfiguration = 'Testing Configuration...',
        targetLabel = 'TARGET:',
        currentLabel = 'CURRENT:',
        watchSequence = 'Watch the sequence...',
        repeatSequence = 'Repeat the sequence!',
        combinationLabel = 'CODE:',
        enterCode = 'Enter the combination!'
    }
}

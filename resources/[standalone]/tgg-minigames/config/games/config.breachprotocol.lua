Config.BreachProtocol = {
    description = 'Navigate through network security matrices by finding the correct hex sequences. Alternate between row and column selections to breach the protocol.',

    defaultNumberOfStages = 3,
    progressiveDifficulty = true,

    stages = {
        {
            matrixSize = 5,     -- Size of the matrix
            sequenceLength = 4, -- Length of the sequence to find
            timeLimit = 60,     -- Time limit for this stage in seconds
            maxWrongMoves = 3   -- Maximum number of wrong moves allowed
        },
        {
            matrixSize = 6,
            sequenceLength = 4,
            timeLimit = 50,
            maxWrongMoves = 2
        },
        {
            matrixSize = 7,
            sequenceLength = 5,
            timeLimit = 40,
            maxWrongMoves = 2
        }
    },

    progression = {
        [1] = {
            matrixSizeIncrease = 1,     -- Increase matrix size
            sequenceLengthIncrease = 1, -- Increase sequence length
            timeLimitIncrease = 5,      -- Increase time limit
            maxWrongMovesIncrease = 0   -- No increase in wrong moves
        },
        [2] = {
            matrixSizeIncrease = 1,
            sequenceLengthIncrease = 1,
            timeLimitIncrease = 0,
            maxWrongMovesIncrease = 0
        },
        [3] = {
            matrixSizeIncrease = 1,
            sequenceLengthIncrease = 1,
            timeLimitIncrease = -5,
            maxWrongMovesIncrease = -1
        }
    },

    guideLines = 2, -- 1 = Show current selectable row/column, 2 = Show next available moves, 3 = Show both
    hexCodes = {
        '1C', '7A', '55', 'BD', 'E9', 'FF',
        '1C', '7A', '55', 'BD', 'E9', 'FF', -- Duplicates for higher probability
        '7A', '55', 'BD', 'E9',             -- More duplicates for common codes
        '1C', '7A', '55', 'BD'
    },

    controls = {
        select = 'Click to select hex codes',
        navigate = 'Alternate between row and column selections'
    },

    labels = {
        instructions = 'Find the target sequence in the security matrix. Navigate by alternating row and column selections.',
        stage = 'ICE Level',
        completed = 'Access Granted!',
        failed = 'Access Denied!',
        allCompleted = 'Protocol Complete!',
        targetSequence = 'Target Sequence:',
        bufferSize = 'Buffer Size:',
        networkBreach = 'Network Breach in Progress...',
        systemLockdown = 'System Lockdown!',
        sequenceReset = 'Sequence Reset - Too Many Errors',
        timeUp = 'Time\'s Up - Security Detected!',
        wrongPath = 'Wrong Path!'
    }
}

Config.Sequence = {
    description = "Find specific sequences of symbols in a grid using arrow key navigation",

    progressiveDifficulty = true,
    instantFail = false,

    stages = {
        [1] = {
            timeLimit = 30,       -- Time limit in seconds
            penaltySeconds = 2,   -- Time penalty for wrong selection when penalty mode is enabled
            sequenceLength = 4,   -- Length of sequence to find
            symbolSets = {        -- Boolean flags for each symbol set type
                shapeSide = true, -- Symbol set of shapes
                dot2x3 = true,    -- Symbol set of 2x3 dots
                dot2x4 = true,    -- Symbol set of 2x4 dots
                dominoV = true,   -- Symbol set of vertical domino
                dominoH = true,   -- Symbol set of horizontal domino
                arrows = true,    -- Symbol set of arrows
                letters = true,   -- Symbol set of letters
                numbers = true,   -- Symbol set of numbers
            },
        },
        [2] = {
            timeLimit = 25,
            penaltySeconds = 3,
            sequenceLength = 4,
            symbolSets = {
                shapeSide = true,
                dot2x3 = true,
                dot2x4 = true,
                dominoV = true,
                dominoH = true,
                arrows = true,
                letters = true,
                numbers = true,
            },
        },
        [3] = {
            timeLimit = 20,
            penaltySeconds = 4,
            sequenceLength = 4,
            symbolSets = {
                shapeSide = true,
                dot2x3 = true,
                dot2x4 = true,
                dominoV = true,
                dominoH = true,
                arrows = true,
                letters = true,
                numbers = true,
            },
        },
    },

    progression = {
        [1] = {
            timerDecrease = 2,          -- -2 seconds per stage
            penaltyIncrease = 0,        -- No penalty increase
            sequenceLengthIncrease = 0, -- No length increase
        },
        [2] = {
            timerDecrease = 3,
            penaltyIncrease = 0.5,
            sequenceLengthIncrease = 0,
        },
        [3] = {
            timerDecrease = 4,
            penaltyIncrease = 1,
            sequenceLengthIncrease = 1,
        },
    },

    -- Symbol sets available for the game
    symbolSets = {
        shapeSide = { "◧", "◨", "⬒", "⬓", "◩", "◪", "■", "🞕", "◐", "◑", "◓", "◒", "◔", "◕", "●", "◉" },
        dot2x3 = { "⠞", "⠮", "⠫", "⠝", "⠳", "⠞", "⠧", "⠼", "⠾", "⠯", "⠽", "⠷", "⠾", "⠟", "⠻", "⠿", "⠗", "⠕" },
        dot2x4 = { "⡻", "⡾", "⢗", "⢯", "⢿", "⣇", "⣏", "⣟", "⣧", "⣯", "⣷", "⣿", "⡾", "⣹", "⣻", "⣼", "⣽", "⡮" },
        dominoV = { "🁪", "🁱", "🁸", "🁿", "🂆", "🂍", "🁤", "🁥", "🁦", "🁧", "🁨", "🁩", "🁫", "🁳", "🁻", "🂃", "🂋", "🂓" },
        dominoH = { "🀲", "🀳", "🀴", "🀵", "🀶", "🀷", "🀸", "🀿", "🁆", "🁍", "🁔", "🁛", "🀹", "🁁", "🁉", "🁑", "🁙", "🁡" },
        arrows = { "⇐", "⇒", "⇑", "⇓", "⇖", "⇘", "⇗", "⇙", "⇔", "⇕" },
        letters = { "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z" },
        numbers = { "0", "1", "2", "3", "4", "5", "6", "7", "8", "9" },
    },

    labels = {
        instructions = "Find the sequence in the grid using arrow keys or WASD. Press Enter to select.",
        findSequence = "Find this sequence:",
        timeUp = "Time's up!",
        sequenceFound = "Sequence found!",
        roundComplete = "Round complete!",
        controls = "Use Arrow Keys or WASD + Enter",
    },
}

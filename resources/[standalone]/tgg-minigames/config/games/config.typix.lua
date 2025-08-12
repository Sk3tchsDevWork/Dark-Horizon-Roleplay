Config.Typix = {
    description = 'Classic word guessing game - guess the 5-letter word in exactly 6 attempts within the time limit!',

    defaultNumberOfStages = 3,
    progressiveDifficulty = true,

    stages = {
        {
            timeLimit = 300,      -- Time limit for this stage in seconds
            wordLists = {         -- Boolean flags for each word list type
                variety = false,  -- Variety of words
                animals = true,   -- Animals like gecko, leech, llama, etc.
                food = true,      -- Food like apple, mango, salad, etc.
                tech = true,      -- Technology like alarm, radar, virus, etc.
                cities = true,    -- Cities like Tokyo, Paris, etc.
                countries = true, -- Countries like Japan, China, etc.
                math = true,      -- Math like array, angle, etc.
                tools = true,     -- Tools like drill, wrench, etc.
                nsfw = false,     -- NSFW words like nudes, boobs, penis, etc.
            },
        },
        {
            timeLimit = 240,
            wordLists = {
                variety = false,
                animals = true,
                food = true,
                tech = true,
                cities = true,
                countries = true,
                math = true,
                tools = true,
                nsfw = false,
            },
        },
        {
            timeLimit = 180,
            wordLists = {
                variety = false,
                animals = true,
                food = true,
                tech = true,
                cities = true,
                countries = true,
                math = true,
                tools = true,
                nsfw = false,
            },
        },
    },

    progression = {
        [1] = {
            timeLimitDecrease = 30 -- Decrease time limit
        },
        [2] = {
            timeLimitDecrease = 45
        },
        [3] = {
            timeLimitDecrease = 60
        },
    },

    labels = {
        instructions = 'Guess the 5-letter word in 6 attempts. Green = correct position, Yellow = wrong position, Gray = not in word.',
        stage = 'Round',
        completed = 'Word Found!',
        failed = 'Word Not Found!',
        allCompleted = 'All Rounds Complete!',
        timeLabel = 'Time',
        attemptsLabel = 'Attempts',
        guessLabel = 'Guess'
    }
}

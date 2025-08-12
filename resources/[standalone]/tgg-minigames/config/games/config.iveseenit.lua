Config.IveSeenIt = {
    description =
    'Test your memory by identifying whether you\'ve seen words before! Click "Seen" if you\'ve seen the word before in this session, or "New" if it\'s the first time you see it.',

    defaultNumberOfStages = 3,
    progressiveDifficulty = true,
    repeatWordChance = 50, -- Percentage chance to repeat a word from current stage

    stages = {
        {
            wordsPerStage = 20, -- Number of words per stage
            timePerStage = 18   -- Time limit for this stage in seconds
        },
        {
            wordsPerStage = 25,
            timePerStage = 21
        },
        {
            wordsPerStage = 30,
            timePerStage = 25
        }
    },
    progression = {
        [1] = {
            wordsPerStageIncrease = 2, -- Increase number of words per stage
            timePerStageDecrease = 1   -- Decrease time limit
        },
        [2] = {
            wordsPerStageIncrease = 3,
            timePerStageDecrease = 2
        },
        [3] = {
            wordsPerStageIncrease = 5,
            timePerStageDecrease = 3
        }
    },

    labels = {
        instructions = 'Click "Seen" if you\'ve seen this word before in this session, or "New" if it\'s the first time you see it.',
        stage = 'Stage',
        completed = 'Stage Complete!',
        failed = 'Wrong answer!',
        allCompleted = 'Perfect Memory!',
        seenButton = 'SEEN',
        newButton = 'NEW',
        correct = 'Correct!',
        timeUp = 'Time\'s up!'
    }
}

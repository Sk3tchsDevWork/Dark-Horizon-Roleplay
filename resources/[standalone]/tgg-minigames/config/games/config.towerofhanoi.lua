Config.TowerOfHanoi = {
    description = 'Move all disks to the rightmost tower. Only move one disk at a time. Cannot place larger disk on smaller disk.',

    defaultNumberOfStages = 3,
    progressiveDifficulty = true,

    stages = {
        {
            numberOfDisks = 3, -- Number of disks
            timePerStage = 180 -- Time limit for this stage in seconds
        },
        {
            numberOfDisks = 4,
            timePerStage = 120
        },
        {
            numberOfDisks = 5,
            timePerStage = 90
        }
    },
    progression = {
        [1] = {
            numberOfDisksIncrease = 0, -- Increase number of disks
            timePerStageDecrease = 10  -- Decrease time limit
        },
        [2] = {
            numberOfDisksIncrease = 1,
            timePerStageDecrease = 15
        },
        [3] = {
            numberOfDisksIncrease = 1,
            timePerStageDecrease = 20
        }
    },

    labels = {
        instructions = 'Move all disks to the rightmost tower. Only move one disk at a time. Cannot place larger disk on smaller disk.',
        stage = 'Stage',
        completed = 'Stage completed!',
        failed = 'Stage failed!',
        allCompleted = 'All Stages Complete!',
    }
}

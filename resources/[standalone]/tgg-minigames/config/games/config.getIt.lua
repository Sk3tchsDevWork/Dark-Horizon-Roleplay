Config = Config or {}

Config.GetIt = {
    description = 'Classic snake game - collect food to grow and complete each stage!',

    defaultNumberOfStages = 3,
    progressiveDifficulty = true,

    stages = {
        {
            speed = 120,     -- Speed of the snake (ms)
            foodTarget = 8,  -- Number of food items to collect
            stageTimer = 40, -- Time limit for this stage in seconds
        },
        {
            speed = 90,
            foodTarget = 10,
            stageTimer = 50,
        },
        {
            speed = 60,
            foodTarget = 12,
            stageTimer = 60,
        },
    },
    progression = {
        [1] = {
            speedIncrease = 10, -- Increase speed (slower movement)
            foodIncrease = 3,   -- Increase food target
            timerIncrease = 5,  -- Increase time limit
        },
        [2] = {
            speedIncrease = 15,
            foodIncrease = 3,
            timerIncrease = 8,
        },
        [3] = {
            speedIncrease = 20,
            foodIncrease = 5,
            timerIncrease = 10,
        }
    },

    labels = {
        instructions = 'Use WASD or arrow keys to move the snake. Collect food to grow and complete each stage!',
        stage = 'Stage',
        completed = 'Stage completed!',
        failed = 'Stage failed!',
        allCompleted = 'All Stages Complete!',
        foodCollected = 'Food Collected',
        target = 'Target',
        controls = {
            move = 'Use WASD or Arrow Keys to move',
        },
    }
}

Config.StickIt = {
    description = 'Shoot pins into the rotating circle without hitting existing pins. Tap to shoot!',

    gameSettings = {
        changeRotationChance = 50 -- 0-100 percentage chance to change direction when pin is placed
    },

    defaultNumberOfStages = 3,
    progressiveDifficulty = true,

    stages = {
        {
            pinsToComplete = 8, -- Number of pins to complete
            rotationSpeed = 50  -- Speed of the rotation (ms)
        },
        {
            pinsToComplete = 12,
            rotationSpeed = 65
        },
        {
            pinsToComplete = 16,
            rotationSpeed = 80
        }
    },

    progression = {
        [1] = {
            pinsToCompleteIncrease = 2, -- Increase number of pins to complete
            rotationSpeedIncrease = 10  -- Increase speed of the rotation
        },
        [2] = {
            pinsToCompleteIncrease = 3,
            rotationSpeedIncrease = 15
        },
        [3] = {
            pinsToCompleteIncrease = 4,
            rotationSpeedIncrease = 20
        }
    },

    controls = {
        shoot = 'Click or Tap to shoot pins'
    },

    labels = {
        instructions = 'Shoot pins into the rotating circle without hitting existing pins. Click to shoot!',
        stage = 'Stage',
        completed = 'Stage Complete!',
        failed = 'Collision!',
        allCompleted = 'All Stages Complete!',
        gameOver = 'Game Over',
        success = 'Success',
        tapToShoot = 'Tap to Shoot',
        pinsRemaining = 'Pins Remaining'
    }
}

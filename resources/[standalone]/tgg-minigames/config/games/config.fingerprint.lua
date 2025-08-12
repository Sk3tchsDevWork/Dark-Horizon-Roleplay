Config.Fingerprint = {
    description = 'Assemble the fingerprint by aligning all 5 parts correctly!',

    numberOfStages = 3,

    defaultStage = {
        timePerStage = 60,        -- Time limit for this stage in seconds
        numberOfFingerprints = 3, -- Minimum number of fingerprints
        ringCount = 8,            -- Number of rings
        minArcLength = 8,         -- Minimum arc length (in degrees)
        maxArcLength = 60,        -- Maximum arc length (in degrees)
        minLineSpacing = 15,      -- Minimum line spacing (in degrees)
    },

    language = {
        title = "Fingerprint",
        instructions = "Assemble the fingerprint by aligning all 5 parts correctly!",
        stage = "Stage",
        completed = "Fingerprint Assembled!",
        failed = "Failed!",
        allCompleted = "Perfect Match!",
        timeUp = "Time's up!",
    },
}

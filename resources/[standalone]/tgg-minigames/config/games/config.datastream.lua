Config.DataStream = {
    description = 'Intercept and decrypt network data packets to breach secure communications!',

    defaultNumberOfStages = 3,
    progressiveDifficulty = true,
    instantFail = false,

    stages = {
        {
            packetSpeed = 0.8,     -- Speed of packet flow
            targetPacketCount = 3, -- Number of packets to capture
            timeLimit = 75,        -- Time limit for this stage in seconds
            maxWrongCaptures = 4,  -- Maximum number of wrong captures allowed
            penaltySeconds = 3     -- Time penalty for wrong packet capture (when instantFail is false)
        },
        {
            packetSpeed = 1,
            targetPacketCount = 4,
            timeLimit = 60,
            maxWrongCaptures = 3,
            penaltySeconds = 4
        },
        {
            packetSpeed = 1.2,
            targetPacketCount = 5,
            timeLimit = 50,
            maxWrongCaptures = 2,
            penaltySeconds = 5
        },
    },

    progression = {
        [1] = {
            packetSpeedIncrease = 0.1,     -- Increase packet speed
            targetPacketCountIncrease = 1, -- Increase target packet count
            timeLimitDecrease = 5,         -- Decrease time limit
            penaltyIncrease = 0.5          -- Increase penalty time
        },
        [2] = {
            packetSpeedIncrease = 0.2,
            targetPacketCountIncrease = 1,
            timeLimitDecrease = 10,
            penaltyIncrease = 0.5
        },
        [3] = {
            packetSpeedIncrease = 0.3,
            targetPacketCountIncrease = 2,
            timeLimitDecrease = 15,
            penaltyIncrease = 0.5
        },
    },

    labels = {
        instructions = 'Intercept the target packets as they flow through the network channels. Click to capture them and decrypt when prompted.',
        stage = 'Network Layer',
        completed = 'Data intercepted!',
        failed = 'Network breach detected!',
        allCompleted = 'All Data Streams Compromised!',
        packetsRemaining = 'Packets Remaining',
        networkTraffic = 'Network Traffic',
        dataIntercepted = 'Data Intercepted',
        decryptionRequired = 'Decryption Required',
        accessGranted = 'Access Granted',
        accessDenied = 'Access Denied',
        wrongPacket = 'Wrong packet captured!',
        timeUp = 'Network timeout!',
        decryptionFailed = 'Decryption failed!'
    }
}

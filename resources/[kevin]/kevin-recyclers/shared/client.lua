return {
    modelLoadTimeout = 50000, -- time in ms to wait for the model to load before giving up and giving an error
    entitySpawnRange = 50.0, -- distance in which the entities will be spawned
    interaction = {
        resource = 'ox', -- ox, qb, interact ( if using interact remove all the coords below the top section in the crates table)
        distance = 3.0,
    },
    models = {
        active = `bzzz_prop_recycler_a`,
        inactive = `bzzz_prop_recycler_b`,
    },
}
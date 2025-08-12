if not Config.Police.Jail?.Refresh then
    return
end

local interval = (Config.Police.Jail.Interval or 60) * 1000

Wait(2500)

if not GetRemainingPrisonSentence then
    debugprint("^1[ERROR]^7: GetRemainingPrisonSentence is not defined - can't refresh jail time")
    return
end

local function UpdateJailTimes()
    debugprint("Updating jail times...")

    local prisoners = MySQL.query.await("SELECT id, prisoner FROM lbtablet_police_jail WHERE jail_time > 0") --[[@as { id: number, prisoner: string }[] ]]

    for i = 1, #prisoners do
        local prisoner = prisoners[i]
        local remainingTime = GetRemainingPrisonSentence(prisoner.prisoner) or 0

        MySQL.update.await(
            "UPDATE lbtablet_police_jail SET jail_time = ? WHERE id = ?",
            { prisoner.id, remainingTime }
        )
    end
end

SetInterval(UpdateJailTimes, interval)

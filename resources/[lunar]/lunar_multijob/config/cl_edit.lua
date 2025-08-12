function IsBossGrade(job)
    if Framework.name == 'es_extended' then
        return Framework.getJob() == job and
            Config.BossMenu.Grades[Framework.object.GetPlayerData().job.grade_name]
    elseif Framework.name == 'qb-core' then
        return Framework.getJob() == job and Framework.object.Functions.GetPlayerData().job.isboss
    end
end
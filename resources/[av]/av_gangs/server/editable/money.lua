function getMoney(source,gang)
    local money = 0
    money = exports['av_laptop']:getMoney(source, Config.MoneyAccount)
    return money
end

function removeMoney(source,gang,amount)
    exports['av_laptop']:removeMoney(source, Config.MoneyAccount, amount)
end

function addMoney(source,gang,amount)
    exports['av_laptop']:addMoney(source, Config.MoneyAccount, amount)
end
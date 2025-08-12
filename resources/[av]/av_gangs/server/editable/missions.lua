Config = Config or {}
Config.Missions = {
  {
    name = "test", -- an identifier
    label = "Test Robbery", -- shown in app as mission title
    price = 2500, -- number or false
    difficulty = 1, -- from 0 to 5
    level = 0, -- min gang level required
    image = "https://r2.fivemanage.com/QmVAYSlqeAlD4IxVbdvu5/laundromat.png",
    description = "Lorem, ipsum dolor sit amet consectetur adipisicing elit. Repudiandae fugiat aspernatur illo enim odio id nam qui ad minus quis.",
    isClient = false, -- true it will trigger "event" client side, false will trigger it server side
    event = "av_gangs:testmission", -- server event to trigger
    started = false
  },
}

lib.callback.register('av_gangs:getMissions', function(source)
  return Config.Missions
end)

RegisterServerEvent('av_gangs:updateMission', function(name,started)
  local update = false
  if Config.Missions and next(Config.Missions) then
    for k, v in pairs(Config.Missions) do
      if v['name'] == name then
        v['started'] = started
        update = true
        break
      end
    end
    if update then
      TriggerClientEvent('av_gangs:updateMission', -1, name, started)
    end
  end
end)

RegisterServerEvent('av_gangs:testmission', function(data)
  print(json.encode(data, {indent = true}))
  TriggerEvent('av_gangs:updateMission', data['name'], true)
  local original = exports['av_gangs']:getMission(data['name'])
  if original and not original['price'] or (original['price'] == data['price']) then
    print("Everything ok with price, keep running the event...")
  else
    print("Price got manipulated by player, ban him or do whatever u want")
  end
end)

exports("registerMission", function(data)
  Config.Missions = Config.Missions or {}
  Config.Missions[#Config.Missions+1] = data
end)

exports("getMission", function(name)
  if not name then return false end
  if Config.Missions and next(Config.Missions) then
    for k, v in pairs(Config.Missions) do
      if v['name'] == name then
        return v
      end
    end
  end
  return false
end)
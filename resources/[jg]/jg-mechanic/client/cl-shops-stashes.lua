local shopZones, shopPeds, shopPoints = {}, {}, {}
local stashZones, stashPeds, stashPoints = {}, {}, {}

local function drawMarkerOnFrame(coords, marker)
  ---@diagnostic disable-next-line: missing-parameter
  DrawMarker(marker.id, coords.x, coords.y, coords.z, 0, 0, 0, 0, 0, 0, marker.size.x,  marker.size.y, marker.size.z, marker.color.r, marker.color.g, marker.color.b, marker.color.a, marker.bobUpAndDown, marker.faceCamera, 0, marker.rotate, marker.drawOnEnts)
end

local function drawCustomMarker(center, marker, shopDistance, mechanicId, shopName, stashName)
  if not marker then
    if shopName and not stashName then
      debugPrint("Marker is not setup for [SHOPS] ".. shopName .. " for location: " .. mechanicId, "warning")
    elseif stashName then
      debugPrint("Marker is not setup for [STASHES] " .. stashName .. " for location: " .. mechanicId, "warning")
    end

    return
  end
  
  local point = lib.points.new({
    coords = center,
    distance = shopDistance or 20,
  })

  function point:nearby()
    drawMarkerOnFrame(center, marker)
  end

  return point
end

local function openShop(mechanicId, shopIndex)
  local mechanicConfig = Config.MechanicLocations[mechanicId]

  if not mechanicConfig or not mechanicConfig.shops or not mechanicConfig.shops[shopIndex] then
    Framework.Client.Notify("Shop not found: " .. mechanicId .. " .. index: " .. shopIndex, "error")
    return
  end

  local shop = mechanicConfig.shops[shopIndex]
  local shopItems = shop.items or {}

  local options = {}
  for index, v in pairs(shopItems) do
    table.insert(options, {
      title = v.label,
      icon = "box",
      description = ("Buy for %d %s"):format(v.price, Config.Currency),
      event = "jg-mechanic:client:input-shop-purchase-qty",
      args = { shopIndex = shopIndex, itemIndex = index, item = v.name, price = v.price, mechanicId = mechanicId }
    })
  end

  local context = {
    id = "shop_" .. mechanicId .. "_" .. shopIndex,
    title = shop.name .. " Shop",
    options = options
  }

  if Config.Menus == "lation_ui" then exports.lation_ui:registerMenu(context) else lib.registerContext(context) end
  if Config.Menus == "lation_ui" then exports.lation_ui:showMenu(("shop_%s_%s"):format(mechanicId, shopIndex)) else lib.showContext(("shop_%s_%s"):format(mechanicId, shopIndex)) end
end

RegisterNetEvent("jg-mechanic:client:input-shop-purchase-qty", function(args)
  local input = lib.inputDialog("Enter the amount you want to buy", { "Amount" })

  if not input then 
    Framework.Client.Notify("Invalid amount", "error")
    return 
  end

  local qty = tonumber(input[1])
  if qty == nil or qty <= 0 then
    Framework.Client.Notify("Invalid amount entered", "error")
    return
  end

  TriggerServerEvent("jg-mechanic:server:buy-item", args.shopIndex, args.itemIndex, qty, args.mechanicId)
end)

function createMechanicShops()
  for _, zone in pairs(shopZones) do
    if zone and zone.remove then zone:remove() end
  end

  for _, ped in pairs(shopPeds) do
    if ped then DeleteEntity(ped) end
  end

  for _, point in pairs(shopPoints) do
    if point and point.remove then point:remove() end
  end

  shopZones, shopPeds, shopPoints = {}, {}, {}

  for mechanicId, mechanicConfig in pairs(Config.MechanicLocations) do
    local isMechanicEmployee = lib.callback.await("jg-mechanic:server:is-mechanic-employee", false, mechanicId)
    if not isMechanicEmployee then goto continue end

    if not mechanicConfig.shops then
      debugPrint(("No shops defined for '%s' in Config.MechanicLocations"):format(mechanicId), "warning")
      goto continue
    end

    for shopIndex, shop in ipairs(mechanicConfig.shops) do
      if shop.type == "self-service" then
        debugPrint(("Skipping self-service shop for '%s' (index: %d)"):format(mechanicId, shopIndex), "debug")
        goto shop_continue
      end

      if not shop.coords or not shop.size then
        debugPrint(("Invalid shop data for '%s' (index: %d) - missing coords or size"):format(mechanicId, shopIndex), "warning")
      end

      if shop.usePed then
        local ped = createPedForTarget(shop.pedModel or "s_m_m_lathandy_01", shop.coords.xyz)
        shopPeds[#shopPeds+1] = ped

        -- If vec4, set heading
        if shop.coords.w then
          SetEntityHeading(ped, shop.coords.w or 0)
        end

        if Config.Target == "qb-target" then
          exports["qb-target"]:AddTargetEntity(ped, {
            options = {
              {
                label = "Access Shop",
                icon = "fas fa-store",
                action = function()
                  openShop(mechanicId, shopIndex)
                end,
              },
            },
            distance = 2.5,
          })
        elseif Config.Target == "ox_target" then
          exports.ox_target:addLocalEntity(ped, {
            {
              name = "access_shop_" .. mechanicId .. "_" .. shopIndex,
              label = "Access Shop",
              icon = "fas fa-store",
              onSelect = function()
                openShop(mechanicId, shopIndex)
              end,
            },
          })
        end
      else
        local zoneData = {
          coords = shop.coords,
          size = vector3(shop.size, shop.size, 2.0),
          rotation = shop.coords.w or 0,
          debug = Config.Debug,
          onEnter = function()
            Framework.Client.ShowTextUI("Press [E] to access " .. shop.name)
          end,
          onExit = function()
            Framework.Client.HideTextUI()
            lib.hideContext()
          end,
          inside = function()
            if IsControlJustReleased(0, 38) then
              openShop(mechanicId, shopIndex)
            end
          end
        }

        local zone = lib.zones.box(zoneData)
        shopZones[#shopZones+1] = zone

        local point = drawCustomMarker(shop.coords, shop.marker, 10.0, mechanicId, shop.name, nil)
        shopPoints[#shopPoints + 1] = point
      end

      ::shop_continue::
    end

    ::continue::
  end
end

function createMechanicStashes()
  for _, zone in pairs(stashZones) do
    if zone and zone.remove then zone:remove() end
  end

  for _, ped in pairs(stashPeds) do
    if ped then DeleteEntity(ped) end
  end

  for _, point in pairs(stashPoints) do
    if point and point.remove then point:remove() end
  end

  stashZones, stashPeds, stashPoints = {}, {}, {}

  for mechanicId, mechanicConfig in pairs(Config.MechanicLocations) do
    local isMechanicEmployee = lib.callback.await("jg-mechanic:server:is-mechanic-employee", false, mechanicId)
    if not isMechanicEmployee then goto continue end

    if not mechanicConfig or not mechanicConfig.stashes then
      debugPrint(("No stashes defined for '%s' in Config.MechanicLocations"):format(mechanicId), "warning")
      goto continue
    end

    for stashIndex, stash in ipairs(mechanicConfig.stashes) do
      if stash.type == "self-service" then
        debugPrint(("Skipping self-service stash for '%s' (index: %d)"):format(mechanicId, stashIndex), "debug")
        goto stash_continue
      end

      if not stash.coords or not stash.size then
        debugPrint(("Invalid stash data for '%s' (index: %d) - missing coords or size"):format(mechanicId, stashIndex), "warning")
        goto stash_continue
      end

      local stashId = mechanicId .. "_" .. stash.name:gsub(" ", "_"):lower() .. "_" .. stashIndex

      if stash.usePed then
        local ped = createPedForTarget(stash.pedModel or "s_m_m_lathandy_01", stash.coords.xyz)
        stashPeds[#stashPeds + 1] = ped

        -- If vec4, set heading
        if stash.coords.w then
          SetEntityHeading(ped, stash.coords.w or 0)
        end

        if Config.Target == "qb-target" then
          exports["qb-target"]:AddTargetEntity(ped, {
            options = {
              {
                label = "Access Stash",
                icon = "fas fa-box",
                action = function()
                  Framework.Client.OpenInventoryStash(stashId, stash.name)
                end,
              },
            },
            distance = 2.5,
          })
        elseif Config.Target == "ox_target" then
          exports.ox_target:addLocalEntity(ped, {
            {
              name = "access_stash_" .. stashId,
              label = "Access Stash",
              icon = "fas fa-box",
              onSelect = function()
                Framework.Client.OpenInventoryStash(stashId, stash.name)
              end,
            },
          })
        end
      else
        local zoneData = {
          coords = stash.coords,
          size = vector3(stash.size, stash.size, 2.0),
          rotation = stash.coords.w or 0,
          debug = Config.Debug,
          onEnter = function()
            Framework.Client.ShowTextUI("Press [E] to access " .. stash.name)
          end,
          onExit = function()
            Framework.Client.HideTextUI()
          end,
          inside = function()
            if IsControlJustReleased(0, 38) then
              Framework.Client.OpenInventoryStash(stashId, stash.name)
            end
          end
        }

        local zone = lib.zones.box(zoneData)
        stashZones[#stashZones + 1] = zone
        
        local point = drawCustomMarker(stash.coords, stash.marker, 10.0, mechanicId, nil, stash.name)
        stashPoints[#stashPoints + 1] = point 
      end

      ::stash_continue::
    end

    ::continue::
  end
end

-- Remove peds on resource stop/restart
AddEventHandler("onResourceStop", function(resource)
  if resource ~= GetCurrentResourceName() then return end

  if shopPeds then
    for _, ped in pairs(shopPeds) do
      if DoesEntityExist(ped) then
        DeleteEntity(ped)
      end
    end
    shopPeds = {}
  end

  if stashPeds then
    for _, ped in pairs(stashPeds) do
      if DoesEntityExist(ped) then
        DeleteEntity(ped)
      end
    end
    stashPeds = {}
  end
end)
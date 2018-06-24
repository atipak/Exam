local sensorInfo = {
    name = "PeeperExploreation",
    desc = "Checks all units in peeper LOS and adds them to table",
    author = "patik",
    date = "2018-06-21",
    license = "notAlicense",
}

local EVAL_PERIOD_DEFAULT = -1 -- acutal, no caching

function getInfo()
    return {
        period = EVAL_PERIOD_DEFAULT
    }
end

exploredUnits = {}
peepersLOS = 900
clock = os.clock
lastPosition = nil
lastTime = 0
timeout = 3

-- is peeper on the ground
function checkPosition(position)
  if lastTime == 0 then
    lastTime = clock()
  end
  if clock() - lastTime > timeout then 
    if lastPosition ~= nil then
      if lastPosition.x == position.x and lastPosition.y == position.y and lastPosition.z == position.z then
        return true
      else
        lastPosition = position
        return false
      end 
    end
    lastTime = clock()
  end
  lastPosition = position
  return false
end


-- @description 
return function(unitId)
  -- returns nil until peeper is dead or is on the ground
  if Spring.ValidUnitID(unitId) and not Spring.GetUnitIsDead(unitId) then
    local peeperPosition = Vec3(Spring.GetUnitPosition(unitId))
    local minX, maxX, minZ, maxZ = peeperPosition.x - peepersLOS, peeperPosition.x + peepersLOS, peeperPosition.z - peepersLOS, peeperPosition.z + peepersLOS  
    local unitsRec = Spring.GetUnitsInRectangle(minX, minZ, maxX, maxZ)
    for i = 1, #unitsRec do
      local unit = unitsRec[1]
      local defType = Spring.GetUnitDefID(unit)
      local pos = Vec3(Spring.GetUnitPosition(unit))
      local team = Spring.GetUnitTeam(unit)
      if defType ~= nil then 
        exploredUnits[unit] = {id = unit, pos = pos, defId = defType, team = team}
      end
    end
    if not checkPosition(peeperPosition) then
      return nil
    else
      return exploredUnits
    end
  else
    return exploredUnits
  end
end
local sensorInfo = {
	name = "CreatesTriplets",
	desc = "Add to given array with already stored keys a new key with begin positions",
	author = "Patik",
	date = "2018-05-11",
	license = "notAlicense",
}

local EVAL_PERIOD_DEFAULT = -1 -- acutal, no caching

function getInfo()
	return {
		period = EVAL_PERIOD_DEFAULT 
	}
end

-- global variable
function isUnitAvaible(actualInfo, unitsIds)
  if #unitsIds == 0 then
    return nil
  end
  for j = 1, #unitsIds do
    local unitID = unitsIds[j]
    for i = 1, #actualInfo do
      local unitID = actualInfo[i].id
      if unitID == unitID then
        return unitID
      end
    end
  end
  return nil
end


local distance = 50

-- @description 
return function(actualInfo)
  if #units == 0 then
    return nil
  end
  local restarts = {false, false, false}
  for i = 1, #actualInfo do
    local unitID = actualInfo[i].id
    if not Spring.ValidUnitID(unitID) or Spring.GetUnitIsDead(unitID) then
      actualInfo[i] = nil 
      restarts[i] = true
    end
  end
  for i = 1, 3 do
    if actualInfo[i] == nil then
      local unit = isUnitAvaible(actualInfo, units)  
      if unit ~= nil then
        actualInfo[#actualInfo + 1] = {id = unit, distance = distance, pathId = i}
      else
        break
      end
    end
  end
  return {restarts = restarts, newInfo = actualInfo}
end
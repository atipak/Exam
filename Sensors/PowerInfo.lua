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
    local isFree = true
    for i = 1, #actualInfo do
      local unitIds = actualInfo[i].ids
      for j = 1, #unitIds  do
        local unitId = unitIds[j]
        if unitId == unitID then
           isFree = false
        end
      end
    end
    if isFree then
      return unitID
    end
  end
  return nil
end


local distance = 0
local shift = 10

-- @description 
return function(actualInfo, missionInfo)
  units = Sensors.Exam.GetUnits({armzeus = true, armmav = true})
  if #units == 0 then
    return nil
  end
  local restarts = {false, false, false}
  for i = 1, #actualInfo do
    local unitIds = actualInfo[i].ids
    local actualIds = {}
    for j = 1, #unitIds  do
      local unitId = unitIds[j]
      if Spring.ValidUnitID(unitId) and not Spring.GetUnitIsDead(unitId) then
        actualIds[#actualIds + 1] = unitId 
      end
    end
    if #actualIds == 0 then
      actualInfo[i] = nil 
      restarts[i] = true
    else
      actualInfo[i].ids = actualIds 
    end
  end
  for i = 1, 3 do
    if actualInfo[i] == nil then
      local avaibleUnits = {}
      for j = 1, 5 do
        local unit = isUnitAvaible(actualInfo, units)  
        if unit ~= nil then
          avaibleUnits[#avaibleUnits + 1] = unit
        else
          break
        end 
      end 
      if #avaibleUnits == 5 then
        local pathId = Sensors.Exam.ChooseBestCoridor(missionInfo)
        actualInfo[#actualInfo + 1] = {ids = avaibleUnits, distance = distance, pathId = pathId, shift = shift}
      else
        break
      end
    end
  end
  return {restarts = restarts, newInfo = actualInfo}
end
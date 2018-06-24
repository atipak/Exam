local sensorInfo = {
	name = "GetUnits",
	desc = "Returns ids of units by given type. It can return {}",
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


-- @description 
return function(unitsNames)
  -- unitsNames = {unitNameType = true, ...}
  local allMyUnits = Spring.GetTeamUnits(Spring.GetLocalTeamID())
  -- there are no units
  if #allMyUnits == 0 then 
    return {}
  end
  local unitsToRescue = {}
  -- if unit name is in array with correct names is this unit added
  -- unitsNames from sensor UnitNames
  local index = 1
  for i = 1, #allMyUnits do
    local unitId = allMyUnits[i]
    local unitDefID = Spring.GetUnitDefID(unitId)
    if unitsNames[UnitDefs[unitDefID].name] then
       unitsToRescue[index] = unitId
       index = index + 1  
    end          
  end 
  return unitsToRescue
end
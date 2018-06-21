local sensorInfo = {
	name = "UnitsToRescue",
	desc = "Creates vector of dimension count with values of given value",
	author = "Patik",
	date = "2018-05-11",
	license = "notAlicense",
}

local EVAL_PERIOD_DEFAULT = 0 -- acutal, no caching

function getInfo()
	return {
		period = EVAL_PERIOD_DEFAULT 
	}
end


-- check function
function isUnitOK(unitID)
  if not Spring.ValidUnitID(unitID) or Spring.GetUnitIsDead(unitID) then
    return false
  else
    return true
  end
end

-- check function
function getDeadUnits(unitsIds)
  local deadUnits = {}
  for i = 1, #unitsIds do
    if Spring.GetUnitIsDead(unitsIds[i]) then
      deadUnits[#deadUnits + 1] = unitsIds[i]
    end
  end
  return deadUnits
end

local reclaimRadius = 300

-- @description 
return function(unitId)
  if not isUnitOK(unitId) then
    return nil
  end 
  local lx, ly, lz = Spring.GetUnitPosition(unitId)
  local nearUnits = Spring.GetUnitsInSphere(lx, ly, lz, reclaimRadius)
  if nearUnits == nil or #nearUnits == 0 then 
    return nil                                                    
  end 
  nearUnits = getDeadUnits(nearUnits)
  if #nearUnits == 0 then 
    return nil
  else
    return nearUnits[1]                                                    
  end 
end
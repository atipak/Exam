function getInfo()
	return {
		onNoUnits = SUCCESS,
		parameterDefs = {
      { 
				name = "path",
				variableType = "expression",
				componentType = "editBox",
				defaultValue = "{}"
			}, 
      { 
				name = "unitIds",
				variableType = "expression",
				componentType = "editBox",
				defaultValue = "{}"
			}
		}
	}
end

targetPlaces = {}
threshold = 700

-- the function function send all given units to given location, no wating for command completing
function Run(self, unitIds, parameter)
  local path = parameter.path 
  for i = 1, #parameter.unitIds do
    local unitId = parameter.unitIds[i] 
    Spring.GiveOrderToUnit(unitId, CMD.MOVE, path[#path].position:AsSpringVector(), {})
  end 
  return SUCCESS
end

-- check function
function isUnitOK(unitID)
  if not Spring.ValidUnitID(unitID) or Spring.GetUnitIsDead(unitID) then
    return false
  else
    return true
  end
end

-- check if given unit is on target position 
-- threshold is global variable
function isOnPosition(transporterID, targetPosition) 
  local tranPosX, tranPosY, tranPosZ = Spring.GetUnitPosition(transporterID)
  if math.abs(tranPosX - targetPosition.x) > threshold or math.abs(tranPosZ - targetPosition.z) > threshold then 
      return false  
  end 
  return true
end


 
  
function getInfo()
	return {
		onNoUnits = SUCCESS,
		parameterDefs = { 
      { 
				name = "unitId",
				variableType = "expression",
				componentType = "editBox",
				defaultValue = "{}"
			},
      { 
				name = "deadUnitId",
				variableType = "expression",
				componentType = "editBox",
				defaultValue = "{}"
			}
		}
	}
end

local reclaimRadius = 300
actualReclaimedUnit = nil

-- reclaims units
function Run(self, unitIds, parameter) 
  if not isUnitOK(parameter.unitId) then
    actualReclaimedUnit = nil
    return SUCCESS
  end 
  if not isUnitDead(parameter.deadUnitId) then
    actualReclaimedUnit = nil
    return SUCCESS
  else
    if Spring.ValidUnitID(parameter.unitId) then
      if actualReclaimedUnit == nil then
        Spring.GiveOrderToUnit(parameter.unitId, CMD.RECLAIM, {parameter.deadUnitId}, {})
        actualReclaimedUnit = parameter.deadUnitId 
      end
      return RUNNING
    else
      actualReclaimedUnit = nil
      return SUCCESS
    end
        
  end
  
end


-- check function
function isUnitOK(unitID)
  if not Spring.ValidUnitID(unitID) or Spring.GetUnitIsDead(unitID) then
    transportersStates[unitID] = endedState
    return false
  else
    return true
  end
end

-- check function
function isUnitDead(unitID)
  if Spring.ValidUnitID(unitID) or Spring.GetUnitIsDead(unitID) then
    return true
  else
    return false
  end
end
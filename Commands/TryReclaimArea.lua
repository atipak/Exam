function getInfo()
	return {
		onNoUnits = SUCCESS,
		parameterDefs = { 
      { 
				name = "unitId",
				variableType = "expression",
				componentType = "editBox",
				defaultValue = "{}"
			}
		}
	}
end

local reclaimRadius = 5000
actualReclaimedUnit = nil

-- reclaims units
function Run(self, unitIds, parameter)
  -- reclaim everything in the area of unit 
  local posX, posY, posZ = Spring.GetUnitPosition(parameter.unitId)
  Spring.GiveOrderToUnit(parameter.unitId, CMD.RECLAIM, {posX, posY, posZ, reclaimRadius}, {})
  return RUNNING
end

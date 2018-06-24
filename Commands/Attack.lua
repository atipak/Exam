function getInfo()
	return {
		onNoUnits = SUCCESS,
		parameterDefs = {
      { 
				name = "unitToAttack",
				variableType = "expression",
				componentType = "editBox",
				defaultValue = "{}"
			}, 
      { 
				name = "unitId",
				variableType = "expression",
				componentType = "editBox",
				defaultValue = "{}"
			}
		}
	}
end


-- load unit
function Run(self, unitIds, parameter)
  -- attacks given location 
  local unitToAttack = parameter.unitToAttack
  local unitId = parameter.unitId
  Spring.GiveOrderToUnit(unitId, CMD.ATTACK, unitToAttack.pos:AsSpringVector(), {})
  return SUCCESS
end

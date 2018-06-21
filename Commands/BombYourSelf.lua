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


-- load unit
function Run(self, unitIds, parameter) 
  Spring.GiveOrderToUnit(parameter.unitId, CMD.SELFD, {}, {})
end



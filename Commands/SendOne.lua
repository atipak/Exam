function getInfo()
	return {
		onNoUnits = SUCCESS,
		parameterDefs = {
      { 
				name = "goal",
				variableType = "expression",
				componentType = "editBox",
				defaultValue = "{}"
			}, 
      { 
				name = "id",
				variableType = "expression",
				componentType = "editBox",
				defaultValue = "{}"
			}
		}
	}
end

local threshold = 50
local already = false

-- the function send one unit to given location
function Run(self, unitIds, parameter)
  local goal = parameter.goal 
  local unitId = parameter.id
  if goal == nil then
    return SUCCESS
  end
  if isUnitOK(unitId) then
    if already then
      if isOnPosition(unitId, goal) then
        already = false
        return SUCCESS
      else
        Spring.GiveOrderToUnit(unitId, CMD.MOVE, goal:AsSpringVector(), {})
        return RUNNING
      end
    else
      already = true
      Spring.GiveOrderToUnit(unitId, CMD.MOVE, goal:AsSpringVector(), {})
      return RUNNING
    end
  else
    already = false
    return SUCCESS
  end
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


 
  
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


local threshold = 50
launched = false




-- goes along a path
function Run(self, unitIds, parameter) 
  -- gies through units array and check if the unit has a task or assigns a new task to it if there is a unit to rescue 
  local unitId = parameter.unitId
  if isUnitOK(unitId) then
    local nearestEnemy = Spring.GetUnitNearestEnemy(unitId)
    if nearestEnemy == nil then
      return SUCCESS
    end
    local health, maxHealth, paralyzeDamage, captureProgress, buildProgress = Spring.GetUnitHealth(unitId)
    if health/maxHealth < 0.25 then
      return SUCCESS
    end
    local targetPos = Vec3(Spring.GetUnitPosition(nearestEnemy))
    -- if the unit is on position, change its state to "load" and execute action
    if not launched then
      Spring.GiveOrderToUnit(unitId, CMD.MOVE, targetPos:AsSpringVector(), {})
      launched = true
    end
    if isOnPosition(unitId, targetPos) then
      launched = false
      return SUCCESS
    end
    return RUNNING
  else
    launched = false
    return SUCCESS
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

function isOnPosition(unitId, target) 
  local x, y, z = Spring.GetUnitPosition(unitId)
  if math.abs(x - target.x) > threshold or math.abs(z - target.z) > threshold then
      return false  
  end 
  return true
end

  
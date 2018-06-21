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

actualIndeces = {}
local threshold = 50
lastCheckTime = 0
timeout = 2
lastPositions = {}
moveThreshold = 10



-- goes along a path
function Run(self, unitIds, parameter) 
  -- gies through units array and check if the unit has a task or assigns a new task to it if there is a unit to rescue 
  local path = parameter.path
  local unitIds = parameter.unitIds
  for i = 1, #unitsIds do
    local unitId = unitsIds[i]
    if isUnitOK(unitId) then
      if actualIndeces[unitId] == nil then
        actualIndeces[unitId] = 1
      end
      local actualIndex = actualIndeces[unitId] 
      local targetPos = path[actualIndex]
      -- if the unit is on position, change its state to "load" and execute action
      if isUnitStuck(unitId) then
        Spring.GiveOrderToUnit(unitId, CMD.MOVE, targetPos:AsSpringVector(), {})
      end
      if isOnPosition(unitId, targetPos) then
        if actualIndex < #path then
          actualIndeces[unitId] = actualIndex + 1
          Spring.GiveOrderToUnit(unitId, CMD.MOVE, path[actualIndex]:AsSpringVector(), {})
        else
          actualIndeces[unitId]  = nil
          return SUCCESS
        end
      end
      return RUNNING
    else
      actualIndeces[unitId] = nil
      return FAILURE
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

function isOnPosition(unitId, target) 
  local x, y, z = Spring.GetUnitPosition(unitId)
  if math.abs(x - target.x) > threshold or math.abs(z - target.z) > threshold then
      return false  
  end 
  return true
end

function isUnitStuck(myId)
  local currentTime = os.clock()
  local stuck = false
  if lastCheckTime == 0 then
    lastCheckTime = currentTime
    lastPositions[myId] = Vec3(Spring.GetUnitPosition(myId))
  end
  if currentTime - lastCheckTime > timeout then
    local lx, ly, lz = Spring.GetUnitPosition(myId)
    --Spring.Echo(lx,ly,lz, lastPosition.x, lastPosition.y, lastPosition.z)
    local lastPosition = lastPositions[myId]
    if math.abs(lastPosition.x - lx) > moveThreshold or math.abs(lastPosition.y - ly) > moveThreshold or math.abs(lastPosition.z - lz) > moveThreshold then
      stuck = false  
    else 
      stuck = true
    end
    lastCheckTime = currentTime
    lastPositions[myId] = Vec3(lx,ly,lz)
  end
  return stuck
end
  
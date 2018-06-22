local sensorInfo = {
	name = "CreatesTriplets",
	desc = "Add to given array with already stored keys a new key with begin positions",
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

-- global variable
lastResult = nil

-- return euclide distance
function vectorsDistance(positionOne, positionTwo) 
  return math.sqrt(math.pow(positionOne.x - positionTwo.x, 2) + math.pow(positionOne.z - positionTwo.z, 2))
end


-- @description 
return function(missionInfo)
  if missionInfo == nil then
    return lastResult 
  end
  local teams = Spring.GetAllyTeamList()
  local myTeam = Spring.GetLocalTeamID()
  local coridorsFronts = {1,1,1}
  -- getCoridors and their length
  local coridorsMaxes = {100,100,100}
  for i = 1, #teams do
    local teamUnits = Spring.GetTeamUnits(teams[i])
    if #teamUnits > 0 then
      for j = 1, #teamUnits do
        local coridorIndex, currentDistance, pointIndex = 1,10000000000000,1
        for k = 1, #coridorsFronts do
          for l = coridorsFronts[k], coridorsMaxes[k] do
            -- get coridors
            local pointDistance = vectorsDistance(Vec3(Spring.GetUnitsPosition(teamUnits[j])), coridors[k][l])
            if pointDistance < currentDistance then   
              currentDistance = pointDistance
              coridorIndex = k
              pointIndex = l
            end
          end
        end
        if pointIndex > coridorsFronts[coridorIndex] then
          coridorsFronts[coridorIndex] = pointIndex
        end
      end
    end      
  end
  lastResult = coridorsFronts
  return coridorsFronts    
end
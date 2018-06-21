local sensorInfo = {
	name = "CreatesTriplets",
	desc = "Add to given array with already stored keys a new key with begin positions",
	author = "Patik",
	date = "2018-05-11",
	license = "notAlicense",
}

local EVAL_PERIOD_DEFAULT = -1 -- acutal, no caching

function getInfo()
	return {
		period = EVAL_PERIOD_DEFAULT 
	}
end

-- global variable


function setBetween(mins, maxs)
  local between = {}  
  for i = 1, #mins do
    if (mins[i] == 1 and maxs[i] == 3) or (mins[i] == 3 and maxs[i] == 1) then
      between[i] = 2
    end
    if (mins[i] == 2 and maxs[i] == 3) or (mins[i] == 3 and maxs[i] == 2) then
      between[i] = 1
    end  
    if (mins[i] == 1 and maxs[i] == 2) or (mins[i] == 2 and maxs[i] == 1) then
      between[i] = 3
    end
  end
  return between
end


-- @description 
return function(missionInfo)
  local myUnits = {0, 0, 0}
  local enemyUnits = {0, 0, 0}
  local myStrongholds = {0,0,0}
  local enemyStrongholds = {0, 0, 0}
  local frontlines = {0, 0, 0}
  local coridorsDistances = {0, 0, 0}
  local mins = {1000000, 1000000, 1000000}
  local maxs = {0, 0, 0}
  local minIndeces = {0,0,0}
  local maxIndeces = {0,0,0}
  for i = 1, #myUnits do
    -- units in coridor
    if myUnits[i] > maxs[0] then
      maxIndeces[0] = i
    end
    if myUnits[i] < mins[0] then
      minIndeces[0] = i
    end
    -- strongholds in coridor
    if myStrongholds[i] > maxs[1] then
      maxIndeces[1] = i         
    end
    if myStrongholds[i] < mins[1] then
      minIndeces[1] = i
    end
    -- frontlines
    if frontlines[i] > maxs[2] then
      maxIndeces[2] = i         
    end
    if frontlines[i] < mins[2] then
      minIndeces[2] = i
    end
  end
  local betweenIndeces = setBetween(minIndeces, maxIndeces)
  if frontlines[maxIndeces[2]] > frontlines[betweenIndeces[2]] and frontlines[betweenIndeces[2]] > frontlines[minIndeces[2]] then
    return minIndeces[2] 
  end
  if myUnits[maxIndeces[0]] > myUnits[betweenIndeces[0]] and myUnits[betweenIndeces[0]] > myUnits[minIndeces[0]] then
    return minIndeces[2] 
  end
  
  return missionInfo.coridors[pathId]
end
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



-- @description 
return function(missionInfo)
  local maxValue, maxIndex = 0,0
  local minValue, minIndex = 1000000000,0
  for i = 1, #missionInfo.coridors do
    if missionInfo.coridors[i].enemyUnits > maxValue then
      maxValue = missionInfo.coridors[i].enemyUnits
      maxIndex = i 
    end
    if missionInfo.coridors[i].enemyUnits < minValue then
      minValue = missionInfo.coridors[i].enemyUnits
      minIndex = i 
    end 
  end
  return {min = minIndex, max = maxIndex}
end
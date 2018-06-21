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


-- @description 
return function(pathId, missionInfo)
  return missionInfo.coridors[pathId]
end
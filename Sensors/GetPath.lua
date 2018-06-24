local sensorInfo = {
	name = "GetPath",
	desc = "Returns path with given id from missionInfo",
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
  return missionInfo.corridors[pathId]
end
local sensorInfo = {
	name = "GetUpdatedPath",
	desc = "Returns updated path from misssionInfo and path identificator",
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
return function(pathId)
  local missInfo = Sensors.Exam.ChangeMissionInfo(Sensors.core.MissionInfo())
  return missInfo.corridors[pathId]
end
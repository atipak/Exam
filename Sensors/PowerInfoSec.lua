local sensorInfo = {
	name = "PowerInfoSec",
	desc = "Returns all zeuses and maverick which are available",
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



local distance = 0
local shift = 2

-- @description 
return function()
  units = Sensors.Exam.GetUnits({armzeus = true, armmav = true})
  local actualInfo = {}
  actualInfo[1] = {ids = units, pathId = 2}
  return actualInfo
end
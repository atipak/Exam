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
return function(unitInfo, direction, index)
  local fronts = Sensors.Exam.CoridorsInfo(nil)
  local endIndex = fronts[unitInfo.pathId] - unitInfo.distance
  local shift = unitInfo.shift
  local dir = direction
  local usualEndIndex = index + dir * shift
  local moved = true
  if dir > 0 then
    if usualEndIndex > endIndex then 
      shift = endIndex - index
      dir = -1 * dir 
      moved = false
    end
  else
    if usualEndIndex < 1 then 
      shift = (index - 1) * dir
      dir = -1 * dir
      moved = false 
    end
  end 
  return {shift = shift, direction = dir, moved = moved}
end
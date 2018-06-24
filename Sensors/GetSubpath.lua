local sensorInfo = {
	name = "GetSubpath",
	desc = "Returns a subpath from a given path (both indeces are inclusive)",
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
return function(beginIndex, endIndex, path)
  local subpath = {}
  local shift = 1
  if beginIndex > endIndex then
    shift = -1
  end
  for i = beginIndex, endIndex, shift do
    subpath[#subpath + 1] = path[i].position
  end
  return subpath
end
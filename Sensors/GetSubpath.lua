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
return function(beginIndex, endIndex, path)
  local subpath = {}
  local shift = 1
  if beginIndex > endIndex then
    shift = -1
  end
  for i = beginIndex, endIndex, shift do
    subpath[#subpath + 1] = path[i]
  end
  return subpath
end
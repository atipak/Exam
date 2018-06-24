local sensorInfo = {
	name = "IsEnoughMetal",
	desc = "Returns true if current metal satisfies a given amount",
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
return function(needed)
  local  currentLevel, storage, pull, income, expense, share, sent, received = Spring.GetTeamResources(Spring.GetLocalTeamID(),"metal")
  if currentLevel ~= nil then
    return currentLevel > needed 
  else
    return false
  end 
end
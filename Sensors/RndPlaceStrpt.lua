local sensorInfo = {
	name = "RndPlaceStrpt",
	desc = "Return a position near to given position",
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

-- @description return a position near to given position  
return function(position)
  -- under given position
  local Xaxes = math.random(70,100)
  local Zaxes = math.random(70,100)
  local xSign = -1
  local zSign = 1
  local goalX = position.x + xSign * Xaxes
  local goalZ = position.z + zSign * Zaxes  
  return Vec3(goalX, Spring.GetGroundHeight(goalX, goalZ) ,goalZ)
end
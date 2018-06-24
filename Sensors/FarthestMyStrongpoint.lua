local sensorInfo = {
    name = "FarthestMyStrongpoint",
    desc = "Returns the farthest strong which I hold.",
    author = "patik",
    date = "2018-06-21",
    license = "notAlicense",
}

local EVAL_PERIOD_DEFAULT = -1 -- acutal, no caching

function getInfo()
    return {
        period = EVAL_PERIOD_DEFAULT
    }
end


-- @description iterates over points in path and serach after my strongpoints
return function(path)
    -- if there is no such strongpoint, then return my base
    local myFarthestStrongPoint = 1
    local teamID, leader, isDead, isAiTeam, side, allyTeam, customTeamKeys, incomeMultiplier = Spring.GetTeamInfo(Spring.GetLocalTeamID())
    for i = 1, #path do
      local point = path[i]
      if point.isStrongpoint and point.ownerAllyID == allyTeam then
        myFarthestStrongPoint = i  
      end 
    end
    return myFarthestStrongPoint 
end
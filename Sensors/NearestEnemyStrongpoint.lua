local sensorInfo = {
    name = "NearestEnemyStrongpoint",
    desc = "Returns the nearest enemy strongpoint",
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


-- @description iterates over points in path and finds the nearest enemy strongpoint
return function(path)
    -- if there is no enemy strongpoint on given path, returns my base position
    local enemyNearestStrongPoint = 1
    local teamID, leader, isDead, isAiTeam, side, allyTeam, customTeamKeys, incomeMultiplier = Spring.GetTeamInfo(Spring.GetLocalTeamID())
    for i = 1, #path do
      local point = path[i]
      if point.isStrongpoint and point.ownerAllyID ~= allyTeam then
        enemyNearestStrongPoint = i
        break  
      end 
    end
    return enemyNearestStrongPoint 
end
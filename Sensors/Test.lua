local sensorInfo = {
    name = "Test",
    desc = "Testing sensor",
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


-- @description return current wind statistics
return function(path)
    local enemyNearestStrongPoint = 1
    local teamID, leader, isDead, isAiTeam, side, allyTeam, customTeamKeys, incomeMultiplier = Spring.GetTeamInfo(Spring.GetLocalTeamID())
    local group = {teamID, leader, isDead, isAiTeam, side, allyTeam, customTeamKeys, incomeMultiplier}
    return group 
end
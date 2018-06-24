local sensorInfo = {
    name = "IsSafe",
    desc = "Checks if there is enemy at given location",
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


-- @description 
return function(position)
    -- the chosen radius is 800
    local units = Spring.GetUnitsInSphere(position.x, position.y, position.z, 800)
    local myTeam = Spring.GetLocalTeamID()
    for i = 1, #units do
        local unit = units[i]
        if not Spring.AreTeamsAllied(myTeam, Spring.GetUnitTeam(unit)) then
          return false
        end
    end
    return true
end
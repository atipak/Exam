local sensorInfo = {
	name = "ChangeMissionInfo",
	desc = "Filters mission info",
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


-- @description missionInfo.corridors.Top.points -> missionInfo.corridors[1] 
return function(missionInfo)
  if missionInfo.corridors.Top == nil then
    return missionInfo
  end
  local top = missionInfo.corridors.Top.points
  local middle = missionInfo.corridors.Middle.points
  local bottom = missionInfo.corridors.Bottom.points
  local corridors = {top, middle, bottom}
  local newMissionInfo = missionInfo
  newMissionInfo['corridors'] = corridors
  return newMissionInfo
end
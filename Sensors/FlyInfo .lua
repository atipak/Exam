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
function isUnitAvaible(actualInfo, unitsIds, type)      
  if #unitsIds == 0 then
    return nil
  end
  for j = 1, #unitsIds do
    local unitId = unitsIds[j]
    local isFree = true
    for i = 1, #actualInfo do
      local unitID = 0
      if type then
        unitID = actualInfo[i].id
      else
        unitID = actualInfo[i].box
      end
      if unitId == unitID then
        isFree = false
      end
    end
    if isFree then
      return unitId
    end
  end
  return nil
end

function divide(unitsIds)
  local atlases = {}
  local boxes = {}
  for i = 1, #unitsIds do
    local unitDefID = Spring.GetUnitDefID(unitsIds[i])
    if UnitDefs[unitDefID].name == "armbox" then
      boxes[#boxes + 1] = unitsIds[i] 
    else
      atlases[#atlases + 1] = unitsIds[i]
    end
  end 
  return {atlases = atlases, boxes = boxes}
end


local distance = 100
local shift = 10

-- @description 
return function(actualInfo) 
  units = Sensors.Exam.GetUnits({armbox = true, armatlas = true})
  if #units == 0 then
    return nil
  end
  local restarts = {false, false, false}
  for i = 1, #actualInfo do
    local transporter = actualInfo[i].id
    local box = actualInfo[i].box
    if not Spring.ValidUnitID(transporter) or Spring.GetUnitIsDead(transporter) or not Spring.ValidUnitID(box) or Spring.GetUnitIsDead(box) then
      actualInfo[i] = nil 
      restarts[i] = true
    end
  end
  local dividedUnits = divide(units)
  for i = 1, 3 do
    if actualInfo[i] == nil then
      local atlas = isUnitAvaible(actualInfo, dividedUnits.atlases, true)
      local box = isUnitAvaible(actualInfo, dividedUnits.boxes, false)  
      if atlas ~= nil and box ~= nil then
        actualInfo[#actualInfo + 1] = {id = atlas, box = box, distance = distance, pathId = i, shift = shift}
      else
        break
      end
    end
  end
  return {restarts = restarts, newInfo = actualInfo}
end
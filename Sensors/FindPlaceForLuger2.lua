local sensorInfo = {
	name = "FindPlaceForLuger2",
	desc = "Returns a position where luger(or another unit with long weapon range) can attack given position (in its weapon range) and it is out of creeps route.",
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
local radius = 30

-- @description 
return function(lugerId, strongpointPosition)
  -- get unit weapon range
  local unitDefId = Spring.GetUnitDefID(lugerId)
  local unitDef = UnitDefs[unitDefId]
  local weaponDefId = unitDef.weapons[1].weaponDef
  local weapon = WeaponDefs[weaponDefId]
  local lugerWeaponRange = weapon.range
  -- get new position
  local xSign = -1
  local zSign = -1
  local airdropX = strongpointPosition.x + xSign * lugerWeaponRange
  local airdropZ = strongpointPosition.z + zSign * 200 
  return Vec3(airdropX, Spring.GetGroundHeight(airdropX, airdropZ) ,airdropZ)
end
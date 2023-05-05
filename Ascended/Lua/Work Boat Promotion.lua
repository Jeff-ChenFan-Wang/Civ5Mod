-- Work Boat Promotion
-- Author: Tofusojo
-- DateCreated: 06-Nov-14 22:27:49
--------------------------------------------------------------

local iWorkBoat = GameInfoTypes["UNIT_WORKBOAT"]
local iOceanImpass = GameInfoTypes["PROMOTION_OCEAN_IMPASSABLE"]
local iXtraMoves2 = GameInfoTypes["PROMOTION_XTRA_MOVES_II"]

function BuffWorkBoatSpeed(pPlayer, pUnit)
	--print("BuffWorkBoatSpeed running...")
	--for pUnit in pPlayer:Units() do
		--if pUnit:GetUnitType() == iWorkBoat then
			--print("Unit is a Work Boat")
			pUnit:SetHasPromotion(iOceanImpass, false)
			pUnit:SetHasPromotion(iXtraMoves2, true)
			if pUnit:MovesLeft() == 120 then
				--print("Work Boat only has 2 moves left")
				pUnit:SetMoves(240)
			end
		--end
	--end
end

function CheckIfIndustrialEra(iPlayerID, iUnitID) 
	--print("CheckIfIndustrialEra running...")
	if (iPlayerID < GameDefines.MAX_MAJOR_CIVS) then
		local pPlayer = Players[iPlayerID]
		local iCurrentEra = pPlayer:GetCurrentEra()
		local pUnit = pPlayer:GetUnitByID(iUnitID) --

		if pUnit:GetUnitType() == iWorkBoat then --
			if (iCurrentEra >= GameInfo.Eras["ERA_INDUSTRIAL"].ID) then
				--print(pPlayer:GetName() .. " is in or beyond the Industrial Era")
				BuffWorkBoatSpeed(pPlayer, pUnit) --
			end
		end
	end
end
Events.SerialEventUnitCreated.Add(CheckIfIndustrialEra) --GameEvents.PlayerDoTurn.Add(CheckIfIndustrialEra)
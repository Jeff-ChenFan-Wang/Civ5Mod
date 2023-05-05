-- Remove Inherited Promotions
-- Author: Tofusojo
-- DateCreated: 3/16/2016 10:41:14 PM
--------------------------------------------------------------
local iCatapult = GameInfoTypes["UNIT_CATAPULT"]
local iCover1 = GameInfoTypes["PROMOTION_COVER_1"]
local iCover2 = GameInfoTypes["PROMOTION_COVER_2"]

function RemovePromotion(iPlayerID, iUnitID)
	print("-------------------------------------------------------------------------------------")
	print("RemovePromotion running...")

	if (iPlayerID < GameDefines.MAX_CIV_PLAYERS) then
		local pPlayer = Players[iPlayerID]
		local pUnit = pPlayer:GetUnitByID(iUnitID) 

		if pUnit:GetUnitType() == iCatapult then 
			print("Catapult detected.")
			if pUnit:IsHasPromotion(iCover2) then
				print("Cover 2 promotion detected on Catapult.")
				pUnit:SetHasPromotion(iCover2, false)
				return
			end
			if pUnit:IsHasPromotion(iCover1) then
				print("Cover 1 promotion detected on Catapult.")
				pUnit:SetHasPromotion(iCover1, false)
			end
		end
	end	
end
Events.SerialEventUnitCreated.Add(RemovePromotion)
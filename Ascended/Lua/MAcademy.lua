-- MAcademy
-- Author: j3ff1
-- DateCreated: 5/25/2018 5:49:12 PM
--------------------------------------------------------------
local militaryAcademy = GameInfoTypes.BUILDING_MILITARY_ACADEMY
local epic = GameInfoTypes.BUILDING_HEROIC_EPIC
local acaPromo = GameInfoTypes.PROMOTION_MILITARY_ACADEMY
local epicPromo = GameInfoTypes.PROMOTION_MORALE
local prizeShipPromo = GameInfoTypes.PROMOTION_PRIZE_SHIPS

function CheckIfUnitStartAca(playerID)
	local pPlayer = Players[playerID]

	print("###check maca function started")
	for pCity in pPlayer:Cities() do
		if pCity:IsHasBuilding(militaryAcademy) then
			local acaUnit = pCity:Plot():GetUnit()
			if acaUnit:IsCombatUnit() then
				acaUnit:SetHasPromotion(acaPromo, true)
				if acaUnit:GetExperience() < 120 then
					acaUnit:ChangeExperience(10)
				end
				if acaUnit:GetDomainType() == DomainTypes.DOMAIN_SEA and acaUnit:IsRanged() == false then
					acaUnit:SetHasPromotion(prizeShipPromo,true)
				end
			end
--[[	elseif pCity:IsHasBuilding(epic) then
			print("found epic")
			local unit = pCity:Plot():GetUnit()
			if unit:IsCombatUnit() then
				print("added promo")
				unit:SetHasPromotion(epicPromo, true)
			end]]--
		end
	end
end


GameEvents.PlayerDoTurn.Add(CheckIfUnitStartAca)
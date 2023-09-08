-- MAcademy
-- Author: j3ff1
-- DateCreated: 5/25/2018 5:49:12 PM
--------------------------------------------------------------
local militaryAcademy = GameInfoTypes.BUILDING_MILITARY_ACADEMY
local mAcaUp = GameInfoTypes.BUILDING_MILITARY_ACADEMY_UP
local miliBarracks = GameInfoTypes.BUILDING_BARRACKS
local barrUp = GameInfoTypes.BUILDING_BARRACKS_UP
local armUp = GameInfoTypes.BUILDING_ARMORY_UP

local epic = GameInfoTypes.BUILDING_HEROIC_EPIC
local acaPromo = GameInfoTypes.PROMOTION_MILITARY_ACADEMY
--local epicPromo = GameInfoTypes.PROMOTION_MORALE
local prizeShipPromo = GameInfoTypes.PROMOTION_PRIZE_SHIPS

function CheckIfUnitStartAca(playerID)
	local pPlayer = Players[playerID]

	--print("###check maca function started")
	for pCity in pPlayer:Cities() do
		if pCity:IsHasBuilding(miliBarracks) then
			local acaUnit = pCity:Plot():GetUnit()
			if acaUnit ~= nil then
				if acaUnit:IsCombatUnit() then
					if pCity:IsHasBuilding(militaryAcademy) then
						acaUnit:SetHasPromotion(acaPromo, true)
						if acaUnit:GetExperience() < 120 then
							acaUnit:ChangeExperience(10)
						end
						if pCity:IsHasBuilding(mAcaUp) then
							if acaUnit:GetExperience() < 120 then
								acaUnit:ChangeExperience(10)
							end
						end
						if pCity:IsHasBuilding(barrUp) then
							if acaUnit:GetExperience() < 120 then
								acaUnit:ChangeExperience(10)
							end
						end
						if pCity:IsHasBuilding(armUp) then
							if acaUnit:GetExperience() < 120 then
								acaUnit:ChangeExperience(10)
							end
						end

					elseif acaUnit:GetExperience() < 30 then
						acaUnit:ChangeExperience(5)

						if pCity:IsHasBuilding(barrUp) then
							if acaUnit:GetExperience() < 30 then
								acaUnit:ChangeExperience(5)
							end
						end
					end
					if acaUnit:GetDomainType() == DomainTypes.DOMAIN_SEA and acaUnit:IsRanged() == false then
						acaUnit:SetHasPromotion(prizeShipPromo,true)
					end
				end
			end
		end
	end
end


GameEvents.PlayerDoTurn.Add(CheckIfUnitStartAca)
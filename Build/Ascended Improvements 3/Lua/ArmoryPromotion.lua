-- ArmoryPromotion
-- Author: j3ff1
-- DateCreated: 5/14/2018 2:39:36 PM
--------------------------------------------------------------
local tValidArmoryUnitDomains = { [GameInfoTypes.DOMAIN_LAND] = GameInfoTypes.DOMAIN_LAND }
local iArmoryWonder = GameInfoTypes.BUILDING_ARMORY
local iArmoryRange = 2
local iArmoryPromotion = GameInfoTypes.PROMOTION_ARMORY
local pArmoryPlot = {}

function UnitsNearArmory(playerID, unitID, unitX, unitY)
	local pUnit = Players[playerID]:GetUnitByID(unitID)
	for count = 1, #pArmoryPlot do
		if playerID == Map.GetPlot(pArmoryPlot[count]:GetX(), pArmoryPlot[count]:GetY()):GetPlotCity():GetOwner() then
			if (Map.PlotDistance(unitX, unitY, pArmoryPlot[count]:GetX(), pArmoryPlot[count]:GetY()) <= iArmoryRange) then
				if tValidArmoryUnitDomains[pUnit:GetDomainType()] and pUnit:IsCombatUnit() then
					pUnit:SetHasPromotion(iArmoryPromotion, true)
					--print("UnitsNearArmory Function executed, promotion = true") 
					--print(pUnit:GetName())
				end
			else
				pUnit:SetHasPromotion(iArmoryPromotion, false)
				--print("UnitsNearArmory Function executed, promotion = false") 
				--print(pUnit:GetName())
			end
		end
	end
end

function CheckForArmory(playerID)
	local pPlayer = Players[playerID]
	--print("###turn initiated, check for armories in all ", pPlayer:GetName(), "'s cities")
	for pCity in pPlayer:Cities() do
		if pCity:IsHasBuilding(iArmoryWonder) then
			--print("city with armory found ", pCity:GetName())
			table.insert(pArmoryPlot, pCity:Plot())
		end
	end
end

function NearAnArmory(pUnit)
	--print("###NearAnArmory function started")
	local isNear = false
	for Count = 1, #pArmoryPlot do
		if (Map.PlotDistance(pUnit:GetX(), pUnit:GetY(), pArmoryPlot[Count]:GetX(), pArmoryPlot[Count]:GetY()) <= iArmoryRange) then
			if pUnit:GetOwner() == pArmoryPlot[Count]:GetPlotCity():GetOwner() then
				isNear = true
				--print("NearAnArmory Function executed, isNear = true") 
				--print(pUnit:GetName())
			else
				--print("unit not with friendly city")
				--print(pUnit:GetName())
			end
		else
			--print("NearAnArmory Function executed, isNear = false")
			--print(pUnit:GetName())
		end
	end
	--print(isNear)
	return isNear
end

function SetArmoryPromotion(playerID)
	--print("###SetArmoryPromotion function started")
	local pPlayer = Players[playerID]
	for pUnit in pPlayer:Units() do
		if tValidArmoryUnitDomains[pUnit:GetDomainType()] then
			if NearAnArmory(pUnit) then
				--print("SetArmoryPromotion function, NearAnArmory check executed, ")
				--print(pUnit:GetName())
				if pUnit:IsCombatUnit() then
					--print("SetArmoryPromotion function, isCombat = true, pUnitSetHasPromotion true")
					pUnit:SetHasPromotion(iArmoryPromotion, true)
				end
			else
				pUnit:SetHasPromotion(iArmoryPromotion, false)
				--print("SetArmoryPromotion function, NearAnArmory check executed, pUnitSetHasPromotion false")
				--print(pUnit:GetName())
			end
		end
	end
end


GameEvents.PlayerDoTurn.Add(CheckForArmory)
GameEvents.PlayerDoTurn.Add(SetArmoryPromotion)
GameEvents.UnitSetXY.Add(UnitsNearArmory)


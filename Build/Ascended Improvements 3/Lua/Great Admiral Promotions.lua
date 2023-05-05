-- Great Admiral Promotions
-- Author: Tofusojo
-- DateCreated: 12-Nov-14 22:36:21
--------------------------------------------------------------

local iAdmiral = GameInfoTypes["UNIT_GREAT_ADMIRAL"]

local iXtraMoves1 = GameInfoTypes["PROMOTION_EXTRA_MOVES_I"]
local iXtraMoves2 = GameInfoTypes["PROMOTION_XTRA_MOVES_II"]
local iXtraMoves3 = GameInfoTypes["PROMOTION_XTRA_MOVES_III"]
local iXtraMoves4 = GameInfoTypes["PROMOTION_XTRA_MOVES_IV"]
local iXtraMoves5 = GameInfoTypes["PROMOTION_XTRA_MOVES_V"]
local iXtraMoves6 = GameInfoTypes["PROMOTION_XTRA_MOVES_VI"]
local iXtraMoves7 = nil
local iXtraMoves8 = GameInfoTypes["PROMOTION_XTRA_MOVES_VIII"] --RFE mod compatibility
local iMobileAdmiral = GameInfoTypes["PROMOTION_FAST_ADMIRAL"]

local TechCompass = GameInfoTypes.TECH_COMPASS
local TechAstronomy = GameInfoTypes.TECH_ASTRONOMY
local TechNavigation = GameInfoTypes.TECH_NAVIGATION
local TechSteamPower = GameInfoTypes.TECH_STEAM_POWER
local TechElectronics = GameInfoTypes.TECH_ELECTRONICS
local TechSonar = GameInfoTypes.TECH_SONAR
local TechRobotics = GameInfoTypes.TECH_ROBOTICS
local TechLasers = GameInfoTypes.TECH_LASERS
local TechNanotech = GameInfoTypes.TECH_NANOTECHNOLOGY
local TechQuantumComputers = GameInfoTypes.TECH_QUANTUM_COMPUTERS

--local iEraInformation = GameInfoTypes["ERA_FUTURE"]	

local pPromotionTable = {iXtraMoves1, iXtraMoves2, iXtraMoves3, iXtraMoves4, iXtraMoves5, iXtraMoves6, 
						 iXtraMoves7, iXtraMoves8}

function BuffAdmiralSpeed(pPlayer, pUnit, iExtraMoves) 
	--print("BuffAdmiralSpeed running...")
	for pUnit in pPlayer:Units() do
		if pUnit:GetUnitType() == iAdmiral then
			--print("Unit is a Great Admiral")

			for i = 0, iExtraMoves - 1 do
				local bChoice = false

				if i == (iExtraMoves - 1) then
					bChoice = true
				end
				pUnit:SetHasPromotion(pPromotionTable[i + 1], bChoice)
				if bChoice == true then
					--print("Great Admiral given " .. i + 1 .. " extra moves")
				end
			end

			local iMaxMoves = 120 + (60 * iExtraMoves)
			if pUnit:IsHasPromotion(iMobileAdmiral) then
				--print("Great Admiral has Mobile Admiral promotion")
				iMaxMoves = iMaxMoves + 120
			end

			if pUnit:MovesLeft() < iMaxMoves then
				--print("Great Admiral's moves aren't full")
				pUnit:SetMoves(iMaxMoves)
			end
		end
	end
end

function TechCheck(iPlayerID, iUnitID) 
	--print("TechCheck running...")
	if (iPlayerID < GameDefines.MAX_MAJOR_CIVS) then
		local pPlayer = Players[iPlayerID]
		local pUnit = pPlayer:GetUnitByID(iUnitID) 

		if pUnit:GetUnitType() == iAdmiral then 
			--print("Is admiral")
			local iExtraMoves
			local pTeamTechs = Teams[pPlayer:GetTeam()]:GetTeamTechs()

			if TechQuantumComputers ~= nil and pTeamTechs:HasTech(TechNanotech) or pTeamTechs:HasTech(TechQuantumComputers) then
				--print("Real Future Era enabled")
				--if pTeamTechs:HasTech(TechNanotech) or pTeamTechs:HasTech(TechQuantumComputers) then 
					iExtraMoves = 6
				--end			
			elseif pTeamTechs:HasTech(TechRobotics) or pTeamTechs:HasTech(TechLasers) then --pPlayer:GetCurrentEra() >= iEraInformation
				iExtraMoves = 5
			--elseif pTeamTechs:HasTech(TechElectronics) or pTeamTechs:HasTech(TechSonar) then
				--iExtraMoves = 5
			elseif pTeamTechs:HasTech(TechSteamPower) then
				iExtraMoves = 4
			elseif pTeamTechs:HasTech(TechNavigation) then
				iExtraMoves = 3
			elseif pTeamTechs:HasTech(TechAstronomy) then
				iExtraMoves = 2
			elseif pTeamTechs:HasTech(TechCompass) then
				iExtraMoves = 1
			else
				iExtraMoves = 0
			end
			if iExtraMoves ~= nil then
				--print("iExtraMoves is: " .. iExtraMoves)
				BuffAdmiralSpeed(pPlayer, pUnit, iExtraMoves)
			elseif iExtraMoves == 0 then
				--print("iExtraMoves is 0")
			end
		end
	end
end
Events.SerialEventUnitCreated.Add(TechCheck)--GameEvents.PlayerDoTurn.Add(TechCheck)
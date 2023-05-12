
-- EraChangeDetectionAndFreeBuilding
-- Author: Eyal Orgad
-- DateCreated: 27-Nov-17 11:31:01 PM
--------------------------------------------------------------
local aiBoostBuilding = GameInfoTypes.BUILDING_AI_BOOSTER;

function EraChangeDetected(teamId, era)
	--add whenever a team hits renaissance or beyond
	if era >= 3 then
		--check all players
		for PlayerId = 0, GameDefines.MAX_MAJOR_CIVS - 1, 1 do
			local pPlayer = Players[PlayerId]
			--get capital if player not human
			if not pPlayer:IsHuman() then
				local pCapital = pPlayer:GetCapitalCity()

				--if capital does not already have booster
				if not pCapital:IsHasBuilding(aiBoostBuilding) then
					--add booster building
					pCapital:SetNumRealBuilding(aiBoostBuilding, 1)
				end
			end
		end
	end
end

-- only update capitals when a team has era change
GameEvents.TeamSetEra.Add(EraChangeDetected)




-- Modern Transport Model for Embarked Units
-- Author: Tofusojo
-- DateCreated: 2/17/2016 10:29:35 AM
--------------------------------------------------------------
--local iTurnPlayer = -1

--GameEvents.PlayerDoTurn.Add(function(iPlayer)
--    iTurnPlayer = iPlayer
  
--	print("------------------------------------------------------------------------------------------------------------")
--	print(Players[iTurnPlayer]:GetName() .. " triggered PlayerDoTurn")
--end)   Might have worked, if TeamSetEra didn't seem to run before this!

local bool bChangeEmbarkModelAIStartHasRun = false

function UpdateEmbarkModel(pPlayer, iEra)
	--print("------------------------------------------------------------------------------------------------------------")
	if (iEra == 3) then	
		--print("It is Renaissance")
		pPlayer:SetEmbarkedGraphicOverride("ART_DEF_UNIT_GALLEON")
	elseif (iEra == 4 or iEra == 5) then	
		--print("It is Industrial or Modern")
		pPlayer:SetEmbarkedGraphicOverride("ART_DEF_UNIT_TRANSPORT")
	elseif (iEra >= 6) then	
		--print("It is Atomic or later")
		pPlayer:SetEmbarkedGraphicOverride("ART_DEF_UNIT_MODERN_TRANSPORT")
	end
end

function ChangeEmbarkModelInit()
	--print("ChangeEmbarkModelInit running...")
	
	local pPlayer = Players[Game.GetActivePlayer()]
	print(pPlayer:GetName() .. "'s turn")
	local iEra = pPlayer:GetCurrentEra()
	--print("iEra is: " .. iEra)
	
	UpdateEmbarkModel(pPlayer, iEra)
	--print("ChangeEmbarkModelInit done")
end
Events.LoadScreenClose.Add(ChangeEmbarkModelInit) --Runs once for each human player at start of first turn

function ChangeEmbarkModelAIStart(iPlayerID)
	--print("ChangeEmbarkModelAIStart running...")
	
	if (bChangeEmbarkModelAIStartHasRun ~= true) then	--Runs until function is turned off
		local pPlayer = Players[iPlayerID]
		--print(pPlayer:GetName() .. "'s turn")
		local iEra = pPlayer:GetCurrentEra()
		--print("iEra is: " .. iEra)
	
		if (pPlayer:IsHuman()) then		--Turns off function once a human player's turn is reached (start of turn 2)
			--print("A human player's 2nd turn has begun")
			bChangeEmbarkModelAIStartHasRun = true
			return
		end
		UpdateEmbarkModel(pPlayer, iEra)
	end
	--print("ChangeEmbarkModelAIStart done")
end
GameEvents.PlayerDoTurn.Add(ChangeEmbarkModelAIStart) --Runs at the beginning of everyone's turns except human players' first

function ChangeEmbarkModeEra (iTeamID, iEra)  --Eras: Anc (0), Clas (1), Med (2), Ren (3), Ind (4), Mod (5), Ato (6), Inf (7), Fut (8)
	--print("ChangeEmbarkModeEra running...")
	local iPlayerID = Teams[iTeamID]:GetLeaderID()
	local pPlayer = Players[iPlayerID]

	--print(pPlayer:GetName() .. "'s turn")
	--print("iEra is: " .. iEra)
	
	UpdateEmbarkModel(pPlayer, iEra)
	--print("ChangeEmbarkModeEra done")
end
GameEvents.TeamSetEra.Add(ChangeEmbarkModeEra) --Runs at start of every turn when any player has entered a new era

--Are Postmodern (atom) and Future (info) era both id 6?? no effect since code is >= 6


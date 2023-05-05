-- PlantingResources
-- Author: j3ff1
-- DateCreated: 9/1/2019 12:55:08 AM
--------------------------------------------------------------
local farmID = GameInfoTypes.BUILD_FARM
local grasslandsID = GameInfoTypes.TERRAIN_GRASS
local plainsID = GameInfoTypes.TERRAIN_PLAINS
local iWheat =GameInfoTypes.RESOURCE_WHEAT
--print("##### planting resources is actually running")

function PlaceResource(playerID, unitID, x, y, buildID)
	--print("##########starting place resource and showing farmID then buildID")
	--print(farmID)
	--print(buildID)
	if buildID == farmID then
		--print("farmID check succeeded")
		local targetPlot = Map.GetPlot(x,y)
		if (targetPlot:GetTerrainType() == grasslandsID) or (targetPlot:GetTerrainType() == plainsID) then
			--print("Check is grass succeeded")
			if (targetPlot:GetPlotType() ~= PlotTypes.PLOT_HILLS) then
				--print("Check NO hill success")
				if (targetPlot:GetResourceType(-1) == -1) then
					--print("check no resource success")
					targetPlot:SetResourceType(iWheat,1)
				end
			end
		end
	end
end

GameEvents.PlayerBuilt.Add(PlaceResource) 
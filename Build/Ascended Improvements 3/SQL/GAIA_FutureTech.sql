--==========================================================================================================================
-- BOOSTED FUTURE TECH
--==========================================================================================================================
UPDATE Buildings SET EnhancedYieldTech = 'TECH_FUTURE_TECH' WHERE BuildingClass IN (
	'BUILDINGCLASS_PALACE',
	'BUILDINGCLASS_IRONWORKS',
	'BUILDINGCLASS_NATIONAL_TREASURY',
	'BUILDINGCLASS_GRAND_TEMPLE',
	'BUILDINGCLASS_HERMITAGE',
	'BUILDINGCLASS_NATIONAL_COLLEGE'
);

INSERT INTO Building_TechEnhancedYieldChanges
		(BuildingType,	YieldType,			Yield)
SELECT	Type,			'YIELD_FOOD',		10
FROM Buildings WHERE BuildingClass = 'BUILDINGCLASS_PALACE';

INSERT INTO Building_TechEnhancedYieldChanges
		(BuildingType,	YieldType,			Yield)
SELECT	Type,			'YIELD_PRODUCTION',	10
FROM Buildings WHERE BuildingClass = 'BUILDINGCLASS_IRONWORKS';

INSERT INTO Building_TechEnhancedYieldChanges
		(BuildingType,	YieldType,			Yield)
SELECT	Type,			'YIELD_GOLD',		10
FROM Buildings WHERE BuildingClass = 'BUILDINGCLASS_NATIONAL_TREASURY';

INSERT INTO Building_TechEnhancedYieldChanges
		(BuildingType,	YieldType,			Yield)
SELECT	Type,			'YIELD_FAITH',		10
FROM Buildings WHERE BuildingClass = 'BUILDINGCLASS_GRAND_TEMPLE';

INSERT INTO Building_TechEnhancedYieldChanges
		(BuildingType,	YieldType,			Yield)
SELECT	Type,			'YIELD_CULTURE',	10
FROM Buildings WHERE BuildingClass = 'BUILDINGCLASS_HERMITAGE';

INSERT INTO Building_TechEnhancedYieldChanges
		(BuildingType,	YieldType,			Yield)
SELECT	Type,			'YIELD_SCIENCE',	10
FROM Buildings WHERE BuildingClass = 'BUILDINGCLASS_NATIONAL_COLLEGE';

--==========================================================================================================================
-- FAKE IMPROVEMENTS for tech tree tooltip
--==========================================================================================================================
INSERT INTO Improvements 
			(Type,						Description, 							Civilopedia, Help, ArtDefineTag, RequiresFeature, PillageGold, PortraitIndex, IconAtlas)
SELECT		'IMPROVEMENT_PALACE_DUMMY',	'TXT_KEY_IMPROVEMENT_D_FOR_PALACE', 	Civilopedia, Help, ArtDefineTag, RequiresFeature, PillageGold, PortraitIndex, IconAtlas 
FROM Improvements WHERE Type = 'IMPROVEMENT_TRADING_POST'
AND EXISTS (Select * FROM Automates WHERE Type = 'AUTOMATE_MISSIONARY');

INSERT INTO Improvements 
			(Type,							Description, 							Civilopedia, Help, ArtDefineTag, RequiresFeature, PillageGold, PortraitIndex, IconAtlas)
SELECT		'IMPROVEMENT_IRONWORKS_DUMMY',	'TXT_KEY_IMPROVEMENT_D_FOR_IRONWORKS', 	Civilopedia, Help, ArtDefineTag, RequiresFeature, PillageGold, PortraitIndex, IconAtlas 
FROM Improvements WHERE Type = 'IMPROVEMENT_TRADING_POST'
AND EXISTS (Select * FROM Automates WHERE Type = 'AUTOMATE_MISSIONARY');

INSERT INTO Improvements 
			(Type,									Description, 									Civilopedia, Help, ArtDefineTag, RequiresFeature, PillageGold, PortraitIndex, IconAtlas)
SELECT		'IMPROVEMENT_NATIONAL_TREASURY_DUMMY',	'TXT_KEY_IMPROVEMENT_D_FOR_NATIONAL_TREASURY', 	Civilopedia, Help, ArtDefineTag, RequiresFeature, PillageGold, PortraitIndex, IconAtlas 
FROM Improvements WHERE Type = 'IMPROVEMENT_TRADING_POST'
AND EXISTS (Select * FROM Automates WHERE Type = 'AUTOMATE_MISSIONARY');

INSERT INTO Improvements 
			(Type,								Description, 								Civilopedia, Help, ArtDefineTag, RequiresFeature, PillageGold, PortraitIndex, IconAtlas)
SELECT		'IMPROVEMENT_GRAND_TEMPLE_DUMMY',	'TXT_KEY_IMPROVEMENT_D_FOR_GRAND_TEMPLE', 	Civilopedia, Help, ArtDefineTag, RequiresFeature, PillageGold, PortraitIndex, IconAtlas 
FROM Improvements WHERE Type = 'IMPROVEMENT_TRADING_POST'
AND EXISTS (Select * FROM Automates WHERE Type = 'AUTOMATE_MISSIONARY');

INSERT INTO Improvements 
			(Type,							Description, 							Civilopedia, Help, ArtDefineTag, RequiresFeature, PillageGold, PortraitIndex, IconAtlas)
SELECT		'IMPROVEMENT_HERMITAGE_DUMMY',	'TXT_KEY_IMPROVEMENT_D_FOR_HERMITAGE', 	Civilopedia, Help, ArtDefineTag, RequiresFeature, PillageGold, PortraitIndex, IconAtlas 
FROM Improvements WHERE Type = 'IMPROVEMENT_TRADING_POST'
AND EXISTS (Select * FROM Automates WHERE Type = 'AUTOMATE_MISSIONARY');

INSERT INTO Improvements 
			(Type,									Description, 									Civilopedia, Help, ArtDefineTag, RequiresFeature, PillageGold, PortraitIndex, IconAtlas)
SELECT		'IMPROVEMENT_NATIONAL_COLLEGE_DUMMY',	'TXT_KEY_IMPROVEMENT_D_FOR_NATIONAL_COLLEGE', 	Civilopedia, Help, ArtDefineTag, RequiresFeature, PillageGold, PortraitIndex, IconAtlas 
FROM Improvements WHERE Type = 'IMPROVEMENT_TRADING_POST'
AND EXISTS (Select * FROM Automates WHERE Type = 'AUTOMATE_MISSIONARY');

--==========================================================================================================================
-- Improvement_TechYieldChanges for tech tree tool tip
--==========================================================================================================================
INSERT INTO Improvement_TechYieldChanges
		(ImprovementType,						TechType,				YieldType,			Yield)
SELECT	'IMPROVEMENT_PALACE_DUMMY',				'TECH_FUTURE_TECH',		'YIELD_FOOD',		10
WHERE EXISTS (Select * FROM Automates WHERE Type = 'AUTOMATE_MISSIONARY');

INSERT INTO Improvement_TechYieldChanges
		(ImprovementType,						TechType,				YieldType,			Yield)
SELECT	'IMPROVEMENT_IRONWORKS_DUMMY',			'TECH_FUTURE_TECH',		'YIELD_PRODUCTION',	10
WHERE EXISTS (Select * FROM Automates WHERE Type = 'AUTOMATE_MISSIONARY');
			
INSERT INTO Improvement_TechYieldChanges
		(ImprovementType,						TechType,				YieldType,			Yield)
SELECT	'IMPROVEMENT_NATIONAL_TREASURY_DUMMY',	'TECH_FUTURE_TECH',		'YIELD_GOLD',		10
WHERE EXISTS (Select * FROM Automates WHERE Type = 'AUTOMATE_MISSIONARY');

INSERT INTO Improvement_TechYieldChanges
		(ImprovementType,						TechType,				YieldType,			Yield)
SELECT	'IMPROVEMENT_GRAND_TEMPLE_DUMMY',		'TECH_FUTURE_TECH',		'YIELD_FAITH',		10
WHERE EXISTS (Select * FROM Automates WHERE Type = 'AUTOMATE_MISSIONARY');

INSERT INTO Improvement_TechYieldChanges
		(ImprovementType,						TechType,				YieldType,			Yield)
SELECT	'IMPROVEMENT_HERMITAGE_DUMMY',			'TECH_FUTURE_TECH',		'YIELD_CULTURE',	10
WHERE EXISTS (Select * FROM Automates WHERE Type = 'AUTOMATE_MISSIONARY');

INSERT INTO Improvement_TechYieldChanges
		(ImprovementType,						TechType,				YieldType,			Yield)
SELECT	'IMPROVEMENT_NATIONAL_COLLEGE_DUMMY',	'TECH_FUTURE_TECH',		'YIELD_SCIENCE',	10
WHERE EXISTS (Select * FROM Automates WHERE Type = 'AUTOMATE_MISSIONARY');

--==========================================================================================================================

--==========================================================================================================================

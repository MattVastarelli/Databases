CREATE DATABASE CombatSports
GO

USE CombatSports
GO

--commissions table
CREATE TABLE Commissions (
	commissionName	varchar(100) NOT NULL,
	--primary key
	CONSTRAINT pkCcommissionName PRIMARY KEY (commissionName)
);
GO

--rule sets table
CREATE TABLE RuleSets (
	ruleSet			varchar(100) NOT NULL,
	commissionName	varchar(100),
	sport			varchar(100),
	fightLevel		varchar(100) NOT NULL,
	--primary key
	CONSTRAINT pkRuleSet PRIMARY KEY (ruleSet, fightLevel),
	-- foreign key
	CONSTRAINT fkCommission FOREIGN KEY (commissionName) 
		REFERENCES Commissions(commissionName)
		ON UPDATE CASCADE
		ON DELETE CASCADE 
);
GO

--refs table
CREATE TABLE Refs (
	refName	varchar(100) NOT NULL,
	--primary key
	CONSTRAINT pkRefName PRIMARY KEY (refName)
);
GO

--fight location table
CREATE TABLE FightLocations (
	city		varchar(100) NOT NULL,
	country		varchar(100) NOT NULL,
	Region		varchar(100),
	arenaName	varchar(100) NOT NULL, 
	--primary key
	CONSTRAINT pkFightLocation PRIMARY KEY (city,country, arenaName)
);
GO

--promoters table
CREATE TABLE Promoters (
	promoterName	varchar(100) NOT NULL,
	numFighters		int,
	president		varchar(100),
	CEO				varchar(100),
	revenue			money,	
	--primary key
	CONSTRAINT pkPromoter PRIMARY KEY (promoterName)		
);
GO

--card table
CREATE TABLE Cards (
	cardName		varchar(100) NOT NULL,
	numFights		int,
	fightDate		datetime,
	mainEvent		varchar(200),
	coMainEvent		varchar(200),
	promoterName	varchar(100),
	city			varchar(100),
	country			varchar(100),
	arenaName		varchar(100),
	--primary key
	CONSTRAINT pkCardName PRIMARY KEY (cardName),
	--foreign keys
	CONSTRAINT fkPromoterName FOREIGN KEY (	promoterName)
		REFERENCES Promoters(promoterName)  
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	CONSTRAINT fkFightLocation FOREIGN KEY (city, country, arenaName)
		REFERENCES FightLocations(city, country, arenaName)   
		ON UPDATE CASCADE 
		ON DELETE CASCADE,
);
GO

--weightclass table
CREATE TABLE WeightClasses (
	weightClass	varchar(100) NOT NULL,
	gender		varchar(100) NOT NULL,
	sport		varchar(100) NOT NULL,
	--public key
	CONSTRAINT pkWeightClass PRIMARY KEY (weightClass, gender, sport),
);
GO

--judges table
CREATE TABLE Judges (
	panelID	int IDENTITY (1,1) NOT NULL,
	judge1			varchar(100),
	judge2			varchar(100),
	judge3			varchar(100),
	judge4			varchar(100),
	judge5			varchar(100),
	judgingSystem	varchar(100),
	decision		varchar(100),
	--public key
	CONSTRAINT pkPanelID PRIMARY KEY (panelID)
);
GO

--purses table
CREATE TABLE Purses (
	purseID		int IDENTITY (1,1) NOT NULL,
	winPay		money,
	showPay		money,
	fightBonus	money,
	totalPurse	as (fightBonus + winPay + showPay)
	--public key
	CONSTRAINT pkPurseID PRIMARY KEY (purseID),
);
GO

--fights table
CREATE TABLE Fights (
	fightID		int IDENTITY(1,1) NOT NULL,
	fighterID	int NOT NULL,
	fightNum	int,
	cardName	varchar(100),
	opponetName	varchar(100) NOT NULL,
	--for weight class fk
	weightClass	varchar(100),
	gender		varchar(100),
	sport		varchar(100),
	--for judges fk
	panelID		int NOT NULL,
	--for ruleset fk 
	fightLevel	varchar(100),
	ruleSet		varchar(100),
	--for ref fk
	refName		varchar(100),
	--for purse fk
	purseID		int,
	--primary key
	CONSTRAINT pkFightID PRIMARY KEY (fightID),
	--foreign keys
	CONSTRAINT fkWeightClass FOREIGN KEY (weightClass, gender, sport)
		REFERENCES WeightClasses(weightClass, gender, sport), 
	CONSTRAINT fkPanelID FOREIGN KEY (panelID)
		REFERENCES Judges(panelID)    
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	CONSTRAINT fkRuleSet FOREIGN KEY (ruleSet, fightLevel)
		REFERENCES RuleSets(ruleSet, fightLevel)    
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	CONSTRAINT fkRefName FOREIGN KEY (refName)
		REFERENCES Refs(refName)  
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	CONSTRAINT fkPurseID FOREIGN KEY (purseID)
		REFERENCES Purses(purseID)  
		ON UPDATE CASCADE
		ON DELETE CASCADE, 
	CONSTRAINT fkCardName FOREIGN KEY (cardName)
		REFERENCES cards(cardName)  
		ON UPDATE CASCADE
		ON DELETE CASCADE, 
);
GO

--gym table
CREATE TABLE Gyms (
	gymName	varchar(100) NOT NULL,
	--primary key
	CONSTRAINT pkgymName PRIMARY KEY (gymName)
);
GO

--fighter table
CREATE TABLE Fighters (
	fighterID	int IDENTITY(1,1) NOT NULL,
	fighterName	varchar(100) NOT NULL,
	dateOfBirth	date,
	nickName	varchar(100),
	gymName		varchar(100),
	--primary key
	CONSTRAINT pkFighterID	PRIMARY KEY (fighterID),
	--foreign key
	CONSTRAINT fkGymName	FOREIGN KEY (gymName)
		REFERENCES Gyms(gymName)
		ON UPDATE CASCADE
		ON DELETE CASCADE,

);
GO

--physical stats table
CREATE TABLE PhysicalStats (
	fighterID	int NOT NULL,
	hight		int NOT NULL,
	reach		int NOT NULL,
	legReach	int NOT NULL,
	gender		varchar(100),
	--primary key
	CONSTRAINT pkFighterPhysicalStats	PRIMARY KEY (fighterID),
	--foreign key
	CONSTRAINT fkFighterID FOREIGN KEY (fighterID)
		REFERENCES Fighters(fighterID)
		ON UPDATE CASCADE
		ON DELETE CASCADE,
);
GO

--fighter record table
CREATE TABLE Records (
	win			int,
	loss		int,
	noContest	int,
	fighterID	int NOT NULL,
	--primary key
	CONSTRAINT pkFighterRecord	PRIMARY KEY (fighterID),
	--foreign key
	CONSTRAINT fkFighterID1 FOREIGN KEY (fighterID)
		REFERENCES Fighters(fighterID)
		ON UPDATE CASCADE
		ON DELETE CASCADE,
);
GO

--add fighterid fk to fights
ALTER TABLE Fights
ADD CONSTRAINT fkFighterID2 FOREIGN KEY (fighterID)
	REFERENCES Fighters(fighterID)
	ON UPDATE CASCADE
	ON DELETE CASCADE

-- offensive WrestlingStats
CREATE TABLE WrestlingStats (
	FighterID	int NOT NULL,
	typeOfShot	varchar(100) NOT NULL, 
	success	int,
	attempt		int,
	accuracy	as ((success / attempt) * 100)
	--primary key
	CONSTRAINT pkWrestlingStats	PRIMARY KEY (fighterID, typeOfShot),
	--foreign key
	CONSTRAINT fkFighterID3 FOREIGN KEY (fighterID)
		REFERENCES Fighters(fighterID)
		ON UPDATE CASCADE
		ON DELETE CASCADE,
);
GO

-- offensive submission stats
CREATE TABLE SubmissionStats (
	FighterID	int NOT NULL,
	typeOfSub	varchar(100) NOT NULL, 
	success		int,
	attempt		int,
	accuracy	as ((success / attempt) * 100)
	--primary key
	CONSTRAINT pkSubmissionStats PRIMARY KEY (fighterID, typeOfSub),
	--foreign key
	CONSTRAINT fkFighterID4 FOREIGN KEY (fighterID)
		REFERENCES Fighters(fighterID)
		ON UPDATE CASCADE
		ON DELETE CASCADE,
);
GO

-- offensive striking stats
CREATE TABLE StrkingStats (
	FighterID		int NOT NULL,
	typeOfStrike	varchar(100) NOT NULL, 
	success			int,
	attempt			int,
	accuracy		as ((success / attempt) * 100)
	--primary key
	CONSTRAINT pkStrikingStats PRIMARY KEY (fighterID, typeOfStrike),
	--foreign key
	CONSTRAINT fkFighterID5 FOREIGN KEY (fighterID)
		REFERENCES Fighters(fighterID)
		ON UPDATE CASCADE
		ON DELETE CASCADE,
);
GO

-- defensive WrestlingStats
CREATE TABLE DefWrestlingStats (
	FighterID	int NOT NULL,
	typeOfShot	varchar(100) NOT NULL, 
	takendown	int,
	attempt		int,
	defense		as (((takendown / attempt) * 100) - 100)
	--primary key
	CONSTRAINT pkDefWrestlingStats	PRIMARY KEY (fighterID, typeOfShot),
	--foreign key
	CONSTRAINT fkFighterID6 FOREIGN KEY (fighterID)
		REFERENCES Fighters(fighterID)
		ON UPDATE CASCADE
		ON DELETE CASCADE,
);
GO

-- defensive Submission Stats
CREATE TABLE DefSubmissionStats (
	FighterID	int NOT NULL,
	typeOfSub	varchar(100) NOT NULL, 
	subed		int,
	attempt		int,
	defense		as (((subed / attempt) * 100) - 100)
	--primary key
	CONSTRAINT pkDefSubmissionStats	PRIMARY KEY (fighterID, typeOfSub),
	--foreign key
	CONSTRAINT fkFighterID7 FOREIGN KEY (fighterID)
		REFERENCES Fighters(fighterID)
		ON UPDATE CASCADE
		ON DELETE CASCADE,
);
GO

-- defensive Submission Stats
CREATE TABLE DefStrikingStats (
	FighterID	int NOT NULL,
	typeOfSub	varchar(100) NOT NULL, 
	hit			int,
	attempt		int,
	defense		as (((hit / attempt) * 100) - 100)
	--primary key
	CONSTRAINT pkDefStrikingStats	PRIMARY KEY (fighterID, typeOfSub),
	--foreign key
	CONSTRAINT fkFighterID8 FOREIGN KEY (fighterID)
		REFERENCES Fighters(fighterID)
		ON UPDATE CASCADE
		ON DELETE CASCADE,
);
GO

--drop keys and fight locations so it could be remade
ALTER TABLE Cards
DROP CONSTRAINT fkFightLocation
GO

DROP TABLE FightLocations
GO

--fight location table
CREATE TABLE FightLocations (
	cardName	varchar(100) NOT NULL,
	city		varchar(100),
	country		varchar(100),
	Region		varchar(100),
	arenaName	varchar(100), 

	--foreign key
	CONSTRAINT fkCardlocName FOREIGN KEY (cardName)
	REFERENCES Cards (cardName)  
		ON UPDATE CASCADE
		ON DELETE CASCADE,

	--primary key
	CONSTRAINT pkCardLocation PRIMARY KEY (cardName)
);
GO

--update the cards table to reflect changes
ALTER TABLE Cards
DROP COLUMN city, country, arenaName
GO 

--alter the fights table and connected tables for better design
ALTER TABLE Fights
DROP CONSTRAINT fkWeightClass, fkPanelID, fkPurseID, fkRuleSet
GO 

ALTER TABLE Fights
DROP COLUMN weightClass, gender, sport, purseID, panelID, ruleSet, fightLevel
GO

--alter affected tables
--drop the affected tables
DROP TABLE Purses, Judges, WeightClasses, RuleSets
GO

--recreate the tables
--purses table
CREATE TABLE Purses (
	fightID		int NOT NULL,
	winPay		money,
	showPay		money,
	fightBonus	money,
	totalPurse	as (fightBonus + winPay + showPay),

	--foreign key
	CONSTRAINT fkFightPurse FOREIGN KEY (fightID)
	REFERENCES Fights (fightID)  
		ON UPDATE CASCADE
		ON DELETE CASCADE,

	--public key
	CONSTRAINT pkFightPurse PRIMARY KEY (fightID),
);
GO


--Panles table
CREATE TABLE Panles (
	fightID			int NOT NULL,
	judge1			varchar(100),
	judge2			varchar(100),
	judge3			varchar(100),
	judge4			varchar(100),
	judge5			varchar(100),
	judgingSystem	varchar(100),
	decision		varchar(100) NOT NULL,

	--foreign key
	CONSTRAINT fkFightPannel FOREIGN KEY (fightID)
	REFERENCES Fights (fightID)  
		ON UPDATE CASCADE
		ON DELETE CASCADE,

	--public key
	CONSTRAINT pkFightPanel PRIMARY KEY (fightID)
);
GO

--weightclass table
CREATE TABLE WeightClasses (
	fightID		int NOT NULL,
	weightClass	varchar(100) NOT NULL,
	gender		varchar(100) NOT NULL,
	sport		varchar(100) NOT NULL,

	--foreign key
	CONSTRAINT fkFightWeight FOREIGN KEY (fightID)
	REFERENCES Fights (fightID)  
		ON UPDATE CASCADE
		ON DELETE CASCADE,

	--public key
	CONSTRAINT pkWeightClass PRIMARY KEY (fightID),
);
GO

--rule sets table
CREATE TABLE RuleSets (
	fightId			int NOT NULL,
	ruleSet			varchar(100) NOT NULL,
	commissionName	varchar(100),
	sport			varchar(100),
	fightLevel		varchar(100) NOT NULL,

	--primary key
	CONSTRAINT pkFightRuleSet PRIMARY KEY (fightID),

	--foreign keys
	CONSTRAINT fkFightRlueset FOREIGN KEY (fightID)
	REFERENCES Fights (fightID)  
		ON UPDATE CASCADE
		ON DELETE CASCADE,

	CONSTRAINT fkCommission FOREIGN KEY (commissionName) 
		REFERENCES Commissions(commissionName)
		ON UPDATE CASCADE
		ON DELETE CASCADE 
);
GO

--remake panels table and break judges out
DROP TABLE Panles
GO

--create judges table
CREATE TABLE Judges (
	judgeName	varchar(100) NOT NULL,
	dateOfBirth	date,
	--primary key
	CONSTRAINT pkJudge PRIMARY KEY (judgeName),
);
GO

--Panles table
CREATE TABLE Panles (
	fightID			int NOT NULL,
	judge			varchar(100) NOT NULL,
	judgingSystem	varchar(100),
	decision		varchar(100) NOT NULL,
	--public key
	CONSTRAINT pkFightPanel PRIMARY KEY (fightID),

	--foreign key
	CONSTRAINT fkJudge FOREIGN KEY (judge)
	REFERENCES Judges (judgeName)
		ON UPDATE CASCADE
		ON DELETE CASCADE,
);
GO

ALTER TABLE Panles
ADD CONSTRAINT fkFightPannel FOREIGN KEY (fightID)
	REFERENCES Fights (fightID)
		ON UPDATE CASCADE
		ON DELETE CASCADE

-- AGENTS TABLE
CREATE TABLE Agencies (
	fighterID	int NOT NULL,
	AgentName	varchar(100),

	--foreign key
	CONSTRAINT fkFighterAgent FOREIGN KEY (fighterID)
	REFERENCES Fighters (fighterID)
		ON UPDATE CASCADE
		ON DELETE CASCADE,

	--public key
	CONSTRAINT pkFighterAgent PRIMARY KEY (fighterID),
);
GO

-- change the realtionship between fighters and gyms
ALTER TABLE Fighters
DROP CONSTRAINT fkGymName
GO 

ALTER TABLE Fighters
DROP COLUMN gymName
GO

ALTER TABLE Gyms
DROP CONSTRAINT pkgymName

ALTER TABLE Gyms
ADD FighterID int NOT NULL

ALTER TABLE Gyms
ADD CONSTRAINT fkFightersGym	FOREIGN KEY (fighterID)
		REFERENCES Fighters(FighterID)
		ON UPDATE CASCADE
		ON DELETE CASCADE
GO

ALTER TABLE Gyms
ADD CONSTRAINT pkFightersGym PRIMARY KEY (fighterID)
GO

--rework the stats tables
ALTER TABLE	WrestlingStats
DROP CONSTRAINT pkWrestlingStats
GO

ALTER TABLE	WrestlingStats
DROP COLUMN typeOfShot
GO

ALTER TABLE	WrestlingStats
ADD CONSTRAINT pkFighterWrestlingStats PRIMARY KEY (fighterID)
GO


ALTER TABLE	SubmissionStats
DROP CONSTRAINT pkSubmissionStats
GO

ALTER TABLE	SubmissionStats
DROP COLUMN typeOfSub
GO

ALTER TABLE	SubmissionStats
ADD CONSTRAINT pkFighterSubStats PRIMARY KEY (fighterID)
GO

ALTER TABLE	StrkingStats
DROP CONSTRAINT pkStrikingStats
GO

ALTER TABLE	StrkingStats
DROP COLUMN typeOfStrike
GO

ALTER TABLE	StrkingStats
ADD CONSTRAINT pkFighterStrikingStats PRIMARY KEY (fighterID)
GO

ALTER TABLE	DefWrestlingStats
DROP CONSTRAINT pkDefWrestlingStats
GO

ALTER TABLE	DefWrestlingStats
DROP COLUMN typeOfShot
GO

ALTER TABLE	DefWrestlingStats
ADD CONSTRAINT pkFighterDefWrestlingStats PRIMARY KEY (fighterID)
GO

ALTER TABLE	DefSubmissionStats
DROP CONSTRAINT pkDefSubmissionStats
GO

ALTER TABLE	DefSubmissionStats
DROP COLUMN typeOfSub
GO

ALTER TABLE	DefSubmissionStats
ADD CONSTRAINT pkFighterDefSubStats PRIMARY KEY (fighterID)
GO

ALTER TABLE	DefStrikingStats
DROP CONSTRAINT pkDefStrikingStats
GO

ALTER TABLE	DefStrikingStats
DROP COLUMN typeOfSub
GO

ALTER TABLE	DefStrikingStats
ADD CONSTRAINT pkFighterDefStrikingStats PRIMARY KEY (fighterID)
GO

--alter records table
ALTER TABLE Records
ADD draw int
GO

--update accuracy
ALTER TABLE StrkingStats
DROP COLUMN accuracy
GO 

ALTER TABLE StrkingStats
ADD accuracy as (success/attempt) * 100
GO

--update accuracy
ALTER TABLE StrkingStats
DROP COLUMN accuracy
GO 

ALTER TABLE StrkingStats
ADD accuracy as (success/attempt * 100) 
GO

--update accuracy
ALTER TABLE StrkingStats
DROP COLUMN accuracy
GO 

ALTER TABLE StrkingStats
ADD accuracy as success/attempt * 100
GO

-- alter panles and judges so that a panel has many judges
ALTER TABLE Judges
ADD fightPannel int NOT NULL
GO

ALTER TABLE Judges
ADD CONSTRAINT fkPannel FOREIGN KEY (fightPannel)
	REFERENCES Panles (fightID)
		ON UPDATE NO ACTION
		ON DELETE NO ACTION
GO

-- drop the judge constraint and column
ALTER TABLE Panles
DROP CONSTRAINT fkJudge
GO

ALTER TABLE Panles
DROP COLUMN judge
GO

-- readd the cascade
ALTER TABLE Judges
DROP CONSTRAINT fkPannel
GO

ALTER TABLE Judges
ADD CONSTRAINT fkPannel FOREIGN KEY (fightPannel)
	REFERENCES Panles (fightID)
		ON UPDATE CASCADE
		ON DELETE CASCADE
GO

-- implment junction table as fights and figters is a many to many relationship
-- remove fighter id key and colum from fights
ALTER TABLE Fights
DROP CONSTRAINT fkFighterID2
GO

ALTER TABLE Fights
DROP COLUMN fighterID
GO

-- junction table
CREATE TABLE FightCombatants (
	fighterID	int NOT NULL,
	fightID		int NOT NULL,

	--foreign key
	CONSTRAINT fkCombatantID FOREIGN KEY (fighterID)
	REFERENCES Fighters (fighterID)
		ON UPDATE CASCADE
		ON DELETE CASCADE,

	CONSTRAINT fkFight FOREIGN KEY (fightID)
	REFERENCES Fights (fightID)
		ON UPDATE CASCADE
		ON DELETE CASCADE,

	--public key
	CONSTRAINT pkFFID PRIMARY KEY (fightID, fighterID),
);
GO 

-- alter purses so it is depenedant on a fighter and a fight
ALTER TABLE Purses
DROP CONSTRAINT fkFightPurse
GO

ALTER TABLE Purses
DROP CONSTRAINT pkFightPurse
GO

ALTER TABLE Purses
DROP COLUMN fightID
GO

-- add the fk and pk
ALTER TABLE Purses
ADD fightID int NOT NULL 
GO 

ALTER TABLE Purses
ADD fighterID int NOT NULL 
GO 

ALTER TABLE Purses
ADD CONSTRAINT fkFightID FOREIGN KEY (fightID)
	REFERENCES Fights (fightID)
		ON UPDATE CASCADE
		ON DELETE CASCADE
GO

ALTER TABLE Purses
ADD CONSTRAINT fkFighterPurseID FOREIGN KEY (fighterID)
	REFERENCES Fighters (fighterID)
		ON UPDATE CASCADE
		ON DELETE CASCADE
GO

ALTER TABLE Purses
ADD CONSTRAINT pkFighterPurseID PRIMARY KEY (fighterID, fightID)
GO

-- alter panles to contain better info usefull for telling wins
ALTER TABLE Panles
ADD winner INT --the winning fighter id
GO

ALTER TABLE Panles
ADD CONSTRAINT fkwinningFighter FOREIGN KEY (winner)
	REFERENCES Fighters (fighterID)
		ON UPDATE CASCADE
		ON DELETE CASCADE
GO

--fix the fight table primary key
--drop all the fk

ALTER TABLE FightCombatants
DROP CONSTRAINT fkFight
GO

ALTER TABLE RuleSets
DROP CONSTRAINT fkFightRlueset
GO

ALTER TABLE WeightClasses
DROP CONSTRAINT fkFightWeight
GO

ALTER TABLE Panles
DROP CONSTRAINT fkFightPannel
GO

ALTER TABLE Purses
DROP CONSTRAINT fkFightID
GO

ALTER TABLE Purses
DROP CONSTRAINT fkFighterPurseID
GO

--drop purses key to re configure
ALTER TABLE Purses
DROP CONSTRAINT pkFighterPurseID
GO

ALTER TABLE Panles
DROP CONSTRAINT fkwinningFighter
GO

ALTER TABLE Fights
DROP CONSTRAINT pkFightID
GO

-- change the fight table
ALTER TABLE Fights
DROP COLUMN FightID
GO

ALTER TABLE Fights
ALTER COLUMN cardName varchar(100) NOT NULL
GO

ALTER TABLE Fights
ALTER COLUMN fightNum int NOT NULL
GO

ALTER TABLE Fights
ADD CONSTRAINT pkFight PRIMARY KEY (fightNum, cardName)
GO

--readd the fk from fights
ALTER TABLE WeightClasses
DROP CONSTRAINT pkWeightClass
GO

ALTER TABLE WeightClasses
DROP COLUMN fightID
GO

ALTER TABLE WeightClasses
ADD fightNum int NOT NULL
GO

ALTER TABLE WeightClasses
ADD cardName varchar(100) NOT NULL
GO

ALTER TABLE WeightClasses
ADD CONSTRAINT fkFightWeight FOREIGN KEY (fightNum,cardName)
	REFERENCES Fights (fightNum,cardName)
		ON UPDATE CASCADE
		ON DELETE CASCADE
GO

ALTER TABLE WeightClasses
ADD CONSTRAINT pkFightWeight PRIMARY KEY (fightNum,cardName)
GO

--rule set
ALTER TABLE RuleSets
DROP CONSTRAINT pkFightRuleSet
GO

ALTER TABLE RuleSets
DROP COLUMN fightid
GO

ALTER TABLE RuleSets
ADD fightNum int NOT NULL
GO

ALTER TABLE RuleSets
ADD cardName varchar(100) NOT NULL
GO

ALTER TABLE RuleSets
ADD CONSTRAINT fkFightRules FOREIGN KEY (fightNum,cardName)
	REFERENCES Fights (fightNum,cardName)
		ON UPDATE CASCADE
		ON DELETE CASCADE
GO

ALTER TABLE RuleSets
ADD CONSTRAINT pkFightRules PRIMARY KEY (fightNum,cardName)
GO

--combatants
ALTER TABLE FightCombatants
DROP CONSTRAINT pkFFID
GO

ALTER TABLE FightCombatants
DROP COLUMN fightid
GO

ALTER TABLE FightCombatants
ADD fightNum int NOT NULL
GO

ALTER TABLE FightCombatants
ADD cardName varchar(100) NOT NULL
GO

ALTER TABLE FightCombatants
ADD CONSTRAINT fkFight FOREIGN KEY (fightNum,cardName)
	REFERENCES Fights (fightNum,cardName)
		ON UPDATE CASCADE
		ON DELETE CASCADE
GO

ALTER TABLE FightCombatants
ADD CONSTRAINT pkFightCombatants PRIMARY KEY (fightNum,cardName,fighterID)
GO

--alter fight combatants to have the relation with purses as they are occurances of when 
-- fighters fight, they are not relvent to the fights table as many instance is needed per fight
-- judges and panles
ALTER TABLE Judges
DROP CONSTRAINT fkPannel
GO

ALTER TABLE Panles
DROP CONSTRAINT pkFightPanel
GO

ALTER TABLE Panles
DROP COLUMN fightid
GO

ALTER TABLE Panles
ADD fightNum int NOT NULL
GO

ALTER TABLE Panles
ADD cardName varchar(100) NOT NULL
GO

ALTER TABLE Panles
ADD CONSTRAINT fkFightPanles FOREIGN KEY (fightNum,cardName)
	REFERENCES Fights (fightNum,cardName)
		ON UPDATE CASCADE
		ON DELETE CASCADE
GO

ALTER TABLE Panles
DROP CONSTRAINT fkFightPanles
GO

ALTER TABLE Panles
ADD fighterID int NOT NULL
GO

ALTER TABLE Panles
DROP COLUMN winner
GO

ALTER TABLE Panles
ADD isWinner bit NOT NULL
GO

ALTER TABLE Panles
ADD CONSTRAINT fkFightPanles FOREIGN KEY (fightNum,cardName,fighterID)
	REFERENCES FightCombatants (fightNum,cardName,fighterID)
		ON UPDATE CASCADE
		ON DELETE CASCADE
GO

ALTER TABLE Panles
ADD CONSTRAINT pkFightPanles  PRIMARY KEY (fightNum,cardName,fighterID)
GO

--judges
ALTER TABLE Judges
DROP COLUMN fightPannel
GO

ALTER TABLE Judges
ADD fightNum int NOT NULL
GO

ALTER TABLE Judges
ADD cardName varchar(100) NOT NULL
GO

ALTER TABLE Judges
ADD fighterID int NOT NULL
GO

ALTER TABLE Judges
ADD CONSTRAINT fkFightJudge FOREIGN KEY (fightNum,cardName,fighterID)
	REFERENCES Panles (fightNum,cardName,fighterID)
		ON UPDATE CASCADE
		ON DELETE CASCADE
GO

ALTER TABLE Judges
DROP COLUMN dateOfBirth
GO

ALTER TABLE Judges
DROP CONSTRAINT pkJudge

ALTER TABLE Judges
ADD CONSTRAINT pkFightJudge PRIMARY KEY (fightNum,cardName,fighterID,judgeName)
GO

--a given judges score card
CREATE TABLE Scores (
	judgeName	varchar(100) NOT NULL,
	fightNum	int,
	fighterID	int,
	cardName	int,
	roundNum	int,
	score		int,
);
GO

ALTER TABLE Scores
ALTER COLUMN cardName varchar(100)
GO

ALTER TABLE Scores
ADD CONSTRAINT fkJudgeRoundScore FOREIGN KEY (fightNum,cardName,fighterID,judgeName)
	REFERENCES Judges (fightNum,cardName,fighterID,judgeName)
		ON UPDATE CASCADE
		ON DELETE CASCADE
GO

ALTER TABLE Scores
DROP CONSTRAINT fkJudgeRoundScore
GO

ALTER TABLE Scores
ALTER COLUMN cardName varchar(100) NOT NULL
GO

ALTER TABLE Scores
ALTER COLUMN fighterID int NOT NULL
GO

ALTER TABLE Scores
ALTER COLUMN fightNum int NOT NULL
GO

ALTER TABLE Scores
ADD CONSTRAINT fkJudgeRoundScore FOREIGN KEY (fightNum,cardName,fighterID,judgeName)
	REFERENCES Judges (fightNum,cardName,fighterID,judgeName)
		ON UPDATE CASCADE
		ON DELETE CASCADE
GO

ALTER TABLE Scores
ALTER COLUMN RoundNum int NOT NULL
GO

ALTER TABLE Scores
ADD CONSTRAINT pkJudgeRoundScore PRIMARY KEY (fightNum,cardName,fighterID,judgeName,roundNum)
GO

-- purses
ALTER TABLE Purses
DROP COLUMN fightid
GO

ALTER TABLE Purses
ADD fightNum int NOT NULL
GO

ALTER TABLE Purses
ADD cardName varchar(100) NOT NULL
GO

ALTER TABLE Purses
ADD CONSTRAINT fkFightPurse FOREIGN KEY (fightNum,cardName,fighterID)
	REFERENCES FightCombatants (fightNum,cardName,fighterID)
		ON UPDATE CASCADE
		ON DELETE CASCADE
GO

ALTER TABLE Purses
ADD CONSTRAINT pkFightPurse PRIMARY KEY (fightNum,cardName,fighterID)
GO

-- change the weight class to an int
ALTER TABLE WeightClasses
ALTER COLUMN weightClass int NOT NULL
GO

-- add normal weight
ALTER TABLE PhysicalStats
ADD	normalWeight	int
GO

-- allow for nulls
ALTER TABLE Panles
ALTER COLUMN judgingSystem varchar(100)
GO

ALTER TABLE Panles
ALTER COLUMN decision varchar(100)
GO

-- rework pannles
ALTER TABLE Panles
DROP CONSTRAINT fkFightPanles 
GO

ALTER TABLE Panles
ADD CONSTRAINT fkFightPanles FOREIGN KEY (fightNum,cardName,fighterID)
	REFERENCES FightCombatants (fightNum,cardName,fighterID)
		ON UPDATE CASCADE
		ON DELETE CASCADE
GO

ALTER TABLE Fights
DROP COLUMN opponetName

--fix the caculated column isuse
-- striking stats
ALTER TABLE StrkingStats
DROP COLUMN accuracy
GO

ALTER TABLE StrkingStats
ALTER COLUMN success float
GO

ALTER TABLE StrkingStats
ALTER COLUMN attempt float
GO

ALTER TABLE StrkingStats
ADD accuracy as (success/attempt) * 100
GO

--Def string stats
ALTER TABLE DefStrikingStats
DROP COLUMN defense
GO

ALTER TABLE DefStrikingStats
ALTER COLUMN hit float
GO

ALTER TABLE DefStrikingStats
ALTER COLUMN attempt float
GO

ALTER TABLE DefStrikingStats
ADD defense as (hit/attempt) * 100
GO

-- sub stats
ALTER TABLE SubmissionStats
DROP COLUMN accuracy
GO

ALTER TABLE SubmissionStats
ALTER COLUMN success float
GO

ALTER TABLE SubmissionStats
ALTER COLUMN attempt float
GO

ALTER TABLE SubmissionStats
ADD accuracy as (success/attempt) * 100
GO

--Def sub stats
ALTER TABLE DefSubmissionStats
DROP COLUMN defense
GO

ALTER TABLE DefSubmissionStats
ALTER COLUMN subed float
GO

ALTER TABLE DefSubmissionStats
ALTER COLUMN attempt float
GO

ALTER TABLE DefSubmissionStats
ADD defense as (subed/attempt) * 100
GO

-- Wrestling stats
ALTER TABLE WrestlingStats
DROP COLUMN accuracy
GO

ALTER TABLE WrestlingStats
ALTER COLUMN success float
GO

ALTER TABLE WrestlingStats
ALTER COLUMN attempt float
GO

ALTER TABLE WrestlingStats
ADD accuracy as (success/attempt) * 100
GO

-- Def Wrestling stats
ALTER TABLE DefWrestlingStats
DROP COLUMN defense
GO

ALTER TABLE DefWrestlingStats
ALTER COLUMN takendown float
GO

ALTER TABLE DefWrestlingStats
ALTER COLUMN attempt float
GO

ALTER TABLE DefWrestlingStats
ADD accuracy as (takendown/attempt) * 100
GO

-- rename some defensive stats columns
 ALTER TABLE DefWrestlingStats
DROP COLUMN accuracy
GO

ALTER TABLE DefWrestlingStats
DROP COLUMN takendown
GO

ALTER TABLE DefWrestlingStats
ADD takedownStoped float
GO

ALTER TABLE DefWrestlingStats
ADD defense as (takedownStoped/attempt) * 100
GO

--Def string stats
ALTER TABLE DefStrikingStats
DROP COLUMN defense
GO

ALTER TABLE DefStrikingStats
DROP COLUMN hit
GO

ALTER TABLE DefStrikingStats
ADD strikeMissed float
GO

ALTER TABLE DefStrikingStats
ADD defense as (strikeMissed/attempt) * 100
GO

--correct spelling
DROP TABLE StrkingStats
GO

-- offensive striking stats
CREATE TABLE StrikingStats (
	FighterID		int NOT NULL,
	success			float,
	attempt			float,
	accuracy		as (success / attempt) * 100
	--primary key
	CONSTRAINT pkStrikingStats PRIMARY KEY (fighterID),
	--foreign key
	CONSTRAINT fkFighterID5 FOREIGN KEY (fighterID)
		REFERENCES Fighters(fighterID)
		ON UPDATE CASCADE
		ON DELETE CASCADE,
);
GO

--correct spelling
ALTER TABLE Panles
DROP CONSTRAINT fkFightPanles
GO

ALTER TABLE Judges
DROP CONSTRAINT fkFightJudge
GO

DROP TABLE Panles
GO

CREATE TABLE Panels (
	judgingSystem	varchar(100),
	decision		varchar(100),
	fightNum		int	NOT NULL,
	cardName		varchar(100) NOT NULL,
	fighterID		int	NOT NULL,
	isWinner		bit NOT NULL
);
GO

ALTER TABLE Panels
ADD CONSTRAINT fkFightPanle FOREIGN KEY (fightNum,cardName,fighterID)
	REFERENCES FightCombatants (fightNum,cardName,fighterID)
		ON UPDATE CASCADE
		ON DELETE CASCADE
GO

ALTER TABLE Panels
DROP CONSTRAINT fkFightPanle
GO

ALTER TABLE Panels
ADD CONSTRAINT fkFightPanel FOREIGN KEY (fightNum,cardName,fighterID)
	REFERENCES FightCombatants (fightNum,cardName,fighterID)
		ON UPDATE CASCADE
		ON DELETE CASCADE
GO

ALTER TABLE Panels
ADD CONSTRAINT pkFightPanel PRIMARY KEY (fightNum,cardName,fighterID)
GO

ALTER TABLE Judges
ADD CONSTRAINT fkFightJudge FOREIGN KEY (fightNum,cardName,fighterID)
	REFERENCES Panels (fightNum,cardName,fighterID)
		ON UPDATE CASCADE
		ON DELETE CASCADE
GO

ALTER TABLE Scores
ALTER COLUMN score int NOT NULL
GO

ALTER TABLE RuleSets
ALTER COLUMN commissionName varchar(100) NOT NULL
GO

--DML
USE CombatSports
GO

--add data to the Fighters table
INSERT INTO Fighters (fighterName, nickName)
	VALUES('Khabib Nurmagomedov','	The Eagle')
GO

INSERT INTO Fighters (fighterName, nickName)
	VALUES('Eddie Alvarez','The Underground King')
GO

INSERT INTO Fighters (fighterName, nickName)
	VALUES('Edson Barboza','Junior')
GO

INSERT INTO Fighters (fighterName, nickName)
	VALUES('Tony Ferguson','El Cucuy')
GO

INSERT INTO Fighters (fighterName, nickName)
	VALUES('Justin Gaethje','The Highlight')
GO

INSERT INTO Fighters (fighterName, nickName)
	VALUES(' Conor McGregor','The Notorious')
GO

INSERT INTO Fighters (fighterName, nickName)
	VALUES('Dustin Poirier','The Diamond')
GO

INSERT INTO Fighters (fighterName, nickName)
	VALUES('Kevin Lee','The Motown Phenom')
GO

INSERT INTO Fighters (fighterName, nickName)
	VALUES('Anthony Pettis','Showtime')
GO

INSERT INTO Fighters (fighterName, nickName)
	VALUES('Al Iaquinta','	Raging')
GO

INSERT INTO Fighters (fighterName, nickName)
	VALUES('Nate Diaz','')
GO

INSERT INTO Fighters (fighterName, nickName)
	VALUES('Michael Chiesa','Maverick')
GO

INSERT INTO Fighters (fighterName, nickName)
	VALUES('James Vick','The Texecutioner')
GO

INSERT INTO Fighters (fighterName, nickName)
	VALUES('Alexander Hernandez','The Great')
GO

INSERT INTO Fighters (fighterName, nickName)
	VALUES('Dan Hooker','The Hangman')
GO

INSERT INTO Fighters (fighterName, nickName)
	VALUES('Francisco Trinaldo','Massaranduba')
GO

INSERT INTO Fighters (fighterName, nickName)
	VALUES('Paul Felder','The Irish Dragon')
GO

INSERT INTO Fighters (fighterName, nickName)
	VALUES('Joe Lauzon','')
GO

INSERT INTO Fighters (fighterName, nickName)
	VALUES('Nick Newell','Notorious')
GO

INSERT INTO Fighters (fighterName, nickName)
	VALUES('Marc Diakiese','Bonecrusher')
GO
--add DOB
UPDATE Fighters
SET dateOfBirth='19880920'
WHERE fighterID='1';
GO

UPDATE Fighters
SET dateOfBirth='19840111'
WHERE fighterID='2';
GO

UPDATE Fighters
SET dateOfBirth='19860121'
WHERE fighterID='3';
GO

UPDATE Fighters
SET dateOfBirth='19840212'
WHERE fighterID='4';
GO

UPDATE Fighters
SET dateOfBirth='19881114'
WHERE fighterID='5';
GO

UPDATE Fighters
SET dateOfBirth='19880714'
WHERE fighterID='6';
GO

UPDATE Fighters
SET dateOfBirth='19890119'
WHERE fighterID='7';
GO

UPDATE Fighters
SET dateOfBirth='19920904'
WHERE fighterID='8';
GO

UPDATE Fighters
SET dateOfBirth='19870127'
WHERE fighterID='9';
GO

UPDATE Fighters
SET dateOfBirth='19870430'
WHERE fighterID='10';
GO

UPDATE Fighters
SET dateOfBirth='19850416'
WHERE fighterID='11';
GO

UPDATE Fighters
SET dateOfBirth='19871207'
WHERE fighterID='12';
GO

UPDATE Fighters
SET dateOfBirth='19870223'
WHERE fighterID='13';
GO

UPDATE Fighters
SET dateOfBirth='19921001'
WHERE fighterID='14';
GO

UPDATE Fighters
SET dateOfBirth='19900213'
WHERE fighterID='15';
GO

UPDATE Fighters
SET dateOfBirth='19780824'
WHERE fighterID='16';
GO

UPDATE Fighters
SET dateOfBirth='19850425'
WHERE fighterID='17';
GO

UPDATE Fighters
SET dateOfBirth='19840522'
WHERE fighterID='18';
GO

UPDATE Fighters
SET dateOfBirth='19860317'
WHERE fighterID='19';
GO

UPDATE Fighters
SET dateOfBirth='19930316'
WHERE fighterID='20';
GO

-- fill the fighter stats
INSERT INTO Records (fighterID, win, loss, draw)
	VALUES('1','27','0','0')
GO

INSERT INTO Records (fighterID, win, loss,noContest, draw)
	VALUES('2','29','6','1', '0')
GO

INSERT INTO Records (fighterID, win, loss,draw)
	VALUES('3','19','5','0')
GO

INSERT INTO Records (fighterID, win, loss,draw)
	VALUES('4','26','3','0')
GO

INSERT INTO Records (fighterID, win, loss,draw)
	VALUES('5','19','2','0')
GO

INSERT INTO Records (fighterID, win, loss,draw)
	VALUES('6','21','4','0')
GO

INSERT INTO Records (fighterID, win, loss,noContest, draw)
	VALUES('7','23','5','1','0')
GO

INSERT INTO Records (fighterID, win, loss,draw)
	VALUES('8','16','4','0')
GO

INSERT INTO Records (fighterID, win, loss,draw)
	VALUES('9','21','8','0')
GO

INSERT INTO Records (fighterID, win, loss,draw)
	VALUES('10','13','4','1')
GO

INSERT INTO Records (fighterID, win, loss,draw)
	VALUES('11','20','11','0')
GO

INSERT INTO Records (fighterID, win, loss,draw)
	VALUES('12','14','4','0')
GO

INSERT INTO Records (fighterID, win, loss,draw)
	VALUES('13','13','2','0')
GO

INSERT INTO Records (fighterID, win, loss,draw)
	VALUES('14','10','1','0')
GO

INSERT INTO Records (fighterID, win, loss,noContest)
	VALUES('15','18','7','0')
GO

INSERT INTO Records (fighterID, win, loss,draw)
	VALUES('16','23','6','0')
GO

INSERT INTO Records (fighterID, win, loss,draw)
	VALUES('17','15','14','0')
GO

INSERT INTO Records (fighterID, win, loss,draw)
	VALUES('18','27','16','0')
GO

INSERT INTO Records (fighterID, win, loss,draw)
	VALUES('19','14','2','0')
GO

INSERT INTO Records (fighterID, win, loss, noContest)
	VALUES('20','12','3','0')
GO

--fix errors

UPDATE Records
SET draw='0'
WHERE fighterID='20';
GO


UPDATE Records
SET draw='0'
WHERE fighterID='15';
GO

UPDATE Records
SET noContest=null
WHERE fighterID='20';
GO


UPDATE Records
SET noContest=null
WHERE fighterID='15';
GO

--add physical stats
INSERT INTO PhysicalStats(fighterID,reach,gender,legReach, hight)
	VALUES ('1','70','male','40','70')
GO

INSERT INTO PhysicalStats(fighterID,reach,gender,legReach, hight)
	VALUES ('2','69','male','40','69')
GO

INSERT INTO PhysicalStats(fighterID,reach,gender,legReach, hight)
	VALUES ('3','75','male','41','71')
GO

INSERT INTO PhysicalStats(fighterID,reach,gender,legReach, hight)
	VALUES ('4','76','male','40','71')
GO

INSERT INTO PhysicalStats(fighterID,reach,gender,legReach, hight)
	VALUES ('5','70','male','40','71')
GO

INSERT INTO PhysicalStats(fighterID,reach,gender,legReach,hight)
	VALUES ('6','74','male','40','69')
GO

INSERT INTO PhysicalStats(fighterID,reach,gender,legReach,hight)
	VALUES ('7','72','male','40','69')
GO

INSERT INTO PhysicalStats(fighterID,reach,gender,legReach,hight)
	VALUES ('8','77','male','39','69')
GO

INSERT INTO PhysicalStats(fighterID,reach,gender,legReach, hight)
	VALUES ('9','72','male','40','70')
GO

INSERT INTO PhysicalStats(fighterID,reach,gender,legReach,hight)
	VALUES ('10','70','male','40','69')
GO

INSERT INTO PhysicalStats(fighterID,reach,gender,legReach, hight)
	VALUES ('11','76','male','38','72')
GO

INSERT INTO PhysicalStats(fighterID,reach,gender,legReach,hight)
	VALUES ('12','75','male','43','73')
GO

INSERT INTO PhysicalStats(fighterID,reach,gender,legReach, hight)
	VALUES ('13','76','male','43','75')
GO

INSERT INTO PhysicalStats(fighterID,reach,gender,legReach, hight)
	VALUES ('14','72','male','39','69')
GO

INSERT INTO PhysicalStats(fighterID,reach,gender,legReach,hight)
	VALUES ('15','75','male','42','72')
GO

INSERT INTO PhysicalStats(fighterID,reach,gender,legReach, hight)
	VALUES ('16','70','male','40','69')
GO

INSERT INTO PhysicalStats(fighterID,reach,gender,legReach,hight)
	VALUES ('17','70','male','40','71')
GO

INSERT INTO PhysicalStats(fighterID,reach,gender,legReach, hight)
	VALUES ('18','71','male','40','70')
GO

INSERT INTO PhysicalStats(fighterID,reach,gender, hight, legReach)
	VALUES ('19','74','male','70','')
GO

INSERT INTO PhysicalStats(fighterID,reach,gender,legReach, hight)
	VALUES ('20','73','male','39','70')
GO

--add values into gyms
INSERT INTO Gyms(FighterID,gymName)
	VALUES ('1','American Kickboxing Academy')
GO

INSERT INTO Gyms(FighterID,gymName)
	VALUES ('2','Ricardo Almeida BJJ')
GO

INSERT INTO Gyms(FighterID,gymName)
	VALUES ('3','Ricardo Almeida BJJ')
GO

INSERT INTO Gyms(FighterID,gymName)
	VALUES ('4','Team Death Clutch')
GO

INSERT INTO Gyms(FighterID,gymName)
	VALUES ('5','SBG Ireland')
GO

INSERT INTO Gyms(FighterID,gymName)
	VALUES ('6','SBG Ireland')
GO

INSERT INTO Gyms(FighterID,gymName)
	VALUES ('7','American Top Team')
GO

INSERT INTO Gyms(FighterID,gymName)
	VALUES ('8','Xtreme Couture')
GO

INSERT INTO Gyms(FighterID,gymName)
	VALUES ('9','Roufusport')
GO

INSERT INTO Gyms(FighterID,gymName)
	VALUES ('10','Serra-Longo Fight Team')
GO

INSERT INTO Gyms(FighterID,gymName)
	VALUES ('11','Cesar Gracie Jiu-Jitsu')
GO

INSERT INTO Gyms(FighterID,gymName)
	VALUES ('12','Team Alpha Male')
GO

INSERT INTO Gyms(FighterID,gymName)
	VALUES ('13','Team Lloyd Irvin')
GO

INSERT INTO Gyms(FighterID,gymName)
	VALUES ('14','Ohana Academy')
GO

INSERT INTO Gyms(FighterID,gymName)
	VALUES ('15','Tiger Muay Thai')
GO

INSERT INTO Gyms(FighterID,gymName)
	VALUES ('16','Evolucao Thai')
GO

INSERT INTO Gyms(FighterID,gymName)
	VALUES ('17','Roufusport')
GO

INSERT INTO Gyms(FighterID,gymName)
	VALUES ('18','Lauzon MMA')
GO

INSERT INTO Gyms(FighterID,gymName)
	VALUES ('19','Fighting Arts Academy')
GO

INSERT INTO Gyms(FighterID,gymName)
	VALUES ('20','American Top Team')
GO

--fix data
UPDATE Gyms
SET gymName='Genesis Training Center'
WHERE fighterID='5';
GO

--add striking stats
INSERT INTO StrikingStats(FighterID,success,attempt)
	VALUES ('1','657','1323')
GO

INSERT INTO StrikingStats(FighterID,success,attempt)
	VALUES ('2','400','970')
GO

INSERT INTO StrikingStats(FighterID,success,attempt)
	VALUES ('3','738','1899')
GO

INSERT INTO StrikingStats(FighterID,success,attempt)
	VALUES ('4','832','1865')
GO

INSERT INTO StrikingStats(FighterID,success,attempt)
	VALUES ('5','348','638')
GO

INSERT INTO StrikingStats(FighterID,success,attempt)
	VALUES ('6','524','1074')
GO

INSERT INTO StrikingStats(FighterID,success,attempt)
	VALUES ('7','1146','2302')
GO

INSERT INTO StrikingStats(FighterID,success,attempt)
	VALUES ('8','585','1295')
GO

INSERT INTO StrikingStats(FighterID,success,attempt)
	VALUES ('9','672','1483')
GO

INSERT INTO StrikingStats(FighterID,success,attempt)
	VALUES ('10','526','1312')
GO

INSERT INTO StrikingStats(FighterID,success,attempt)
	VALUES ('11','1311','2965')
GO

INSERT INTO StrikingStats(FighterID,success,attempt)
	VALUES ('12','193','509')
GO

INSERT INTO StrikingStats(FighterID,success,attempt)
	VALUES ('13','395','1023')
GO

INSERT INTO StrikingStats(FighterID,success,attempt)
	VALUES ('14','47','94')
GO

INSERT INTO StrikingStats(FighterID,success,attempt)
	VALUES ('15','335','762')
GO

INSERT INTO StrikingStats(FighterID,success,attempt)
	VALUES ('16','673','1483')
GO

INSERT INTO StrikingStats(FighterID,success,attempt)
	VALUES ('17','444','1017')
GO

INSERT INTO StrikingStats(FighterID,success,attempt)
	VALUES ('18','580','1489')
GO

INSERT INTO StrikingStats(FighterID)
	VALUES ('19')
GO

INSERT INTO StrikingStats(FighterID,success,attempt)
	VALUES ('20','171','523')
GO

--add wrestling stats
INSERT INTO WrestlingStats(FighterID,success,attempt)
	VALUES ('1','52','116')
GO

INSERT INTO WrestlingStats(FighterID,success,attempt)
	VALUES ('2','12','46')
GO

INSERT INTO WrestlingStats(FighterID,success,attempt)
	VALUES ('3','7','14')
GO

INSERT INTO WrestlingStats(FighterID,success,attempt)
	VALUES ('4','6','14')
GO

INSERT INTO WrestlingStats(FighterID)
	VALUES ('5')
GO

INSERT INTO WrestlingStats(FighterID,success,attempt)
	VALUES ('6','5','8')
GO

INSERT INTO WrestlingStats(FighterID,success,attempt)
	VALUES ('7','24','58')
GO

INSERT INTO WrestlingStats(FighterID,success,attempt)
	VALUES ('8','32','75')
GO

INSERT INTO WrestlingStats(FighterID,success,attempt)
	VALUES ('9','12','22')
GO

INSERT INTO WrestlingStats(FighterID,success,attempt)
	VALUES ('10','8','28')
GO

INSERT INTO WrestlingStats(FighterID,success,attempt)
	VALUES ('11','22','73')
GO

INSERT INTO WrestlingStats(FighterID,success,attempt)
	VALUES ('12','17','43')
GO

INSERT INTO WrestlingStats(FighterID,success,attempt)
	VALUES ('13','2','6')
GO

INSERT INTO WrestlingStats(FighterID,success,attempt)
	VALUES ('14','4','10')
GO

INSERT INTO WrestlingStats(FighterID,success,attempt)
	VALUES ('15','3','7')
GO

INSERT INTO WrestlingStats(FighterID,success,attempt)
	VALUES ('16','16','35')
GO

INSERT INTO WrestlingStats(FighterID,success,attempt)
	VALUES ('17','3','9')
GO

INSERT INTO WrestlingStats(FighterID,success,attempt)
	VALUES ('18','33','73')
GO

INSERT INTO WrestlingStats(FighterID)
	VALUES ('19')
GO

INSERT INTO WrestlingStats(FighterID,success,attempt)
	VALUES ('20','9','29')
GO

--add submission stats
INSERT INTO SubmissionStats(FighterID,success)
	VALUES ('1','9')
GO

INSERT INTO SubmissionStats(FighterID,success)
	VALUES ('2','7')
GO

INSERT INTO SubmissionStats(FighterID,success)
	VALUES ('3','1')
GO

INSERT INTO SubmissionStats(FighterID,success)
	VALUES ('4','8')
GO

INSERT INTO SubmissionStats(FighterID,success)
	VALUES ('5','1')
GO

INSERT INTO SubmissionStats(FighterID,success)
	VALUES ('6','1')
GO

INSERT INTO SubmissionStats(FighterID,success)
	VALUES ('7','7')
GO

INSERT INTO SubmissionStats(FighterID,success)
	VALUES ('8','8')
GO

INSERT INTO SubmissionStats(FighterID,success)
	VALUES ('9','8')
GO

INSERT INTO SubmissionStats(FighterID,success)
	VALUES ('10','1')
GO

INSERT INTO SubmissionStats(FighterID,success)
	VALUES ('11','12')
GO

INSERT INTO SubmissionStats(FighterID,success)
	VALUES ('12','10')
GO

INSERT INTO SubmissionStats(FighterID,success)
	VALUES ('13','5')
GO

INSERT INTO SubmissionStats(FighterID,success)
	VALUES ('14','2')
GO

INSERT INTO SubmissionStats(FighterID,success)
	VALUES ('15','7')
GO

INSERT INTO SubmissionStats(FighterID,success)
	VALUES ('16','5')
GO

INSERT INTO SubmissionStats(FighterID,success)
	VALUES ('17','1')
GO

INSERT INTO SubmissionStats(FighterID,success)
	VALUES ('18','18')
GO

INSERT INTO SubmissionStats(FighterID,success)
	VALUES ('19','9')
GO

INSERT INTO SubmissionStats(FighterID,success)
	VALUES ('20','1')
GO

--defensive submission stats
INSERT INTO	DefSubmissionStats(FighterID,subed)
	VALUES	('1','0')
GO

INSERT INTO	DefSubmissionStats(FighterID,subed)
	VALUES	('2','2')
GO

INSERT INTO	DefSubmissionStats(FighterID,subed)
	VALUES	('3','2')
GO

INSERT INTO	DefSubmissionStats(FighterID,subed)
	VALUES	('4','1')
GO

INSERT INTO	DefSubmissionStats(FighterID,subed)
	VALUES	('5','0')
GO

INSERT INTO	DefSubmissionStats(FighterID,subed)
	VALUES	('6','4')
GO

INSERT INTO	DefSubmissionStats(FighterID,subed)
	VALUES	('7','1')
GO

INSERT INTO	DefSubmissionStats(FighterID,subed)
	VALUES	('8','1')
GO

INSERT INTO	DefSubmissionStats(FighterID,subed)
	VALUES	('9','1')
GO

INSERT INTO	DefSubmissionStats(FighterID,subed)
	VALUES	('10','3')
GO

INSERT INTO	DefSubmissionStats(FighterID,subed)
	VALUES	('11','1')
GO

INSERT INTO	DefSubmissionStats(FighterID,subed)
	VALUES	('12','3')
GO

INSERT INTO	DefSubmissionStats(FighterID,subed)
	VALUES	('13','0')
GO

INSERT INTO	DefSubmissionStats(FighterID,subed)
	VALUES	('14','0')
GO

INSERT INTO	DefSubmissionStats(FighterID,subed)
	VALUES	('15','2')
GO

INSERT INTO	DefSubmissionStats(FighterID,subed)
	VALUES	('16','3')
GO

INSERT INTO	DefSubmissionStats(FighterID,subed)
	VALUES	('17','0')
GO

INSERT INTO	DefSubmissionStats(FighterID,subed)
	VALUES	('18','3')
GO

INSERT INTO	DefSubmissionStats(FighterID,subed)
	VALUES	('19','0')
GO

INSERT INTO	DefSubmissionStats(FighterID,subed)
	VALUES	('20','1')
GO

--add Def striking stats
INSERT INTO DefStrikingStats(FighterID,strikeMissed,attempt)
	VALUES ('1','6.7','10')
GO

INSERT INTO DefStrikingStats(FighterID,strikeMissed,attempt)
	VALUES ('2','5.6','10')
GO

INSERT INTO DefStrikingStats(FighterID,strikeMissed,attempt)
	VALUES ('3','6','10')
GO

INSERT INTO DefStrikingStats(FighterID,strikeMissed,attempt)
	VALUES ('4','6.4','10')
GO

INSERT INTO DefStrikingStats(FighterID,strikeMissed,attempt)
	VALUES ('5','5.4','10')
GO

INSERT INTO DefStrikingStats(FighterID,strikeMissed,attempt)
	VALUES ('6','5.5','10')
GO

INSERT INTO DefStrikingStats(FighterID,strikeMissed,attempt)
	VALUES ('7','5.6','10')
GO

INSERT INTO DefStrikingStats(FighterID,strikeMissed,attempt)
	VALUES ('8','5.2','10')
GO

INSERT INTO DefStrikingStats(FighterID,strikeMissed,attempt)
	VALUES ('9','5.5','10')
GO

INSERT INTO DefStrikingStats(FighterID,strikeMissed,attempt)
	VALUES ('10','6.2','10')
GO

INSERT INTO DefStrikingStats(FighterID,strikeMissed,attempt)
	VALUES ('11','5.5','10')
GO

INSERT INTO DefStrikingStats(FighterID,strikeMissed,attempt)
	VALUES ('12','5.1','10')
GO

INSERT INTO DefStrikingStats(FighterID,strikeMissed,attempt)
	VALUES ('13','6.3','10')
GO

INSERT INTO DefStrikingStats(FighterID,strikeMissed,attempt)
	VALUES ('14','4.7','10')
GO

INSERT INTO DefStrikingStats(FighterID,strikeMissed,attempt)
	VALUES ('15','5.7','10')
GO

INSERT INTO DefStrikingStats(FighterID,strikeMissed,attempt)
	VALUES ('16','6','10')
GO

INSERT INTO DefStrikingStats(FighterID,strikeMissed,attempt)
	VALUES ('17','5.1','10')
GO

INSERT INTO DefStrikingStats(FighterID,strikeMissed,attempt)
	VALUES ('18','5.5','10')
GO

INSERT INTO DefStrikingStats(FighterID,strikeMissed,attempt)
	VALUES ('20','5.5','10')
GO

--add defwrestling stats
INSERT INTO DefWrestlingStats(FighterID,takedownStoped,attempt)
	VALUES ('1','8.5','10')
GO

INSERT INTO DefWrestlingStats(FighterID,takedownStoped,attempt)
	VALUES ('2','9.3','10')
GO

INSERT INTO DefWrestlingStats(FighterID,takedownStoped,attempt)
	VALUES ('3','8','10')
GO

INSERT INTO DefWrestlingStats(FighterID,takedownStoped,attempt)
	VALUES ('4','7.7','10')
GO

INSERT INTO DefWrestlingStats(FighterID, takedownStoped,attempt)
	VALUES ('5','8','10')
GO

INSERT INTO DefWrestlingStats(FighterID,takedownStoped,attempt)
	VALUES ('6','7','10')
GO

INSERT INTO DefWrestlingStats(FighterID,takedownStoped,attempt)
	VALUES ('7','6.9','10')
GO

INSERT INTO DefWrestlingStats(FighterID,takedownStoped,attempt)
	VALUES ('8','7.5','10')
GO

INSERT INTO DefWrestlingStats(FighterID,takedownStoped,attempt)
	VALUES ('9','5.9','10')
GO

INSERT INTO DefWrestlingStats(FighterID,takedownStoped,attempt)
	VALUES ('10','7.7','10')
GO

INSERT INTO DefWrestlingStats(FighterID,takedownStoped,attempt)
	VALUES ('11','4.6','10')
GO

INSERT INTO DefWrestlingStats(FighterID,takedownStoped,attempt)
	VALUES ('12','6.8','10')
GO

INSERT INTO DefWrestlingStats(FighterID,takedownStoped,attempt)
	VALUES ('13','5.7','10')
GO

INSERT INTO DefWrestlingStats(FighterID,takedownStoped,attempt)
	VALUES ('14','6.7','10')
GO

INSERT INTO DefWrestlingStats(FighterID,takedownStoped,attempt)
	VALUES ('15','7.7','10')
GO

INSERT INTO DefWrestlingStats(FighterID,takedownStoped,attempt)
	VALUES ('16','6.3','10')
GO

INSERT INTO DefWrestlingStats(FighterID,takedownStoped,attempt)
	VALUES ('17','5.9','10')
GO

INSERT INTO DefWrestlingStats(FighterID,takedownStoped,attempt)
	VALUES ('18','5.5','10')
GO

INSERT INTO DefWrestlingStats(FighterID,takedownStoped,attempt)
	VALUES ('20','6.2','10')
GO

-- promoter information
INSERT INTO Promoters(president, promoterName)
	VALUES('Dana White','Ultimate Fighting Championship')
GO

UPDATE Promoters
SET revenue='700000000'
WHERE promoterName='Ultimate Fighting Championship';
GO

INSERT INTO Promoters(president, promoterName, revenue)
	VALUES('Scott Coker','Bellator MMA','15000000')
GO

INSERT INTO Promoters(CEO, promoterName, revenue)
	VALUES('Chatri Sityodtong','One FC','16000000')
GO

INSERT INTO Promoters(CEO, promoterName, president)
	VALUES('Peter Murray','Professional Fighters League','Carlos Silva')
GO

-- card data
INSERT INTO Cards(cardName, numFights, mainEvent, fightDate, promoterName)
	VALUES('UFC 229','12','Khabib vs McGregor','10/6/2018','Ultimate Fighting Championship')
GO

UPDATE Cards
SET coMainEvent='Ferguson vs Pettis'
WHERE cardName='UFC 229'

INSERT INTO Cards(cardName, numFights, mainEvent, fightDate, promoterName, coMainEvent)
	VALUES('UFC Fight Night: Santos vs. Anders','14','Santos vs Anders','9/22/2018','Ultimate Fighting Championship', 'Oliveria vs Pedersoli')
GO

INSERT INTO Cards(cardName, numFights, mainEvent, fightDate, promoterName)
	VALUES('UFC Fight Night: Gaethje vs. Vick','13','Gaethje vs Vick','8/25/2018','Ultimate Fighting Championship')
GO

INSERT INTO Cards(cardName, numFights, mainEvent, fightDate, promoterName, coMainEvent)
	VALUES('UFC on Fox: Alvarez vs. Poirier 2','13','Alvarez vs. Poirier','7/28/2018','Ultimate Fighting Championship','Aldo vs Stephens')
GO

INSERT INTO Cards(cardName, numFights, mainEvent, fightDate, promoterName, coMainEvent)
	VALUES('UFC 226','11',' Miocic vs. Cormier','7/7/2018','Ultimate Fighting Championship','Lewis vs Ngannou')
GO

INSERT INTO Cards(cardName, numFights, mainEvent, fightDate, promoterName)
	VALUES('UFC Fight Night: Barboza vs. Lee','11','Barboza vs. Lee','4/21/2018','Ultimate Fighting Championship')
GO

INSERT INTO Cards(cardName, numFights, mainEvent, fightDate, promoterName)
	VALUES('UFC on Fox: Poirier vs. Gaethje','13','Poirier vs. Gaethje','4/14.2018','Ultimate Fighting Championship')
GO

INSERT INTO Cards(cardName, numFights, mainEvent, fightDate, promoterName)
	VALUES('UFC 223','9','Khabib vs. Iaquinta','4/7/2018','Ultimate Fighting Championship')
GO

INSERT INTO Cards(cardName, numFights, mainEvent, fightDate, promoterName)
	VALUES('UFC 222','12','Cyborg vs. Kunitskaya','3/3/2018','Ultimate Fighting Championship')
GO

INSERT INTO Cards(cardName, numFights, mainEvent, fightDate, promoterName)
	VALUES('UFC Fight Night: Cowboy vs. Medeiros','12','Cowboy vs. Medeiros','2/18/2018','Ultimate Fighting Championship')
GO

INSERT INTO Cards(cardName, numFights, mainEvent, fightDate, promoterName)
	VALUES('UFC 219: Cyborg vs. Holm','10','Cyborg vs. Holm','12/30/2017','Ultimate Fighting Championship')
GO

INSERT INTO Cards(cardName, numFights, mainEvent, fightDate, promoterName)
	VALUES('UFC 218: Holloway vs. Aldo 2','13','Holloway vs. Aldo','12/2/2017','Ultimate Fighting Championship')
GO

INSERT INTO Cards(cardName, numFights, mainEvent, fightDate, promoterName)
	VALUES('UFC Fight Night: Poirier vs. Pettis','13','Poirier vs. Pettis','11/11/2017','Ultimate Fighting Championship')
GO

--fight data
INSERT INTO Fights(fightNum, cardName)
	VALUES('13','UFC Fight Night: Poirier vs. Pettis')
GO

INSERT INTO Fights(fightNum, cardName)
	VALUES('8','UFC 218: Holloway vs. Aldo 2')
GO

INSERT INTO Fights(fightNum, cardName)
	VALUES('10','UFC 218: Holloway vs. Aldo 2')
GO

INSERT INTO Fights(fightNum, cardName)
	VALUES('8','UFC 219: Cyborg vs. Holm')
GO

INSERT INTO Fights(fightNum, cardName)
	VALUES('9','UFC 219: Cyborg vs. Holm')
GO

INSERT INTO Fights(fightNum, cardName)
	VALUES('6','UFC 222')
GO

INSERT INTO Fights(fightNum, cardName)
	VALUES('5','UFC 223')
GO

INSERT INTO Fights(fightNum, cardName)
	VALUES('9','UFC 223')
GO

INSERT INTO Fights(fightNum, cardName)
	VALUES('8','UFC 226')
GO

INSERT INTO Fights(fightNum, cardName)
	VALUES('2','UFC 226')
GO

INSERT INTO Fights(fightNum, cardName)
	VALUES('11','UFC 229')
GO

INSERT INTO Fights(fightNum, cardName)
	VALUES('12','UFC 229')
GO

INSERT INTO Fights(fightNum, cardName)
	VALUES('6','UFC Fight Night: Barboza vs. Lee')
GO

INSERT INTO Fights(fightNum, cardName)
	VALUES('11','UFC Fight Night: Barboza vs. Lee')
GO

INSERT INTO Fights(fightNum, cardName)
	VALUES('10','UFC Fight Night: Cowboy vs. Medeiros')
GO

INSERT INTO Fights(fightNum, cardName)
	VALUES('13','UFC Fight Night: Gaethje vs. Vick')
GO

INSERT INTO Fights(fightNum, cardName)
	VALUES('8','UFC Fight Night: Santos vs. Anders')
GO

INSERT INTO Fights(fightNum, cardName)
	VALUES('10','UFC on Fox: Alvarez vs. Poirier 2')
GO

INSERT INTO Fights(fightNum, cardName)
	VALUES('13','UFC on Fox: Alvarez vs. Poirier 2')
GO

INSERT INTO Fights(fightNum, cardName)
	VALUES('14','UFC on Fox: Poirier vs. Gaethje')
GO

INSERT INTO Fights(fightNum, cardName)
	VALUES('8','UFC Fight Night: Poirier vs. Pettis')
GO

-- add the relation between fighters and fights
INSERT INTO FightCombatants(fighterID, fightNum,cardName)
	VALUES('15','2','UFC 226')
GO

INSERT INTO FightCombatants(fighterID, fightNum,cardName)
	VALUES('18','5','UFC 223')
GO

INSERT INTO FightCombatants(fighterID, fightNum,cardName)
	VALUES('1','9','UFC 223')
GO

INSERT INTO FightCombatants(fighterID, fightNum,cardName)
	VALUES('10','9','UFC 223')
GO

INSERT INTO FightCombatants(fighterID, fightNum,cardName)
	VALUES('14','6','UFC 222')
GO

INSERT INTO FightCombatants(fighterID, fightNum,cardName)
	VALUES('15','6','UFC Fight Night: Barboza vs. Lee')
GO

INSERT INTO FightCombatants(fighterID, fightNum,cardName)
	VALUES('3','11','UFC Fight Night: Barboza vs. Lee')
GO

INSERT INTO FightCombatants(fighterID, fightNum,cardName)
	VALUES('8','11','UFC Fight Night: Barboza vs. Lee')
GO

INSERT INTO FightCombatants(fighterID, fightNum,cardName)
	VALUES('5','8','UFC 218: Holloway vs. Aldo 2')
GO

INSERT INTO FightCombatants(fighterID, fightNum,cardName)
	VALUES('2','8','UFC 218: Holloway vs. Aldo 2')
GO

INSERT INTO FightCombatants(fighterID, fightNum,cardName)
	VALUES('15','8','UFC 219: Cyborg vs. Holm')
GO

INSERT INTO FightCombatants(fighterID, fightNum,cardName)
	VALUES('20','8','UFC 219: Cyborg vs. Holm')
GO

INSERT INTO FightCombatants(fighterID, fightNum,cardName)
	VALUES('1','9','UFC 219: Cyborg vs. Holm')
GO

INSERT INTO FightCombatants(fighterID, fightNum,cardName)
	VALUES('3','9','UFC 219: Cyborg vs. Holm')
GO

INSERT INTO FightCombatants(fighterID, fightNum,cardName)
	VALUES('9','8','UFC 226')
GO

INSERT INTO FightCombatants(fighterID, fightNum,cardName)
	VALUES('12','8','UFC 226')
GO

INSERT INTO FightCombatants(fighterID, fightNum,cardName)
	VALUES('16','8','UFC Fight Night: Santos vs. Anders')
GO

UPDATE	FightCombatants
SET		fightNum='10'
WHERE	cardName='UFC 218: Holloway vs. Aldo 2'	

INSERT INTO FightCombatants(fighterID, fightNum,cardName)
	VALUES('17','8','UFC 218: Holloway vs. Aldo 2')
GO

INSERT INTO FightCombatants(fighterID, fightNum,cardName)
	VALUES('13','10','UFC Fight Night: Cowboy vs. Medeiros')
GO

INSERT INTO FightCombatants(fighterID, fightNum,cardName)
	VALUES('2','13','UFC on Fox: Alvarez vs. Poirier 2')
GO

INSERT INTO FightCombatants(fighterID, fightNum,cardName)
	VALUES('7','13','UFC on Fox: Alvarez vs. Poirier 2')
GO

INSERT INTO FightCombatants(fighterID, fightNum,cardName)
	VALUES('14','10','UFC on Fox: Alvarez vs. Poirier 2')
GO

INSERT INTO FightCombatants(fighterID, fightNum,cardName)
	VALUES('4','11','UFC 229')
GO

INSERT INTO FightCombatants(fighterID, fightNum,cardName)
	VALUES('9','11','UFC 229')
GO

INSERT INTO FightCombatants(fighterID, fightNum,cardName)
	VALUES('1','12','UFC 229')
GO

INSERT INTO FightCombatants(fighterID, fightNum,cardName)
	VALUES('6','12','UFC 229')
GO

INSERT INTO FightCombatants(fighterID, fightNum,cardName)
	VALUES('7','14','UFC on Fox: Poirier vs. Gaethje')
GO

INSERT INTO FightCombatants(fighterID, fightNum,cardName)
	VALUES('5','14','UFC on Fox: Poirier vs. Gaethje')
GO

INSERT INTO FightCombatants(fighterID, fightNum,cardName)
	VALUES('5','13','UFC Fight Night: Gaethje vs. Vick')
GO

INSERT INTO FightCombatants(fighterID, fightNum,cardName)
	VALUES('13','13','UFC Fight Night: Gaethje vs. Vick')
GO

INSERT INTO FightCombatants(fighterID, fightNum,cardName)
	VALUES('7','13','UFC Fight Night: Poirier vs. Pettis')
GO

INSERT INTO FightCombatants(fighterID, fightNum,cardName)
	VALUES('9','13','UFC Fight Night: Poirier vs. Pettis')
GO

INSERT INTO FightCombatants(fighterID, fightNum,cardName)
	VALUES('18','8','UFC Fight Night: Poirier vs. Pettis')
GO

-- add normal weight classes
UPDATE PhysicalStats
SET normalWeight=155
WHERE fighterID='1';
GO

UPDATE PhysicalStats
SET normalWeight=155
WHERE fighterID='2';
GO

UPDATE PhysicalStats
SET normalWeight=155
WHERE fighterID='3';
GO

UPDATE PhysicalStats
SET normalWeight=155
WHERE fighterID='4';
GO

UPDATE PhysicalStats
SET normalWeight=155
WHERE fighterID='5';
GO

UPDATE PhysicalStats
SET normalWeight=155
WHERE fighterID='6';
GO

UPDATE PhysicalStats
SET normalWeight=155
WHERE fighterID='7';
GO

UPDATE PhysicalStats
SET normalWeight=155
WHERE fighterID='8';
GO

UPDATE PhysicalStats
SET normalWeight=155
WHERE fighterID='9';
GO

UPDATE PhysicalStats
SET normalWeight=155
WHERE fighterID='10';
GO

UPDATE PhysicalStats
SET normalWeight=155
WHERE fighterID='11';
GO

UPDATE PhysicalStats
SET normalWeight=155
WHERE fighterID='12';
GO

UPDATE PhysicalStats
SET normalWeight=155
WHERE fighterID='13';
GO

UPDATE PhysicalStats
SET normalWeight=155
WHERE fighterID='14';
GO

UPDATE PhysicalStats
SET normalWeight=155
WHERE fighterID='15';
GO

UPDATE PhysicalStats
SET normalWeight=155
WHERE fighterID='16';
GO

UPDATE PhysicalStats
SET normalWeight=155
WHERE fighterID='17';
GO

UPDATE PhysicalStats
SET normalWeight=155
WHERE fighterID='18';
GO

UPDATE PhysicalStats
SET normalWeight=155
WHERE fighterID='19';
GO

UPDATE PhysicalStats
SET normalWeight=155
WHERE fighterID='20';
GO

-- add in the weight classes for each fight
INSERT INTO WeightClasses(cardName, fightNum, gender, sport, weightClass)
	VALUES('UFC 223','5','male','MMA','155')
GO

INSERT INTO WeightClasses(cardName, fightNum, gender, sport, weightClass)
	VALUES('UFC 222','6','male','MMA','155')
GO

INSERT INTO WeightClasses(cardName, fightNum, gender, sport, weightClass)
	VALUES('UFC Fight Night: Barboza vs. Lee','6','male','MMA','155')
GO

INSERT INTO WeightClasses(cardName, fightNum, gender, sport, weightClass)
	VALUES('UFC 218: Holloway vs. Aldo 2','8','male','MMA','155')
GO

INSERT INTO WeightClasses(cardName, fightNum, gender, sport, weightClass)
	VALUES('UFC 219: Cyborg vs. Holm','8','male','MMA','155')
GO

INSERT INTO WeightClasses(cardName, fightNum, gender, sport, weightClass)
	VALUES('UFC 226','8','male','MMA','155')
GO

INSERT INTO WeightClasses(cardName, fightNum, gender, sport, weightClass)
	VALUES('UFC Fight Night: Poirier vs. Pettis','8','male','MMA','155')
GO

INSERT INTO WeightClasses(cardName, fightNum, gender, sport, weightClass)
	VALUES('UFC Fight Night: Santos vs. Anders','8','male','MMA','155')
GO

INSERT INTO WeightClasses(cardName, fightNum, gender, sport, weightClass)
	VALUES('UFC 219: Cyborg vs. Holm','9','male','MMA','155')
GO

INSERT INTO WeightClasses(cardName, fightNum, gender, sport, weightClass)
	VALUES('UFC 223','9','male','MMA','155')
GO

INSERT INTO WeightClasses(cardName, fightNum, gender, sport, weightClass)
	VALUES('UFC 218: Holloway vs. Aldo 2','10','male','MMA','')
GO

INSERT INTO WeightClasses(cardName, fightNum, gender, sport, weightClass)
	VALUES('UFC Fight Night: Cowboy vs. Medeiros','10','male','MMA','155')
GO

INSERT INTO WeightClasses(cardName, fightNum, gender, sport, weightClass)
	VALUES('UFC on Fox: Alvarez vs. Poirier 2','10','male','MMA','155')
GO

INSERT INTO WeightClasses(cardName, fightNum, gender, sport, weightClass)
	VALUES('UFC 229','11','male','MMA','155')
GO

INSERT INTO WeightClasses(cardName, fightNum, gender, sport, weightClass)
	VALUES('UFC Fight Night: Barboza vs. Lee','11','male','MMA','157')
GO

INSERT INTO WeightClasses(cardName, fightNum, gender, sport, weightClass)
	VALUES('UFC 229','12','male','MMA','155')
GO

INSERT INTO WeightClasses(cardName, fightNum, gender, sport, weightClass)
	VALUES('UFC Fight Night: Gaethje vs. Vick','13','male','MMA','155')
GO

INSERT INTO WeightClasses(cardName, fightNum, gender, sport, weightClass)
	VALUES('UFC Fight Night: Poirier vs. Pettis','13','male','MMA','155')
GO

INSERT INTO WeightClasses(cardName, fightNum, gender, sport, weightClass)
	VALUES('UFC on Fox: Alvarez vs. Poirier 2','13','male','MMA','155')
GO

INSERT INTO WeightClasses(cardName, fightNum, gender, sport, weightClass)
	VALUES('UFC on Fox: Poirier vs. Gaethje','14','male','MMA','155')
GO

UPDATE WeightClasses
SET weightClass='155'
WHERE cardName='UFC 218: Holloway vs. Aldo 2'
	AND fightNum='10'

-- add data to the panels table
INSERT INTO Panels(fighterID, fightNum, cardName, isWinner)
	VALUES('1','9','UFC 219: Cyborg vs. Holm','1')
GO

INSERT INTO Panels(fighterID, fightNum, cardName, isWinner)
	VALUES('1','9','UFC 223','1')
GO

INSERT INTO Panels(fighterID, fightNum, cardName, isWinner)
	VALUES('1','12','UFC 229','1')
GO

INSERT INTO Panels(fighterID, fightNum, cardName, isWinner)
	VALUES('2','13','UFC on Fox: Alvarez vs. Poirier 2','0')
GO

INSERT INTO Panels(fighterID, fightNum, cardName, isWinner)
	VALUES('2','10','UFC 218: Holloway vs. Aldo 2','1')
GO

INSERT INTO Panels(fighterID, fightNum, cardName, isWinner)
	VALUES('3','9','UFC 219: Cyborg vs. Holm','0')
GO

INSERT INTO Panels(fighterID, fightNum, cardName, isWinner)
	VALUES('3','11','UFC Fight Night: Barboza vs. Lee','0')
GO

INSERT INTO Panels(fighterID, fightNum, cardName, isWinner)
	VALUES('4','11','UFC 229','1')
GO

INSERT INTO Panels(fighterID, fightNum, cardName, isWinner)
	VALUES('5','13','UFC Fight Night: Gaethje vs. Vick','1')
GO

INSERT INTO Panels(fighterID, fightNum, cardName, isWinner)
	VALUES('5','14','UFC on Fox: Poirier vs. Gaethje','0')
GO

INSERT INTO Panels(fighterID, fightNum, cardName, isWinner)
	VALUES('5','10','UFC 218: Holloway vs. Aldo 2','0')
GO

INSERT INTO Panels(fighterID, fightNum, cardName, isWinner)
	VALUES('6','12','UFC 229','0')
GO

INSERT INTO Panels(fighterID, fightNum, cardName, isWinner)
	VALUES('7','14','UFC on Fox: Poirier vs. Gaethje','1')
GO

INSERT INTO Panels(fighterID, fightNum, cardName, isWinner)
	VALUES('7','13','UFC on Fox: Alvarez vs. Poirier 2','0')
GO

INSERT INTO Panels(fighterID, fightNum, cardName, isWinner)
	VALUES('7','13','UFC Fight Night: Poirier vs. Pettis','1')
GO

INSERT INTO Panels(fighterID, fightNum, cardName, isWinner)
	VALUES('8','11','UFC Fight Night: Barboza vs. Lee','1')
GO

INSERT INTO Panels(fighterID, fightNum, cardName, isWinner)
	VALUES('9','11','UFC 229','0')
GO

INSERT INTO Panels(fighterID, fightNum, cardName, isWinner)
	VALUES('9','13','UFC Fight Night: Poirier vs. Pettis','0')
GO

INSERT INTO Panels(fighterID, fightNum, cardName, isWinner)
	VALUES('9','8','UFC 226','1')
GO

INSERT INTO Panels(fighterID, fightNum, cardName, isWinner)
	VALUES('10','9','UFC 223','0')
GO

INSERT INTO Panels(fighterID, fightNum, cardName, isWinner)
	VALUES('12','8','UFC 226','0')
GO

INSERT INTO Panels(fighterID, fightNum, cardName, isWinner)
	VALUES('13','10','UFC Fight Night: Cowboy vs. Medeiros','1')
GO

INSERT INTO Panels(fighterID, fightNum, cardName, isWinner)
	VALUES('13','13','UFC Fight Night: Gaethje vs. Vick','0')
GO

INSERT INTO Panels(fighterID, fightNum, cardName, isWinner)
	VALUES('14','10','UFC on Fox: Alvarez vs. Poirier 2','1')
GO

INSERT INTO Panels(fighterID, fightNum, cardName, isWinner)
	VALUES('14','6','UFC 222','1')
GO

INSERT INTO Panels(fighterID, fightNum, cardName, isWinner)
	VALUES('15','6','UFC Fight Night: Barboza vs. Lee','1')
GO

INSERT INTO Panels(fighterID, fightNum, cardName, isWinner)
	VALUES('15','2','UFC 226','1')
GO

INSERT INTO Panels(fighterID, fightNum, cardName, isWinner)
	VALUES('15','8','UFC 219: Cyborg vs. Holm','1')
GO

INSERT INTO Panels(fighterID, fightNum, cardName, isWinner)
	VALUES('16','8','UFC Fight Night: Santos vs. Anders','1')
GO

INSERT INTO Panels(fighterID, fightNum, cardName, isWinner)
	VALUES('17','8','UFC 218: Holloway vs. Aldo 2','1')
GO

INSERT INTO Panels(fighterID, fightNum, cardName, isWinner)
	VALUES('18','5','UFC 223','0')
GO

INSERT INTO Panels(fighterID, fightNum, cardName, isWinner)
	VALUES('18','8','UFC Fight Night: Poirier vs. Pettis','0')
GO

INSERT INTO Panels(fighterID, fightNum, cardName, isWinner)
	VALUES('20','8','UFC 219: Cyborg vs. Holm','0')
GO

--fighter agents data
INSERT INTO	Agencies(fighterID,	AgentName)
	VALUES('1','Shonda Marston')
GO

INSERT INTO	Agencies(fighterID,	AgentName)
	VALUES('2','Cairo Leonardson')
GO

INSERT INTO	Agencies(fighterID,	AgentName)
	VALUES('3','Jolene Tyrell')
GO

INSERT INTO	Agencies(fighterID,	AgentName)
	VALUES('4','Shonda Marston')
GO

INSERT INTO	Agencies(fighterID,	AgentName)
	VALUES('5','London Hunter')
GO

INSERT INTO	Agencies(fighterID,	AgentName)
	VALUES('6','Cairo Leonardson')
GO

INSERT INTO	Agencies(fighterID,	AgentName)
	VALUES('7','Maddy James')
GO

INSERT INTO	Agencies(fighterID,	AgentName)
	VALUES('8','Shonda Marston')
GO

INSERT INTO	Agencies(fighterID,	AgentName)
	VALUES('9','Jolene Tyrell')
GO

INSERT INTO	Agencies(fighterID,	AgentName)
	VALUES('10','Cairo Leonardson')
GO

INSERT INTO	Agencies(fighterID,	AgentName)
	VALUES('11','Garret Fry')
GO

INSERT INTO	Agencies(fighterID,	AgentName)
	VALUES('12','Maddy James')
GO

INSERT INTO	Agencies(fighterID,	AgentName)
	VALUES('13','Cairo Leonardson')
GO

INSERT INTO	Agencies(fighterID,	AgentName)
	VALUES('14','Jolene Tyrell')
GO

INSERT INTO	Agencies(fighterID,	AgentName)
	VALUES('15','London Hunter')
GO

INSERT INTO	Agencies(fighterID,	AgentName)
	VALUES('16','Jolene Tyrell')
GO

INSERT INTO	Agencies(fighterID,	AgentName)
	VALUES('17','Myles Hailey')
GO

INSERT INTO	Agencies(fighterID,	AgentName)
	VALUES('18','Garret Fry')
GO

INSERT INTO	Agencies(fighterID,	AgentName)
	VALUES('19','Maddy James')
GO

INSERT INTO	Agencies(fighterID,	AgentName)
	VALUES('20','London Hunter')
GO

--fight locations
INSERT INTO FightLocations(cardName,city,country,arenaName)
	VALUES('UFC 218: Holloway vs. Aldo 2','Boston','United States','TD Garden')
GO

INSERT INTO FightLocations(cardName,city,country,arenaName)
	VALUES('UFC 219: Cyborg vs. Holm','brooklyn','United States','barclay center')
GO

INSERT INTO FightLocations(cardName,city,country,arenaName)
	VALUES('UFC 222','Las Vegas','United States','MGM Arena')
GO

INSERT INTO FightLocations(cardName,city,country,arenaName)
	VALUES('UFC 223','los angeles','United States','Staples Center')
GO

INSERT INTO FightLocations(cardName,city,country,arenaName)
	VALUES('UFC 226','Boston','United States','TD Garden')
GO

INSERT INTO FightLocations(cardName,city,country,arenaName)
	VALUES('UFC 229','Las Vegas','United States','MGM Arena')
GO

INSERT INTO FightLocations(cardName,city,country,arenaName)
	VALUES('UFC Fight Night: Barboza vs. Lee','brooklyn','United States','barclay center')
GO

INSERT INTO FightLocations(cardName,city,country,arenaName)
	VALUES('UFC Fight Night: Cowboy vs. Medeiros','Boston','United States','TD Garden')
GO

INSERT INTO FightLocations(cardName,city,country,arenaName)
	VALUES('UFC Fight Night: Gaethje vs. Vick','los angeles','United States','Staples Center')
GO

INSERT INTO FightLocations(cardName,city,country,arenaName)
	VALUES('UFC Fight Night: Poirier vs. Pettis','brooklyn','United States','barclay center')
GO

INSERT INTO FightLocations(cardName,city,country,arenaName)
	VALUES('UFC Fight Night: Santos vs. Anders','los angeles','United States','Staples Center')
GO

INSERT INTO FightLocations(cardName,city,country,arenaName)
	VALUES('UFC on Fox: Alvarez vs. Poirier 2','Las Vegas','United States','MGM Arena')
GO

INSERT INTO FightLocations(cardName,city,country,arenaName)
	VALUES('UFC on Fox: Poirier vs. Gaethje','brooklyn','United States','barclay center')
GO

--ref data
INSERT INTO Refs(refName)
	VALUES('Mark Matheny')
GO

INSERT INTO Refs(refName)
	VALUES('Rob Hinds')
GO

INSERT INTO Refs(refName)
	VALUES('Minoru Toyonaga')
GO

INSERT INTO Refs(refName)
	VALUES('Josh Rosenthal')
GO

INSERT INTO Refs(refName)
	VALUES('Jason Herzog')
GO

INSERT INTO Refs(refName)
	VALUES('Keith Peterson')
GO

INSERT INTO Refs(refName)
	VALUES('Leon Roberts')
GO

INSERT INTO Refs(refName)
	VALUES('Marc Goddard')
GO

INSERT INTO Refs(refName)
	VALUES('John McCarthy')
GO

INSERT INTO Refs(refName)
	VALUES('Herb Dean')
GO

--judge data
INSERT INTO Judges(judgeName,cardName,fightNum,fighterID)
	VALUES('Howard Ellisson','UFC 226','8','9')
GO

INSERT INTO Judges(judgeName,cardName,fightNum,fighterID)
	VALUES('Howard Ellisson','UFC 226','8','12')
GO

INSERT INTO Judges(judgeName,cardName,fightNum,fighterID)
	VALUES('Howard Ellisson','UFC Fight Night: Barboza vs. Lee','11','3')
GO

INSERT INTO Judges(judgeName,cardName,fightNum,fighterID)
	VALUES('Howard Ellisson','UFC Fight Night: Barboza vs. Lee','11','8')
GO

INSERT INTO Judges(judgeName,cardName,fightNum,fighterID)
	VALUES('Valarie Holmes','UFC 226','8','9')
GO

INSERT INTO Judges(judgeName,cardName,fightNum,fighterID)
	VALUES('Valarie Holmes','UFC 226','8','12')
GO

INSERT INTO Judges(judgeName,cardName,fightNum,fighterID)
	VALUES('Valarie Holmes','UFC Fight Night: Barboza vs. Lee','11','3')
GO

INSERT INTO Judges(judgeName,cardName,fightNum,fighterID)
	VALUES('Valarie Holmes','UFC Fight Night: Barboza vs. Lee','11','8')
GO

INSERT INTO Judges(judgeName,cardName,fightNum,fighterID)
	VALUES('Alexandra Waters','UFC 226','8','9')
GO

INSERT INTO Judges(judgeName,cardName,fightNum,fighterID)
	VALUES('Alexandra Waters','UFC 226','8','12')
GO

INSERT INTO Judges(judgeName,cardName,fightNum,fighterID)
	VALUES('Alexandra Waters','UFC Fight Night: Barboza vs. Lee','11','3')
GO

INSERT INTO Judges(judgeName,cardName,fightNum,fighterID)
	VALUES('Alexandra Waters','UFC Fight Night: Barboza vs. Lee','11','8')
GO

INSERT INTO Judges(judgeName,cardName,fightNum,fighterID)
	VALUES('Logan Corey','UFC 226','8','9')
GO

INSERT INTO Judges(judgeName,cardName,fightNum,fighterID)
	VALUES('Logan Corey','UFC 226','8','12')
GO

INSERT INTO Judges(judgeName,cardName,fightNum,fighterID)
	VALUES('Logan Corey','UFC Fight Night: Barboza vs. Lee','11','3')
GO

INSERT INTO Judges(judgeName,cardName,fightNum,fighterID)
	VALUES('Logan Corey','UFC Fight Night: Barboza vs. Lee','11','8')
GO

--judges score data
INSERT INTO Scores(cardName,fightNum,fighterID,judgeName,roundNum,score)
	VALUES('UFC Fight Night: Barboza vs. Lee','11','8','Alexandra Waters','1','10')
GO

INSERT INTO Scores(cardName,fightNum,fighterID,judgeName,roundNum,score)
	VALUES('UFC Fight Night: Barboza vs. Lee','11','8','Valarie Holmes','1','10')
GO

INSERT INTO Scores(cardName,fightNum,fighterID,judgeName,roundNum,score)
	VALUES('UFC Fight Night: Barboza vs. Lee','11','8','Logan Corey','1','10')
GO

INSERT INTO Scores(cardName,fightNum,fighterID,judgeName,roundNum,score)
	VALUES('UFC Fight Night: Barboza vs. Lee','11','8','Alexandra Waters','2','10')
GO

INSERT INTO Scores(cardName,fightNum,fighterID,judgeName,roundNum,score)
	VALUES('UFC Fight Night: Barboza vs. Lee','11','8','Valarie Holmes','2','10')
GO

INSERT INTO Scores(cardName,fightNum,fighterID,judgeName,roundNum,score)
	VALUES('UFC Fight Night: Barboza vs. Lee','11','8','Logan Corey','2','10')
GO

INSERT INTO Scores(cardName,fightNum,fighterID,judgeName,roundNum,score)
	VALUES('UFC Fight Night: Barboza vs. Lee','11','3','Alexandra Waters','1','9')
GO

INSERT INTO Scores(cardName,fightNum,fighterID,judgeName,roundNum,score)
	VALUES('UFC Fight Night: Barboza vs. Lee','11','3','Valarie Holmes','1','8')
GO

INSERT INTO Scores(cardName,fightNum,fighterID,judgeName,roundNum,score)
	VALUES('UFC Fight Night: Barboza vs. Lee','11','3','Logan Corey','1','9')
GO

INSERT INTO Scores(cardName,fightNum,fighterID,judgeName,roundNum,score)
	VALUES('UFC Fight Night: Barboza vs. Lee','11','3','Alexandra Waters','2','9')
GO

INSERT INTO Scores(cardName,fightNum,fighterID,judgeName,roundNum,score)
	VALUES('UFC Fight Night: Barboza vs. Lee','11','3','Valarie Holmes','2','9')
GO

INSERT INTO Scores(cardName,fightNum,fighterID,judgeName,roundNum,score)
	VALUES('UFC Fight Night: Barboza vs. Lee','11','3','Logan Corey','2','8')
GO

--commission data
INSERT INTO Commissions(commissionName)
	VALUES('New York Athletic Commission')
GO

INSERT INTO Commissions(commissionName)
	VALUES('Nevada Athletic Commission')
GO

INSERT INTO Commissions(commissionName)
	VALUES('Massachusetts Athletic Commission')
GO

INSERT INTO Commissions(commissionName)
	VALUES('California Athletic Commission')
GO

--ruleset data
INSERT INTO RuleSets(cardName,fightNum,commissionName,sport,fightLevel,ruleSet)
	VALUES('UFC Fight Night: Santos vs. Anders','8','California Athletic Commission','MMA','professional','unified mma rules')
GO

INSERT INTO RuleSets(cardName,fightNum,commissionName,sport,fightLevel,ruleSet)
	VALUES('UFC 226','8','Massachusetts Athletic Commission','MMA','professional','unified mma rules')
GO

INSERT INTO RuleSets(cardName,fightNum,commissionName,sport,fightLevel,ruleSet)
	VALUES('UFC 229','11','Nevada Athletic Commission','MMA','professional','unified mma rules')
GO

INSERT INTO RuleSets(cardName,fightNum,commissionName,sport,fightLevel,ruleSet)
	VALUES('UFC Fight Night: Barboza vs. Lee','11','New York Athletic Commission','MMA','professional','unified mma rules')
GO

INSERT INTO RuleSets(cardName,fightNum,commissionName,sport,fightLevel,ruleSet)
	VALUES('UFC Fight Night: Poirier vs. Pettis','13','New York Athletic Commission','MMA','professional','unified mma rules')
GO

INSERT INTO RuleSets(cardName,fightNum,commissionName,sport,fightLevel,ruleSet)
	VALUES('UFC on Fox: Alvarez vs. Poirier 2','13','Nevada Athletic Commission','MMA','professional','unified mma rules')
GO

INSERT INTO RuleSets(cardName,fightNum,commissionName,sport,fightLevel,ruleSet)
	VALUES('UFC 218: Holloway vs. Aldo 2','8','Massachusetts Athletic Commission','MMA','professional','unified mma rules')
GO

INSERT INTO RuleSets(cardName,fightNum,commissionName,sport,fightLevel,ruleSet)
	VALUES('UFC Fight Night: Gaethje vs. Vick','13','California Athletic Commission','MMA','professional','unified mma rules')
GO

--purse data
INSERT INTO Purses(cardName,fightNum,fighterID,winPay,showPay,fightBonus)
	VALUES('UFC Fight Night: Barboza vs. Lee','11','3','0','250000','0')
GO

INSERT INTO Purses(cardName,fightNum,fighterID,winPay,showPay,fightBonus)
	VALUES('UFC Fight Night: Barboza vs. Lee','11','8','100000','250000','0')
GO

INSERT INTO Purses(cardName,fightNum,fighterID,winPay,showPay,fightBonus)
	VALUES('UFC Fight Night: Gaethje vs. Vick','13','5','50000','100000','25000')
GO

INSERT INTO Purses(cardName,fightNum,fighterID,winPay,showPay,fightBonus)
	VALUES('UFC Fight Night: Gaethje vs. Vick','13','13','0','100000','25000')
GO

INSERT INTO Purses(cardName,fightNum,fighterID,winPay,showPay,fightBonus)
	VALUES('UFC 218: Holloway vs. Aldo 2','10','2','125000','50000','0')
GO

INSERT INTO Purses(cardName,fightNum,fighterID,winPay,showPay,fightBonus)
	VALUES('UFC 218: Holloway vs. Aldo 2','10','5','0','50000','0')
GO

INSERT INTO Purses(cardName,fightNum,fighterID,winPay,showPay,fightBonus)
	VALUES('UFC on Fox: Alvarez vs. Poirier 2','13','2','0','75000','1000')
GO

INSERT INTO Purses(cardName,fightNum,fighterID,winPay,showPay,fightBonus)
	VALUES('UFC on Fox: Alvarez vs. Poirier 2','13','7','10000','75000','1000')
GO

INSERT INTO Purses(cardName,fightNum,fighterID,winPay,showPay,fightBonus)
	VALUES('UFC 229','12','1','25000','275000','30000')
GO

INSERT INTO Purses(cardName,fightNum,fighterID,winPay,showPay,fightBonus)
	VALUES('UFC 229','12','6','0','275000','0')
GO

INSERT INTO Purses(cardName,fightNum,fighterID,winPay,showPay,fightBonus)
	VALUES('UFC 229','11','4','25000','200000','0')
GO

INSERT INTO Purses(cardName,fightNum,fighterID,winPay,showPay,fightBonus)
	VALUES('UFC 229','11','9','0','200000','0')
GO

--upadate fight refs
UPDATE Fights
SET refName = 'Marc Goddard'
WHERE cardName = 'UFC Fight Night: Barboza vs. Lee'
	AND fightNum = '11'
GO

UPDATE Fights
SET refName = 'Marc Goddard'
WHERE cardName = 'UFC 226'
	AND fightNum = '2'
GO

UPDATE Fights
SET refName = 'Marc Goddard'
WHERE cardName = 'UFC 223'
	AND fightNum = '9'
GO

UPDATE Fights
SET refName = 'Jason Herzog'
WHERE cardName = 'UFC 223'
	AND fightNum = '5'
GO

UPDATE Fights
SET refName = 'Jason Herzog'
WHERE cardName = 'UFC 219: Cyborg vs. Holm'
	AND fightNum = '9'
GO

UPDATE Fights
SET refName = 'Jason Herzog'
WHERE cardName = 'UFC Fight Night: Gaethje vs. Vick'
	AND fightNum = '13'
GO

UPDATE Fights
SET refName = 'John McCarthy'
WHERE cardName = 'UFC 219: Cyborg vs. Holm'
	AND fightNum = '8'
GO

UPDATE Fights
SET refName = 'John McCarthy'
WHERE cardName = 'UFC 222'
	AND fightNum = '6'
GO

UPDATE Fights
SET refName = 'John McCarthy'
WHERE cardName = 'UFC Fight Night: Cowboy vs. Medeiros'
	AND fightNum = '10'
GO

UPDATE Fights
SET refName = 'Herb Dean'
WHERE cardName = 'UFC Fight Night: Poirier vs. Pettis'
	AND fightNum = '13'
GO

UPDATE Fights
SET refName = 'Herb Dean'
WHERE cardName = 'UFC Fight Night: Poirier vs. Pettis'
	AND fightNum = '8'
GO

UPDATE Fights
SET refName = 'Herb Dean'
WHERE cardName = 'UFC Fight Night: Barboza vs. Lee'
	AND fightNum = '6'
GO

UPDATE Fights
SET refName = 'Minoru Toyonaga'
WHERE cardName = 'UFC on Fox: Alvarez vs. Poirier 2'
	AND fightNum = '10'
GO

UPDATE Fights
SET refName = 'Minoru Toyonaga'
WHERE cardName = 'UFC on Fox: Alvarez vs. Poirier 2'
	AND fightNum = '13'
GO

UPDATE Fights
SET refName = 'Minoru Toyonaga'
WHERE cardName = 'UFC 229'
	AND fightNum = '12'
GO

UPDATE Fights
SET refName = 'Leon Roberts'
WHERE cardName = 'UFC 218: Holloway vs. Aldo 2'
	AND fightNum = '8'
GO

UPDATE Fights
SET refName = 'Leon Roberts'
WHERE cardName = 'UFC 226'
	AND fightNum = '8'
GO

UPDATE Fights
SET refName = 'Leon Roberts'
WHERE cardName = 'UFC Fight Night: Santos vs. Anders'
	AND fightNum = '8'
GO

UPDATE Fights
SET refName = 'Leon Roberts'
WHERE cardName = 'UFC on Fox: Poirier vs. Gaethje'
	AND fightNum = '14'
GO

UPDATE Fights
SET refName = 'Rob Hinds'
WHERE cardName = 'UFC 218: Holloway vs. Aldo 2'
	AND fightNum = '10'
GO

UPDATE Fights
SET refName = 'Rob Hinds'
WHERE cardName = 'UFC 229'
	AND fightNum = '11'
GO

--function
-- =============================================
-- Author:		Matthew vastarelli
-- Create date: 11/18/2018
-- Description:	return the given age based of the curent time
-- =============================================
CREATE FUNCTION dbo.FindYearsSince (@dob datetime)
RETURNS int
AS
BEGIN
	-- Declare the variables
	DECLARE @currentDate datetime
	DECLARE @yearsSince int

	--T-SQL statements to compute the return value here
	SELECT @currentDate = GETDATE()
	SELECT @yearsSince = (0 + Convert(Char(8),@currentDate,112) - Convert(Char(8),@dob,112)) / 10000

	-- Return the result of the function
	RETURN @yearsSince

END
GO

-- group by
--find and rank weight class  by number of fights in the current year
-- inorder to determine how active each weight class is
SELECT
	COUNT(DISTINCT c.cardName + CONVERT(varchar(100), f.fightNum)) DistinctFights,
	w.weightClass
FROM  Cards c
INNER JOIN  Fights f
	ON c.cardName = f.cardName 
INNER JOIN FightCombatants fc
	ON  f.cardName = fc.cardName 
	AND f.fightNum = fc.fightNum
INNER JOIN WeightClasses w
	ON  f.cardName = w.cardName
	AND f.fightNum = w.fightNum
WHERE dbo.FindYearsSince(c.fightDate) < 1
GROUP BY w.weightClass
ORDER BY w.weightClass ASC

GO

--order fighters by the most wins 
--baised on their fights recorded in the database
SELECT
	f.fighterName,
	COUNT(p.isWinner) TotalWins
FROM Panels p
INNER JOIN Fighters f
	ON p.fighterID = f.fighterID
GROUP BY f.fighterName
ORDER BY TotalWins DESC

GO

--subqueries
--find the reach of the top five fighters in the lightweight division
SELECT TOP 5
	TopFighters.fighterName,
	TopFighters.TotalWins,
	p.reach
FROM
	(
		SELECT
			f.fighterID,
			f.fighterName,
			COUNT(p.isWinner) TotalWins
		FROM Panels p
		INNER JOIN Fighters f
			ON p.fighterID = f.fighterID
		GROUP BY f.fighterName, f.fighterID
	) TopFighters
INNER JOIN PhysicalStats p
	ON TopFighters.fighterID = p.fighterID
WHERE p.normalWeight = '155'
ORDER BY TopFighters.TotalWins DESC

GO

--find all the fighters that have been in a fight in the last year
--where one fighter missed weight or fought out of their weight class

SELECT 
	f.fighterName,
	FighterWeights.weightClass,
	p.normalWeight
FROM (
		SELECT 
			c.fightDate,
			fc.fighterID,
			w.weightClass
		FROM FightCombatants fc
		INNER JOIN Fights f
			ON fc.cardName = f.cardName
			AND fc.fightNum = f.fightNum
		INNER JOIN Cards c
			ON f.cardName = c.cardName
		INNER JOIN WeightClasses w
			ON f.cardName = w.cardName
			AND f.fightNum = w.fightNum
		WHERE dbo.FindYearsSince(c.fightDate) < 1
	) FighterWeights
INNER JOIN PhysicalStats p
	ON FighterWeights.fighterID = p.fighterID
INNER JOIN Fighters f
	ON p.fighterID = f.fighterID
WHERE FighterWeights.weightClass != p.normalWeight

GO

-- join
-- select the fighter with the longest reach
SELECT  TOP 1
  f.fighterID,
  f.fighterName,
  p.reach
FROM Fighters f
INNER JOIN	PhysicalStats p
ON f.fighterID = p.fighterID
ORDER BY  p.reach DESC

GO

--find the fighter with the best striking offense
SELECT TOP 1 
  f.fighterName,
  f.fighterID,
  s.attempt,
  s.success,
  s.accuracy
FROM  Fighters f
INNER JOIN  StrikingStats s
ON  f.fighterID = s.FighterID
ORDER BY s.accuracy DESC

GO

--regular
-- find all the fighters whos nickname starts with the
SELECT *
FROM  Fighters f
WHERE  f.nickName LIKE	'the%'

GO

-- find all the fighters under 27
SELECT *
FROM  Fighters f
WHERE dbo.FindYearsSince(f.dateOfBirth) < 27

GO

-- This is an isolated example of adding
-- the maximum data for one fight and its
-- respective fighters


-- the data shown is already in the database

---- fighters
--INSERT INTO Fighters (fighterName, nickName,dateOfBirth)
--	VALUES('Edson Barboza','Junior','19860121')
--GO

--INSERT INTO Fighters (fighterName, nickName,dateOfBirth)
--	VALUES('Kevin Lee','The Motown Phenom','19920904')
--GO

---- fighters agents
--INSERT INTO	Agencies(fighterID,	AgentName)
--	VALUES('3','Jolene Tyrell')
--GO

--INSERT INTO	Agencies(fighterID,	AgentName)
--	VALUES('8','Shonda Marston')
--GO

---- fighters records
--INSERT INTO Records (fighterID, win, loss,draw)
--	VALUES('3','19','5','0')
--GO

--INSERT INTO Records (fighterID, win, loss,draw)
--	VALUES('8','16','4','0')
--GO

---- fighters PhysicalStats
--INSERT INTO PhysicalStats(fighterID,reach,gender,legReach, hight, normalWeight)
--	VALUES ('3','75','male','41','71','155')
--GO

--INSERT INTO PhysicalStats(fighterID,reach,gender,legReach,hight, normalWeight)
--	VALUES ('8','77','male','39','69','155')
--GO

----fighters main gym
--INSERT INTO Gyms(FighterID,gymName)
--	VALUES ('3','Ricardo Almeida BJJ')
--GO

--INSERT INTO Gyms(FighterID,gymName)
--	VALUES ('8','Xtreme Couture')
--GO

----striking stats
--INSERT INTO StrikingStats(FighterID,success,attempt)
--	VALUES ('3','738','1899')
--GO

--INSERT INTO StrikingStats(FighterID,success,attempt)
--	VALUES ('8','585','1295')
--GO

----wrestling stats
--INSERT INTO WrestlingStats(FighterID,success,attempt)
--	VALUES ('3','7','14')
--GO

--INSERT INTO WrestlingStats(FighterID,success,attempt)
--	VALUES ('8','32','75')
--GO

----submission stats
--INSERT INTO SubmissionStats(FighterID,success)
--	VALUES ('3','1')
--GO

--INSERT INTO SubmissionStats(FighterID,success)
--	VALUES ('8','8')
--GO

----defensive submission stats
--INSERT INTO	DefSubmissionStats(FighterID,subed)
--	VALUES	('3','2')
--GO

--INSERT INTO	DefSubmissionStats(FighterID,subed)
--	VALUES	('8','1')
--GO

----defensive striking stats
--INSERT INTO DefStrikingStats(FighterID,strikeMissed,attempt)
--	VALUES ('3','6','10')
--GO

--INSERT INTO DefStrikingStats(FighterID,strikeMissed,attempt)
--	VALUES ('8','5.2','10')
--GO

----defensive wrestling stats
--INSERT INTO DefWrestlingStats(FighterID,takedownStoped,attempt)
--	VALUES ('3','8','10')
--GO

--INSERT INTO DefWrestlingStats(FighterID,takedownStoped,attempt)
--	VALUES ('8','7.5','10')
--GO

---- promoters
--INSERT INTO Promoters(president, promoterName, revenue)
--	VALUES('Dana White','Ultimate Fighting Championship','700000000')
--GO

---- card by promoter in database with both fighters fighting on the card
--INSERT INTO Cards(cardName, numFights, mainEvent, fightDate, promoterName)
--	VALUES('UFC Fight Night: Barboza vs. Lee','11','Barboza vs. Lee','4/21/2018','Ultimate Fighting Championship')
--GO


---- ref for a fight
--INSERT INTO Refs(refName)
--	VALUES('Marc Goddard')
--GO

---- instance of fighter occuring
--INSERT INTO Fights(fightNum, cardName,refName)
--	VALUES('11','UFC Fight Night: Barboza vs. Lee','Marc Goddard')
--GO

---- add the two fighters to a fight
--INSERT INTO FightCombatants(fighterID, fightNum,cardName)
--	VALUES('3','11','UFC Fight Night: Barboza vs. Lee')
--GO

--INSERT INTO FightCombatants(fighterID, fightNum,cardName)
--	VALUES('8','11','UFC Fight Night: Barboza vs. Lee')
--GO

---- weight class for the fight
--INSERT INTO WeightClasses(cardName, fightNum, gender, sport, weightClass)
--	VALUES('UFC Fight Night: Barboza vs. Lee','11','male','MMA','157')
--GO

---- panel records to record the outcome of a fight and control scores
--INSERT INTO Panels(fighterID, fightNum, cardName, isWinner)
--	VALUES('3','11','UFC Fight Night: Barboza vs. Lee','0')
--GO

--INSERT INTO Panels(fighterID, fightNum, cardName, isWinner)
--	VALUES('8','11','UFC Fight Night: Barboza vs. Lee','1')
--GO 

---- location of the fight
--INSERT INTO FightLocations(cardName,city,country,arenaName)
--	VALUES('UFC Fight Night: Barboza vs. Lee','brooklyn','United States','barclay center')
--GO

---- judges for a fight
--INSERT INTO Judges(judgeName,cardName,fightNum,fighterID)
--	VALUES('Howard Ellisson','UFC Fight Night: Barboza vs. Lee','11','3')
--GO

--INSERT INTO Judges(judgeName,cardName,fightNum,fighterID)
--	VALUES('Howard Ellisson','UFC Fight Night: Barboza vs. Lee','11','8')
--GO

--INSERT INTO Judges(judgeName,cardName,fightNum,fighterID)
--	VALUES('Valarie Holmes','UFC Fight Night: Barboza vs. Lee','11','3')
--GO

--INSERT INTO Judges(judgeName,cardName,fightNum,fighterID)
--	VALUES('Valarie Holmes','UFC Fight Night: Barboza vs. Lee','11','8')
--GO

--INSERT INTO Judges(judgeName,cardName,fightNum,fighterID)
--	VALUES('Alexandra Waters','UFC Fight Night: Barboza vs. Lee','11','3')
--GO

--INSERT INTO Judges(judgeName,cardName,fightNum,fighterID)
--	VALUES('Alexandra Waters','UFC Fight Night: Barboza vs. Lee','11','8')
--GO

--INSERT INTO Judges(judgeName,cardName,fightNum,fighterID)
--	VALUES('Logan Corey','UFC Fight Night: Barboza vs. Lee','11','3')
--GO

--INSERT INTO Judges(judgeName,cardName,fightNum,fighterID)
--	VALUES('Logan Corey','UFC Fight Night: Barboza vs. Lee','11','8')
--GO

----round one scores
----lee's scores
--INSERT INTO Scores(cardName,fightNum,fighterID,judgeName,roundNum,score)
--	VALUES('UFC Fight Night: Barboza vs. Lee','11','8','Alexandra Waters','1','10')
--GO

--INSERT INTO Scores(cardName,fightNum,fighterID,judgeName,roundNum,score)
--	VALUES('UFC Fight Night: Barboza vs. Lee','11','8','Valarie Holmes','1','10')
--GO

--INSERT INTO Scores(cardName,fightNum,fighterID,judgeName,roundNum,score)
--	VALUES('UFC Fight Night: Barboza vs. Lee','11','8','Logan Corey','1','10')
--GO

----Barboza's scores
--INSERT INTO Scores(cardName,fightNum,fighterID,judgeName,roundNum,score)
--	VALUES('UFC Fight Night: Barboza vs. Lee','11','3','Alexandra Waters','1','9')
--GO

--INSERT INTO Scores(cardName,fightNum,fighterID,judgeName,roundNum,score)
--	VALUES('UFC Fight Night: Barboza vs. Lee','11','3','Valarie Holmes','1','8')
--GO

--INSERT INTO Scores(cardName,fightNum,fighterID,judgeName,roundNum,score)
--	VALUES('UFC Fight Night: Barboza vs. Lee','11','3','Logan Corey','1','9')

----round two scores
----lee's scores
--INSERT INTO Scores(cardName,fightNum,fighterID,judgeName,roundNum,score)
--	VALUES('UFC Fight Night: Barboza vs. Lee','11','8','Alexandra Waters','2','10')
--GO

--INSERT INTO Scores(cardName,fightNum,fighterID,judgeName,roundNum,score)
--	VALUES('UFC Fight Night: Barboza vs. Lee','11','8','Valarie Holmes','2','10')
--GO

--INSERT INTO Scores(cardName,fightNum,fighterID,judgeName,roundNum,score)
--	VALUES('UFC Fight Night: Barboza vs. Lee','11','8','Logan Corey','2','10')
--GO

----Barboza's scores
--INSERT INTO Scores(cardName,fightNum,fighterID,judgeName,roundNum,score)
--	VALUES('UFC Fight Night: Barboza vs. Lee','11','3','Alexandra Waters','2','9')
--GO

--INSERT INTO Scores(cardName,fightNum,fighterID,judgeName,roundNum,score)
--	VALUES('UFC Fight Night: Barboza vs. Lee','11','3','Valarie Holmes','2','9')
--GO

--INSERT INTO Scores(cardName,fightNum,fighterID,judgeName,roundNum,score)
--	VALUES('UFC Fight Night: Barboza vs. Lee','11','3','Logan Corey','2','8')
--GO

----commission 
--INSERT INTO Commissions(commissionName)
--	VALUES('New York Athletic Commission')
--GO

----rule set for a fight
--INSERT INTO RuleSets(cardName,fightNum,commissionName,sport,fightLevel,ruleSet)
--	VALUES('UFC Fight Night: Barboza vs. Lee','11','New York Athletic Commission','MMA','professional','unified mma rules')
--GO

----payment for the fight
----lee's payment
--INSERT INTO Purses(cardName,fightNum,fighterID,winPay,showPay,fightBonus)
--	VALUES('UFC Fight Night: Barboza vs. Lee','11','8','100000','250000','0')
--GO

----Barboza's payment
--INSERT INTO Purses(cardName,fightNum,fighterID,winPay,showPay,fightBonus)
--	VALUES('UFC Fight Night: Barboza vs. Lee','11','3','0','250000','0')
--GO
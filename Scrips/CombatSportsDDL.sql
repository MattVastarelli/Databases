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
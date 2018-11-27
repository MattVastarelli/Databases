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
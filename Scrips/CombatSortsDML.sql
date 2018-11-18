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

INSERT INTO StrkingStats(FighterID,success,attempt)
	VALUES ('1','657','1323')
GO

INSERT INTO StrkingStats(FighterID,success,attempt)
	VALUES ('2','400','970')
GO

INSERT INTO StrkingStats(FighterID,success,attempt)
	VALUES ('3','738','1899')
GO

INSERT INTO StrkingStats(FighterID,success,attempt)
	VALUES ('4','832','1865')
GO

INSERT INTO StrkingStats(FighterID,success,attempt)
	VALUES ('5','348','638')
GO

INSERT INTO StrkingStats(FighterID,success,attempt)
	VALUES ('6','524','1074')
GO

INSERT INTO StrkingStats(FighterID,success,attempt)
	VALUES ('7','1146','2302')
GO

INSERT INTO StrkingStats(FighterID,success,attempt)
	VALUES ('8','585','1295')
GO

INSERT INTO StrkingStats(FighterID,success,attempt)
	VALUES ('9','672','1483')
GO

INSERT INTO StrkingStats(FighterID,success,attempt)
	VALUES ('10','526','1312')
GO

INSERT INTO StrkingStats(FighterID,success,attempt)
	VALUES ('11','1311','2965')
GO

INSERT INTO StrkingStats(FighterID,success,attempt)
	VALUES ('12','193','509')
GO

INSERT INTO StrkingStats(FighterID,success,attempt)
	VALUES ('13','395','1023')
GO

INSERT INTO StrkingStats(FighterID,success,attempt)
	VALUES ('14','47','94')
GO

INSERT INTO StrkingStats(FighterID,success,attempt)
	VALUES ('15','335','762')
GO

INSERT INTO StrkingStats(FighterID,success,attempt)
	VALUES ('16','673','1483')
GO

INSERT INTO StrkingStats(FighterID,success,attempt)
	VALUES ('17','444','1017')
GO

INSERT INTO StrkingStats(FighterID,success,attempt)
	VALUES ('18','580','1489')
GO

INSERT INTO StrkingStats(FighterID)
	VALUES ('19')
GO

INSERT INTO StrkingStats(FighterID,success,attempt)
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

-- Fight info

--INSERT INTO Fights(fightNum, cardName)
--	VALUES('13','UFC Fight Night: Poirier vs. Pettis')
--GO

--INSERT INTO Fights(fightNum, cardName)
--	VALUES('13','UFC Fight Night: Poirier vs. Pettis')
--GO

--INSERT INTO Fights(fightNum, cardName)
--	VALUES('8','UFC 218: Holloway vs. Aldo 2')
--GO

--INSERT INTO Fights(fightNum, cardName)
--	VALUES('10','UFC 218: Holloway vs. Aldo 2')
--GO

--INSERT INTO Fights(fightNum, cardName)
--	VALUES('8','UFC 219: Cyborg vs. Holm')
--GO

--INSERT INTO Fights(fightNum, cardName)
--	VALUES('9','UFC 219: Cyborg vs. Holm')
--GO

--INSERT INTO Fights(fightNum, cardName)
--	VALUES('6','UFC 222')
--GO

--INSERT INTO Fights(fightNum, cardName)
--	VALUES('5','UFC 223')
--GO

--INSERT INTO Fights(fightNum, cardName)
--	VALUES('9','UFC 223')
--GO

----Fixed error
----DELETE FROM Fights
----	WHERE fightNum='9'

----UPDATE Fights
----SET fightNum='9'
----WHERE fightID='9'

----UPDATE Fights
----SET fightNum='6'
----WHERE fightID='8'

--INSERT INTO Fights(fightNum, cardName)
--	VALUES('8','UFC 226')
--GO

--INSERT INTO Fights(fightNum, cardName)
--	VALUES('2','UFC 226')
--GO

--INSERT INTO Fights(fightNum, cardName)
--	VALUES('11','UFC 229')
--GO

--INSERT INTO Fights(fightNum, cardName)
--	VALUES('12','UFC 229')
--GO

--INSERT INTO Fights(fightNum, cardName)
--	VALUES('6','UFC Fight Night: Barboza vs. Lee')
--GO

--INSERT INTO Fights(fightNum, cardName)
--	VALUES('11','UFC Fight Night: Barboza vs. Lee')
--GO

--INSERT INTO Fights(fightNum, cardName)
--	VALUES('10','UFC Fight Night: Cowboy vs. Medeiros')
--GO

--INSERT INTO Fights(fightNum, cardName)
--	VALUES('13','UFC Fight Night: Gaethje vs. Vick')
--GO

--INSERT INTO Fights(fightNum, cardName)
--	VALUES('8','UFC Fight Night: Santos vs. Anders')
--GO

--INSERT INTO Fights(fightNum, cardName)
--	VALUES('10','UFC on Fox: Alvarez vs. Poirier 2')
--GO

--INSERT INTO Fights(fightNum, cardName)
--	VALUES('13','UFC on Fox: Alvarez vs. Poirier 2')
--GO

--INSERT INTO Fights(fightNum, cardName)
--	VALUES('14','UFC on Fox: Poirier vs. Gaethje')
--GO

--remove data
--DELETE FROM Fights
--GO

--readd the data to fit the new design of the table
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

-- add in the weight classes for each fight
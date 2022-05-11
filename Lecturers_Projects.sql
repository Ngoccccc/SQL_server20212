CREATE DATABASE [QLKH];

CREATE TABLE [Lecturers] (
  [Lid] varchar(4),
  [FullName] varchar(40),
  [Address] varchar(50),
  [DOB] date,
  PRIMARY KEY ([Lid])
);

CREATE TABLE [Projects] (
	[Pid] varchar(4),
	[Title] varchar(40),
	[Level] varchar(1),
	[Cost] int,
	PRIMARY KEY ([Pid])
);

CREATE TABLE [Participation](
	[Lid] varchar(4),
	[Pid] varchar(4),
	[Duration] int,
	PRIMARY KEY([Lid],[Pid]),
	FOREIGN KEY ([Lid]) REFERENCES [Lecturers]([Lid]),
	FOREIGN KEY ([Pid]) REFERENCES [Projects]([Pid])

);

Lecturers

INSERT INTO [Lecturers]([Lid],[FullName],[Address],[DOB])
VALUES	('GV01','Vu Tuyet Trinh','Hoang Mai, Hanoi','10/10/1975'),			
		('GV02','Nguyen Nhat Quang','Hai Ba Trung, Hanoi','03/11/1976'),
		('GV03','Tran Duc Khanh','Dong Da, Hanoi','04/06/1977'),
		('GV04','Nguyen Hong Phuong','Tay Ho, Hanoi','10/12/1983'),
		('GV05','Le Thanh Huong','Hai Ba Trung, Hanoi','10/10/1976')


INSERT INTO [Projects]([Pid],[Title],[Level],[Cost])
VALUES	('DT01','Grid Computing','A','700'),
		('DT02','Knowledge Discovery','B','300'),
		('DT03','Text Classification','B','270'),
		('DT04','Automatic English-Vietnamese Translation','C','30')
		
		
INSERT INTO [Participation]([Lid],[Pid],[Duration])
VALUES	('GV01','DT01','100'),
		('GV01','DT02','80'),
		('GV01','DT03','80'),
		('GV02','DT01','120'),
		('GV02','DT03','140'),
		('GV03','DT03','150'),
		('GV04','DT04','180')

USE CompanySupplyProduct SELECT *FROM Lecturers
USE CompanySupplyProduct SELECT *FROM Projects
USE CompanySupplyProduct SELECT *FROM Participation

SELECT (FullName) FROM Lecturers WHERE [Address] = 'Hai Ba Trung, Hanoi'


SELECT (FullName) FROM [Lecturers] Lec,[Projects] Prj,[Participation] Par 
	WHERE Prj.[Title]='Grid Computing' AND Lec.[Lid] = Par.[Lid] AND Prj.[Pid]=Par.[Pid]

SELECT (FullName) FROM [Lecturers] Lec,[Projects] Prj,[Participation] Par 
	WHERE (Prj.[Title]='Grid Computing' OR Prj.[Title]='Automatic English-Vietnamese Translation') AND Lec.[Lid] = Par.[Lid] AND Prj.[Pid]=Par.[Pid]

--Dem so giang vien huong dan hon 1 project
SELECT Lecturers.[Lid], Fullname FROM Lecturers, (SELECT Participation.[Lid], COUNT(Participation.[Lid]) AS Count_Prj
																	FROM Participation GROUP BY Participation.[Lid]) AS ThongtinSL
						WHERE Lecturers.Lid = ThongtinSL.[Lid]  AND ThongtinSL.Count_Prj > 1

SELECT * FROM Lecturers
WHERE Lid IN(SELECT Lid FROM Participation GROUP BY Lid HAVING COUNT (Pid)>1)

--Giang vien so prj lon nhat
SELECT * FROM Lecturers
WHERE Lid IN(SELECT Lid FROM Participation GROUP BY Lid HAVING COUNT (Pid)>= All(SELECT COUNT(Pid) FROM Participation GROUP BY Lid))
--Du an re nhat
SELECT *FROM Projects
WHERE Cost <= All(SELECT Cost FROM Projects)
--Ten va Project cua giang vien o tay ho
SELECT FullName,Prj.[Title] FROM [Lecturers] Lec,[Projects] Prj,[Participation] Par 
	WHERE Lec.[Lid] = Par.[Lid] AND Prj.[Pid]=Par.[Pid] AND Lec.[Address] LIKE 'Tay Ho%'

--giang vien sinh truoc 1980 va join vao "Text Classification"

SELECT FullName,Prj.[Title] FROM [Lecturers] Lec,[Projects] Prj,[Participation] Par 
	WHERE Lec.[Lid] = Par.[Lid] AND Prj.[Pid]=Par.[Pid] AND YEAR(DOB)<1980 AND Title LIKE '%Text Classification%'

-- voi moi giang vien in fullname va thoi luong

SELECT Lecturers.[LID], [FullName],
CASE 
    WHEN DURATION_SUM IS NULL THEN 0
    ELSE DURATION_SUM
END AS TIME
FROM (SELECT LID, SUM([Duration]) DURATION_SUM FROM Participation GROUP BY LID) AS lt
RIGHT JOIN Lecturers ON Lecturers.LID = lt.LID
-- cach 2
SELECT Lecturers.[LID], [FullName],
CASE 
    WHEN SUM(Duration) IS NULL THEN 0
    ELSE SUM(Duration)
END AS "SUM TIME"
FROM Lecturers LEFT JOIN Participation ON Lecturers.Lid = Participation.Lid
GROUP BY Lecturers.Lid, FullName


-- insert giang vien moi
INSERT INTO [Lecturers]([Lid],[FullName],[Address],[DOB])
VALUES	('GV06','Ngo Tuan Phong','Dong Da, Hanoi','08/09/1986')
	 		
-- update dia chi

UPDATE Lecturers
SET [Address] = 'Tay Ho, Hanoi'
WHERE [FullName] = 'Vu Tuyet Trinh'

-- xoa giang vien
DELETE FROM Participation WHERE Lid = 'GV02'
DELETE FROM Lecturers WHERE Lid = 'GV02'

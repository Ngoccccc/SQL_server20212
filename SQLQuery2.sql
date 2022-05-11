USE QLKH;

CREATE TABLE Lecturers(
LID char(4) NOT NULL,
FullName nchar(30) NOT NULL,
Address nvarchar(50) NOT NULL,
DOB date NOT NULL,
CONSTRAINT pkLecturers PRIMARY KEY (LID)
)
CREATE TABLE Projects(
PID char(4) NOT NULL,
Title nvarchar(50) NOT NULL,
Level nchar(12) NOT NULL,
Cost integer,
CONSTRAINT pkProjects PRIMARY KEY (PID )
)
CREATE TABLE Participation(
LID char(4) NOT NULL,
PID char(4) NOT NULL,
Duration smallint,
CONSTRAINT pkParticipation PRIMARY KEY (LID, PID),
CONSTRAINT fk1 FOREIGN KEY (LID) REFERENCES Lecturers (LID),CONSTRAINT fk2 FOREIGN KEY (PID) REFERENCES Projects (PID) )


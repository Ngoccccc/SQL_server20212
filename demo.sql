USE testDB
CREATE TABLE Persons(
	ID int NOT NULL PRIMARY KEY,
	LastName varchar(20) NOT NULL,
	FirstName varchar(20),
	Age int
);

INSERT INTO Persons VALUES (
	1 , 'Tran' , 'Ngoc', 20
)

SELECT *FROM Persons
ALTER TABLE Persons
add address1 varchar(20)
insert into Persons Values(
2,'Truong','dan',18,'yen bai')

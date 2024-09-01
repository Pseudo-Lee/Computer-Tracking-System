
DECLARE @SerialNumber VARCHAR(50);
DECLARE @ComputerName VARCHAR(50);
DECLARE @Description VARCHAR(200);


INSERT INTO Computer (Serial_no, Name, Description) 

VALUES (@SerialNumber, @ComputerName, @Description)

SELECT * FROM Computer
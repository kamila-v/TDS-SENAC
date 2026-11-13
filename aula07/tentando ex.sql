CREATE DATABASE EstacionamentoDB;
GO 

CREATE TABLE Veiculos 
(
	id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	placa VARCHAR(7) NOT NULL UNIQUE,
	vaga_id INT IDENTITY(1,1) NOT NULL,
	registro_id INT IDENTITY(1,1) NOT NULL
); 
GO

-- 2 CLIENTES
INSERT INTO Veiculos (placa, vaga_id, registro_id) VALUES
('th356d', '33', 'vaga33')


SELECT * FROM Veiculos
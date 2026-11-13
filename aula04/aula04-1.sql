CREATE DATABASE EstacionamentoDB;
GO

USE EstacionamentoDB;
GO


-- CRIAÇÃO DE TABELAS
CREATE TABLE Clientes 
(
    id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(14) NOT NULL UNIQUE,
    telefone VARCHAR(20)
); 
GO

CREATE TABLE Veiculos
(
    id INTEGER IDENTITY(1,1) NOT NULL PRIMARY KEY,
    cliente_id INTEGER NOT NULL,
    placa VARCHAR(100) NOT NULL UNIQUE,
    modelo VARCHAR(30) NOT NULL,
    cor VARCHAR(30),
    FOREIGN KEY (cliente_id) REFERENCES Clientes (id) ON DELETE CASCADE
);
GO

CREATE TABLE Vagas
(
    id  INTEGER IDENTITY(1,1) NOT NULL PRIMARY KEY,
    localizacao TEXT NOT NULL,
    tipo TEXT NOT NULL
);
GO

CREATE TABLE RegistrosEstacionamento
(
    id  INTEGER IDENTITY(1,1) NOT NULL PRIMARY KEY,
    veiculo_id INTEGER NOT NULL,
    vaga_id INTEGER NOT NULL,
    data_hora_entrada DATETIME NOT NULL,
    data_hora_saida DATETIME,
    valor_total DECIMAL(10,2),
    CONSTRAINT FK_RegEstacionamento_Veiculo FOREIGN KEY (veiculo_id) REFERENCES Veiculos (id),
    CONSTRAINT FK_RegEstacionamento_Vaga FOREIGN KEY (vaga_id) REFERENCES Vagas (id)
);
GO
/*
NO "EstacionamentoDB", CRIAR A ROLE "Role_OperadorPatio"
 
PERMITIR SELECT NA TABELA DE VAGAS
PERMITIR EXECUTE NAS PROCEDURES DE REGISTRAR ENTRADA E REGISTRAR SAÍDA DE VEÍCULO
BLOQUEAR OPERAÇÕES DROP, ALTER E DELTE NA TABELA "RegistroEstacionamento"
 
CRIAR A ROLE "RoleAuditor"
APENAS LEITURA (SELECT) EM TODAS AS TABELAS, SEM PERMISSÃO DE ESCRITA
*/

USE master;
GO

CREATE LOGIN login_estacionamento WITH PASSWORD = 'Senha@123', CHECK_POLICY = ON;
GO

USE EstacionamentoDB;
GO

CREATE USER usr_operador FOR LOGIN login_estacionamento;
GO

-- CRIAR UMA ROLE 
CREATE ROLE Role_OperadorPatio;
GO

CREATE ROLE RoleAuditor;
GO

-- MENOR PRIVILÉGIO, ROLE COMEÇA VAZIO, GARANTA O MINIMO
GRANT SELECT ON Vagas TO Role_OperadorPatio;

-- INSERIR PEDIDOS E ITENS 
GRANT SELECT ON Pedidos TO Role_Garcom;
GRANT SELECT ON Pedido_Itens TO Role_Garcom;


-- ADICIONAR O USUARIO GARÇOM AO PAPEL (ROLE)
ALTER ROLE Role_Garcom ADD MEMBER usr_garcom;
GO

DENY DELETE ON Saida TO Role_OperadorPatio;
DENY DELETE ON Pizzas TO Role_OperadorPatio;
GO

-- fiz mais doq devia eu acho...
-- prof fez bem mais simples, perdi a linha de raciocinio quando percebi que precisava "refazer" o bd 
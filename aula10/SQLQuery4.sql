USE master;
GO

-- CRIAR DOIS LOGINS
-- UM PARA "login_app_web"
CREATE LOGIN login_app_web WITH PASSWORD = 'Senha@123', CHECK_POLICY = ON;
GO

-- OUTRO PARA "login_garcom"
 CREATE LOGIN login_garcom WITH PASSWORD = 'Senha@123', CHECK_POLICY = ON;
GO

USE PizzariaDB;
GO
 
-- CRIAR OS USUARIOS
-- "usr_app_web" VINCULADO AO "login_app_web"
CREATE USER usr_app_web FOR LOGIN login_app_web;
GO

-- "usr_garcom" VINCULADO AO "login_garcom"
CREATE USER usr_garcom FOR LOGIN login_garcom;
GO

-- VERIFICAR USUÁRIOS HOJE CADASTRADOS NO BANCO
SELECT name, type_desc, create_date 
FROM sys.database_principals 
WHERE type	IN ('S', 'U');
GO

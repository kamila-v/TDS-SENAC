USE PizzariaDB;
GO

-- USUÁRIO DE INSTANCIA DE BANCO DE DADOS
CREATE USER usr_atendente FOR LOGIN login_atendente;
GO

-- VERIFICAR USUÁRIOS HOJE CADASTRADOS NO BANCO
SELECT name, type_desc, create_date 
FROM sys.database_principals 
WHERE type	IN ('S', 'U');
GO
use master 
DROP DATABASE IF  exists HandsOn
GO
CREATE  DATABASE HandsOn
GO
--mostra o informacoes de arquivo de log e dados do banco espeficado
exec sp_helpdb 'HandsOn'
--altera via comando o tamnho do arquivo para 100 mb, so permite aumentar e nao diminuir
ALTER DATABASE HandsOn MODIFY FILE (NAME=  N'HandsOn', SIZE=100MB)
-- cria um novo arquivo de dado/log, é uma possibildiade de  aumentar
ALTER DATABASE HandsOn ADD FILE (NAME=N'HandsOn_FILE3',FILENAME='C:\MSSQL_Data\HandsOn_FILE3.ndf',SIZE=100MB,FILEGROWTH=50MB)

USE MASTER 
GO 
ALTER DATABASE HandsOn SET READ_ONLY WITH ROLLBACK IMMEDIATE 
GO
DROP DATABASE IF exists HandsOn
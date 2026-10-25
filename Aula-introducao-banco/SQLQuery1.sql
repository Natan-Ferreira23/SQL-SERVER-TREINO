
/*
 ao criar um banco de dados é possivel definir informações sobre os arquivos de dados
 MDF = arquivo de dados
 LDF = arquivo de log
 1- É possível limitar o tamanho, definir um tamanho inicial, tamanho de crescimento, qual o caminho do arquivo
 2- É possivel definir um filegroup para cada arquivo
 3- uma tabela pode ter mais de um arquivo de dados sendo o principal MDF e os secundariso caso houver NDF
 4- caso nao seja especifica as propriedades ao banco, utilizando somente 'create database' será usado as informações padrões da model
*/
CREATE DATABASE [OlaMundo]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'OlaMundo', FILENAME = N'C:\MSSQL_Data\OlaMundo.mdf' , SIZE = 102400KB , FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'OlaMundo_log', FILENAME = N'C:\MSSQL_Data\OlaMundo_log.ldf' , SIZE = 51200KB , MAXSIZE = 2048000KB , FILEGROWTH = 65536KB )
 WITH LEDGER = OFF
 GO

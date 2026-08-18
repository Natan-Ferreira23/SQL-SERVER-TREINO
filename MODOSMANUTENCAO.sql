use master
go 
--COLOCAR ONLINE E ENCERRAR OPERACOES OCORRENDO NO MOMENTO
alter database treino_eng_dados SET OFFLINE WITH ROLLBACK IMMEDIATE;

ALTER DATABASE treino_eng_dados SET ONLINE;

--db modo unico user
ALTER DATABASE treino_eng_dados SET SINGLE_USER WITH ROLLBACK IMMEDIATE;

--DB MODO LEITURA
ALTER DATABASE treino_eng_dados SET READ_ONLY;

--DB MODO MULTIUSUAIRO
ALTER DATABASE treino_eng_dados SET MULTI_USER ;

--bd leitura e gravacao 
ALTER DATABASE treino_eng_dados SET READ_WRITE;
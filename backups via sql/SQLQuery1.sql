USE treino_eng_dados
select * from clientes

insert into clientes values (10,'jurandir DA SILVA','Londrina');
delete from clientes where id_cliente=9

RESTORE DATABASE treino_eng_dados WITH RECOVERY

---Backup via comando
BACKUP DATABASE treino_eng_dados
TO DISK = 'C:\SQL\treino_eng_dados_bkpfull01.bak'
WITH  STATS

--com compressao
BACKUP DATABASE treino_eng_dados
TO DISK = 'C:\SQL\treino_eng_dados_bkpfull02.bak'
WITH Compression, STATS

USE MASTER
DROP DATABASE treino_eng_dados

--RESTORE DATABASE VIA COMANDO
RESTORE DATABASE treino_eng_dados
FROM DISK = 'C:\SQL\treino_eng_dados_bkpfull01.bak'
WITH  STATS, RECOVERY


--RESTORE DATABASE VIA COMANDO compress
RESTORE DATABASE treino_eng_dados
FROM DISK = 'C:\SQL\treino_eng_dados_bkpfull02.bak'
WITH  STATS, NORECOVERY --NORECOVERY PARA NAO DEIXAR DISPONIVEL APOS O RESTORE

-- DEIXANDO BANCO EM RESTAURANDO (NORECOVERY) ATIVO
RESTORE DATABASE treino_eng_dados WITH RECOVERY


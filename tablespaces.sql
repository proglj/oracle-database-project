CREATE TABLESPACE dados_clientes
DATAFILE '/u01/app/oracle/oradata/dados_cli_01.dbf'
SIZE 100M
AUTOEXTEND ON NEXT 50M
MAXSIZE 500M;

CREATE TABLESPACE indices_clientes
DATAFILE '/u01/app/oracle/oradata/ind_cli_01.dbf'
SIZE 50M
AUTOEXTEND ON NEXT 25M
MAXSIZE 250M;

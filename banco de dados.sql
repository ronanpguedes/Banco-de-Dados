create database bd1;
use bd1;
/*----------------------------------INSERT INTO banco---------------------------------*/
INSERT INTO bd1.banco (Codigo, nome)
VALUES ('1','Banco do brasil');
INSERT INTO bd1.banco (Codigo, nome)
VALUES ('4','CEF');
INSERT INTO bd1.banco (Codigo, nome)
VALUES ('2','Bradesco');
select * from banco, agencia;
select * from banco, agencia where cod_banco = codigo and numero_agencia = 6342;
select * from agencia join banco on cod_banco = codigo where numero_agencia = 6342;
/*----------------------------------------banco-------------------------------------*/
create table banco (
codigo int not null auto_increment primary key,
nome varchar(45)
);
/*-------------------INSERT INTO agencia--------------------------------------*/
drop table agencia;
INSERT INTO bd1.agencia (cod_banco, numero_agencia,endereco)
VALUES ('4','0562','Rua Joaquim Teixeira alves, 1555');
INSERT INTO bd1.agencia (cod_banco, numero_agencia,endereco)
VALUES ('1','3153','Rua Marcelino pires, 1960');

UPDATE agencia
SET numero_agencia = 6342
WHERE numero_agencia = 562 ;
select * from agencia;
drop table agencia;
alter table agencia drop constraint fk_agencia_banco;
alter table conta drop constraint fk_conta_agencia;
ALTER TABLE bd1.agencia ADD FOREIGN KEY fk_agencia_banco(cod_banco) REFERENCES banco(codigo) ON UPDATE CASCADE ;
DELETE FROM bd1.agencia WHERE agencia_ibfk_5;
select * from agencia;
INSERT INTO bd1.agencia (cod_banco, numero_agencia,endereco )
VALUES ('1','1333','Rua Joao Jose da Silva , 486');
select codigo,nome from banco where nome = 'Banco do brasil' or nome = 'Bradesco';
select * from banco;
select numero_agencia, endereco from agencia where cod_banco = (select codigo from banco where nome = 'Banco do brasil');

/*--------------------------------agencia---------------------------------------*/
create table agencia (
cod_banco int not null,
numero_agencia int not null,
endereco varchar(45),
PRIMARY KEY( numero_agencia,cod_banco),
FOREIGN KEY fk_agencia_banco(cod_banco) REFERENCES banco(codigo) ON UPDATE CASCADE
);
/*--------------------------------INSERT INTO cliente-----------------------------*/
drop table cliente;
ALTER TABLE bd1.cliente ADD email varchar(45);
INSERT INTO bd1.cliente (CPF, nome, sexo, endereco, email)
VALUES ('111.222.333-44', 'Jennifer B Souza', 'F','Rua: Cuiaba, 1050', 'jennifer@mail.com' );
INSERT INTO bd1.cliente (CPF, nome, sexo, endereco, email)
VALUES ('666.777.888-99', 'Caetano K Lima', 'M','Rua: Ivinhema, 879', 'Caetano@mail.com' );
INSERT INTO bd1.cliente (CPF, nome, sexo, endereco, email)
VALUES ('555.444.777-33', 'Silvia Macedo', 'F','Rua: Estados unidos, 735', 'Silvia@mail.com' );
SELECT * FROM cliente;
SELECT CPF, nome FROM cliente where nome like '%c%';
alter table cliente add column email varchar(45);
update bd1.cliente set email='caetanolima@gmail.com' where nome = 'Caetano K Lima';
/*------------------------------cliente---------------------------------*/
create table cliente(
CPF varchar(45) not null  primary key,
nome varchar(45),
sexo varchar(1),
endereco varchar(45)
);
/*------------------------------INSERT INTO conta ---------------------------------*/
INSERT INTO bd1.conta (numero_conta, saldo,tipo_conta,num_agencia)
VALUES ('86340-2','763.05','2','3153');
INSERT INTO bd1.conta (numero_conta, saldo,tipo_conta,num_agencia)
VALUES ('23584-7','3879.12','1','0562');
drop table bd1.conta;
ALTER TABLE bd1.conta
DROP COLUMN saida;
ALTER TABLE bd1.conta ADD saldo float;
ALTER TABLE bd1.conta ADD FOREIGN KEY fk_conta_agencia(num_agencia) REFERENCES agencia(numero_agencia) ON UPDATE CASCADE;
select * from conta;
update conta set saldo = saldo * 1.1 where  numero_conta = '23584-7' ;
/*--------------------------------conta---------------------------*/
create table conta(
numero_conta varchar(45) not null primary key,
saldo float,
tipo_conta int,
num_agencia int,
FOREIGN KEY fk_conta_agencia(num_agencia) REFERENCES agencia(numero_agencia)
);
/*----------------------------INSERT INTO historico------------------------------*/
INSERT INTO bd1.historico (CPF_cliente, num_conta,data_inicio)
VALUES ('111.222.333-44','23584-7','1997-12-17');
INSERT INTO bd1.historico (CPF_cliente, num_conta,data_inicio)
VALUES ('666.777.888-99','23584-7','1997-12-17');
INSERT INTO bd1.historico (CPF_cliente, num_conta,data_inicio)
VALUES ('555.444.777-33','86340-2','2010-11-29');
/*------------------------historico----------------------------*/
create table historico(
CPF_cliente varchar(45) not null,
num_conta varchar (45)not null,
PRIMARY KEY( CPF_cliente,num_conta),
data_inicio date,
FOREIGN KEY fk_historico_clieCPFnte(CPF_cliente) REFERENCES cliente(CPF),
FOREIGN KEY fk_historico_conta(num_conta) REFERENCES conta(numero_conta)
);
/*------------------------------INSERT INTO telefone_cliente -----------------------------*/
INSERT INTO bd1.telefone_cliente (CPF_cli, telfone_cli)
VALUES ('111.222.333-44','(67)3422-7788');
INSERT INTO bd1.telefone_cliente (CPF_cli, telfone_cli)
VALUES ('666.777.888-99','(67)3422-9900');
INSERT INTO bd1.telefone_cliente (CPF_cli, telfone_cli)
VALUES ('666.777.888-99','(67)8121-8833');
/*-----------------------------telefone_cliente------------------------------*/
create table telefone_cliente(
CPF_cli varchar(45)not null,
telfone_cli varchar(45)not null,
PRIMARY KEY( CPF_cli,telfone_cli),
FOREIGN KEY fk_telefone_cliente(CPF_cli) REFERENCES cliente(CPF)
);

/*-----------------------------BDEmpresa------------------------------*/
create database if not exists BDEmpresa;
use BDEmpresa;
/*-----------------------------Departamento------------------------------*/
CREATE TABLE Departamento (
    ID_Depto    NUMERIC(2)    NOT NULL,
    NomeDepto   VARCHAR(30)   NOT NULL,
    ID_Gerente  NUMERIC(4)      NOT NULL,
    CONSTRAINT pk_depto PRIMARY KEY (ID_Depto),
    CONSTRAINT uk_nome UNIQUE (NomeDepto)
);
/*-----------------------------Funcionario------------------------------*/
CREATE TABLE Funcionario (
    ID_Func     NUMERIC(4)     NOT NULL,
    NomeFunc    VARCHAR(30)  NOT NULL,
    Endereco    VARCHAR(50)  NOT NULL,
    DataNasc    DATE          NOT NULL,
    Sexo        CHAR(1)       NOT NULL,
    Salario     NUMERIC(8,2)   NOT NULL,
    ID_Superv   NUMERIC(4)         NULL,
    ID_Depto    NUMERIC(2)     NOT NULL,
    CONSTRAINT pk_func PRIMARY KEY (ID_Func),
    CONSTRAINT ck_sexo CHECK (Sexo='M' or Sexo='F')
);
/*-----------------------------Projeto------------------------------*/
CREATE TABLE Projeto (
    ID_Proj       NUMERIC(4)     NOT NULL,
    NomeProj      VARCHAR(30)  NOT NULL,
    Localizacao   VARCHAR(30)      NULL,
    ID_Depto      NUMERIC(2)     NOT NULL,
    CONSTRAINT pk_proj PRIMARY KEY (ID_Proj),
    CONSTRAINT uk_nomeProj UNIQUE (NomeProj)
);
/*-----------------------------Dependente------------------------------*/
CREATE TABLE Dependente (
    ID_Dep       NUMERIC(6)     NOT NULL,
    ID_Func      NUMERIC(4)     NOT NULL,
    NomeDep      VARCHAR(30)  NOT NULL,
    DataNasc     DATE          NOT NULL,
    Sexo         CHAR(1)       NOT NULL,
    Parentesco   CHAR(15)          NULL,
    CONSTRAINT pk_depend PRIMARY KEY (ID_Dep, ID_Func),
    CONSTRAINT ck_sexo_dep CHECK (Sexo='M' or Sexo='F')
);
/*-----------------------------Trabalha------------------------------*/
CREATE TABLE Trabalha (
    ID_Func    NUMERIC(4)     NOT NULL,
    ID_Proj    NUMERIC(4)     NOT NULL,
    NumHoras   NUMERIC(6,1)       NULL,
    CONSTRAINT pk_trab PRIMARY KEY (ID_Func,ID_Proj)
);
/*---------------------------INSERT INTO--------------------------------*/
INSERT INTO Funcionario
VALUES (1,'Joao Silva','R. Guaicui, 175', str_to_date('01/02/1955',"%d/%m/%Y"),'M',500,2,1);
INSERT INTO Funcionario
VALUES (2,'Frank Santos','R. Gentios, 22',str_to_date('02/02/1966',"%d/%m/%Y"),'M',1000,8,1);
INSERT INTO Funcionario
VALUES (3,'Alice Pereira','R. Curitiba, 11',str_to_date('15/05/1970',"%d/%m/%Y"),'F',700,4,3);
INSERT INTO Funcionario
VALUES (4,'Junia Mendes','R. Espirito Santos, 123',str_to_date('06/07/1976',"%d/%m/%Y"),'F',1200,8,3);
INSERT INTO Funcionario
VALUES (5,'Jose Tavares','R. Irai, 153',str_to_date('07/10/1975',"%d/%m/%Y"),'M',1500,2,1);
INSERT INTO Funcionario
VALUES (6,'Luciana Santos','R. Irai, 175',str_to_date('07/10/1960',"%d/%m/%Y"),'F',600,2,1);
INSERT INTO Funcionario
VALUES (7,'Maria Ramos','R. C. Linhares, 10',str_to_date('01/11/1965',"%d/%m/%Y"),'F',1000,4,3);
INSERT INTO Funcionario
VALUES (8,'Jaime Mendes','R. Bahia, 111',str_to_date('25/11/1960',"%d/%m/%Y"),'M',2000,NULL,2);
/*----------------------------INSERT INTO-------------------------------*/
INSERT INTO Departamento
VALUES (1,'Pesquisa',2);
INSERT INTO Departamento
VALUES (2,'Administracao',8);
INSERT INTO Departamento
VALUES (3,'Construcao',4);
/*-------------------------INSERT INTO----------------------------------*/
INSERT INTO Dependente
VALUES (1,2,'Luciana',str_to_date('05/11/1990',"%d/%m/%Y"),'F','Filha');
INSERT INTO Dependente
VALUES (2,2,'Paulo',str_to_date('11/11/1992',"%d/%m/%Y"),'M','Filho');
INSERT INTO Dependente
VALUES (3,2,'Sandra',str_to_date('05/12/1996',"%d/%m/%Y"),'F','Filha');
INSERT INTO Dependente
VALUES (4,4,'Mike',str_to_date('05/11/1997',"%d/%m/%Y"),'M','Filho');
INSERT INTO Dependente
VALUES (5,1,'Max',str_to_date('11/05/1979',"%d/%m/%Y"),'M','Filho');
INSERT INTO Dependente
VALUES (6,1,'Rita',str_to_date('07/11/1985',"%d/%m/%Y"),'F','Filha');
INSERT INTO Dependente
VALUES (7,1,'Bety',str_to_date('15/12/1960',"%d/%m/%Y"),'F','Esposa');
/*---------------------------INSERT INTO--------------------------------*/
INSERT INTO Projeto
VALUES (1,'ProdX','Savassi',1);
INSERT INTO Projeto
VALUES (2,'ProdY','Luxemburgo',1);
INSERT INTO Projeto
VALUES (3,'ProdZ','Centro',1);
INSERT INTO Projeto
VALUES (10,'Computacao','C. Nova',3);
INSERT INTO Projeto
VALUES (20,'Organizacao','Luxemburgo',2);
INSERT INTO Projeto
VALUES (30,'N. Beneficios','C. Nova',1);
/*----------------------------INSERT INTO-------------------------------*/
INSERT INTO Trabalha
VALUES (1,1,32.5);
INSERT INTO Trabalha
VALUES (1,2,7.5);
INSERT INTO Trabalha
VALUES (5,3,40.0);
INSERT INTO Trabalha
VALUES (6,1,20.0);
INSERT INTO Trabalha
VALUES (6,2,20.0);
INSERT INTO Trabalha
VALUES (2,2,10.0);
INSERT INTO Trabalha
VALUES (2,3,10.0);
INSERT INTO Trabalha
VALUES (2,10,10.0);
INSERT INTO Trabalha
VALUES (2,20,10.0);
INSERT INTO Trabalha
VALUES (3,30,30.0);
INSERT INTO Trabalha
VALUES (3,10,10.0);
INSERT INTO Trabalha
VALUES (7,10,35.0);
INSERT INTO Trabalha
VALUES (7,30,5.0);
INSERT INTO Trabalha
VALUES (4,20,15.0);
INSERT INTO Trabalha
VALUES (8,20,NULL);
/*-----------------------------FOREIGN KEY------------------------------*/
ALTER TABLE Funcionario
ADD CONSTRAINT fk_func_depto FOREIGN KEY (ID_Depto) REFERENCES Departamento (ID_Depto);

ALTER TABLE Funcionario
ADD CONSTRAINT fk_func_superv FOREIGN KEY (ID_Superv) REFERENCES Funcionario (ID_Func);

ALTER TABLE Departamento
ADD CONSTRAINT fk_depto_func FOREIGN KEY (ID_Gerente) REFERENCES Funcionario (ID_Func);

ALTER TABLE Projeto
ADD CONSTRAINT fk_proj_depto FOREIGN KEY (ID_Depto) REFERENCES Departamento (ID_Depto);

ALTER TABLE Dependente
ADD CONSTRAINT fk_dep_func FOREIGN KEY (ID_Func) REFERENCES Funcionario (ID_Func) ON DELETE CASCADE;

ALTER TABLE Trabalha
ADD CONSTRAINT fk_trab_func FOREIGN KEY (ID_Func) REFERENCES Funcionario (ID_Func) ON DELETE CASCADE;

ALTER TABLE Trabalha
ADD CONSTRAINT fk_trab_proj FOREIGN KEY (ID_Proj) REFERENCES Projeto (ID_Proj) ON DELETE CASCADE;
/*-----------------------------------------------------------*/
/*1. Liste o nome e a data de nascimento do empregado 'Joao Silva'. Mostre no formato brasileiro com
dois digitos no ano. (pesquise a função date_format)*/
select NomeFunc, DATE_FORMAT(DataNasc,'%d/%m/%y') as data from funcionario where NomeFunc = 'Joao Silva';
SELECT  DATE_FORMAT(DataNasc,'%d/%m/%y') as data from dependente ;

/*2. Liste o nome e o endereço de todos os empregados que pertencem ao departamento 'Pesquisa'.*/
select NomeFunc,Endereco from funcionario 
inner join departamento on funcionario.ID_Depto = departamento.ID_Depto 
where departamento.NomeDepto = 'Pesquisa' ;
select * from departamento;
/*3. Para cada projeto localizado no 'Luxemburgo', liste o numero do projeto, o número do departamento
que o controla e o nome, endereço e data de aniversário do gerente do departamento.*/
select * from projeto;
select projeto.ID_Proj, departamento.ID_Depto ,funcionario.NomeFunc, funcionario.Endereco, funcionario.DataNasc from 
((projeto inner join departamento on projeto.ID_Depto= departamento.ID_Depto) inner join funcionario on departamento.ID_Gerente= funcionario.ID_Func )
 where projeto.Localizacao ='Luxemburgo';
/*4. Para cada empregado, recupere o seu nome e o nome de seu supervisor.*/
SELECT f1.ID_Func, f1.NomeFunc AS NomeFuncionario, f2.NomeFunc, f2.ID_Superv AS NomeSupervisor
FROM funcionario AS f1
LEFT JOIN funcionario AS f2 ON f1.ID_Superv = f2.ID_Func;
/*5. Selecione os empregados do departamento de número 1.*/
select * from funcionario 
inner join departamento on funcionario.ID_Depto = departamento.ID_Depto 
where departamento.ID_Depto = 1;
/*6. Liste o salário de todos os empregados, de tal forma que não apareçam salários iguais.*/
SELECT DISTINCT NomeFunc, Salario  FROM funcionario where salario = salario;
SELECT f1.NomeFunc, f1.Salario FROM funcionario AS f1 
INNER JOIN funcionario AS f2 ON f1.ID_Depto = f2.ID_Depto
 WHERE f1.Salario > f2.Salario;
/*7. Liste todos os dados dos empregados que moram na 'Irai'.*/
SELECT * FROM funcionario WHERE Endereco LIKE '%Irai%';
/*8. Liste o número de todos os projetos que possuem empregados com sobrenome 'Santos', como
trabalhador ou como gerente do departamento que controla os projetos.*/
select p.ID_Proj,f.NomeFunc from projeto p
join Trabalha t on t.ID_Proj = p.ID_Proj
join funcionario f on f.ID_Func = t.ID_Func
 where f.NomeFunc like '%Santos%' ;
 -- union all unir duas tabelas deixando repetir todos os id
/*9. Mostre o resultado do aumento de 20% sobre o salário dos empregados que trabalham no projeto de
nome 'ProdX'.*/
select p.ID_Proj,f.NomeFunc, f.Salario from projeto p
join Trabalha t on t.ID_Proj = p.ID_Proj
join funcionario f on f.ID_Func = t.ID_Func
 where p.NomeProj like '%ProdX%';
/*10. Liste o nome dos empregados do departamento 3 que possuem salário entre R$800,00 e
R$1.200,00.*/
select NomeFunc, Salario from funcionario f where f.ID_Depto = 3 and salario between 800 and 1200;

/*1. Liste o nome dos empregados, o nome dos seus departamentos e o nome dos
projetos em que eles trabalham, ordenados pelo departamento e pelo nome do
projeto. */
select NomeFunc, NomeDepto, NomeProj from funcionario 
inner join departamento on funcionario.ID_Depto = departamento.ID_Depto
inner join trabalha on funcionario.ID_Func = trabalha.ID_Func
inner join projeto on trabalha.ID_Proj = projeto.ID_Proj
order by departamento.NomeDepto , projeto.NomeProj;


select NomeFunc,NomeProj,NomeDepto from funcionario, projeto, departamento;
select f.NomeFunc,d.NomeDepto,p.NomeProj from funcionario f
 join trabalha t  on f.ID_Func = t.ID_Func
 join projeto p  on t.ID_Proj = p.ID_Proj
 join departamento d  on d.ID_Depto = f.ID_Depto;
/*2. Liste o nome dos empregados que trabalham em algum dos projetos em que o 'Joao
Silva' trabalha.*/
select distinct(f.NomeFunc)
from Funcionario f
join Trabalha t on f.ID_Func = t.ID_Func
join Projeto p on t.ID_Proj = p.ID_Proj
where p.ID_Proj in (select ID_Proj from Funcionario f
join Trabalha t on t.ID_Func = f.ID_Func
where f.NomeFunc = "Joao Silva");
/*3. Liste o nome dos empregados que não possuem supervisores.*/
select NomeFunc from funcionario where ID_Superv is null;
select supervisionado.NomeFunc as empregado
from Funcionario as supervisionado
left join Funcionario as supervisor on supervisionado.id_superv = supervisor.id_func
where supervisor.ID_Func is null;
/*4. Liste o nome dos empregados que possuem mais que 2 dependentes, juntamente
com os nomes dos seus dependentes.*/
select f.NomeFunc, d.NomeDep from Funcionario f
join Dependente d on d.ID_Func=f.ID_Func
where f.ID_Func in (select f.ID_Func
from Funcionario f
join Dependente d on f.ID_Func= d.ID_Func
group by f.ID_Func
having count(d.ID_Dep) > 2);
/*5. Liste a soma, a média, o maior e o menor salário de todos os empregados.*/
select sum(salario),avg(salario),max(salario),min(salario) from funcionario;
/*6. Liste a soma, a média, o maior e o menor salário dos empregados do departamento
'Pesquisa'.*/
select sum(salario),avg(salario),max(salario),min(salario) from funcionario 
inner join departamento on funcionario.ID_Depto = departamento.ID_Depto where departamento.NomeDepto = 'Pesquisa';
/*7. Liste o nome de cada supervisor com a quantidade de supervisionados.*/
select  DISTINCT supervisor, count(supervisor)  as qtd from funcionario
left join (select NomeFunc as supervisor , ID_Func from funcionario ) as f1 on funcionario.ID_Superv=f1.ID_Func GROUP BY supervisor ;
/*8. Liste o nome de cada projeto com o número de empregados que trabalham no projeto.*/
select  projeto.NomeProj, count(projeto.NomeProj) as numeroFuncionarios from projeto
join trabalha on projeto.ID_Proj = trabalha.ID_Proj group by projeto.NomeProj ;
/*9. Para cada projeto que possua mais de 2 empregados na equipe, liste o nome do
projeto e a quantidade de empregados que trabalham no mesmo.*/
select  projeto.NomeProj, count(projeto.NomeProj) as numeroFuncionarios from projeto
join funcionario on projeto.ID_Depto = funcionario.ID_Depto 
join trabalha on projeto.ID_Proj = trabalha.ID_Proj group by projeto.NomeProj;

select distinct projeto.NomeProj, equipe from trabalha
inner join projeto on projeto.ID_Proj = trabalha.ID_Proj
inner join (select ID_Proj, count(trabalha.ID_Proj) as equipe from trabalha group by trabalha.ID_Proj) as t
on trabalha.ID_Proj = t.ID_Proj where equipe >2;

/*10.Para cada departamento que possua mais do que 2 empregados, liste o nome do
departamento e o nome dos empregados que ganham mais do que 800,00.*/

select distinct departamento.NomeDepto, funcionario.NomeFunc, funcionario.Salario from departamento , funcionario
inner join trabalha on trabalha.ID_Func = funcionario.ID_Func where funcionario.Salario > 800;

/*11. Liste o nome dos funcionários que não tem dependentes.*/
select NomeFunc from funcionario left join dependente on funcionario.ID_Func = dependente.ID_Func where dependente.ID_Func is null;
/*12.Liste o nome e localização dos projetos que não tem funcionários trabalhando neles.*/
select distinct NomeProj, Localizacao from projeto 
 join trabalha on trabalha.ID_Proj = projeto.ID_Proj where trabalha.NumHoras is null ;
/*13.Liste o nome dos funcionários que não tem dependentes e não estejam trabalhando
em nenhum projeto.*/ 
SELECT NomeFunc AS nome, T.ID_Proj AS projeto FROM funcionario f LEFT JOIN trabalha t ON f.ID_Func = t.ID_Func
WHERE t.ID_Proj IS NULL AND NomeFunc IN (SELECT NomeFunc AS nf FROM funcionario
LEFT JOIN dependente ON funcionario.ID_Func = dependente.ID_Func WHERE NomeDep IS NULL);
INSERT INTO Funcionario
VALUES (15,'Jubilieu','R. para, 478', str_to_date('01/02/1955',"%d/%m/%Y"),'M',500,2,1);
select NomeFunc, NomeDep as nf from funcionario left join dependente on funcionario.ID_Func = dependente.ID_Func where NomeDep is null;
/*14.Calcule a idade de cada funcionário.*/
select NomeFunc, year(from_days(to_days(now())-to_days(DataNasc))) as idade from funcionario;
select * from funcionario;



# Desafio - Projeto de Banco de Dados utilizando MySQL.

* **Concluí o Desafio que consiste na modelagem de um banco de dados utilizando MySQL, criei o cenário de uma empresa que trabalha com aulas de cursos técnicos, script sql para criação do schema, persistência e realização de testes utilizando queries para responder determinadas perguntas.** 
* **Resolvi realizar o projeto utilizando Python**
* **Ao navegar pelo índice, é possível visualizar todo o passo-à-passo realizado durante a elaboração do projeto.**
* **Todos os scripts SQL estão disponibilizados neste repositório na pasta 'Projeto_BD_script', para um eventual estudo ou replicação, vale ressaltar que intuito do conteúdo é apenas didático, com o propósito de demonstrar todo o conhecimento adquirido durante o aprendizado, ou seja, o conteúdo aqui disponibilizado apesar de similar, não abrange um banco de dados para um cenário real.**


<a name="ancora"></a>
# Índice
    
* [Mapeamento do Diagrama ER](#ancora2)

* [Script SQL para criação do esquema do banco de dados](#ancora3)
    * [CREATE SCHEMA](#ancora3.1)
    * [CREATE TABLE Aluno](#ancora3.2)
    * [CREATE TABLE Curso](#ancora3.3)
    * [CREATE TABLE Professor](#ancora3.4)
    * [CREATE TABLE Materia](#ancora3.5)
    * [CREATE TABLE Turma](#ancora3.6)
    * [CREATE TABLE Atividade](#ancora3.7)
    * [CREATE TABLE Materia_Turma](#ancora3.8)
   
        
* [Script SQL para Persistir Registros no BD.](#ancora4)
    * [INSERT INTO Aluno](#ancora4.2)
    * [INSERT INTO Curso](#ancora4.3)
    * [INSERT INTO Professor](#ancora4.4)
    * [INSERT INTO Materia](#ancora4.5)
    * [INSERT INTO Turma](#ancora4.6)
    * [INSERT INTO Atividade](#ancora4.7)
    * [INSERT INTO Materia_Turma](#ancora4.8)
    
    
* [Script SQL para consultas(Queries)](#ancora5)
    * [1-Relação entre matérias, turmas, cursos:](#ancora5.3)
    * [2-Quais professores de cada matéria:](#ancora5.4)
    * [3-Quais alunos estão em cada curso:](#ancora5.5)    


## Mapeamento do Diagrama ER.
<a id="ancora2"></a>
[voltar](#ancora)

![diagrama_projeto_BD]([https://github.com/AgataAraujo-dev/projeto_BD_MySQL/blob/6d6de76c445b49ee8e297545d8c4e5b6e080faa3/diagrama_projeto_BD.png])


## Script SQL para criação do esquema do banco de dados.
<a id="ancora3"></a>

### CREATE SCHEMA:
<a id="ancora3.1"></a>
[voltar](#ancora)


```python
'''CREATE SCHEMA IF NOT EXISTS `curso_tecnico`;
USE `curso_tecnico` ;'''
```

### CREATE TABLE Aluno
<a id="ancora3.2"></a>
[voltar](#ancora)


```python
create table Aluno(
		idAluno int primary key auto_increment,
        Nome varchar(15) NOT NULL,
        iniciais_meio varchar(3),
        Sobrenome varchar(20) NOT NULL,
        Data_Nascimento date NOT NULL,
        Email varchar(30),
        CPF char(11) NOT NULL,
        Contato char(11) NOT NULL,
        Data_matricula date NOT NULL,
        constraint unique_aluno_cpf	unique(CPF)
);

alter table Aluno auto_increment=1;
```

### CREATE TABLE Curso
<a id="ancora3.3"></a>
[voltar](#ancora)


```python
create table Curso(
		idCurso int primary key auto_increment,
        Nome varchar(35) NOT NULL,
        Descrição varchar(100)
);

alter table Curso auto_increment=1;
```

### CREATE TABLE Professor
<a id="ancora3.4"></a>
[voltar](#ancora)


```python
create table Professor(
		idProfessor int primary key auto_increment,
        Nome varchar(15) NOT NULL,
        Sobrenome varchar(30) NOT NULL,
        Data_Nascimento date NOT NULL,
        Contato char(11) NOT NULL,
        Formação enum('Mestrado', 'Doutorado', 'Graduado') default 'Graduado'
);

alter table Professor auto_increment=1;
```

### CREATE TABLE Materia
<a id="ancora3.5"></a>
[voltar](#ancora)


```python
create table Materia(
		idMateria int primary key auto_increment,
        Nome varchar(20) NOT NULL,
        fk_idProfessor int NOT NULL,
        fk_idCurso int NOT NULL,
        constraint fk_materia_idProfessor foreign key (fk_idProfessor) references Professor(idProfessor),
        constraint fk_materia_idCurso foreign key (fk_idCurso) references Curso(idCurso)
);

alter table Materia auto_increment=1;
```

### CREATE TABLE Turma
<a id="ancora3.6"></a>
[voltar](#ancora)


```python
create table Turma(
		idTurma varchar(15) primary key NOT NULL,
        fk_idCurso int NOT NULL,
        fk_idAluno int NOT NULL,
        fk_idProfessorResponsavel int NOT NULL,
        fk_materias int NOT NULL,
        Turno enum('Manhã','Tarde','Noite') NOT NULL,
        constraint fk_turma_idCurso foreign key (fk_idCurso) references Curso(idCurso),
        constraint fk_turma_idAluno foreign key (fk_idAluno) references Aluno(idAluno),
        constraint fk_turma_idProfessorResponsavel foreign key (fk_idProfessorResponsavel) references Professor(idProfessor),
        constraint fk_curso_matérias foreign key (fk_materias) references Materia(idMateria)
);
```

### CREATE TABLE Atividade
<a id="ancora3.7"></a>
[voltar](#ancora)


```python
create table Atividade(
		idAtividade int primary key auto_increment,
        fk_idCurso int NOT NULL,
        fk_idMateria int NOT NULL,
        fk_idProfessor int NOT NULL,
        QtdQuestoes int NOT NULL,
        Prazo date NOT NULL,
        Nota float NOT NULL,
        Descrição varchar(100),
        constraint fk_atividade_idCurso foreign key (fk_idCurso) references Curso(idCurso),
        constraint fk_atividade_idMateria foreign key (fk_idMateria) references Materia(idMateria),
        constraint fk_atividade_idProfessor foreign key (fk_idProfessor) references Professor(idProfessor)
);

alter table Atividade auto_increment=1;
```

### CREATE TABLE Materia_Turma
<a id="ancora3.8"></a>
[voltar](#ancora)


```python
create table Materia_Turma(
		fk_materia int NOT NULL,
        fk_Turma varchar(15) NOT NULL,
        constraint fk_materiaT_materia foreign key (fk_materia) references materia(idmateria),
        constraint fk_materiaT_turma foreign key (fk_turma) references turma(idTurma)
);
```


## Script SQL para Persistir Registros no BD.

### INSERT INTO Aluno
<a id="ancora4"></a>
[voltar](#ancora)

```python
insert into Aluno(Nome, iniciais_meio, Sobrenome, Data_Nascimento, Email, CPF, Contato, Data_matricula) values
			('Arthur','H Z','Cabrita','1998-10-10','arthurzinho@gmail,.com',15623549876,21965432015,'2020-05-19'),
            ('Clara','Z','de Lima','2000-05-25','clarinha@gmail.com',51032698702,21965023145,'2020-05-12'),
            ('Kalel','A','Cabrita','2003-01-03','kalel@gmail.com',95463201256,21965432056,'2020-05-16'),
            ('Maria','N','Loudes','1997-03-26','maria@gmail.com',65012365412,21965420103,'2020-04-09'),
            ('Leila','A','Costa','1999-03-21','leila@gmail.com',95401236541,21965423100,'2020-04-19'),
            ('Gabriela','D','Barbosa','1999-06-29','gabriela@gmail.com',01236512365,21985410210,'2020-04-26'),
            ('Ana','D','Ferreira','1998-03-21','ana@gmail.com',65213021564,21985102316,'2020-05-03'),
            ('Luana','F','Moreira','1999-05-26','luana@gmail.com',65320120123,21965400231,'2020-05-14'),
            ('Juliano','H','Souza','2001-03-12','juliano@gmail.com',32102654102,2195402366,'2020-04-23'),
            ('Felipe','D','Moura','2002-05-12','felipe@gmail.com',3210215600,2195632104,'2020-05-01');
```

### INSERT INTO Curso
<a id="ancora4.3"></a>
[voltar](#ancora)


```python
insert into Curso(Nome, Descrição) values
			('Elétrica','Noções para resolver atividades da função eletricista'),
            ('Economia','Noções para resolver atividades da função economista e/ou contador'),
            ('Programador','Noções para resolver atividades da função programador web'),
            ('Administração','Noções para resolver atividades da função auxiliar adminitrativo'),
            ('Recursos Humanos','Noções para resolver atividades da função auxiliar de RH');
```

### INSERT INTO Professor
<a id="ancora4.4"></a>
[voltar](#ancora)


```python
insert into Professor(Nome, Sobrenome, Data_Nascimento, Contato, Formação) values
			('Leandro','Cabrita','1980-05-23',21965231015,'Mestrado'),
            ('Regina','Marques','1987-03-15',21965423105,default),
            ('Rodrigo','Ferreira','1989-03-21',21965421023,'Mestrado'),
            ('Marcia','Duarte','1986-09-25',21965102365,'Doutorado'),
            ('Larissa','Souza','1989-12-13',21954102365,'Mestrado'),
            ('Thiago','Barbosa','1985-09-24',21965412012,'Mestrado'),
            ('Gustavo','Pereira','1993-06-25',21965421302,default),
            ('Agnaldo','Dorneles','1991-11-26',21965412013,'Doutorado');
```

### INSERT INTO Materia
<a id="ancora4.5"></a>
[voltar](#ancora)


```python
insert into Materia(Nome, fk_idProfessor, fk_idCurso) values
			('Matemática',1,1),
            ('Português',2,4),
            ('Inglês',3,3),
            ('Física elétrica',4,1),
            ('Administração',5,4),
            ('Recursos Humanos',6,5),
            ('Informática',7,3),
            ('Economia',8,2);
```

### INSERT INTO Turma
<a id="ancora4.6"></a>
[voltar](#ancora)


```python
insert into Turma(idTurma, fk_idCurso, fk_idAluno, fk_idProfessorResponsavel, fk_materias, Turno) values
			('EL1',1,1,4,4,'Manhã'),
            ('EL2',1,2,4,1,'Noite'),
            ('EC1',2,3,8,1,'Tarde'),
            ('EC2',2,4,8,8,'Noite'),
            ('P1',3,5,2,2,'Manhã'),
            ('P2',3,6,2,2,'Tarde'),
            ('A1',4,7,5,1,'Tarde'),
            ('A2',4,8,5,7,'Noite'),
            ('RH1',5,9,6,1,'Manhã'),
            ('RH2',5,10,6,7,'Noite');
```

### INSERT INTO Atividade
<a id="ancora4.7"></a>
[voltar](#ancora)


```python
insert into Atividade(fk_idCurso, fk_idMateria, fk_idProfessor, QtdQuestoes, Prazo, Nota, Descrição) values
			(1,1,1,10,'2023-05-23',10,'Prova para parcial da nota'),
            (2,8,2,10,'2023-05-22',10,'Prova para parcial da nota'),
            (3,3,3,10,'2023-05-21',10,'Prova para parcial da nota'),
            (4,2,4,10,'2023-05-21',10,'Prova para parcial da nota'),
            (5,5,5,10,'2023-05-20',10,'Prova para parcial da nota');
```


### INSERT INTO Materia_Turma
<a id="ancora4.8"></a>
[voltar](#ancora)


```python
insert into Materia_Turma(fk_turma, fk_materia) values
			('EL1',4), ('EL1',1),
            ('EL2',4), ('EL2',1),
            ('EC1',1), ('EC1',8),
            ('EC2',1), ('EC2',8),
            ('P1',2),  ('P2',2),
            ('A1',1),  ('A1',2), ('A1',5),  ('A1',7),
            ('A2',1),  ('A2',2), ('A2',5),  ('A2',7),
            ('RH1',1), ('RH1',2), ('RH1',6), ('RH1',7),
            ('RH2',1), ('RH2',2), ('RH2',6), ('RH2',7);
```

## Respondendo as Perguntas com Queries.
<a id="ancora5"></a>
[voltar](#ancora)


### 1-Relação entre matérias, turmas, cursos:
<a id="ancora5.3"></a>
[voltar](#ancora)


```python
select c.nome as Curso,
		t.idTurma as Turma,
        t.Turno as Turno,
        m.Nome as Materia
	FROM curso c
    JOIN turma t on t.fk_idCurso = c.idCurso
    JOIN materia m on m.fk_idCurso = c.idCurso;
```

### 2-Quais professores de cada matéria:
<a id="ancora5.4"></a>
[voltar](#ancora)


```python
select CONCAT(p.Nome,' ',p.Sobrenome) as Professor,
		m.Nome as Materia
	FROM professor p
    JOIN materia m ON M.fk_idProfessor = p.idProfessor;
```

### 3-Quais alunos estão em cada curso:
<a id="ancora5.5"></a>
[voltar](#ancora)


```python
select CONCAT(a.Nome,' ',a.Sobrenome) as Aluno,
		t.idTurma as Turma,
        t.Turno as Turno,
        c.Nome as Curso
	FROM aluno a
    JOIN turma t ON t.fk_idAluno = a.idAluno
    JOIN curso c ON t.fk_idCurso = c.idCurso;
```

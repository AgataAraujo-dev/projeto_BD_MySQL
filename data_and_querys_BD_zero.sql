use curso_tecnico;

-- aluno, atividade, curso, materia, professor, turma

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

insert into Curso(Nome, Descrição) values
			('Elétrica','Noções para resolver atividades da função eletricista'),
            ('Economia','Noções para resolver atividades da função economista e/ou contador'),
            ('Programador','Noções para resolver atividades da função programador web'),
            ('Administração','Noções para resolver atividades da função auxiliar adminitrativo'),
            ('Recursos Humanos','Noções para resolver atividades da função auxiliar de RH');

insert into Professor(Nome, Sobrenome, Data_Nascimento, Contato, Formação) values
			('Leandro','Cabrita','1980-05-23',21965231015,'Mestrado'),
            ('Regina','Marques','1987-03-15',21965423105,default),
            ('Rodrigo','Ferreira','1989-03-21',21965421023,'Mestrado'),
            ('Marcia','Duarte','1986-09-25',21965102365,'Doutorado'),
            ('Larissa','Souza','1989-12-13',21954102365,'Mestrado'),
            ('Thiago','Barbosa','1985-09-24',21965412012,'Mestrado'),
            ('Gustavo','Pereira','1993-06-25',21965421302,default),
            ('Agnaldo','Dorneles','1991-11-26',21965412013,'Doutorado');
            
insert into Materia(Nome, fk_idProfessor, fk_idCurso) values
			('Matemática',1,1),
            ('Português',2,4),
            ('Inglês',3,3),
            ('Física elétrica',4,1),
            ('Administração',5,4),
            ('Recursos Humanos',6,5),
            ('Informática',7,3),
            ('Economia',8,2);

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

select * from curso;
insert into Atividade(fk_idCurso, fk_idMateria, fk_idProfessor, QtdQuestoes, Prazo, Nota, Descrição) values
			(1,1,1,10,'2023-05-23',10,'Prova para parcial da nota'),
            (2,8,2,10,'2023-05-22',10,'Prova para parcial da nota'),
            (3,3,3,10,'2023-05-21',10,'Prova para parcial da nota'),
            (4,2,4,10,'2023-05-21',10,'Prova para parcial da nota'),
            (5,5,5,10,'2023-05-20',10,'Prova para parcial da nota');            
            
insert into MateriaTurma(fk_turma, fk_materia) values
			('EL1',4), ('EL1',1),
            ('EL2',4), ('EL2',1),
            ('EC1',1), ('EC1',8),
            ('EC2',1), ('EC2',8),
            ('P1',2),  ('P2',2),
            ('A1',1),  ('A1',2), ('A1',5),  ('A1',7),
            ('A2',1),  ('A2',2), ('A2',5),  ('A2',7),
            ('RH1',1), ('RH1',2), ('RH1',6), ('RH1',7),
            ('RH2',1), ('RH2',2), ('RH2',6), ('RH2',7);
            
            
-- Relação entre matérias, turmas, cursos;
select c.nome as Curso,
		t.idTurma as Turma,
        t.Turno as Turno,
        m.Nome as Materia
	FROM curso c
    JOIN turma t on t.fk_idCurso = c.idCurso
    JOIN materia m on m.fk_idCurso = c.idCurso;
    
-- Quais professores de cada matéria;
select CONCAT(p.Nome,' ',p.Sobrenome) as Professor,
		m.Nome as Materia
	FROM professor p
    JOIN materia m ON M.fk_idProfessor = p.idProfessor;
    
-- Quais alunos estão em cada curso;    
select CONCAT(a.Nome,' ',a.Sobrenome) as Aluno,
		t.idTurma as Turma,
        t.Turno as Turno,
        c.Nome as Curso
	FROM aluno a
    JOIN turma t ON t.fk_idAluno = a.idAluno
    JOIN curso c ON t.fk_idCurso = c.idCurso;
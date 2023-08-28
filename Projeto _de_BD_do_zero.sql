-- drop database curso_tecnico;
create database curso_tecnico;
use curso_tecnico;

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

create table Curso(
		idCurso int primary key auto_increment,
        Nome varchar(35) NOT NULL,
        Descrição varchar(100)
);

alter table Curso auto_increment=1;

create table Professor(
		idProfessor int primary key auto_increment,
        Nome varchar(15) NOT NULL,
        Sobrenome varchar(30) NOT NULL,
        Data_Nascimento date NOT NULL,
        Contato char(11) NOT NULL,
        Formação enum('Mestrado', 'Doutorado', 'Graduado') default 'Graduado'
);

alter table Professor auto_increment=1;

create table Materia(
		idMateria int primary key auto_increment,
        Nome varchar(20) NOT NULL,
        fk_idProfessor int NOT NULL,
        fk_idCurso int NOT NULL,
        constraint fk_materia_idProfessor foreign key (fk_idProfessor) references Professor(idProfessor),
        constraint fk_materia_idCurso foreign key (fk_idCurso) references Curso(idCurso)
);

alter table Materia auto_increment=1;

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

create table MateriaTurma(
		fk_materia int NOT NULL,
        fk_Turma varchar(15) NOT NULL,
        constraint fk_materiaT_materia foreign key (fk_materia) references materia(idmateria),
        constraint fk_materiaT_turma foreign key (fk_turma) references turma(idTurma)
);

show tables;
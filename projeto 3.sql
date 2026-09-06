CREATE DATABASE gestao_curso;
USE gestao_curso;

CREATE TABLE usuarios(
usuario_id INT AUTO_INCREMENT PRIMARY KEY,
nome VARCHAR(45),
email VARCHAR (100) UNIQUE,
senha VARCHAR (100));

CREATE TABLE cursos (
curso_id INT AUTO_INCREMENT PRIMARY KEY,
nome_curso VARCHAR(45),
descricao VARCHAR(100),
preco DECIMAL(10,2));

CREATE TABLE aulas(
aula_id INT AUTO_INCREMENT PRIMARY KEY,
curso_id INT,
titulo VARCHAR(40),
duracao INT,
FOREIGN KEY (curso_id) REFERENCES cursos (curso_id));

CREATE TABLE inscricoes(
inscricao_id INT AUTO_INCREMENT PRIMARY KEY,
usuario_id INT,
curso_id INT,
data_inscricao DATE,
FOREIGN KEY (usuario_id) REFERENCES usuarios(usuario_id),
FOREIGN KEY (curso_id) REFERENCES cursos (curso_id));

INSERT INTO usuarios (usuario_id,nome, email, senha) VALUES (1,"João Silva", "joao@email.com", "123456");
INSERT INTO usuarios (usuario_id,nome, email, senha) VALUES (2,"Leornado Oliveira", "Leonardo897@gmail.com", "589947");
INSERT INTO usuarios (usuario_id,nome, email, senha) VALUES (3,"Douglas Costa", "Douglas5847@gmail.com", "693247");
INSERT INTO usuarios (usuario_id,nome, email, senha) VALUES (4,"Marcela Santos", "Marcela129@gmail.com", "854369");
INSERT INTO usuarios (usuario_id,nome, email, senha) VALUES (5,"Amanda Sousa", "AmandaSousa456@gmail.com", "144854");

INSERT INTO cursos (curso_id,nome_curso,descricao,preco) VALUES (6, "Desenvolvimento Web  Completo", "Aprender a criar sites e aplicacoes web do zero", 100.00);
INSERT INTO cursos (curso_id,nome_curso,descricao,preco) VALUES (7, "Marketing Digital", "Conhecer as principais estratégias de marketing digital", 90.00);
INSERT INTO cursos (curso_id,nome_curso,descricao,preco) VALUES (8, "Fotografia Digital", "aprender técnicas de composição, iluminação e edicao de imagem", 150.00);
INSERT INTO cursos (curso_id,nome_curso,descricao,preco) VALUES (9, "Gestão de Projetos com Scrum", "Aprender a gerenciar projetos de forma eficiente com a metodologia ágil Scrum", 200.00);
INSERT INTO cursos (curso_id,nome_curso,descricao,preco) VALUES (10, " Introdução à Programação com Python", "Este curso é voltado para iniciantes e aborda os conceitos fundamentais da programação com Python", 115.00);

INSERT INTO aulas (aula_id,curso_id,titulo,duracao) VALUES (11, 6, "Introdução Web", 60);
INSERT INTO aulas (aula_id,curso_id,titulo,duracao) VALUES (12,7, "Estratégias de Mídias Sociais",80);
INSERT INTO aulas (aula_id,curso_id,titulo,duracao) VALUES (13,8, "Iluminação para Fotografia",60);
INSERT INTO aulas (aula_id,curso_id,titulo,duracao) VALUES (14,9,"Introdução ao Scrum e Metodologias Ágeis", 90);
INSERT INTO aulas (aula_id,curso_id,titulo,duracao) VALUES (15,10, "Sintaxe Básica e Tipos de Dados", 90);

INSERT INTO Inscricoes (inscricao_id,usuario_id,curso_id,data_inscricao) VALUES (16,1,6,'2023-02-04');
INSERT INTO Inscricoes (inscricao_id,usuario_id,curso_id,data_inscricao) VALUES (17,2,7, '2023-02-06');
INSERT INTO Inscricoes (inscricao_id,usuario_id,curso_id,data_inscricao) VALUES (18,3,8, '2023-02-11');
INSERT INTO Inscricoes (inscricao_id,usuario_id,curso_id,data_inscricao) VALUES (19,4,9, '2023-02-12');
INSERT INTO Inscricoes (inscricao_id,usuario_id,curso_id,data_inscricao) VALUES (20,5,10,'2023-02-14');

SELECT*FROM usuarios;

SELECT*FROM cursos;

SELECT*FROM aulas WHERE curso_id = 7;

SELECT*FROM inscricoes WHERE usuario_id = 3;

SELECT nome_curso, preco FROM cursos;

SELECT nome_curso , preco
FROM cursos
WHERE preco < 100.00;

SELECT nome_curso, preco
FROM cursos
WHERE preco > 90.00;

SELECT*FROM cursos WHERE NOT nome_curso = "Desenvolvimento Web  Completo";

SELECT*FROM cursos WHERE NOT preco > 100.00;

SELECT usuarios.nome, cursos.nome_curso
FROM usuarios
 JOIN inscricoes
ON usuarios.usuario_id = inscricoes.usuario_id
JOIN cursos 
ON inscricoes.curso_id = cursos.curso_id
WHERE usuarios.usuario_id = 1;

SELECT usuarios.nome, Inscricoes.data_inscricao
FROM usuarios
JOIN inscricoes 
ON usuarios.usuario_id = inscricoes.usuario_id
WHERE data_inscricao = '2023-02-14';

SELECT cursos.nome_curso,COUNT( inscricoes.inscricao_id) AS total_inscrito
FROM cursos
LEFT JOIN inscricoes ON cursos.curso_id = inscricoes.curso_id
GROUP BY cursos.nome_curso;

SELECT cursos.nome_curso, SUM(duracao) AS duracao_total
FROM cursos 
JOIN aulas ON cursos.curso_id = aulas.curso_id
GROUP BY cursos.nome_curso;

SELECT cursos.nome_curso, cursos.preco * COUNT(inscricoes.inscricao_id) AS receita_estimada
FROM cursos
LEFT JOIN inscricoes ON cursos.curso_id = inscricoes.curso_id
GROUP BY cursos.nome_curso, cursos.preco;



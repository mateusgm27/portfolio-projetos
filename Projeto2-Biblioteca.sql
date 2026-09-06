SELECT * FROM Livros ORDER BY ano_publicacao DESC LIMIT 5;
CREATE DATABASE Biblioteca;
USE Biblioteca;

CREATE TABLE Autores (
    autor_id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    nacionalidade VARCHAR(50) NOT NULL
);

CREATE TABLE Clientes (
    cliente_id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(50) NOT NULL,
    data_cadastro DATE
);

CREATE TABLE Livros (
    livro_id INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(100) NOT NULL,
    autor_id INT,
    categoria VARCHAR(50) NOT NULL,
    ano_publicacao INT,
    FOREIGN KEY (autor_id) REFERENCES Autores(autor_id)
);

CREATE TABLE Emprestimos (
    emprestimo_id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT,
    livro_id INT,
    data_emprestimo DATE,
    data_devolucao DATE,
    FOREIGN KEY (cliente_id) REFERENCES Clientes(cliente_id),
    FOREIGN KEY (livro_id) REFERENCES Livros(livro_id)
);

INSERT INTO Autores (autor_id, nome, nacionalidade) VALUES 
(1, 'Machado de Assis', 'Brasileiro'),
(2, 'Clarice Lispector', 'Brasileira'),
(3, 'Gabrielle-Suzanne Barbot de Villeneuve', 'Francesa'),
(4, 'Antoine de Saint-Exupéry', 'Francês'),
(5, 'Maggie O\'Farrell', 'Britânica'),
(6, 'José Mauro de Vasconcelos', 'Brasileiro'),
(7, 'George Orwell', 'Britânico'),
(8, 'J.K. Rowling', 'Britânica'),
(9, 'Albert Camus', 'Francês'),
(10, 'F. Scott Fitzgerald', 'Americano');

INSERT INTO Clientes (cliente_id, nome, email, data_cadastro) VALUES 
(1, 'Carlos Silva', 'carlos.silva@email.com', '2023-01-01'),
(2, 'Ana Oliveira', 'ana.oliveira@email.com', '2023-02-15'),
(3, 'Lucas Pereira', 'lucas.pereira@email.com', '2023-03-10'),
(4, 'Maria Souza', 'maria.souza@email.com', '2023-04-20'),
(5, 'Rafael Costa', 'rafael.costa@email.com', '2023-05-30'),
(6, 'Fernanda Lima', 'fernanda.lima@email.com', '2023-06-12'),
(7, 'Roberta Almeida', 'roberta.almeida@email.com', '2023-07-25'),
(8, 'Gabriel Rocha', 'gabriel.rocha@email.com', '2023-08-05'),
(9, 'Patrícia Santos', 'patricia.santos@email.com', '2023-09-18'),
(10, 'Marcos Silva', 'marcos.silva@email.com', '2023-10-10');

INSERT INTO Livros (livro_id, titulo, autor_id, categoria, ano_publicacao) VALUES 
(1, 'Dom Casmurro', 1, 'Literatura Brasileira', 1899),
(2, 'A Hora da Estrela', 2, 'Literatura Brasileira', 1977),
(3, 'A Bela e a Fera', 3, 'Ficção Infantil', 1740),
(4, 'Voo de Noite', 4, 'Aventura', 1931),
(5, 'Hamnet', 5, 'Ficção histórica', 2020),
(6, 'Meu Pé de Laranja Lima', 6, 'Infantil', 1968),
(7, '1984', 7, 'Distopia', 1949),
(8, 'Harry Potter e a Pedra Filosofal', 8, 'Fantasia', 1997),
(9, 'O Estrangeiro', 9, 'Filosofia', 1942),
(10, 'O Grande Gatsby', 10, 'Romance', 1925);

INSERT INTO Emprestimos (emprestimo_id, cliente_id, livro_id, data_emprestimo, data_devolucao) VALUES 
(1, 1, 2, '2023-07-01', '2023-07-15'),
(2, 2, 4, '2023-07-05', '2023-07-19'),
(3, 3, 6, '2023-08-10', '2023-08-24'),
(4, 4, 7, '2023-08-12', '2023-08-26'),
(5, 5, 1, '2023-09-01', '2023-09-15'),
(6, 6, 8, '2023-09-07', '2023-09-21'),
(7, 7, 5, '2023-10-01', '2023-10-15'),
(8, 8, 9, '2023-10-03', '2023-10-17'),
(9, 9, 3, '2023-11-05', '2023-11-19'),
(10, 10, 10, '2023-11-10', '2023-11-24');

SELECT*FROM autores;
SELECT * FROM Clientes;
SELECT * FROM Livros WHERE categoria = 'Literatura Brasileira';
SELECT*FROM Livros WHERE categoria = "Aventura";
SELECT * FROM Emprestimos WHERE cliente_id = 1;
SELECT * FROM Emprestimos WHERE cliente_id = 5;
SELECT titulo, ano_publicacao FROM Livros;
SELECT * FROM Clientes WHERE data_cadastro > '2023-05-01';
SELECT*FROM Clientes WHERE data_cadastro < '2023-03-10';
SELECT * FROM Livros WHERE ano_publicacao > 1950;
SELECT*FROM Livros WHERE ano_publicacao < 1968;
SELECT * FROM Emprestimos WHERE data_devolucao IS NOT NULL;

SELECT Clientes.nome, Livros.titulo
FROM Emprestimos
JOIN Clientes ON Emprestimos.cliente_id = Clientes.cliente_id
JOIN Livros ON Emprestimos.livro_id = Livros.livro_id;

SELECT Autores.nome, COUNT(Livros.livro_id) AS quantidade_de_livros
FROM Autores
LEFT JOIN Livros ON Autores.autor_id = Livros.autor_id
GROUP BY Autores.nome;

SELECT Livros.titulo
FROM Emprestimos
JOIN Livros ON Emprestimos.livro_id = Livros.livro_id
WHERE Emprestimos.cliente_id = 4;

SELECT Livros.titulo
FROM Emprestimos
JOIN Livros ON Emprestimos.livro_id = Livros.livro_id
WHERE Emprestimos.cliente_id = 6;

SELECT categoria, AVG(ano_publicacao) AS media_ano_publicacao
FROM Livros
GROUP BY categoria;













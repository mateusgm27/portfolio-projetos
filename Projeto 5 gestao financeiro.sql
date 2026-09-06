CREATE DATABASE gestao_financeiro;
USE gestao_financeiro;

CREATE TABLE usuarios(
    usuario_id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(45) NOT NULL,
    data_registro DATE NOT NULL
);

CREATE TABLE categorias(
categoria_id INT AUTO_INCREMENT PRIMARY KEY,
nome VARCHAR (45),
tipo ENUM ("Receita", "Despesa"),
usuario_id INT,
FOREIGN KEY (usuario_id) REFERENCES usuarios (usuario_id));

CREATE TABLE metas(
meta_id INT AUTO_INCREMENT PRIMARY KEY,
descricao VARCHAR(45),
valor_alvo DECIMAL(10,2),
prazo DATE,
progresso DECIMAL(10,2),
usuario_id INT,
FOREIGN KEY (usuario_id) REFERENCES usuarios (usuario_id));

CREATE TABLE transacoes (
    transacao_id INT AUTO_INCREMENT PRIMARY KEY,
    descricao VARCHAR(45),
    valor DECIMAL(10,2),
    data DATE,
    tipo ENUM ("Receita", "Despesa"),
    status ENUM("Concluida", "Pendente"),
    categoria_id INT,
    usuario_id INT,
    FOREIGN KEY (categoria_id) REFERENCES categorias(categoria_id),
    FOREIGN KEY (usuario_id) REFERENCES usuarios(usuario_id));

INSERT INTO usuarios(usuario_id,nome,email,data_registro) VALUES (1,"Leandro Gomes","Leandro149@gmail.com",'2023-04-03');
INSERT INTO usuarios(usuario_id,nome,email,data_registro) VALUES (2,"Guilherme Goncalves ","Guilherme784@gmail.com",'2023-04-03');
INSERT INTO usuarios(usuario_id,nome,email,data_registro) VALUES (3,"Alessandra Alves","Alessandra651@gmail.com",'2023-04-05');
INSERT INTO usuarios(usuario_id,nome,email,data_registro) VALUES (4,"Paulo Oliveira","Paulo416@gmail.com",'2023-04-05');
INSERT INTO usuarios(usuario_id,nome,email,data_registro) VALUES (5,"Jessica Alves","Jessica615@gmail.com",'2023-04-05');
INSERT INTO usuarios(usuario_id,nome,email,data_registro) VALUES (6,"Joana Sousa","Joana841@gmail.com",'2023-04-05');
INSERT INTO usuarios(usuario_id,nome,email,data_registro) VALUES (7,"Bruna Oliveira","BrunaOliveira1466@gmail.com",'2023-04-06');
INSERT INTO usuarios(usuario_id,nome,email,data_registro) VALUES (8,"Matheus Pereira","matheus555@gmail.com",'2023-04-06');
INSERT INTO usuarios(usuario_id,nome,email,data_registro) VALUES (9,"Eduardo Teixeira","Eduardo100809@gmail.com",'2023-04-06');
INSERT INTO usuarios(usuario_id,nome,email,data_registro) VALUES (10,"Rafael Messias","rafaelmessias040316@gmail.com",'2023-04-06');
INSERT INTO usuarios(usuario_id,nome,email,data_registro) VALUES (11,"Maria Santos","maria185@gmail.com","2023-04-07");
INSERT INTO usuarios(usuario_id,nome,email,data_registro) VALUES (12,"Leandra Esteves","Esteves365@gmail.com","2023-04-08");
INSERT INTO usuarios(usuario_id,nome,email,data_registro) VALUES (13,"Vitor Guilherme","vitor41065@gmail.com","2024-04-09");
INSERT INTO usuarios(usuario_id,nome,email,data_registro) VALUES (14,"Estefania Oliveira","EstefaniaOliveira1145@gmail.com",'2024-04-09');
INSERT INTO usuarios(usuario_id,nome,email,data_registro) VALUES (15,"Sandra Esteves","SandraEsteves250@gmail.com",'2024-04-10');

INSERT INTO categorias(categoria_id,nome,tipo,usuario_id) VALUES (16,"Alimentação","Despesa",1);
INSERT INTO categorias(categoria_id,nome,tipo,usuario_id) VALUES (17,"Saúde","Despesa",2);
INSERT INTO categorias(categoria_id,nome,tipo,usuario_id) VALUES (18,"Educação","Despesa",3);
INSERT INTO categorias(categoria_id,nome,tipo,usuario_id) VALUES (19,"Transporte","Despesa",4);
INSERT INTO categorias(categoria_id,nome,tipo,usuario_id) VALUES (20,"Salário","Receita",5);
INSERT INTO categorias(categoria_id,nome,tipo,usuario_id) VALUES (21,"Freelance","Receita",6);
INSERT INTO categorias(categoria_id,nome,tipo,usuario_id) VALUES (22,"Investimentos","Receita",7);
INSERT INTO categorias(categoria_id,nome,tipo,usuario_id) VALUES (23,"Vendas","Receita",8);
INSERT INTO categorias(categoria_id,nome,tipo,usuario_id) VALUES (24,"Doações","Receita",9);
INSERT INTO categorias(categoria_id,nome,tipo,usuario_id) VALUES (25,"Lazer","Despesa",10);
INSERT INTO categorias(categoria_id,nome,tipo,usuario_id) VALUES (26,"Renda Extra","Receita",11);
INSERT INTO categorias(categoria_id,nome,tipo,usuario_id) VALUES (27,"Contas De Casa","Despesa",12);
INSERT INTO categorias(categoria_id,nome,tipo,usuario_id) VALUES (28,"Viagem","Despesa",13);
INSERT INTO categorias(categoria_id,nome,tipo,usuario_id) VALUES (29,"Presentes","Despesa",14);
INSERT INTO categorias(categoria_id,nome,tipo,usuario_id) VALUES (30,"Lucros","Receita",15);

INSERT INTO metas(meta_id,descricao,valor_alvo,prazo,progresso,usuario_id) VALUES(31,"Comprar Comida",400.00,'2023-04-04',2000.00,1);
INSERT INTO metas(meta_id,descricao,valor_alvo,prazo,progresso,usuario_id) VALUES (32,"Dentista",300.00,'2023-04-06',150.00,2);
INSERT INTO metas(meta_id,descricao,valor_alvo,prazo,progresso,usuario_id) VALUES (33,"Fazer Um Curso Online",1500.00,'2023-04-08',0.00,3);
INSERT INTO metas(meta_id,descricao,valor_alvo,prazo,progresso,usuario_id) VALUES(34,"Comprar um carro",4000.00,'2023-04-07',2000.00,4);
INSERT INTO metas(meta_id,descricao,valor_alvo,prazo,progresso,usuario_id) VALUES (35,"Comprar Notebook",5000.00,'2023-04-09',1200.00,5);
INSERT INTO metas(meta_id,descricao,valor_alvo,prazo,progresso,usuario_id) VALUES (36,"Reforma Da Casa",20000.00,'2023-04-11',900.00,6);
INSERT INTO metas(meta_id,descricao,valor_alvo,prazo,progresso,usuario_id) VALUES (37,"Montar Uma Pequena Empresa",50000.00,'2023-04-20',15000.00,7);
INSERT INTO metas(meta_id,descricao,valor_alvo,prazo,progresso,usuario_id) VALUES (38,"Vender Moto",17000.00,'2023-04-18',11000.00,8);
INSERT INTO metas(meta_id,descricao,valor_alvo,prazo,progresso,usuario_id) VALUES (39,"Bazar",650.00,'2023-04-24',168.00,9);
INSERT INTO metas(meta_id,descricao,valor_alvo,prazo,progresso,usuario_id) VALUES (40,"Fazer Uma Viagem Internacional",20000.00,'2023-05-01',5000.00,10);
INSERT INTO metas(meta_id,descricao,valor_alvo,prazo,progresso,usuario_id) VALUES (41,"Reservar Dinheiro Para Filhos",25000.00,'2023-09-15',10000.00,11);
INSERT INTO metas(meta_id,descricao,valor_alvo,prazo,progresso,usuario_id) VALUES (42,"Pagar conta agua e luz",300.00,'2023-05-01',150.00,12);
INSERT INTO metas(meta_id,descricao,valor_alvo,prazo,progresso,usuario_id) VALUES (43,"Viagem Em Familia",7000.00,'2023-04-13',450.00,13);
INSERT INTO metas(meta_id,descricao,valor_alvo,prazo,progresso,usuario_id) VALUES (44,"Comprar Presente Para Um Amigo",850.00,'2023-04-10',400.00,14);
INSERT INTO metas(meta_id,descricao,valor_alvo,prazo,progresso,usuario_id) VALUES (45,"Realizar Casamento",30000.00,'2023-05-05',10000.00,15);

 INSERT INTO transacoes(transacao_id, descricao, valor, data, tipo, status, categoria_id, usuario_id) VALUES (46,"Comprar Alimentos",120.50,'2023-04-04',"Despesa","Concluida",16,1);
 INSERT INTO transacoes(transacao_id, descricao, valor, data, tipo, status, categoria_id, usuario_id) VALUES (47,"Consulta Médica", 250.00, '2023-04-06', 'Despesa', 'Concluida', 17, 2);
 INSERT INTO transacoes(transacao_id, descricao, valor, data, tipo, status, categoria_id, usuario_id) VALUES (48,"Mensalidade Escolar", 500.00, '2023-04-08', 'Despesa', 'Concluida', 18, 3);
 INSERT INTO transacoes(transacao_id, descricao, valor, data, tipo, status, categoria_id, usuario_id) VALUES (49,"Abastecimento do Carro", 150.00, '2023-04-09', 'Despesa', 'Pendente', 19, 4);
 INSERT INTO transacoes(transacao_id, descricao, valor, data, tipo, status, categoria_id, usuario_id) VALUES (50,'Recebimento de Salário', 3000.00, '2023-04-05', 'Receita', 'Concluida', 20, 5);
 INSERT INTO transacoes(transacao_id, descricao, valor, data, tipo, status, categoria_id, usuario_id) VALUES (51, 'Freelance de Design', 800.00, '2023-04-10', 'Receita', 'Concluida', 21, 6);
 INSERT INTO transacoes(transacao_id, descricao, valor, data, tipo, status, categoria_id, usuario_id) VALUES (52, 'Compra de Ações', 2000.00, '2023-04-11', 'Receita', 'Pendente', 22, 7);
 INSERT INTO transacoes(transacao_id, descricao, valor, data, tipo, status, categoria_id, usuario_id) VALUES (53, 'Venda de Produtos', 1500.00, '2023-04-15', 'Receita', 'Concluida', 23, 8);
 INSERT INTO transacoes(transacao_id, descricao, valor, data, tipo, status, categoria_id, usuario_id) VALUES (54, 'Doação para ONG', 100.00, '2023-04-18', 'Receita', 'Concluida', 24, 9);
 INSERT INTO transacoes(transacao_id, descricao, valor, data, tipo, status, categoria_id, usuario_id) VALUES (55, 'Cinema com Amigos', 70.00, '2023-04-20', 'Despesa', 'Concluida', 25, 10);
 INSERT INTO transacoes(transacao_id, descricao, valor, data, tipo, status, categoria_id, usuario_id) VALUES (56, 'Renda Extra', 400.00, '2023-04-22', 'Receita', 'Concluida', 26, 11);
 INSERT INTO transacoes(transacao_id, descricao, valor, data, tipo, status, categoria_id, usuario_id) VALUES (57, 'Pagto Conta de Água e Luz', 300.00, '2023-04-23', 'Despesa', 'Pendente', 27, 12);
 INSERT INTO transacoes(transacao_id, descricao, valor, data, tipo, status, categoria_id, usuario_id) VALUES (58, 'Compra de Passagens', 2000.00, '2023-04-25', 'Despesa', 'Concluida', 28, 13);
 INSERT INTO transacoes(transacao_id, descricao, valor, data, tipo, status, categoria_id, usuario_id) VALUES (59, 'Compra de Presente', 120.00, '2023-04-28', 'Despesa', 'Concluida', 29, 14);
 INSERT INTO transacoes(transacao_id, descricao, valor, data, tipo, status, categoria_id, usuario_id) VALUES (60, 'Lucro com Venda Online', 2500.00, '2023-04-30', 'Receita', 'Concluida', 30, 15);
 
SELECT t.transacao_id, t.descricao, u.nome
FROM transacoes t
JOIN usuarios u ON t.usuario_id = u.usuario_id;

SELECT c.categoria_id, c.nome AS categoria_nome, t.descricao AS transacao_descricao
FROM categorias c
LEFT JOIN transacoes t ON c.categoria_id = t.categoria_id;

SELECT u.nome, c.nome AS categoria_nome
FROM usuarios u
RIGHT JOIN categorias c ON u.usuario_id = c.usuario_id;

SELECT AVG (valor) AS media_valor_transacoes FROM transacoes;

SELECT SUM(valor) AS total_despesas
FROM transacoes
WHERE usuario_id = 1 AND tipo = 'Despesa';

SELECT * 
FROM metas
WHERE prazo <= '2023-04-10';

SELECT MIN(valor) AS menor_valor
FROM transacoes;

SELECT u.nome, t.descricao, t.status
FROM usuarios u
JOIN transacoes t ON u.usuario_id = t.usuario_id
WHERE t.status = 'Pendente';

SELECT c.nome AS categoria, t.descricao AS transacao
FROM categorias c
LEFT JOIN transacoes t ON c.categoria_id = t.categoria_id
WHERE c.tipo = 'Receita';

SELECT m.descricao, u.nome
FROM metas m
RIGHT JOIN usuarios u ON m.usuario_id = u.usuario_id
WHERE u.data_registro > '2023-04-05';

SELECT SUM(valor) AS total_receitas
FROM transacoes
WHERE usuario_id = 5 AND tipo = 'Receita';

SELECT AVG(progresso) AS progresso_medio
FROM metas
WHERE usuario_id = 7;

SELECT DISTINCT u.nome
FROM usuarios u
JOIN transacoes t ON u.usuario_id = t.usuario_id
WHERE t.status = 'Concluida';

SELECT u.nome AS usuario, t.tipo, SUM(t.valor) AS total
FROM transacoes t
JOIN usuarios u ON t.usuario_id = u.usuario_id
GROUP BY u.usuario_id, t.tipo;

SELECT t.descricao, t.valor, t.data, t.status, u.nome AS usuario
FROM transacoes t
JOIN usuarios u ON t.usuario_id = u.usuario_id
WHERE t.status = 'Pendente';

SELECT c.nome AS categoria, t.tipo, SUM(t.valor) AS total
FROM transacoes t
JOIN categorias c ON t.categoria_id = c.categoria_id
GROUP BY c.categoria_id, t.tipo;


SELECT t.descricao, t.valor, t.data, t.tipo, t.status
FROM transacoes t
WHERE t.usuario_id = 3;



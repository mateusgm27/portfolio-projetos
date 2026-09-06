CREATE DATABASE restaurante;
USE restaurante;



CREATE TABLE clientes(
cliente_id INT AUTO_INCREMENT PRIMARY KEY,
nome VARCHAR(45),
telefone VARCHAR(15),
endereco VARCHAR(255));

CREATE TABLE funcionarios(
funcionario_id INT AUTO_INCREMENT PRIMARY KEY,
nome VARCHAR(50),
cargo VARCHAR(45),
salario DECIMAL(10,2),
horario_trabalho VARCHAR(20));

CREATE TABLE pratos(
prato_id INT AUTO_INCREMENT PRIMARY KEY,
nome VARCHAR(45),
descricao VARCHAR(100),
categoria VARCHAR(50),
preco DECIMAL (10,2),
disponibilidade VARCHAR(20));

CREATE TABLE pedidos(
pedido_id INT AUTO_INCREMENT PRIMARY KEY,
cliente_id INT,
data_pedido DATE,
status ENUM("Em Preparação","Finalizado","Pago"),
FOREIGN KEY (cliente_id) REFERENCES clientes (cliente_id));

CREATE TABLE itens_pedidos (
    item_id INT AUTO_INCREMENT PRIMARY KEY,
    pedido_id INT,
    prato_id INT,
    quantidade INT,
    FOREIGN KEY (pedido_id) REFERENCES pedidos(pedido_id),
    FOREIGN KEY (prato_id) REFERENCES pratos(prato_id));
    
    CREATE TABLE pagamentos(
    pagamento_id INT AUTO_INCREMENT PRIMARY KEY,
    pedido_id INT,
    valor_pago DECIMAL (10,2),
    metodo_pagamento VARCHAR(20),
    status_pagamento ENUM("Pendente","Pago"),
    FOREIGN KEY (pedido_id) REFERENCES pedidos (pedido_id));
    
    
    CREATE TABLE estoque(
    estoque_id INT AUTO_INCREMENT PRIMARY KEY,
    prato_id INT,
    ingrediente VARCHAR(40),
    quantidade_disponivel INT,
    FOREIGN KEY (prato_id) REFERENCES pratos (prato_id));
    
INSERT INTO clientes (cliente_id,nome,telefone,endereco) VALUES (1,"Adriana Alves",'118574963',"Rua das Flores, 123 - Centro, SP");
INSERT INTO clientes (cliente_id,nome,telefone,endereco) VALUES (2,"Alessandra Oliveira",'1185107506',"Rua dos Ipés, 45 - Vila Mariana, SP");
INSERT INTO clientes (cliente_id,nome,telefone,endereco) VALUES (3,"Bruno Pereira",'11587509124', "Avenida Paulista, 100 - Consolação ,SP");
INSERT INTO clientes (cliente_id,nome,telefone,endereco) VALUES (4,"Bruna Gonçalves",'1185107403',"Rua dos Três Irmãos, 201 - Bela Vista, SP");
INSERT INTO clientes (cliente_id,nome,telefone,endereco) VALUES (5,"Leornado Alves", '1198650814',"Rua Dos Girassois, 350- Liberdade, SP");
INSERT INTO clientes (cliente_id,nome,telefone,endereco) VALUES (6, "Daniel Costa", '1198575093',"Rua Do Sol, 789- Itaim Bibi, SP");
INSERT INTO clientes (cliente_id,nome,telefone,endereco) VALUES (7, "Heloisa Pereira",'1175037403',"Avenida Rebouças,4200 - Pinheiros, SP");
INSERT INTO clientes (cliente_id,nome,telefone,endereco) VALUES (8,"Israel Costa", '1198901234', "Rua Almirante Barroso, 1150 - Centro ,SP");
INSERT INTO clientes (cliente_id,nome,telefone,endereco) VALUES (9, "Gabriela Costa", '11912345678',"Rua Jasmins,78 - Moema, SP");
INSERT INTO clientes (cliente_id,nome,telefone,endereco) VALUES (10, "Gabriel Sousa", '11985107509',"Rua Da Paz, 900 - Santo Amaro ,SP");
INSERT INTO clientes (cliente_id,nome,telefone,endereco) VALUES (11, "Larissa Barroso", '1185106503', "Avenida Dos Bandeirantes, 500 - Vila Progedior , SP");
INSERT INTO clientes (cliente_id,nome,telefone,endereco) VALUES (12, "Mateus Henrique", '11923456789', "Rua Do Bosque, 255 - Jardim Paulista, SP");
INSERT INTO clientes (cliente_id,nome,telefone,endereco) VALUES (13, "Joao Silva",'11934567890', "Rua Verde, 160 - Vila Clementino, SP");
INSERT INTO clientes (cliente_id,nome,telefone,endereco) VALUES (14, "Ana Costa", '1945678901', "Rua Dos Lirios, 240 - Saúde, SP");
INSERT INTO clientes (cliente_id,nome,telefone,endereco) VALUES (15, "Carlos Souza", '11956789012', " Rua Doutor Varela, 556 -  Campo Belo ,SP");
INSERT INTO clientes (cliente_id,nome,telefone,endereco) VALUES (16, "Fernanda Almeida", '11967890123', " Avenida ibirapuera, 350 - Moema, SP");
INSERT INTO clientes (cliente_id,nome,telefone,endereco) VALUES (17, "Fernando Teixeira", '11978901234', "Rua São Joaquim, 470 - Liberdade, SP");
INSERT INTO clientes (cliente_id,nome,telefone,endereco) VALUES (18, "Felipe Benjamin", '11989012345', "Rua Da Alegria, 730 - Bixiga, SP");
INSERT INTO clientes (cliente_id,nome,telefone,endereco) VALUES (19, "Willian Barbosa",  '11990123456', "Rua Dos Eucaliptos, 1015 - Vila Progredior ,SP");
INSERT INTO clientes (cliente_id,nome,telefone,endereco) VALUES (20, "Franscica Maria",  '11901234567', "Rua Do Palmeiras, 650 - Vila Mariana, SP");

INSERT INTO funcionarios (funcionario_id,nome,cargo,salario,horario_trabalho) VALUES (21, "Alessandro Barbosa", "Cozinheiro", "2500.00", "08:00 - 16:00");
INSERT INTO funcionarios (funcionario_id,nome,cargo,salario,horario_trabalho) VALUES (22, "Gustavo Moreira", "Cozinheiro", "2500.00", "08:00 - 16:00");
INSERT INTO funcionarios (funcionario_id,nome,cargo,salario,horario_trabalho) VALUES (23, "Lorrany Castro", "Cozinheira", "2700.00", "08:00 - 16:00");
INSERT INTO funcionarios (funcionario_id,nome,cargo,salario,horario_trabalho) VALUES (24, "Jessica Barbosa", "Cozinheira", "2600.00", "08:00 - 16:00");
INSERT INTO funcionarios (funcionario_id,nome,cargo,salario,horario_trabalho) VALUES (25, "Matheus Teixeira", "Garçom", "2400.00", "08:00 - 16:00");
INSERT INTO funcionarios (funcionario_id,nome,cargo,salario,horario_trabalho) VALUES (26, "Patrick Dantas", "Garçom", "2100.00", "08:00 - 16:00");
INSERT INTO funcionarios (funcionario_id,nome,cargo,salario,horario_trabalho) VALUES (27, "Leandra Gomes", "Garçom", "2000.00", "08:00 - 16:00");
INSERT INTO funcionarios (funcionario_id,nome,cargo,salario,horario_trabalho) VALUES (28, "Paulo Henrique", "Garçom", "2300.00", "08:00 - 16:00");
INSERT INTO funcionarios (funcionario_id,nome,cargo,salario,horario_trabalho) VALUES (29, "Moises Oliveira", "Garçom", "2100.00", "08:00 - 16:00");
INSERT INTO funcionarios (funcionario_id,nome,cargo,salario,horario_trabalho) VALUES (30, "Marcela Gonçalves", "Caixa", "2400.00", "08:00- 16:00");
INSERT INTO funcionarios (funcionario_id,nome,cargo,salario,horario_trabalho) VALUES (31, "Maria Alves", "Caixa", "2200.00", "08:00 - 16:00");

INSERT INTO pratos ( prato_id,nome, descricao, categoria, preco, disponibilidade) VALUES (32,"Feijoada", "Feijao Preto com carnes defumadas e acompanhamentos", "Tradicional", '40.00', "Disponivel");
INSERT INTO pratos ( prato_id,nome, descricao, categoria, preco, disponibilidade) VALUES (33, "Lasanha Bolonhesa", "Massa com carne moida , molho bolonhesa e queijo gratinado", "Massas e risotos", '35.00', "Disponivel");
INSERT INTO pratos ( prato_id,nome, descricao, categoria, preco, disponibilidade) VALUES (34, "Frango Assado", "Frango temperado e assado com batatas", "Carnes", 30.00 , "indisponivel");
INSERT INTO pratos ( prato_id,nome, descricao, categoria, preco, disponibilidade) VALUES (35, "Escondidinho De Carne Seca", "Pure de mandioca com carne seca desfiada", "Tradicional", 25.00, "Disponivel");
INSERT INTO pratos ( prato_id,nome, descricao, categoria, preco, disponibilidade) VALUES (36, "Strogonoff de Frango", "Frango com molho cremoso de mostarda e cogumelos", "Tradicional", 28.00, "Disponivel");
INSERT INTO pratos ( prato_id,nome, descricao, categoria, preco, disponibilidade) VALUES (37, "Sushi", "Arroz de sushi com peixe fresco e algas nori", "Fruto do Mar", 45.00, "indisponivel");
INSERT INTO pratos ( prato_id,nome, descricao, categoria, preco, disponibilidade) VALUES (38, "Bacalhau à Brás", "Bacalhau desfiado com batatas palhas e ovos mexidos", "Tradicional", 50.00, "Disponivel");
INSERT INTO pratos ( prato_id,nome, descricao, categoria, preco, disponibilidade) VALUES (39, "Camarão alho e oleo", "Camarôes salteados com alho e oleo", "Frutos do mar", 50.00, "Disponivel");
INSERT INTO pratos ( prato_id,nome, descricao, categoria, preco, disponibilidade) VALUES (40, "Moussaka", "Prato grego com carne de carneiro moida , berinjela e molho bechamel", "Tradicional", 45.00, "Disponivel");
INSERT INTO pratos ( prato_id,nome, descricao, categoria, preco, disponibilidade) VALUES (41, "Feijão Tropeiro", "Feijao com arroz, carne de porco e farofa", "Tradicional", 28.00, "Disponivel");
INSERT INTO pratos ( prato_id,nome, descricao, categoria, preco, disponibilidade) VALUES (42, "Costelinha com molho barbecue", "Costelinha de porco suculenta marinada e assada com molho barbecue", "Carnes", 40.00, "Disponivel");
INSERT INTO pratos ( prato_id,nome, descricao, categoria, preco, disponibilidade) VALUES (43, "Lagosta com Cogumelos", "Lagosta fresca acompanhada de cogumelos salteados", "Frutos do mar", 55.00, "indisponivel");
INSERT INTO pratos ( prato_id,nome, descricao, categoria, preco, disponibilidade) VALUES (44, "Tiramisu", "Sobremesa italiana com café, mascarpone e cacau", "Sobremesas", 18.00, "Disponível");
INSERT INTO pratos ( prato_id,nome, descricao, categoria, preco, disponibilidade) VALUES (45, "Brigadeiro Gourmet", "Bombom de chocolate com leite condensado e granulado", "Sobremesas", 10.00, "Disponível");
INSERT INTO pratos ( prato_id,nome, descricao, categoria, preco, disponibilidade) VALUES (46, "Pudim de Leite Condensado", "Sobremesa cremosa com leite condensado, ovos e açúcar", "Sobremesas", 20.00, "Disponível");
INSERT INTO pratos ( prato_id,nome, descricao, categoria, preco, disponibilidade) VALUES (47, "Cheesecake de Frutas Vermelhas", "Sobremesa de queijo cremoso com calda de frutas vermelhas", "Sobremesas", 22.00, "Disponível");

INSERT INTO pedidos (pedido_id,cliente_id,data_pedido,status) VALUES (48,1,'2023-04-05', "Em Preparação");
INSERT INTO pedidos (pedido_id,cliente_id,data_pedido,status) VALUES (49,2,'2023-04-05', "Finalizado");
INSERT INTO pedidos (pedido_id,cliente_id,data_pedido,status) VALUES (50,3,'2023-04-05', "Finalizado");
INSERT INTO pedidos (pedido_id,cliente_id,data_pedido,status) VALUES (51,4,'2023-04-06', "Em Preparação");
INSERT INTO pedidos (pedido_id,cliente_id,data_pedido,status) VALUES (52,5,'2023-04-06', "Finalizado");
INSERT INTO pedidos (pedido_id,cliente_id,data_pedido,status) VALUES (53,6,'2023-04-06', "Pago");
INSERT INTO pedidos (pedido_id,cliente_id,data_pedido,status) VALUES (54,7,'2023-04-06', "Finalizado");
INSERT INTO pedidos (pedido_id,cliente_id,data_pedido,status) VALUES (55,8,'2023-04-06', "Finalizado");
INSERT INTO pedidos (pedido_id,cliente_id,data_pedido,status) VALUES (56,9,'2023-04-07', "Finalizado");
INSERT INTO pedidos (pedido_id,cliente_id,data_pedido,status) VALUES (57,10,'2023-04-07', "Em Preparação");
INSERT INTO pedidos (pedido_id,cliente_id,data_pedido,status) VALUES (58,11, '2023-04-07', "Finalizado");
INSERT INTO pedidos (pedido_id,cliente_id,data_pedido,status) VALUES (59,12,'2023-04-08', "Em Preparação");
INSERT INTO pedidos (pedido_id,cliente_id,data_pedido,status) VALUES (60,13,'2023-04-08', "Em Preparação");
INSERT INTO pedidos (pedido_id,cliente_id,data_pedido,status) VALUES (61,14,'2023-04-09', "Em Preparação");
INSERT INTO pedidos (pedido_id,cliente_id,data_pedido,status) VALUES (62,15,'2023-04-10', "Pago");
INSERT INTO pedidos (pedido_id,cliente_id,data_pedido,status) VALUES (63,16,'2023-04-10', "Pago");
INSERT INTO pedidos (pedido_id,cliente_id,data_pedido,status) VALUES (64,17,'2023-04-11', "Em Preparação");
INSERT INTO pedidos (pedido_id,cliente_id,data_pedido,status) VALUES (65,18,'2023-04-12', "Finalizado");
INSERT INTO pedidos (pedido_id,cliente_id,data_pedido,status) VALUES (66,19,'2023-04-12', "Finalizado");
INSERT INTO pedidos (pedido_id,cliente_id,data_pedido,status) VALUES (67,20,'2023-04-13', "Finalizado");

INSERT INTO itens_pedidos (item_id,pedido_id,prato_id,quantidade) VALUES (68,48,32,1);
INSERT INTO itens_pedidos (item_id,pedido_id,prato_id,quantidade) VALUES (69,49,33,2);
INSERT INTO itens_pedidos (item_id,pedido_id,prato_id,quantidade) VALUES (70,50,35,2);
INSERT INTO itens_pedidos (item_id,pedido_id,prato_id,quantidade) VALUES (80,51,36,2);
INSERT INTO itens_pedidos (item_id,pedido_id,prato_id,quantidade) VALUES (81,52,38,4);
INSERT INTO itens_pedidos (item_id,pedido_id,prato_id,quantidade) VALUES (82,53,41,2);
INSERT INTO itens_pedidos (item_id,pedido_id,prato_id,quantidade) VALUES (83,54,39,3);
INSERT INTO itens_pedidos (item_id,pedido_id,prato_id,quantidade) VALUES (84,55,36,1);
INSERT INTO itens_pedidos (item_id,pedido_id,prato_id,quantidade) VALUES (85,56,36,1);
INSERT INTO itens_pedidos (item_id,pedido_id,prato_id,quantidade) VALUES (86,55,40,2);
INSERT INTO itens_pedidos (item_id,pedido_id,prato_id,quantidade) VALUES (87,56,41,2);
INSERT INTO itens_pedidos (item_id,pedido_id,prato_id,quantidade) VALUES (88,57,45,1);
INSERT INTO itens_pedidos (item_id,pedido_id,prato_id,quantidade) VALUES (89,58,41,3);
INSERT INTO itens_pedidos (item_id,pedido_id,prato_id,quantidade) VALUES (90,58,44,2);
INSERT INTO itens_pedidos (item_id,pedido_id,prato_id,quantidade) VALUES (91,59,42,2);
INSERT INTO itens_pedidos (item_id,pedido_id,prato_id,quantidade) VALUES (92,59,46,1);
INSERT INTO itens_pedidos (item_id,pedido_id,prato_id,quantidade) VALUES (93,60,32,1);
INSERT INTO itens_pedidos (item_id,pedido_id,prato_id,quantidade) VALUES (94,61,35,2);
INSERT INTO itens_pedidos (item_id,pedido_id,prato_id,quantidade) VALUES (95,62,38,2);
INSERT INTO itens_pedidos (item_id,pedido_id,prato_id,quantidade) VALUES (96,62,44,2);
INSERT INTO itens_pedidos (item_id,pedido_id,prato_id,quantidade) VALUES (97,63,46,3);
INSERT INTO itens_pedidos (item_id,pedido_id,prato_id,quantidade) VALUES (98,64,33,4);
INSERT INTO itens_pedidos (item_id,pedido_id,prato_id,quantidade) VALUES (99,65,36,2);
INSERT INTO itens_pedidos (item_id,pedido_id,prato_id,quantidade) VALUES (100,66,33,4);
INSERT INTO itens_pedidos (item_id,pedido_id,prato_id,quantidade) VALUES (101,67,42,2);
INSERT INTO itens_pedidos (item_id,pedido_id,prato_id,quantidade) VALUES (102,67,47,2);

INSERT INTO pagamentos (pagamento_id,pedido_id,valor_pago,metodo_pagamento,status_pagamento) VALUES (103,48,40.00,"Pix","Pendente");
INSERT INTO pagamentos (pagamento_id,pedido_id,valor_pago,metodo_pagamento,status_pagamento) VALUES (104,49,70.00, "Cartão Debito", "Pendente");
INSERT INTO pagamentos (pagamento_id,pedido_id,valor_pago,metodo_pagamento,status_pagamento) VALUES (105,50,50.00, "Pix", "Pago");
INSERT INTO pagamentos (pagamento_id,pedido_id,valor_pago,metodo_pagamento,status_pagamento) VALUES (106,51,56.00, "Cartão Credito", "Pendente");
INSERT INTO pagamentos (pagamento_id,pedido_id,valor_pago,metodo_pagamento,status_pagamento) VALUES (107,52,200.00,"Cartão Debito", "Pago");
INSERT INTO pagamentos (pagamento_id,pedido_id,valor_pago,metodo_pagamento,status_pagamento) VALUES (108,53,56.00, "Pix", "Pago");
INSERT INTO pagamentos (pagamento_id,pedido_id,valor_pago,metodo_pagamento,status_pagamento) VALUES (109,54,150.00, "Dinheiro","Pago");
INSERT INTO pagamentos (pagamento_id,pedido_id,valor_pago,metodo_pagamento,status_pagamento) VALUES (110,55,28.00, "Pix", "Pago");
INSERT INTO pagamentos (pagamento_id,pedido_id,valor_pago,metodo_pagamento,status_pagamento) VALUES (111,56,56.00, "Cartão Debito", "Pago");
INSERT INTO pagamentos (pagamento_id,pedido_id,valor_pago,metodo_pagamento,status_pagamento) VALUES (112,57,10.00, "Dinheiro", "Pago");
INSERT INTO pagamentos (pagamento_id,pedido_id,valor_pago,metodo_pagamento,status_pagamento) VALUES (113,58,84.00, "Pix", "Pendente");
INSERT INTO pagamentos (pagamento_id,pedido_id,valor_pago,metodo_pagamento,status_pagamento) VALUES (114,59,80.00, "Pix", "Pendente");
INSERT INTO pagamentos (pagamento_id,pedido_id,valor_pago,metodo_pagamento,status_pagamento) VALUES (115,60,40.00, "Cartão Debito", "Pendente");
INSERT INTO pagamentos (pagamento_id,pedido_id,valor_pago,metodo_pagamento,status_pagamento) VALUES (116,61,50.00, "Pix", "Pago");
INSERT INTO pagamentos (pagamento_id,pedido_id,valor_pago,metodo_pagamento,status_pagamento) VALUES (117,62,160.00, "Cartão Credito", "Pago");
INSERT INTO pagamentos (pagamento_id,pedido_id,valor_pago,metodo_pagamento,status_pagamento) VALUES (118,63,60.00, "Pix", "Pago");
INSERT INTO pagamentos (pagamento_id,pedido_id,valor_pago,metodo_pagamento,status_pagamento) VALUES (119,64,140.00, "Cartão Debito", "Pendente");
INSERT INTO pagamentos (pagamento_id,pedido_id,valor_pago,metodo_pagamento,status_pagamento) VALUES (120,65,56.00, "Dinheiro", "Pago");
INSERT INTO pagamentos (pagamento_id,pedido_id,valor_pago,metodo_pagamento,status_pagamento) VALUES (121,66,140.00, "Pix", "Pago");
INSERT INTO pagamentos (pagamento_id,pedido_id,valor_pago,metodo_pagamento,status_pagamento) VALUES (122,67,44.00, "Cartão Debito", "Pago");

INSERT INTO estoque (estoque_id,prato_id, ingrediente, quantidade_disponivel) VALUES (123,32, "Feijão", 20);
INSERT INTO estoque (estoque_id,prato_id, ingrediente, quantidade_disponivel) VALUES (124,32, "Carne de porco", 15);
INSERT INTO estoque (estoque_id,prato_id, ingrediente, quantidade_disponivel) VALUES (125,32, "Arroz", 50);
INSERT INTO estoque (estoque_id,prato_id, ingrediente, quantidade_disponivel) VALUES (126,33, "Massa de lasanha", 30);
INSERT INTO estoque (estoque_id,prato_id, ingrediente, quantidade_disponivel) VALUES (127,33, "Carne moída", 20);
INSERT INTO estoque (estoque_id,prato_id, ingrediente, quantidade_disponivel) VALUES (128,33, "Queijo", 25);
INSERT INTO estoque (estoque_id,prato_id, ingrediente, quantidade_disponivel) VALUES (129,35, "Carne seca", 10);
INSERT INTO estoque (estoque_id,prato_id, ingrediente, quantidade_disponivel) VALUES (130,35, "Mandioca", 30);
INSERT INTO estoque (estoque_id,prato_id, ingrediente, quantidade_disponivel) VALUES (131,36, "Frango", 20);
INSERT INTO estoque (estoque_id,prato_id, ingrediente, quantidade_disponivel) VALUES (132,36, "Cogumelos", 15);
INSERT INTO estoque (estoque_id,prato_id, ingrediente, quantidade_disponivel) VALUES (133,36, "Creme de leite", 10);
INSERT INTO estoque (estoque_id,prato_id, ingrediente, quantidade_disponivel) VALUES (134,38, "Bacalhau", 15);
INSERT INTO estoque (estoque_id,prato_id, ingrediente, quantidade_disponivel) VALUES (135,38, "Batata palha", 25);
INSERT INTO estoque (estoque_id,prato_id, ingrediente, quantidade_disponivel) VALUES (136,38, "Ovos", 30);
INSERT INTO estoque (estoque_id,prato_id, ingrediente, quantidade_disponivel) VALUES (137,39, "Camarão", 30);
INSERT INTO estoque (estoque_id,prato_id, ingrediente, quantidade_disponivel) VALUES (138,39, "Alho", 20);
INSERT INTO estoque (estoque_id,prato_id, ingrediente, quantidade_disponivel) VALUES (139,39, "Óleo", 15);
INSERT INTO estoque (estoque_id,prato_id, ingrediente, quantidade_disponivel) VALUES (140,40, "Carne de carneiro", 10);
INSERT INTO estoque (estoque_id,prato_id, ingrediente, quantidade_disponivel) VALUES (141,40, "Berinjela", 20);
INSERT INTO estoque (estoque_id,prato_id, ingrediente, quantidade_disponivel) VALUES (142,40, "Molho bechamel", 15);
INSERT INTO estoque (estoque_id,prato_id, ingrediente, quantidade_disponivel) VALUES (143,41, "Feijão", 25);
INSERT INTO estoque (estoque_id,prato_id, ingrediente, quantidade_disponivel) VALUES (144,41, "Arroz", 40);
INSERT INTO estoque (estoque_id,prato_id, ingrediente, quantidade_disponivel) VALUES (145,41, "Carne de porco", 15);
INSERT INTO estoque (estoque_id,prato_id, ingrediente, quantidade_disponivel) VALUES (146, 41, "Farofa", 30);
INSERT INTO estoque (estoque_id,prato_id, ingrediente, quantidade_disponivel) VALUES (147,42, "Costelinha de porco", 20);
INSERT INTO estoque (estoque_id,prato_id, ingrediente, quantidade_disponivel) VALUES (148,42, "Molho barbecue", 15);
INSERT INTO estoque (estoque_id,prato_id, ingrediente, quantidade_disponivel) VALUES (149,44, "Café", 25);
INSERT INTO estoque (estoque_id,prato_id, ingrediente, quantidade_disponivel) VALUES (150,44, "Mascarpone", 20);
INSERT INTO estoque (estoque_id,prato_id, ingrediente, quantidade_disponivel) VALUES (151,44, "Cacau", 30);
INSERT INTO estoque (estoque_id,prato_id, ingrediente, quantidade_disponivel) VALUES (152,45, "Leite condensado", 40);
INSERT INTO estoque (estoque_id,prato_id, ingrediente, quantidade_disponivel) VALUES (153,45, "Chocolate", 30);
INSERT INTO estoque (estoque_id,prato_id, ingrediente, quantidade_disponivel) VALUES (154,45, "Granulado", 20);
INSERT INTO estoque (estoque_id,prato_id, ingrediente, quantidade_disponivel) VALUES (155,46, "Leite condensado", 30);
INSERT INTO estoque (estoque_id,prato_id, ingrediente, quantidade_disponivel) VALUES (156,46, "Ovos", 25);
INSERT INTO estoque (estoque_id,prato_id, ingrediente, quantidade_disponivel) VALUES (157,46, "Açúcar", 20);
INSERT INTO estoque (estoque_id,prato_id, ingrediente, quantidade_disponivel) VALUES (158,47, "Queijo cremoso", 15);
INSERT INTO estoque (estoque_id,prato_id, ingrediente, quantidade_disponivel) VALUES (159,47, "Frutas vermelhas", 10);
INSERT INTO estoque (estoque_id, prato_id, ingrediente, quantidade_disponivel) VALUES (160,47, "Biscoito", 30);

SELECT*FROM clientes;

SELECT nome, categoria, preco FROM pratos
WHERE disponibilidade = "Disponivel";

SELECT nome, cargo FROM funcionarios
WHERE cargo = "Garçom";

SELECT*FROM pedidos WHERE status = "Finalizado";

SELECT nome, preco FROM pratos WHERE preco > 30.00;

SELECT pedidos.pedido_id, clientes.nome
FROM pedidos
JOIN clientes ON pedidos.cliente_id = clientes.cliente_id;

SELECT SUM(valor_pago) FROM pagamentos;

SELECT nome, categoria ,preco  FROM pratos
WHERE disponibilidade = "Indisponivel";

SELECT AVG(valor_pago) AS media_valor_pago
FROM pagamentos;

SELECT AVG(quantidade) AS media_quantidade_itens_pedidos
FROM itens_pedidos;

SELECT*FROM pratos WHERE preco BETWEEN "30.00" AND 50.00 
ORDER BY preco DESC;

SELECT AVG(preco) AS media_preco FROM pratos
WHERE categoria = "Tradicional";

SELECT SUM(quantidade_disponivel) FROM estoque;

SELECT SUM(quantidade_disponivel) AS total_ovos
FROM estoque WHERE ingrediente = "ovos";

SELECT SUM(quantidade_disponivel * ingrediente) AS quantidade_disponivel
FROM estoque;

SELECT clientes.nome AS cliente, pratos.nome AS prato
FROM pedidos
INNER JOIN clientes ON pedidos.cliente_id = clientes.cliente_id
INNER JOIN itens_pedidos ON pedidos.pedido_id = pedidos.pedido_id
INNER JOIN pratos ON itens_pedidos.prato_id = pratos.prato_id;

SELECT funcionarios.nome AS garçom, clientes.nome AS cliente
FROM pedidos
INNER JOIN clientes ON pedidos.cliente_id = clientes.cliente_id
INNER JOIN funcionarios ON funcionarios.funcionario_id = funcionarios.funcionario_id
WHERE pedidos.status = "Finalizado";

SELECT clientes.nome AS cliente, pedidos.pedido_id
FROM clientes
LEFT JOIN pedidos ON clientes.cliente_id = pedidos.cliente_id;

SELECT pratos.nome AS pratos, itens_pedidos.pedido_id
FROM pratos
LEFT JOIN itens_pedidos ON pratos.prato_id = itens_pedidos.prato_id;

SELECT clientes.nome AS clientes, pedidos.data_pedido
FROM clientes
LEFT JOIN pedidos ON clientes.cliente_id = pedidos.cliente_id;

SELECT pedidos.pedido_id , pratos.nome AS prato
FROM pedidos
RIGHT JOIN itens_pedidos ON pedidos.pedido_id = itens_pedidos.pedido_id
RIGHT JOIN pratos ON itens_pedidos.prato_id = pratos.prato_id;

SELECT clientes.nome AS clientes, pedidos.pedido_id
FROM clientes
RIGHT JOIN pedidos ON clientes.cliente_id = pedidos.cliente_id
RIGHT JOIN pagamentos ON pedidos.pedido_id = pagamentos.pedido_id
WHERE pagamentos.metodo_pagamento = "Pix";
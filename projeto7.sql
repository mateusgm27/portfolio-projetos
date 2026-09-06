CREATE DATABASE db_gestao_empresarial;
USE db_gestao_empresarial;

CREATE TABLE usuarios(
id_usuario INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(45) NOT NULL,
email VARCHAR(100) NOT NULL,
cargo VARCHAR(50) NOT NULL,
data_criacao DATETIME DEFAULT CURRENT_TIMESTAMP);


CREATE TABLE fornecedores(
id_fornecedor INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(45) NOT NULL,
cnpj VARCHAR(18) NOT NULL,
telefone VARCHAR(15) NOT NULL ,
email VARCHAR(100) NOT NULL);

CREATE TABLE categorias(
id_categoria INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(45) NOT NULL,
descricao VARCHAR(50) NOT NULL );

CREATE TABLE produtos(
id_produto INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(45) NOT NULL,
descricao VARCHAR(50) NOT NULL,
preco_compra DECIMAL (10,2) NOT NULL,
preco_venda DECIMAL (10,2) NOT NULL,
estoque_atual INT NOT NULL,
estoque_minimo INT NOT NULL ,
id_categoria INT NOT NULL,
id_fornecedor INT NOT NULL,
FOREIGN KEY (id_categoria) REFERENCES categorias (id_categoria),
FOREIGN KEY (id_fornecedor) REFERENCES fornecedores(id_fornecedor));

CREATE TABLE vendas(
id_venda INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
data_venda DATETIME NOT NULL ,
id_usuario INT NOT NULL,
valor_total DECIMAL (10,2) NOT NULL,
FOREIGN KEY (id_usuario) REFERENCES usuarios (id_usuario));

CREATE TABLE compras(
id_compra INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
data_compra DATETIME NOT NULL ,
id_fornecedor INT NOT NULL,
id_usuario INT NOT NULL ,
valor_total DECIMAL(10,2) NOT NULL ,
FOREIGN KEY (id_fornecedor) REFERENCES fornecedores (id_fornecedor),
FOREIGN KEY (id_usuario) REFERENCES usuarios (id_usuario));

CREATE TABLE itens_vendas(
id_itens_venda INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
id_venda INT NOT NULL ,
id_produto INT NOT NULL ,
quantidade INT NOT NULL,
preco_unitario DECIMAL (10,2),
FOREIGN KEY (id_venda) REFERENCES vendas (id_venda),
FOREIGN KEY (id_produto) REFERENCES produtos (id_produto));

CREATE TABLE itens_compras(
id_itens_compra INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
id_compra INT NOT NULL,
id_produto INT NOT NULL,
quantidade INT NOT NULL,
preco_unitario DECIMAL (10,2) NOT NULL,
FOREIGN KEY (id_compra) REFERENCES compras (id_compra),
FOREIGN KEY (id_produto) REFERENCES produtos (id_produto));

INSERT INTO usuarios(nome,email,cargo) VALUES ('Leornado Oliveira','leosouza.2606@gmail.com','Vendedor'),
('Gustavo Almeida','gustavo.al0612@gmail.com','Gerente'),
('Marcelo Lima', 'marcelo.li512@gmail.com','Auxiliar de Estoque'),
('Carlos Gonçalves','Carlos.g0102@gmail.com','Vendedor'),
('Mariana Carvalho','mariana.carvalho9398@gmail.com','Gerente'),
('Alessandro Costa','alessandro.7599@gmail.com','Vendedor'),
('Franscisco Dias','franscisco.melo5509@gmai.com','Auxiliar de estoque'),
('Adriana Ferreira','adri.ferreira6495@gmai.com','Administradora'),
('Leandra Mendes','mendesmiller.5090@gmail.com','Admimistradora'),
('Fernando Machado','fernandocordeiro.7194@gmail.com','Vendedor'),
('Marcelo Azevedo','azevedo.3069@gmail.com','Vendedor'),
('Amanda Barbosa','barbosaa.4103@gmail.com','Administradora'),
('Felipe Batista','batista.3201@gmail.com','Vendedor'),
('Beatriz Andrade','andrade.71035@gmail.com','Gerente'),
('João Tavares','tavares.melo@gmail.com','Gerente'),
('Leandra Fonseca','leandra.fon34@gmail.com','Vendedora'),
('Gabriela Xavier','xavier.souza47@gmail.com','Auxiliar de Estoque'),
('Jessica Farias','jessica.fo50@gmail.com','Auxiliar de Estoque'),
('David Lopez','lopezga.78@gmail.com','Auxiliar de Estoque'),
('Sarah Andrade','sarah.ramos6941@gmail.com','Vendedora'),
('James Miller','miller.04@gmail.com','Gerente'),
('Nicholas Gonzalez','gonzalez.2412@gmail.com','Administrador'),
('Paulo Victor','victor.oliveira230689@gmail.com','Administrador'),
('Ricardo Gomes','gomes.freitas450378@gmail.com','Vendedor'),
('Debora Cunha','cunha.cardoso05@gmail.com','Vendedora'),
('Caio Gonçalves','caio.gm2906@gmail.com','Auxiliar de Estoque'),
('Amanda abrão','amanda.farias41@gmail.com','Administradora'),
('Matheus Pereira','matheus.pereira1202@gmail.com','Vendedor'),
('Daniel Costa','costa.her07@gmail.com','Gerente'),
('Michael Garcia','michael.san08@gmail.com','Administrador'),
('Patricia Miller','miller.melo09@gmail.com','Vendedora');

INSERT INTO fornecedores(nome,cnpj,telefone,email) VALUES ('Tech Brasil','11.111.111/0001-01','11999990001','contato@techbrasil@gmail.com'),
('Global Eletronics','22.222.222/0001-02','11999990002','vendasglobaleletronics@gmail.com'),
('Mega Atacado','33.333.333/0001-03','11999990003','atendimento@megaatacado@gmail.com'),
('Pichau Log','44.444./0001-04','4733330004','contato@pichau.com'),
('Kabum Corp','55.555.555/0001-05', '11999990005', 'corp@kabum.com'),
('Dell Store', '66.666.666/0001-06', '08007770006', 'vendas@dell.com'),
('Logitech BR', '77.777.777/0001-07', '11999990007', 'suporte@logitech.com'),
('Razr Brasil', '88.888.888/0001-08', '11999990008', 'vendas@razr.com'),
('Intel Semi', '99.999.999/0001-09', '11999990009', 'contato@intel.com'),
('AMD Distribuidora', '00.000.000/0001-10', '11999990010', 'vendas@amd.com'),
('Samsung Parts', '12.121.212/0001-11', '11999990011', 'contato@samsung.com'),
('LG Displays', '13.131.313/0001-12', '11999990012', 'vendas@lg.com'),
('Kingston Tech', '14.141.414/0001-13', '11999990013', 'vendas@kingston.com'),
('Corsair Gaming', '15.151.151/0001-14', '11999990014', 'sac@corsair.com'),
('Asus Brasil', '16.161.616/0001-15', '11999990015', 'vendas@asus.com'),
('Gigabyte Log', '17.171.171/0001-16', '11999990016', 'contato@gigabyte.com'),
('HyperX Br', '18.181.181/0001-17', '11999990017', 'vendas@hyperx.com'),
('Western Digital', '19.191.191/0001-18', '11999990018', 'suporte@wd.com'),
('Seagate Corp', '21.212.121/0001-19', '11999990019', 'vendas@seagate.com'),
('Crucial Ram', '23.232.323/0001-20', '11999990020', 'vendas@crucial.com'),
('Microsoft Soft', '24.242.424/0001-21', '11999990021', 'vendas@microsoft.com'),
('Adobe Br', '25.252.525/0001-22', '11999990022', 'contato@adobe.com'),
('TP-Link Net', '26.262.626/0001-23', '11999990023', 'vendas@tplink.com'),
('D-Link Brasil', '27.272.727/0001-24', '11999990024', 'suporte@dlink.com'),
('Cisco Systems', '28.282.828/0001-25', '11999990025', 'contato@cisco.com'),
('Nvidia Br', '29.292.929/0001-26', '11999990026', 'vendas@nvidia.com'),
('EVGA Parts', '31.313.131/0001-27', '11999990027', 'vendas@evga.com'),
('MSI Store', '32.323.232/0001-28', '11999990028', 'contato@msi.com'),
('Cooler Master', '34.343.434/0001-29', '11999990029', 'vendas@coolermaster.com'),
('Thermaltake', '35.353.535/0001-30', '11999990030', 'vendas@thermaltake.com');

INSERT INTO categorias (nome, descricao) VALUES 
('Processadores', 'CPUs Intel e AMD'),
('Placas de Vídeo', 'GPUs Nvidia e Radeon'),
('Memória RAM', 'Módulos DDR4 e DDR5'),
('Armazenamento', 'HDs e SSDs'),
('Placas-Mãe', 'Modelos Intel e AMD'),
('Fontes', 'Fontes de alimentação ATX'),
('Gabinetes', 'Gabinetes Gamer e Office'),
('Coolers', 'Air Coolers e Water Coolers'),
('Monitores', 'Telas LED, IPS e Gamer'),
('Teclados', 'Mecânicos e Membrana'),
('Mouses', 'Mouses Gamer e Office'),
('Headsets', 'Fones de ouvido e Microfones'),
('Cadeiras Gamer', 'Conforto para longas horas'),
('Roteadores', 'Equipamentos de rede'),
('Impressoras', 'Jato de tinta e Laser'),
('Software', 'Licenças Windows e Office'),
('Cabos', 'HDMI, DisplayPort e USB'),
('Webcams', 'Câmeras para streaming'),
('Microfones', 'Modelos condensadores'),
('Pendrives', 'Armazenamento portátil'),
('Nobreaks', 'Proteção elétrica'),
('Adaptadores', 'Conversores de vídeo e rede'),
('Pastas Térmicas', 'Resfriamento de CPU'),
('Joysticks', 'Controles para PC'),
('Tapetes (Mousepad)', 'Mousepads Speed e Control'),
('Tablets', 'Modelos para desenho e estudo'),
('Mesas Office', 'Móveis para escritório'),
('Iluminação RGB', 'Fitas led e controladores'),
('Hubs USB', 'Expansores de portas'),
('Suportes', 'Suportes para monitor e gabinete');

INSERT INTO produtos (nome, descricao, preco_compra, preco_venda, estoque_atual, estoque_minimo, id_categoria, id_fornecedor) VALUES 
('Intel Core i5', 'i5-12400F 4.4GHz', 700.00, 1100.00, 15, 5, 1, 9),
('AMD Ryzen 7', 'Ryzen 5700X', 850.00, 1300.00, 10, 3, 1, 10),
('RTX 3060', 'Nvidia 12GB GDDR6', 1600.00, 2200.00, 8, 2, 2, 26),
('GTX 1650', 'Nvidia 4GB GDDR5', 600.00, 950.00, 12, 4, 2, 1),
('RAM 16GB Corsair', 'Vengeance 3200MHz', 250.00, 450.00, 30, 10, 3, 14),
('RAM 8GB Kingston', 'Fury 2666MHz', 120.00, 220.00, 40, 15, 3, 13),
('SSD 1TB Kingston', 'NV2 NVMe Gen4', 280.00, 480.00, 25, 5, 4, 13),
('SSD 480GB Sata', 'Crucial BX500', 140.00, 280.00, 18, 5, 4, 20),
('B550M Asus', 'Placa-Mãe AM4', 550.00, 850.00, 14, 4, 5, 15),
('H610M Gigabyte', 'Placa-Mãe LGA 1700', 480.00, 750.00, 10, 3, 5, 16),
('Fonte 600W EVGA', '80 Plus Bronze', 280.00, 450.00, 20, 5, 6, 27),
('Fonte 750W Corsair', '80 Plus Gold', 450.00, 780.00, 15, 5, 6, 14),
('Gabinete MT-G20', 'Gamer Mid Tower RGB', 180.00, 320.00, 10, 3, 7, 3),
('Water Cooler 240mm', 'Cooler Master RGB', 350.00, 580.00, 7, 2, 8, 29),
('Monitor 24 LG', '75Hz IPS Full HD', 550.00, 890.00, 12, 3, 9, 12),
('Monitor 27 Samsung', '144Hz Curvo', 900.00, 1500.00, 5, 2, 9, 11),
('Teclado G213', 'Logitech Membrana', 180.00, 350.00, 20, 5, 10, 7),
('Teclado BlackWidow', 'Razer Mecânico', 500.00, 950.00, 8, 2, 10, 8),
('Mouse G203', 'Logitech 8000 DPI', 85.00, 160.00, 35, 10, 11, 7),
('Mouse Deathadder', 'Razer Elite', 150.00, 320.00, 15, 5, 11, 8),
('Headset Cloud II', 'HyperX 7.1', 380.00, 650.00, 10, 3, 12, 17),
('Cadeira Alpha', 'Couro Sintético', 700.00, 1200.00, 4, 2, 13, 3),
('Roteador AX1800', 'TP-Link WiFi 6', 280.00, 520.00, 12, 4, 14, 23),
('HD 2TB Seagate', '7200 RPM Barracuda', 220.00, 410.00, 15, 5, 4, 19),
('Webcam C920', 'Logitech Full HD', 280.00, 550.00, 10, 3, 18, 7),
('Microfone Solocast', 'HyperX USB', 250.00, 480.00, 8, 2, 19, 17),
('Pendrive 64GB', 'SanDisk USB 3.0', 30.00, 75.00, 50, 10, 20, 5),
('Nobreak 1200VA', 'APC Bivolt', 550.00, 980.00, 6, 2, 21, 5),
('Mousepad Gigante', '90x40cm Speed', 45.00, 95.00, 30, 10, 25, 4),
('Controle Xbox PC', 'Microsoft Wireless', 250.00, 480.00, 12, 4, 24, 21);


INSERT INTO vendas (data_venda, id_usuario, valor_total) VALUES 
(NOW(), 2, 1100.00), (NOW(), 4, 450.00), (NOW(), 6, 2200.00), (NOW(), 8, 160.00), (NOW(), 10, 1500.00),
(NOW(), 12, 850.00), (NOW(), 13, 350.00), (NOW(), 15, 480.00), (NOW(), 18, 950.00), (NOW(), 20, 1200.00),
(NOW(), 2, 480.00), (NOW(), 4, 280.00), (NOW(), 6, 75.00), (NOW(), 8, 550.00), (NOW(), 10, 320.00),
(NOW(), 12, 890.00), (NOW(), 13, 650.00), (NOW(), 15, 410.00), (NOW(), 18, 480.00), (NOW(), 20, 95.00),
(NOW(), 2, 220.00), (NOW(), 4, 320.00), (NOW(), 6, 520.00), (NOW(), 8, 780.00), (NOW(), 10, 2200.00),
(NOW(), 12, 1100.00), (NOW(), 13, 450.00), (NOW(), 15, 1300.00), (NOW(), 18, 750.00), (NOW(), 20, 450.00);


INSERT INTO compras (data_compra, id_fornecedor, id_usuario, valor_total) VALUES 
(NOW(), 9, 1, 7000.00), (NOW(), 10, 3, 8500.00), (NOW(), 26, 7, 16000.00), (NOW(), 14, 11, 2500.00), (NOW(), 13, 17, 1200.00),
(NOW(), 15, 1, 5500.00), (NOW(), 16, 3, 4800.00), (NOW(), 27, 7, 2800.00), (NOW(), 3, 11, 1800.00), (NOW(), 29, 17, 3500.00),
(NOW(), 12, 1, 5500.00), (NOW(), 11, 3, 9000.00), (NOW(), 7, 7, 1800.00), (NOW(), 8, 11, 5000.00), (NOW(), 17, 17, 3800.00),
(NOW(), 19, 1, 2200.00), (NOW(), 23, 3, 2800.00), (NOW(), 5, 7, 300.00), (NOW(), 21, 11, 2500.00), (NOW(), 4, 17, 450.00),
(NOW(), 1, 1, 6000.00), (NOW(), 2, 3, 16000.00), (NOW(), 14, 7, 4500.00), (NOW(), 13, 11, 2800.00), (NOW(), 20, 17, 1400.00),
(NOW(), 15, 1, 4800.00), (NOW(), 26, 3, 1600.00), (NOW(), 9, 7, 700.00), (NOW(), 10, 11, 850.00), (NOW(), 27, 17, 280.00);

INSERT INTO itens_vendas (id_venda, id_produto, quantidade, preco_unitario) VALUES 
(1, 1, 1, 1100.00), (2, 5, 1, 450.00), (3, 3, 1, 2200.00), (4, 19, 1, 160.00), (5, 16, 1, 1500.00),
(6, 9, 1, 850.00), (7, 17, 1, 350.00), (8, 30, 1, 480.00), (9, 18, 1, 950.00), (10, 22, 1, 1200.00),
(11, 7, 1, 480.00), (12, 8, 1, 280.00), (13, 27, 1, 75.00), (14, 25, 1, 550.00), (15, 13, 1, 320.00),
(16, 15, 1, 890.00), (17, 21, 1, 650.00), (18, 24, 1, 410.00), (19, 26, 1, 480.00), (20, 29, 1, 95.00),
(21, 6, 1, 220.00), (22, 13, 1, 320.00), (23, 23, 1, 520.00), (24, 12, 1, 780.00), (25, 3, 1, 2200.00),
(26, 1, 1, 1100.00), (27, 5, 1, 450.00), (28, 2, 1, 1300.00), (29, 10, 1, 750.00), (30, 11, 1, 450.00);


INSERT INTO itens_compras (id_compra, id_produto, quantidade, preco_unitario) VALUES 
(1, 1, 10, 700.00), (2, 2, 10, 850.00), (3, 3, 10, 1600.00), (4, 5, 10, 250.00), (5, 6, 10, 120.00),
(6, 9, 10, 550.00), (7, 10, 10, 480.00), (8, 11, 10, 280.00), (9, 13, 10, 180.00), (10, 14, 10, 350.00),
(11, 15, 10, 550.00), (12, 16, 10, 900.00), (13, 17, 10, 180.00), (14, 18, 10, 500.00), (15, 21, 10, 380.00),
(16, 24, 10, 220.00), (17, 23, 10, 280.00), (18, 27, 10, 30.00), (19, 30, 10, 250.00), (20, 29, 10, 45.00),
(21, 4, 10, 600.00), (22, 3, 10, 1600.00), (23, 12, 10, 450.00), (24, 7, 10, 280.00), (25, 8, 10, 140.00),
(26, 10, 10, 480.00), (27, 3, 1, 1600.00), (28, 1, 1, 700.00), (29, 2, 1, 850.00), (30, 11, 1, 280.00);

SELECT* FROM produtos WHERE preco_venda BETWEEN 500.00 AND 2000  ORDER BY nome;

SELECT*FROM fornecedores WHERE nome LIKE 'A%'OR nome LIKE  '%s';

SELECT * FROM usuarios 
WHERE cargo IN ('Gerente', 'Vendedor') 
AND YEAR(data_criacao) = 2025;

SELECT id_categoria, AVG(preco_venda) FROM produtos AS media_preco
GROUP BY id_categoria;

SELECT id_fornecedor, COUNT(*) FROM produtos AS total_itens
GROUP BY id_fornecedor;

SELECT SUM(preco_compra * estoque_atual) AS valor_total_estoque FROM produtos;

SELECT produtos.nome, categorias.nome, fornecedores.nome
FROM produtos
INNER JOIN categorias ON produtos.id_categoria = categorias.id_categoria
INNER JOIN fornecedores ON produtos.id_fornecedor = fornecedores.id_fornecedor;

SELECT vendas.id_venda, vendas.valor_total, usuarios.nome
FROM vendas
INNER JOIN usuarios ON vendas.id_usuario = usuarios.id_usuario;

SELECT usuarios.nome, SUM(vendas.valor_total) AS valor_total_vendas
FROM vendas
INNER JOIN usuarios ON vendas.id_usuario = usuarios.id_usuario 
GROUP BY usuarios.nome
ORDER BY valor_total_vendas DESC;

SELECT itens_vendas.id_venda, produtos.nome, itens_vendas.quantidade
FROM itens_vendas
INNER JOIN produtos ON itens_vendas.id_produto = produtos.id_produto;

SELECT usuarios.nome, produtos.nome
FROM usuarios
INNER JOIN vendas ON vendas.id_usuario = usuarios.id_usuario
INNER JOIN itens_vendas ON vendas.id_venda = itens_vendas.id_venda
INNER JOIN produtos ON itens_vendas.id_produto = produtos.id_produto;

SELECT produtos.nome, itens_vendas.quantidade
FROM produtos
LEFT JOIN itens_vendas ON produtos.id_produto = itens_vendas.id_produto;

SELECT fornecedores.nome, produtos.nome
FROM produtos
RIGHT JOIN fornecedores ON produtos.id_fornecedor = fornecedores.id_fornecedor;

SELECT*FROM vendas WHERE data_venda BETWEEN  '2026-01-01' AND '2026-02-28' AND valor_total > 1000;

SELECT nome, email FROM usuarios
WHERE cargo = 'vendedor' OR nome LIKE 'M%';

SELECT id_categoria, SUM(estoque_atual) AS total_estoque
FROM produtos
GROUP BY id_categoria
HAVING SUM(estoque_atual) > 50;

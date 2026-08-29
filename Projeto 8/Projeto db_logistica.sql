CREATE DATABASE db_logistica;
USE db_logistica;

CREATE TABLE clientes(
id_cliente INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(45) NOT NULL,
cpf VARCHAR(14) NOT NULL UNIQUE,
telefone VARCHAR(20) NOT NULL,
endereco VARCHAR(50) NOT NULL,
cep VARCHAR(9) NOT NULL);

CREATE TABLE produtos(
id_produto INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(50) NOT NULL,
categoria VARCHAR(40) NOT NULL ,
preco DECIMAL (10,2) NOT NULL,
peso DECIMAL (6,2) NOT NULL,
estoque INT NOT NULL);


CREATE TABLE motoristas(
id_motorista INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(45) NOT NULL,
telefone VARCHAR(12) NOT NULL,
data_nascimento DATE NOT NULL,
CNH VARCHAR(11) NOT NULL,
Categoria_CNH ENUM('A','B','C','E') NOT NULL,
data_admissao DATE,
status ENUM('Ativo','Ferias','Inativo'));


CREATE TABLE veiculos(
id_veiculo INT PRIMARY KEY AUTO_INCREMENT,
marca VARCHAR(30) NOT NULL,
modelo VARCHAR(45) NOT NULL,
placa VARCHAR(10) UNIQUE NOT NULL,
Categoria_CNH VARCHAR(10) NOT NULL,
capacidade_de_carga DECIMAL (10,2) NOT NULL,
ano INT);

CREATE TABLE pedidos (
    id_pedido INT PRIMARY KEY AUTO_INCREMENT,
    endereco_origem VARCHAR(150) NOT NULL,
    endereco_destino VARCHAR(150) NOT NULL,
    data_pedido DATETIME,
    status ENUM('Pendente', 'Em Processamento', 'Enviado', 'Entregue', 'Cancelado'),
    valor_total DECIMAL(10,2),
    id_cliente INT,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente));

CREATE TABLE itens_pedidos(
id_item INT PRIMARY KEY AUTO_INCREMENT,
id_pedido INT,
id_produto INT,
quantidade INT NOT NULL,
preco_unitario DECIMAL(10,2) NOT NULL,
FOREIGN KEY (id_pedido) REFERENCES pedidos (id_pedido),
FOREIGN KEY (id_produto) REFERENCES produtos (id_produto));


CREATE TABLE entregas(
id_entrega INT PRIMARY KEY AUTO_INCREMENT,
id_pedido INT,
id_motorista INT,
id_veiculo INT,
data_saida DATETIME,
data_entrega DATETIME,
previsao_entrega DATETIME,
status ENUM('pendente', 'preparando', 'enviado', 'em_transito', 'saiu_entrega','entregue','cancelado'),
FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido),
FOREIGN KEY (id_motorista) REFERENCES motoristas(id_motorista),
FOREIGN KEY (id_veiculo) REFERENCES veiculos(id_veiculo));


CREATE TABLE rastreamentos(
id_rastreamento INT PRIMARY KEY AUTO_INCREMENT,
id_entrega INT,
status ENUM ('pendente', 'preparando', 'enviado', 'em_transito', 'saiu_entrega','entregue','cancelado'),
data_Hora DATETIME,
localizacao VARCHAR(100),
codigo_rastreio VARCHAR(13),
FOREIGN KEY (id_entrega) REFERENCES entregas (id_entrega));


INSERT INTO clientes (nome, cpf, telefone, endereco, cep) VALUES
('Mateus Silva', '111.222.333-44', '(61) 98888-0001', 'SQN 212 Bloco A, Brasília-DF', '70864-000'),
('Ana Oliveira', '222.333.444-55', '(11) 97777-0002', 'Av. Paulista, 1000, São Paulo-SP', '01310-100'),
('Lucas Pereira', '333.444.555-66', '(21) 96666-0003', 'Rua Copacabana, 50, Rio de Janeiro-RJ', '22020-001'),
('Carla Souza', '444.555.666-77', '(31) 95555-0004', 'Rua da Bahia, 120, Belo Horizonte-MG', '30160-011'),
('Bruno Santos', '555.666.777-88', '(41) 94444-0005', 'Rua XV de Novembro, Curitiba-PR', '80020-310'),
('Juliana Costa', '666.777.888-99', '(71) 93333-0006', 'Pelourinho, Salvador-BA', '40026-280'),
('Ricardo Alves', '777.888.999-00', '(81) 92222-0007', 'Boa Viagem, Recife-PE', '51011-000'),
('Fernanda Lima', '888.999.000-11', '(91) 91111-0008', 'Av. Nazaré, Belém-PA', '66035-145'),
('Diego Rocha', '999.000.111-22', '(62) 90000-0009', 'Setor Bueno, Goiânia-GO', '74210-060'),
('Patrícia Mello', '000.111.222-33', '(48) 98888-1110', 'Beira Mar Norte, Florianópolis-SC', '88015-700'),
('John Smith', 'US-100200300', '+1 202-555-011', '1600 Pennsylvania Ave NW, DC', '20500'),
('Emily Johnson', 'US-400500600', '+1 212-555-022', '5th Avenue, New York, NY', '10001'),
('Michael Brown', 'US-700800900', '+1 310-555-033', 'Santa Monica Blvd, LA', '90401'),
('Sarah Williams', 'US-111222333', '+1 415-555-044', 'Market St, San Francisco, CA', '94103'),
('David Jones', 'US-444555666', '+1 305-555-055', 'Ocean Drive, Miami, FL', '33139'),
('Jessica Miller', 'US-777888999', '+1 713-555-066', 'Main St, Houston, TX', '77002'),
('Robert Wilson', 'US-222333444', '+1 312-555-077', 'Michigan Ave, Chicago, IL', '60611'),
('Linda Taylor', 'US-555666777', '+1 617-555-088', 'Beacon St, Boston, MA', '02108'),
('William Moore', 'US-888999000', '+1 206-555-099', 'Pike St, Seattle, WA', '98101'),
('Ashley Anderson', 'US-000111222', '+1 404-555-100', 'Peachtree St, Atlanta, GA', '30303'),
('Li Wei', 'CN-123456789', '+86 10-6401-11', 'Wangfujing St, Beijing', '100006'),
('Zhang Yi', 'CN-987654321', '+86 21-6321-22', 'Nanjing Road, Shanghai', '200001'),
('Wang Jun', 'CN-112233445', '+86 20-3813-33', 'Zhujiang New Town, Guangzhou', '510623'),
('Chen Lin', 'CN-556677889', '+86 755-833-44', 'Huaqiangbei, Shenzhen', '518031'),
('Liu Yang', 'CN-998877665', '+86 28-8666-55', 'Chunxi Road, Chengdu', '610016'),
('Zhao Min', 'CN-443322110', '+86 27-8577-66', 'Jianghan Road, Wuhan', '430000'),
('Huang Tao', 'CN-667788990', '+86 29-8721-77', 'Bell Tower, Xi’an', '710001'),
('Zhou Jie', 'CN-223344556', '+86 571-870-88', 'West Lake, Hangzhou', '310000'),
('Wu Song', 'CN-887766554', '+86 25-8330-99', 'Xinjiekou, Nanjing', '210000'),
('Xu Dan', 'CN-101010101', '+86 512-625-00', 'Pingjiang Road, Suzhou', '215000'),
('Diego Armando', 'AR-203040506', '+54 11-4343-11', 'Av. 9 de Julio, Buenos Aires', 'C1043'),
('Camila Fernandez', 'AR-101010100', '+54 341-456-22', 'Av. Pellegrini, Rosario', 'S2000'),
('Sofia Gomez', 'AR-304050607', '+54 351-422-33', 'Av. Colón, Córdoba', 'X5000'),
('Mateo Rossi', 'AR-405060708', '+54 261-423-44', 'Av. San Martín, Mendoza', 'M5500'),
('Lucia Fernandez', 'AR-506070809', '+54 381-430-55', '25 de Mayo, Tucumán', 'T4000'),
('Juan Peron', 'AR-607080910', '+54 221-421-66', 'Calle 7, La Plata', 'B1900'),
('Elena Paz', 'AR-708091011', '+54 387-431-77', 'Caseros, Salta', 'A4400'),
('Carlos Soler', 'AR-809101112', '+54 223-491-88', 'Av. Luro, Mar del Plata', 'B7600'),
('Belén Ortega', 'AR-910111213', '+54 299-442-99', 'Av. Argentina, Neuquén', 'Q8300'),
('Ramiro Diaz', 'AR-121212121', '+54 264-422-00', 'Av. Libertador, San Juan', 'J5400'),
('Mariana Silva', '619.888.877-77', '61988887777', 'SCLN 210, Asa Norte, Brasília-DF', '70751-000'),
('Ricardo Oliveira', '619.777.766-66', '61977776666', 'SQS 305, Asa Sul, Brasília-DF', '70352-000'),
('Beatriz Souza', '119.666.655-55', '11966665555', 'Rua Augusta, 1500, São Paulo-SP', '01305-100'),
('Lucas Mendes', '219.555.544-44', '21955554444', 'Av. Atlântica, Copacabana, Rio de Janeiro-RJ', '22070-000'),
('Alejandro Sanz', 'ES-12345678A', '+34 912 345 678', 'Calle de Alcalá, 45, Madrid, Espanha', '28014'),
('Elena Rodríguez', 'ES-87654321B', '+34 931 876 543', 'Avinguda Diagonal, 123, Barcelona, Espanha', '08008');

INSERT INTO produtos (nome, categoria, preco, peso, estoque) VALUES 
('IPhone Pro Max', 'Eletronicos', 7500.00, 0.22, 50),
('Samsung Galaxy S24 Ultra', 'Eletronicos', 5800.00, 0.23, 30),
('MacBook Air M3', 'Eletronicos', 9500.00, 1.24, 15),
('Kit Maquiagem Completo', 'Beleza', 200.00, 0.50, 50),
('Fone Sony WH-1000XM5', 'Eletronicos', 2100.00, 0.25, 40),
('Mesa de Jantar 6 Cadeiras', 'Casa', 2200.00, 50.00, 5),
('Secador de Cabelo Taiff', 'Beleza', 250.00, 0.90, 40),
('Tapete Sala 2x3m', 'Casa', 300.00, 2.50, 25),
('Nitendo Switch OLED', 'Eletronicos', 2400.00, 0.42, 25),
('Kindle Paperwhite 16GB', 'Eletronicos', 799.00, 0.20, 100),
('Monitor LG Ultrawide 29', 'Eletronicos', 1300.00, 4.50, 20),
('Luminária LED', 'Casa', 120.00, 0.80, 80),
('Teclado Mecânico Keychron', 'Eletronicos', 650.00, 0.90, 35),
('Tênis Nike Air Force 1', 'Moda', 799.90, 0.95, 60),
('Tênis Adidas Ultraboost', 'Moda', 899.00, 0.70, 40),
('Bola de Futebol Adidas Champions', 'Esporte', 199.00, 0.45, 120),
('Luva De Boxe Venum 12oz', 'Esporte', 290.00, 0.80, 20),
('Bicicleta Aro Shimano', 'Esporte', 2200.00, 15.00, 10),
('Capacete Ciclismo Absolute', 'Esporte', 180.00, 0.30, 25),
('Cafeteira Dolce Gusto', 'Eletrodomesticos', 550.00, 2.50, 30),
('Geladeira Brastemp', 'Eletrodomesticos', 3200.00, 60.00, 11),
('Óleo Motor 5W30', 'Automotivo', 45.00, 1.00, 100),
('Microondas Eletrolux', 'Eletrodomesticos', 600.00, 15.00, 20),
('Livro Clean Code', 'Livros', 120.00, 0.60, 30),
('Livro Harry Potter', 'Livros', 80.00, 0.50, 60),
('Livro o Hobbit', 'Livros', 70.00, 0.45, 40),
('Pneu Michelin Aro 15', 'Automotivo', 400.00, 8.00, 20),
('Máquina de Lavar 12kg', 'Eletrodomesticos', 2100.00, 55.00, 10),
('Carrinho Hot Wheels', 'Brinquedos', 15.00, 0.10, 150),
('Boneca Barbie', 'Brinquedos', 120.00, 0.40, 50),
('Lego Classic 500 peças', 'Brinquedos', 300.00, 1.20, 30),
('Ração para Cachorro 10kg', 'Pet', 180.00, 10.00, 25),
('Brinquedo para Gato', 'Pet', 35.00, 0.20, 60),
('Coleira Pet', 'Pet', 25.00, 0.10, 80),
('Café Premium 500g', 'Alimentos', 25.00, 0.50, 100),
('Chocolate Lindt', 'Alimentos', 35.00, 0.20, 80),
('Azeite Extra Virgem', 'Alimentos', 40.00, 0.90, 60),
('Bateria Automotiva', 'Automotivo', 500.00, 12.00, 35),
('PlayStation 5', 'Games', 4500.00, 4.50, 15),
('Cadeira Gamer ThunderX3', 'Games', 1200.00, 18.00, 10),
('Controle PS5 DualSense', 'Games', 400.00, 0.40, 35),
('Headset Gamer HyperX', 'Games', 350.00, 0.60, 45),
('Jogo GTA V', 'Games', 150.00, 0.10, 50),
('Volante Logitech G29', 'Games', 2500.00, 5.00, 10),
('Mouse Gamer Razer', 'Games', 280.00, 0.30, 40),
('Xbox series s', 'Games', 3169.00, 4.20, 25),
('Jogo FIFA 24', 'Games', 300.00, 0.10, 70),
('Perfume Chanel No.5', 'Beleza', 650.00, 0.30, 25),
('Chapinha Gama Italy', 'Beleza', 180.00, 0.70, 35),
('Webcam Full HD Logitech', 'Informatica', 220.00, 0.30, 35),
('Roteador TP-Link AC1200', 'Informatica', 250.00, 0.40, 30),
('Smart TV Samsung 50 4K', 'Eletronicos', 2800.00, 12.00, 20),
('Smartwatch Apple Watch Series 9', 'Eletronicos', 3200.00, 0.20, 25),
('Tablet Samsung Galaxy Tab S9', 'Eletronicos', 4200.00, 0.60, 15),
('Caixa de Som JBL Flip 6', 'Eletronicos', 650.00, 0.55, 40),
('Câmera Canon EOS Rebel T7', 'Eletronicos', 3500.00, 1.20, 10),
('Camisa Oversized One Piece', 'Moda', 32.00, 0.50, 177),
('Camisa Oversized Superman', 'Moda', 41.00, 0.60, 150),
('Jaqueta Jeans Masculina', 'Moda', 180.00, 1.00, 40),
('Vestido Feminino Casual', 'Moda', 120.00, 0.50, 60),
('Relógio Casio', 'Moda', 250.00, 0.30, 35),
('Óculos de Sol Ray-Ban', 'Moda', 600.00, 0.20, 20),
('Boné Adidas', 'Moda', 90.00, 0.15, 50),
('Camisa Argentina Adidas', 'Moda', 200.00, 0.70, 80),
('Camisa Brasil Nike', 'Moda', 250.00, 0.70, 70),
('Esteira Elétrica', 'Esporte', 3500.00, 40.00, 8),
('Halter 10kg', 'Esporte', 120.00, 10.00, 30),
('Corda de Pular', 'Esporte', 30.00, 0.20, 80),
('Chuteira Nike', 'Esporte', 350.00, 0.80, 40),
('Kimono Jiu Jitsu', 'Esporte', 250.00, 1.50, 20),
('Som Automotivo Pioneer', 'Automotivo', 700.00, 3.00, 20),
('Kit Multimídia Carro', 'Automotivo', 1200.00, 4.00, 15),
('Sensor de Ré', 'Automotivo', 150.00, 0.50, 40),
('Capa para Banco', 'Automotivo', 200.00, 2.00, 30),
('Lâmpada LED Automotiva', 'Automotivo', 80.00, 0.20, 60),
('Cama para Cachorro', 'Pet', 120.00, 2.50, 30),
('Areia para Gato', 'Pet', 40.00, 4.00, 50),
('Shampoo Pet', 'Pet', 35.00, 0.50, 60),
('Comedouro Automático', 'Pet', 180.00, 1.50, 25),
('Arranhador para Gato', 'Pet', 150.00, 3.00, 20),
('Arroz 5kg', 'Alimentos', 25.00, 5.00, 100),
('Feijão 1kg', 'Alimentos', 8.00, 1.00, 120),
('Macarrão 500g', 'Alimentos', 5.00, 0.50, 150),
('Leite Integral 1L', 'Alimentos', 6.00, 1.00, 200),
('Refrigerante Coca-Cola 2L', 'Alimentos', 10.00, 2.00, 180),
('Guarda Roupa 6 Portas', 'Casa', 1800.00, 70.00, 8),
('Cama Box Casal', 'Casa', 1500.00, 60.00, 10),
('Ventilador Arno', 'Casa', 200.00, 3.00, 35),
('Espelho Decorativo', 'Casa', 150.00, 2.00, 25),
('Livro Entendendo Algoritmos', 'Livros', 65.00, 0.40, 45),
('Livro O Codificador Limpo', 'Livros', 85.00, 0.45, 30),
('Livro O Senhor dos Anéis', 'Livros', 110.00, 1.10, 25),
('Livro Arquitetura Limpa', 'Livros', 95.00, 0.55, 20),
('Livro Padrões de Projeto', 'Livros', 130.00, 0.70, 15),
('Protetor Solar La Roche-Posay', 'Beleza', 89.90, 0.15, 60),
('Sérum Facial Vitamina C', 'Beleza', 60.00, 0.10, 80),
('Base Líquida Boca Rosa', 'Beleza', 55.00, 0.12, 50),
('Máscara de Cílios Maybelline', 'Beleza', 45.00, 0.08, 70),
('Kit Pincéis de Maquiagem', 'Beleza', 75.00, 0.25, 40),
('SSD NVMe 1TB Kingston', 'Informatica', 380.00, 0.10, 50),
('Memória RAM 16GB DDR4', 'Informatica', 260.00, 0.12, 40),
('Massinha Play-Doh Kit', 'Brinquedos', 45.00, 0.50, 50),
('Pelúcia Pokémon Pikachu', 'Brinquedos', 85.00, 0.30, 35),
('Cabo HDMI 2.1 4K 2m', 'Informatica', 45.00, 0.15, 90),
('Hub USB-C 7 em 1', 'Informatica', 140.00, 0.20, 30),
('Suporte Gamer para Controle e Fone', 'Games', 49.90, 0.60, 48),
('Video Game Stick 20000 Jogos', 'Games', 104.50, 0.40, 60),
('Capa Case Silicone Controle PS5', 'Games', 16.99, 0.08, 100),
('Pista Hot Wheels Loop', 'Brinquedos', 160.00, 1.10, 25),
('Jogo Imagem & Ação', 'Brinquedos', 99.00, 0.80, 30),
('Quebra-Cabeça 1000 Peças', 'Brinquedos', 60.00, 0.60, 40),
('Suporte para Notebook Alumínio', 'Informatica', 95.00, 0.60, 45),
('Cortina Blackout', 'Casa', 180.00, 1.50, 40),
('Liquidificador Mondial', 'Eletrodomesticos', 150.00, 2.00, 50),
('Batedeira Arno', 'Eletrodomesticos', 300.00, 3.50, 25),
('Fogão 4 Bocas', 'Eletrodomesticos', 900.00, 30.00, 15),
('Aspirador de Pó Electrolux', 'Eletrodomesticos', 450.00, 4.00, 20),
('Purificador de Água', 'Eletrodomesticos', 700.00, 6.00, 18),
('Impressora HP DeskJet 2774', 'Informatica', 350.00, 3.50, 20),
('Panela de Pressão 5L', 'Casa', 120.00, 2.80, 40),
('Mochila Executiva para Notebook', 'Moda', 150.00, 1.20, 30),
('Cadeira de Escritório', 'Casa', 450.00, 8.00, 20),
('Power Bank 20000mAh', 'Eletronicos', 180.00, 0.60, 50);

INSERT INTO motoristas (nome, telefone, data_nascimento, cnh, categoria_cnh, data_admissao, status) VALUES
('Carlos Oliveira', '61988880001', '1988-05-15', '12345678901', 'B', '2020-01-10', 'Ativo'),
('Marcos Souza', '11977770002', '1992-08-22', '23456789012', 'B', '2021-03-22', 'Ativo'),
('André Santos', '21966660003', '1984-11-05', '34567890123', 'B', '2019-11-05', 'Ferias'),
('Paulo Lima', '31955550004', '1980-02-10', '45678901234', 'B', '2022-06-15', 'Ativo'),
('Roberto Rocha', '41944440005', '1997-01-20', '56789012345', 'A', '2023-01-20', 'Inativo'),
('Fernando Costa', '71933330006', '1990-09-30', '67890123456', 'A', '2020-09-30', 'Ativo'),
('Sergio Alves', '81922220007', '1985-05-18', '78901234567', 'E', '2021-05-18', 'Ativo'),
('Ricardo Mello', '91911110008', '1982-12-12', '89012345678', 'E', '2018-12-12', 'Ferias'),
('Luciano Ferreira', '62900000009', '1994-05-01', '90123456789', 'C', '2023-05-01', 'Ativo'),
('Gilberto Silva', '48988881110', '1977-08-20', '01234567890', 'E', '2015-08-20', 'Ativo'),
('Wesley Nobre', '61912345678', '1999-01-15', '11223344556', 'B', '2024-01-15', 'Ativo'),
('Fabrício Barreira', '11922334455', '1995-11-20', '22334455667', 'A', '2022-11-20', 'Ativo'),
('Renato Gonçalves', '51933445566', '1971-05-05', '33445566778', 'E', '2010-05-05', 'Ativo'),
('Tiago Santos', '11944556677', '1987-08-10', '44556677889', 'B', '2023-08-10', 'Inativo'),
('Alex Escobar', '21955667788', '1981-12-01', '55667788990', 'C', '2021-12-01', 'Ativo'),
('James Miller', '1202555011', '1986-02-15', '99887766554', 'E', '2021-02-15', 'Ativo'),
('David Wilson', '1212555022', '1993-07-01', '88776655443', 'E', '2022-07-01', 'Ativo'),
('John Davis', '1310555033', '1989-05-10', '77665544332', 'E', '2019-05-10', 'Ferias'),
('Robert Clark', '1415555044', '1981-10-25', '66554433221', 'E', '2020-10-25', 'Ativo'),
('Michael Lewis', '1305555055', '1995-02-14', '55443322110', 'C', '2023-02-14', 'Ativo'),
('William Walker', '1713555066', '1988-11-30', '44332211009', 'A', '2021-11-30', 'Inativo'),
('Richard Hall', '1312555077', '1984-06-20', '33221100998', 'E', '2018-06-20', 'Ativo'),
('Joseph Young', '1617555088', '1992-09-05', '22110099887', 'B', '2022-09-05', 'Ativo'),
('Thomas King', '1206555099', '1987-12-01', '11009988776', 'E', '2019-12-01', 'Ativo'),
('Charles Wright', '1404555100', '1979-04-12', '00998877665', 'C', '2017-04-12', 'Ferias'),
('Li Wei', '861001001001', '1991-03-10', 'CN123456001', 'C', '2021-03-10', 'Ativo'),
('Zhang Yong', '861001001002', '1986-07-15', 'CN123456002', 'E', '2019-07-15', 'Ativo'),
('Wang Lei', '861001001003', '1993-01-20', 'CN123456003', 'C', '2022-01-20', 'Ativo'),
('Chen Hao', '861001001004', '1981-11-05', 'CN123456004', 'E', '2018-11-05', 'Ferias'),
('Liu Fang', '861001001005', '1997-04-12', 'CN123456005', 'B', '2023-04-12', 'Ativo'),
('Zhao Ming', '861001001006', '1988-06-25', 'CN123456006', 'C', '2020-06-25', 'Ativo'),
('Sun Jian', '861001001007', '1984-09-09', 'CN123456007', 'E', '2017-09-09', 'Ativo'),
('Xu Peng', '861001001008', '1995-08-18', 'CN123456008', 'B', '2022-08-18', 'Inativo'),
('Huang Tao', '861001001009', '1990-12-30', 'CN123456009', 'C', '2021-12-30', 'Ativo'),
('Guo Lin', '861001001010', '1987-02-14', 'CN123456010', 'E', '2019-02-14', 'Ativo'),
('Juan Perez', '5411001001', '1989-05-10', 'AR12345001', 'C', '2020-05-10', 'Ativo'),
('Carlos Gomez', '5411001002', '1982-09-22', 'AR12345002', 'E', '2018-09-22', 'Ativo'),
('Luis Fernandez', '5411001003', '1996-01-05', 'AR12345003', 'B', '2023-01-05', 'Ativo'),
('Miguel Rodriguez', '5411001004', '1985-06-17', 'AR12345004', 'C', '2021-06-17', 'Ferias'),
('Diego Martinez', '5411001005', '1991-11-11', 'AR12345005', 'E', '2019-11-11', 'Ativo'),
('Pablo Sanchez', '5411001006', '1987-03-03', 'AR12345006', 'C', '2020-03-03', 'Ativo'),
('Andres Lopez', '5411001007', '1998-07-07', 'AR12345007', 'B', '2022-07-07', 'Inativo');

INSERT INTO veiculos (marca, modelo, placa, tipo_veiculo, capacidade_de_carga, ano) VALUES 
('Honda', 'CG 160 Fan', 'ABC1D23', 'Moto', 160.00, 2022),
('Yamaha', 'Factor 150', 'BRA2E45', 'Moto', 150.00, 2021),
('Honda', 'CB 300F Twister', 'KLY3F67', 'Moto', 180.00, 2023),
('Yamaha', 'Lander 250', 'MEX4G89', 'Moto', 170.00, 2022),
('Shineray', 'Worker 125', 'ARG5H01', 'Moto', 150.00, 2020),
('BMW', 'G 310 GS', 'USA6I12', 'Moto', 200.00, 2023),
('Kawasaki', 'Versys-X 300', 'CHN7J34', 'Moto', 190.00, 2022),
('Honda', 'PCX 160', 'DFB8K56', 'Moto', 150.00, 2024),
('Yamaha', 'NMAX 160', 'SP9L78', 'Moto', 150.00, 2023),
('Suzuki', 'V-Strom 650', 'RJ0M90', 'Moto', 210.00, 2021),
('Fiat', 'Fiorino Endurance', 'MCO1A22', 'Carro', 650.00, 2022),
('Fiat', 'Fiorino Endurance', 'MCO1A23', 'Carro', 650.00, 2023),
('Renault', 'Kangoo E-Tech', 'REN2B44', 'Carro', 800.00, 2024),
('Peugeot', 'Partner Rapid', 'PEU3C66', 'Carro', 650.00, 2023),
('Volkswagen', 'Saveiro Robust', 'VW4D88', 'Carro', 700.00, 2022),
('Chevrolet', 'Montana Premier', 'CH5E11', 'Carro', 750.00, 2023),
('Toyota', 'Hilux CS', 'TOY6F33', 'Carro', 1000.00, 2022),
('Ford', 'Ranger XL', 'FOR7G55', 'Carro', 1100.00, 2021),
('Mercedes-Benz', 'Vito Cargo', 'MBW8H77', 'Carro', 1200.00, 2022),
('Nissan', 'Frontier S', 'NIS9I99', 'Carro', 1050.00, 2023),
('Hyundai', 'HR Bau', 'HYU0J10', 'Carro', 1800.00, 2021),
('Kia', 'Bongo K2500', 'KIA1K21', 'Carro', 1800.00, 2022),
('Citroën', 'Jumpy Cargo', 'CIT2L32', 'Carro', 1500.00, 2023),
('Iveco', 'Daily City 30-130', 'IVE3M43', 'Carro', 1300.00, 2021),
('Ram', 'Classic 1500', 'RAM4N54', 'Carro', 1000.00, 2024),
('Mercedes-Benz', 'Accelo 1016', 'ACC5O65', 'Caminhão', 8000.00, 2021),
('Volkswagen', 'Delivery 9.170', 'DEL6P76', 'Caminhão', 9000.00, 2022),
('Ford', 'Cargo 816', 'CAR7Q87', 'Caminhão', 8000.00, 2019),
('Iveco', 'Tector 11-190', 'TEC8R98', 'Caminhão', 11000.00, 2022),
('Mercedes-Benz', 'Atego 2426', 'ATE9S09', 'Caminhão', 24000.00, 2021),
('Volvo', 'VM 270', 'VOL0T10', 'Caminhão', 27000.00, 2022),
('Scania', 'P280 B6x2', 'SCA1U21', 'Caminhão', 28000.00, 2023),
('DAF', 'LF 210', 'DAF2V32', 'Caminhão', 12000.00, 2022),
('MAN', 'TGL 12.190', 'MAN3W43', 'Caminhão', 12000.00, 2021),
('Volvo', 'FH 540 Globetrotter', 'FH4X54', 'Caminhão', 45000.00, 2024),
('Scania', 'R450 Highline', 'R455Y65', 'Caminhão', 45000.00, 2023),
('Mercedes-Benz', 'Actros 2651', 'ACT6Z76', 'Caminhão', 45000.00, 2022),
('Iveco', 'S-Way 540', 'SWA7A87', 'Caminhão', 45000.00, 2024),
('Volkswagen', 'Meteor 28.460', 'MET8B98', 'Caminhão', 45000.00, 2023),
('Volvo', 'FMX 460', 'FMX9C09', 'Caminhão', 32000.00, 2021),
('Mercedes-Benz', 'Sprinter 415', 'VSX1A22', 'Van', 1500.00, 2022),
('Renault', 'Master Grand Volume', 'FAN2B33', 'Van', 1600.00, 2023),
('Iveco', 'Daily Glass', 'HAN3C44', 'Van', 1800.00, 2021),
('Ford', 'Transit Vidrada', 'ZAD9L55', 'Van', 1400.00, 2022),
('Fiat', 'Scudo Cargo', 'VQK5E66', 'Van', 1500.00, 2024);

INSERT INTO pedidos (endereco_origem, endereco_destino, data_pedido, status, valor_total, id_cliente) VALUES
('Centro de Distribuição DF','SQN 212,Brasilia-DF','2026-01-12','Entregue',1500.00,1),
('Porto de Santos-SP','Av.Paulista,São Paulo-SP','2026-01-14','Entregue',3200.00,2),
('CD Logistica Rio','Copacabana Rio de Janeiro','2026-01-14','Entregue',800.00,3),
('Matriz BH','Rua Da Bahia,Belo Horizonte','2026-01-15','Entregue',2200.00,4),
('CD Sul Curitiba','Rua XV De Novembro,Curitiba','2026-01-15','Entregue',950.00,5),
('Porto De Salvador','Pelourinho,Salvador-BA','2026-01-17','Entregue',400.00,6),
('Distribuidora Recife','Boa Viagem, Recife-PE','2026-01-17','Entregue',1800.00,7),
('CD Norte Belém','Av. Nazaré, Belém-PA','2026-01-18','Entregue',600.00,8),
('Hub Centro-Oeste','Setor Bueno, Goiânia-GO','2026-01-18','Entregue',2100.00,9),
('CD Florianópolis','Beira Mar, Florianópolis','2026-01-18','Entregue',750.00,10),
('Miami Export Hub','Washington DC','2026-01-19','Enviado',5000.00,11),
('New York Central Port','Manhattan, NY','2026-01-19','Enviado',4200.00,12),
('LA Logistics Center','Santa Monica, CA','2026-01-20','Enviado',3800.00,13),
('SF Tech Shipments','Market St, San Francisco','2026-01-20','Enviado',2600.00,14),
('Miami Export Hub','Ocean Drive, Miami','2026-01-20','Enviado',3100.00,15),
('Houston Oil & Gas Hub','Main St, Houston','2026-01-20','Enviado',2800.00,16),
('Chicago Rail Terminal','Michigan Ave, Chicago','2026-01-20','Enviado',1900.00,17),
('Boston Port','Beacon St, Boston','2026-02-21','Pendente',1200.00,18),
('Seattle Air Cargo','Pike St, Seattle','2026-01-21','Enviado',3300.00,19),
('Atlanta Hub','Peachtree St, Atlanta','2026-01-25','Pendente',900.00,20),
('Beijing Industrial Park','Wangfujing St, Beijing','2026-01-25','Enviado',4500.00,21),
('Shanghai Port','Nanjing Road, Shanghai','2026-01-26','Enviado',4700.00,22),
('Guangzhou Export Zone','Zhujiang, Guangzhou','2026-01-26','Enviado',3600.00,23),
('Shenzhen Tech Hub','Huaqiangbei, Shenzhen','2026-01-31','Pendente',2900.00,24),
('Chengdu Logistics','Chunxi Road, Chengdu','2026-02-04','Pendente',1500.00,25),
('Wuhan Terminal','Jianghan Road, Wuhan','2026-02-04','Pendente',1800.00,26),
('Xi’an Logistics','Bell Tower, Xi’an','2026-02-06','Pendente',2000.00,27),
('Hangzhou E-commerce Hub','West Lake, Hangzhou','2026-02-08','Pendente',2100.00,28),
('Nanjing Port','Xinjiekou, Nanjing','2026-02-08','Pendente',1750.00,29),
('Suzhou Industrial Zone','Pingjiang Road, Suzhou','2026-02-10','Pendente',1600.00,30),
('Buenos Aires Central','Av. 9 de Julio, BsAs','2026-02-10','Enviado',1300.00,31),
('Rosario Terminal','Av. Pellegrini, Rosario','2026-02-14','Enviado',900.00,32),
('Cordoba Hub','Av. Colón, Córdoba','2026-02-14','Pendente',1100.00,33),
('Mendoza Wine Logistics','Av. San Martín, Mendoza','2026-02-14','Pendente',1400.00,34),
('Tucuman Air Cargo','25 de Mayo, Tucumán','2026-02-15','Pendente',800.00,35),
('La Plata Port','Calle 7, La Plata','2026-02-17','Pendente',950.00,36),
('Salta Terminal','Caseros, Salta','2026-02-17','Pendente',1200.00,37),
('Mar del Plata Hub','Av. Luro, Mar del Plata','2026-02-19','Pendente',1000.00,38),
('Neuquén Energy Hub','Av. Argentina, Neuquén','2026-02-19','Pendente',1700.00,39),
('San Juan Logistics','Av. Libertador, San Juan','2026-02-22','Pendente',1600.00,40),
('CD Brasília Central', 'SCLN 210, Brasília-DF', '2026-03-29', 'Pendente', 1125.00, 41),
('CD Brasília Central', 'SQS 305, Brasília-DF', '2026-03-29', 'Pendente', 890.00, 42),
('Hub São Paulo', 'Rua Augusta, São Paulo-SP', '2026-03-29', 'Pendente', 350.00, 43),
('CD Rio de Janeiro', 'Av. Atlântica, Rio de Janeiro-RJ', '2026-03-29', 'Pendente', 280.00, 44),
('Hub Logística Internacional', 'Madrid, Espanha', '2026-03-29', 'Pendente', 2500.00, 45),
('Hub Logística Internacional', 'Barcelona, Espanha', '2026-03-29', 'Pendente', 1800.00, 46);

INSERT INTO itens_pedidos (id_pedido, id_produto, quantidade, preco_unitario) VALUES
(1,1,1, 7500.00), (1,9,1, 2400.00), (1,5,1, 2100.00),
(2,2,1, 5800.00), (2,7,1, 250.00), (2,10,2, 799.00),
(3,9,1, 2400.00), (3,12,2, 120.00),
(4,6,1, 2200.00), (4,8,2, 300.00),
(5,14,1, 799.90), (5,15,1, 899.00), (5,19,1, 180.00),
(6,7,1, 250.00), (6,19,2, 180.00),
(7,3,1, 9500.00),
(8,12,2, 120.00), (8,13,1, 650.00),
(9,18,1, 2200.00),
(10,9,1, 2400.00), (10,14,1, 799.90), (10,34,1, 25.00),
(11,1,1, 7500.00), (11,5,1, 2100.00),
(12,2,1, 5800.00), (12,9,1, 2400.00),
(13,3,1, 9500.00), (13,13,2, 650.00),
(14,11,1, 1300.00), (14,15,1, 899.00),
(15,5,1, 2100.00), (15,36,4, 35.00),
(16,20,1, 550.00), (16,27,2, 400.00),
(17,24,1, 120.00),
(18,25,1, 80.00), (18,63,1, 90.00),
(19,39,1, 4500.00),
(20,13,1, 650.00),
(21,41,1, 400.00),
(22,42,1, 350.00),
(23,43,1, 150.00),
(24,44,1, 2500.00), (24,26,2, 70.00),
(25,45,1, 280.00),
(26,46,1, 3169.00),
(27,47,1, 300.00),
(28,48,1, 650.00),
(29,49,1, 180.00), (29,64,2, 200.00),
(30,50,1, 220.00), (30,52,1, 2800.00), (30,61,1, 250.00),
(31,60,2, 120.00), (31,70,2, 700.00),
(32,61,1, 250.00),
(33,62,1, 600.00),
(34,63,1, 90.00),
(35,64,1, 200.00), (35,32,1, 180.00),
(36,65,1, 250.00),
(37,66,1, 3500.00), (37,46,1, 3169.00),
(38,67,1, 120.00), (38,81,2, 25.00), (38,78,1, 35.00), (38,82,3, 8.00), (38,83,2, 5.00),
(39,68,1, 30.00), (39,33,2, 35.00), (39,27,4, 400.00),
(40,69,1, 350.00), (40,35,3, 25.00),
(41,59,1, 180.00), (41,57,2, 32.00),
(42,88,1, 200.00),
(43,77,1, 40.00), (43,27,2, 400.00),
(44,9,1, 2400.00),
(45,13,2, 650.00), (45,40,1, 1200.00),
(46,50,2, 220.00), (46,85,4, 1800.00), (46,73,2, 150.00), (46,95,2, 350.00);



INSERT INTO entregas (id_pedido, id_motorista, id_veiculo, data_saida, data_entrega, previsao_entrega, status) VALUES

(1,1,26,'2026-01-12 08:00:00','2026-01-13 10:00:00','2026-01-13 18:00:00','entregue'),
(2,2,27,'2026-01-14 09:00:00','2026-01-15 11:00:00','2026-01-15 18:00:00','entregue'),
(3,3,28,'2026-01-14 08:30:00','2026-01-15 09:30:00','2026-01-15 12:00:00','entregue'),
(4,4,29,'2026-01-15 07:50:00','2026-01-16 10:10:00','2026-01-16 15:00:00','entregue'),
(5,5,30,'2026-01-15 08:10:00','2026-01-16 11:00:00','2026-01-16 17:00:00','entregue'),
(6,6,31,'2026-01-17 07:40:00','2026-01-18 10:20:00','2026-01-18 18:00:00','entregue'),
(7,7,32,'2026-01-17 08:00:00','2026-01-18 11:30:00','2026-01-18 18:00:00','entregue'),
(8,8,33,'2026-01-18 08:30:00','2026-01-19 12:00:00','2026-01-19 18:00:00','entregue'),
(9,9,34,'2026-01-18 09:00:00','2026-01-19 11:40:00','2026-01-19 18:00:00','entregue'),
(10,10,35,'2026-01-18 09:20:00','2026-01-19 13:00:00','2026-01-19 18:00:00','entregue'),
(11,11,11,'2026-01-19 08:00:00', NULL, '2026-01-22 18:00:00', 'em_transito'),
(12,12,12,'2026-01-19 10:00:00', NULL, '2026-01-21 18:00:00', 'em_transito'),
(13,13,13,'2026-01-20 08:00:00', NULL, '2026-01-23 18:00:00', 'em_transito'),
(14,14,14,'2026-01-20 09:00:00', NULL, '2026-01-23 18:00:00', 'em_transito'),
(15,15,15,'2026-01-20 09:30:00', NULL, '2026-01-23 18:00:00', 'em_transito'),
(16,16,16,'2026-01-20 10:00:00', NULL, '2026-01-23 18:00:00', 'em_transito'),
(17,17,17,'2026-01-20 10:30:00', NULL, '2026-01-23 18:00:00', 'em_transito'),
(18,18,18, NULL, NULL, '2026-02-25 18:00:00', 'pendente'),
(19,19,19,'2026-01-21 08:00:00', NULL, '2026-01-24 18:00:00', 'em_transito'),
(20,20,20, NULL, NULL, '2026-01-30 18:00:00', 'preparando'),
(21,21,21,'2026-01-25 08:00:00', NULL, '2026-01-28 18:00:00', 'em_transito'),
(22,22,22,'2026-01-26 08:00:00', NULL, '2026-01-29 18:00:00', 'em_transito'),
(23,23,23,'2026-01-26 09:00:00', NULL, '2026-01-29 18:00:00', 'em_transito'),
(24,24,24, NULL, NULL, '2026-02-10 18:00:00', 'pendente'),
(25,25,25, NULL, NULL, '2026-02-10 18:00:00', 'pendente'),
(26,26,26, NULL, NULL, '2026-02-10 18:00:00', 'pendente'),
(27,27,27, NULL, NULL, '2026-02-10 18:00:00', 'pendente'),
(28,28,28, NULL, NULL, '2026-02-10 18:00:00', 'pendente'),
(29,29,29, NULL, NULL, '2026-02-10 18:00:00', 'pendente'),
(30,30,30, NULL, NULL, '2026-02-10 18:00:00', 'pendente'),
(31,31,31,'2026-02-10 08:00:00', NULL, '2026-02-13 18:00:00', 'em_transito'),
(32,32,32,'2026-02-14 08:00:00', NULL, '2026-02-17 18:00:00', 'em_transito'),
(33,33,33, NULL, NULL, '2026-02-20 18:00:00', 'pendente'),
(34,34,34, NULL, NULL, '2026-02-20 18:00:00', 'pendente'),
(35,35,35, NULL, NULL, '2026-02-20 18:00:00', 'pendente'),
(36,36,41,'2026-03-29 08:00:00', NULL, '2026-03-31 18:00:00', 'em_transito'),
(37,37,42,'2026-03-29 08:30:00', NULL, '2026-03-30 18:00:00', 'em_transito'),
(38,38,43,'2026-03-29 09:00:00', NULL, '2026-03-30 18:00:00', 'em_transito'),
(39,39,44,'2026-03-29 09:15:00', NULL, '2026-03-30 18:00:00', 'em_transito'),
(40,40,45,'2026-03-29 10:00:00', NULL, '2026-03-31 18:00:00', 'em_transito'),
(41,11,41,'2026-03-29 10:00:00', NULL, '2026-03-30 14:00:00', 'em_transito'),
(42,12,42,'2026-03-29 11:00:00', NULL, '2026-03-31 12:00:00', 'em_transito'),
(43,13,43, NULL, NULL, '2026-04-02 18:00:00', 'pendente'),
(44,15,44,'2026-03-29 12:00:00', NULL, '2026-03-30 18:00:00', 'em_transito'),
(45,10,45,'2026-03-29 14:00:00', NULL, '2026-04-05 18:00:00', 'em_transito'),
(46,9,45,'2026-03-29 14:30:00', NULL, '2026-04-05 18:00:00', 'em_transito');

INSERT INTO rastreamentos (id_entrega, status, data_hora, localizacao, codigo_rastreio) VALUES
(1,'em_transito','2026-01-12 08:00:00','Centro de Distribuição DF', 'BR10001001LOG'),
(1,'saiu_entrega','2026-01-12 12:00:00','Brasília-DF', 'BR10001001LOG'),
(1,'entregue','2026-01-13 10:00:00','Destino final', 'BR10001001LOG'),
(2,'em_transito','2026-01-14 09:00:00','Porto de Santos', 'BR20002002LOG'),
(2,'saiu_entrega','2026-01-14 14:00:00','São Paulo-SP', 'BR20002002LOG'),
(2,'entregue','2026-01-15 11:00:00','Destino final', 'BR20002002LOG'),
(11,'em_transito','2026-01-19 08:00:00','Miami Export Hub', 'US11001100LOG'),
(11,'saiu_entrega','2026-01-20 09:30:00','Washington DC', 'US11001100LOG'),
(12,'em_transito','2026-01-19 10:00:00','New York Port', 'US12001200LOG'),
(12,'saiu_entrega','2026-01-20 11:00:00','Manhattan', 'US12001200LOG'),
(36, 'em_transito', '2026-03-29 08:00:00', 'Centro de Distribuição Brasília', 'BR36003600LOG'),
(37, 'em_transito', '2026-03-29 08:30:00', 'Centro de Distribuição Brasília', 'BR37003700LOG'),
(38, 'em_transito', '2026-03-29 09:00:00', 'Hub São Paulo', 'BR38003800LOG'),
(39, 'em_transito', '2026-03-29 09:15:00', 'CD Rio de Janeiro', 'BR39003900LOG'),
(40, 'em_transito', '2026-03-29 10:00:00', 'Aeroporto Internacional (Carga)', 'BR40004000LOG'),
(41, 'em_transito', '2026-03-29 10:30:00', 'CD Brasília - Processando', 'BR41004100LOG'),
(44, 'em_transito', '2026-03-29 12:00:00', 'CD Brasília - Saindo para entrega', 'BR44004400LOG'),
(45, 'em_transito', '2026-03-29 14:00:00', 'Terminal Internacional - Madrid', 'ES45004500LOG'),
(46, 'em_transito', '2026-03-29 14:30:00', 'Terminal Internacional - Barcelona', 'ES46004600LOG');

SELECT*FROM clientes
WHERE nome LIKE '%Silva';

SELECT*FROM clientes
WHERE cpf = '111.222.333-44';

SELECT nome, estoque
FROM produtos
WHERE estoque < 20;


SELECT*FROM produtos
WHERE categoria = 'Eletronicos' 
ORDER BY preco DESC;


SELECT*FROM entregas
WHERE data_saida BETWEEN '2026-01-01' AND '2026-01-20';

SELECT*FROM veiculos 
WHERE placa LIKE '%21';

SELECT nome , telefone 
FROM motoristas
WHERE status = 'Ativo';

SELECT*FROM produtos 
ORDER BY preco ASC LIMIT 5;

SELECT*FROM clientes
WHERE endereco LIKE '%Brasilia%';

SELECT*FROM produtos 
WHERE categoria IN ('Moda', 'Esporte');

SELECT nome , peso 
FROM produtos WHERE peso BETWEEN 0.50 AND 5.00;

SELECT nome, status 
FROM motoristas WHERE status IN ('Ferias', 'Inativo');

SELECT*FROM veiculos 
ORDER BY tipo_veiculo ASC;


SELECT 
nome 
FROM motoristas 
ORDER BY data_nascimento ASC 
LIMIT 3;

SELECT id_pedido FROM pedidos ORDER BY id_pedido DESC LIMIT 10;


SELECT id_entrega, id_pedido FROM entregas ORDER BY id_entrega DESC LIMIT 10;

SELECT c.nome, p.id_pedido
FROM pedidos AS p
INNER JOIN clientes AS c ON c.id_cliente = p.id_cliente;

SELECT i.id_pedido, prod.nome AS produto , i.quantidade, i.preco_unitario
FROM itens_pedidos AS i
INNER JOIN produtos AS prod ON prod.id_produto = i.id_produto;

SELECT e.id_pedido, m.nome
FROM entregas AS e
INNER JOIN motoristas AS m ON m.id_motorista = e.id_motorista;

SELECT e.id_entrega , v.modelo
FROM entregas AS e
INNER JOIN veiculos AS v ON v.id_veiculo = e.id_veiculo;

SELECT r.codigo_rastreio , e.status
FROM rastreamentos AS r
INNER JOIN entregas AS e ON e.id_entrega = r.id_entrega;

SELECT c.nome, p.id_pedido ,m.nome AS motoristas
FROM entregas AS e
INNER JOIN pedidos AS p ON p.id_pedido = e.id_pedido
INNER JOIN clientes AS c ON c.id_cliente = p.id_cliente
INNER JOIN motoristas AS m ON m.id_motorista = e.id_motorista;

SELECT p.nome , i.preco_unitario
FROM itens_pedidos AS i
INNER JOIN produtos AS p ON p.id_produto = i.id_produto;

SELECT c.nome, r.localizacao
FROM rastreamentos AS r
INNER JOIN entregas AS e ON e.id_entrega = r.id_entrega
INNER JOIN pedidos AS p ON p.id_pedido = e.id_pedido
INNER JOIN clientes AS c ON c.id_cliente = p.id_cliente;

SELECT c.nome, p.id_pedido
FROM clientes AS c
LEFT JOIN pedidos AS p ON p.id_cliente = c.id_cliente;

SELECT prod.nome , i.id_pedido
FROM produtos AS prod
LEFT JOIN itens_pedidos AS i ON prod.id_produto = i.id_produto
WHERE i.id_pedido IS NULL;

SELECT m.nome, e.id_entrega
FROM motoristas AS m
LEFT JOIN entregas AS e ON m.id_motorista = e.id_motorista
WHERE e.id_entrega IS NULL;

SELECT v.marca, e.id_entrega
FROM veiculos AS v
LEFT JOIN entregas AS e ON v.id_veiculo = e.id_veiculo
WHERE e.id_entrega IS NULL;

SELECT p.id_pedido, i.id_item
FROM pedidos AS p
LEFT JOIN itens_pedidos AS i ON p.id_pedido = i.id_pedido;

SELECT e.id_entrega, m.nome
FROM entregas AS e
LEFT JOIN motoristas AS m ON m.id_motorista = e.id_motorista;

SELECT c.nome, p.id_pedido, r.localizacao
FROM clientes AS c
LEFT JOIN pedidos AS p ON p.id_cliente = c.id_cliente
LEFT JOIN entregas AS e ON e.id_pedido = p.id_pedido
LEFT JOIN rastreamentos AS r ON r.id_entrega = e.id_entrega;

SELECT e.id_entrega, p.id_pedido
FROM pedidos AS p
RIGHT JOIN entregas AS e ON e.id_pedido = p.id_pedido;

SELECT r.id_rastreamento, e.id_entrega 
FROM entregas AS e
RIGHT JOIN rastreamentos AS r ON r.id_rastreamento = e.id_entrega;

SELECT c.nome, COUNT(p.id_pedido) AS total_pedido
FROM pedidos AS p
INNER JOIN clientes AS c ON c.id_cliente = p.id_cliente
GROUP BY c.nome
ORDER BY total_pedido DESC;

SELECT AVG(valor_total) AS valor_medio , MIN(valor_total) AS valor_minimo , MAX(valor_total) AS valor_maximo 
FROM pedidos;

SELECT prod.categoria, COUNT(estoque) AS quantidade
FROM produtos AS prod
GROUP BY categoria
ORDER BY quantidade DESC;

SELECT m.nome, COUNT(e.id_entrega) AS total_entrega
FROM entregas AS e
INNER JOIN motoristas AS m ON e.id_motorista = m.id_motorista
GROUP BY m.id_motorista
HAVING total_entrega > 1
ORDER BY total_entrega;

SELECT prod.categoria , SUM(i.preco_unitario * i.quantidade) AS total_faturado
FROM itens_pedidos AS i
INNER JOIN produtos AS prod ON prod.id_produto = i.id_produto
GROUP BY prod.categoria
HAVING total_faturado > 1000
ORDER BY total_faturado;

SELECT e.status, COUNT(status) AS quantidade
FROM entregas AS e
GROUP BY e.status
HAVING COUNT(e.status) > 2
ORDER BY quantidade;

SELECT prod.nome, SUM(i.quantidade) AS produtos_mais_vendidos
FROM itens_pedidos AS i
INNER JOIN produtos AS prod ON prod.id_produto = i.id_produto
GROUP BY prod.nome
ORDER BY  produtos_mais_vendidos DESC
LIMIT 5;

SELECT v.tipo_veiculo, SUM(prod.peso * i.quantidade) AS peso_total_transportado
FROM veiculos AS v
INNER JOIN entregas AS e ON v.id_veiculo = e.id_veiculo
INNER JOIN pedidos AS p ON p.id_pedido = e.id_pedido
INNER JOIN itens_pedidos AS i ON p.id_pedido = i.id_pedido
INNER JOIN produtos AS prod ON prod.id_produto = i.id_produto
GROUP BY v.tipo_veiculo
ORDER BY peso_total_transportado DESC;

SELECT c.nome, AVG(valor_total) AS valor_medio
FROM pedidos AS p
INNER JOIN clientes AS c ON c.id_cliente = p.id_cliente
GROUP BY c.nome
HAVING AVG(p.valor_total) > 500
ORDER BY valor_medio DESC;

CREATE VIEW vw_rastreamentos_clientes AS 
SELECT c.nome, p.id_pedido,e.status,r.localizacao, r.codigo_rastreio
FROM entregas AS e INNER JOIN rastreamentos AS r ON r.id_entrega = e.id_entrega
INNER JOIN pedidos AS p ON p.id_pedido = e.id_pedido
INNER JOIN clientes AS c ON c.id_cliente = p.id_cliente;

SELECT*FROM  vw_rastreamentos_clientes;

SELECT c.nome , SUM(p.valor_total) AS total_gasto
FROM pedidos AS p
INNER JOIN clientes AS c ON p.id_cliente = c.id_cliente
GROUP BY c.nome
HAVING SUM(valor_total) > (SELECT AVG(valor_total) FROM pedidos);



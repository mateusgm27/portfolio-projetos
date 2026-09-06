CREATE DATABASE gestao_clinica_medica;
USE gestao_clinica_medica;

CREATE TABLE medicos(
medico_id INT AUTO_INCREMENT PRIMARY KEY,
nome VARCHAR(100),
especialidade VARCHAR(100),
email VARCHAR (50),
telefone VARCHAR(11));

CREATE TABLE pacientes(
paciente_id INT AUTO_INCREMENT PRIMARY KEY,
nome VARCHAR(100),
data_nascimento DATE,
telefone VARCHAR(11),
endereco VARCHAR(150));

CREATE TABLE consultas(
consulta_id INT AUTO_INCREMENT PRIMARY KEY,
medico_id INT,
paciente_id INT,
status ENUM ("Agendada", "Concluída", "Cancelada"),
Data_Hora DATETIME,
FOREIGN KEY (medico_id) REFERENCES medicos (medico_id),
FOREIGN KEY (paciente_id) REFERENCES pacientes (paciente_id));

CREATE TABLE exames(
exame_id INT AUTO_INCREMENT PRIMARY KEY,
nome VARCHAR(100),
descricao VARCHAR(150),
preco DECIMAL (10,2),
paciente_id INT,
FOREIGN KEY (paciente_id) REFERENCES pacientes (paciente_id));

CREATE TABLE pagamentos(
pagamento_id INT AUTO_INCREMENT PRIMARY KEY,
consulta_id INT,
valor DECIMAL(10,2),
data_pagamento DATE,
forma_pagamento ENUM("Cartão De Crédito","Dinheiro","Pix"),
FOREIGN KEY (consulta_id) REFERENCES consultas (consulta_id));

INSERT INTO medicos(medico_id,nome,especialidade,email,telefone) VALUES (1,"Dr.Marcelo De Oliveira","Pediatria","Marcelo415@gmail.com",'61912345678');
INSERT INTO medicos(medico_id,nome,especialidade,email,telefone) VALUES (2,"Dr.Luiz Gustavo","Cardiologia","Luiz19845@gmail.com",'61987654321');
INSERT INTO medicos(medico_id,nome,especialidade,email,telefone) VALUES (3,"Dra.Maria Sousa","Dermatologia","Maria789@gmail.com",'61998765432');
INSERT INTO medicos(medico_id,nome,especialidade,email,telefone) VALUES (4,"Dr.Leandro Costa","Neurologia","Leandro15567@gmail.com",'61934567890');
INSERT INTO medicos(medico_id,nome,especialidade,email,telefone) VALUES (5,"Dra.Paula Gomes","Cardiologia","Paulagomes126@gmail.com",'61945678901');
INSERT INTO medicos(medico_id,nome,especialidade,email,telefone) VALUES (6,"Dr.Sandro Almeida","Ginecologia","sandro652001@gmail.com",'61985107509');
INSERT INTO medicos(medico_id,nome,especialidade,email,telefone) VALUES (7,"Dra.Gabriela Alves","Oftalmologia","gabriela2034@gmail.com",'31998887777');
INSERT INTO medicos(medico_id,nome,especialidade,email,telefone) VALUES (8,"Dr.Leonardo Goncalves","Psiquiatria","leornardo1885@gmail.com",'61993746598');
INSERT INTO medicos(medico_id,nome,especialidade,email,telefone) VALUES (9,"Dra.Alessandro Albuquerque","Fisioterapia","alessandro651503@gmail.com",'31945671234');
INSERT INTO medicos(medico_id,nome,especialidade,email,telefone) VALUES (10,"Dra.Cristina Fonseca","Psiquiatria","cristina985145@gmail.com","31976543210");
INSERT INTO medicos(medico_id,nome,especialidade,email,telefone) VALUES (11,"Dr.Franscico Silva","Hematologia","francisco270519@gmail.com","31991234567");
INSERT INTO medicos(medico_id,nome,especialidade,email,telefone) VALUES (12,"Dr.Mateus Teixeira","Urologia","mateusteixeira4580@gmail.com",'11933334444');
INSERT INTO medicos(medico_id,nome,especialidade,email,telefone) VALUES (13,"Dr.Leandro Braga","Geriatria","leandrobraga8510@gmail.com",'11999992222');
INSERT INTO medicos(medico_id,nome,especialidade,email,telefone) VALUES (14,"Dra.Simone Farias","Cirurgia Geral","simonefarias6987@gmail.com",'11967543210');
INSERT INTO medicos(medico_id,nome,especialidade,email,telefone) VALUES (15,"Dra.Priscila Nogueira","Reumatologia","priscilafaria55666@gmail.com",'11977675432');
INSERT INTO medicos(medico_id,nome,especialidade,email,telefone) VALUES (16,"Dra.Vanessa Cruz","Otorrinolaringologia","vanessa1114@gmail.com",'61888887777');
INSERT INTO medicos(medico_id,nome,especialidade,email,telefone) VALUES (17,"Dr.João Paulo","Radiologia","joaopaulo480599@gmail.com",'11977654321');
INSERT INTO medicos(medico_id,nome,especialidade,email,telefone) VALUES (18,"Dra.Roberta Guedes","Fisioterapia","roberta080594@gmail.com",'1195107506');
INSERT INTO medicos(medico_id,nome,especialidade,email,telefone) VALUES (19,"Dr.Matheus Dias","Neurologia","matheusdias61@gmail.com",'31966754421');
INSERT INTO medicos(medico_id,nome,especialidade,email,telefone) VALUES (20,"Dra.Renata Batista","Ginecologia","renatabatista97@gmail.com",'21988765832');
INSERT INTO medicos(medico_id,nome,especialidade,email,telefone) VALUES (21,"Dr.Felipe Monteiro","Dermatologia","felipe451510@gmail.com",'21997654321');
INSERT INTO medicos(medico_id,nome,especialidade,email,telefone) VALUES (22,"Dra.Ricardo Lima","infectologia","ricardo5556@gmail.com",'21987129087');
INSERT INTO medicos(medico_id,nome,especialidade,email,telefone) VALUES (23,"Dr.Rafael Rocha","Proctologia","rafael85146@gmail.com",'21981234567');
INSERT INTO medicos(medico_id,nome,especialidade,email,telefone) VALUES (24,"Dr.Lucas Andrade","Ortopedia","lucasandrade856914@gmail.com",'21988908765');
INSERT INTO medicos(medico_id,nome,especialidade,email,telefone) VALUES (25,"Dr.Thiago Vieira","Dermatologia","thiagovieira6508@gmail.com",'21980012345');
INSERT INTO medicos(medico_id,nome,especialidade,email,telefone) VALUES (26,"Dra.Carolina Neves","Reumatologia","carolinaneves1985@gmail.com",'61990123456');
INSERT INTO medicos(medico_id,nome,especialidade,email,telefone) VALUES (27,"Dr.Gael Fontoura","Cirugia Geral","gael146947@gmail.com",'61985146257');
INSERT INTO medicos(medico_id,nome,especialidade,email,telefone) VALUES (28,"Dra.Livia Serafim","infectologia","livia4444@gmail.com",'21666664331');
INSERT INTO medicos(medico_id,nome,especialidade,email,telefone) VALUES (29,"Dr.Alvaro Negrão","Cirugia Plastica","alvaro658514@gmail.com",'61851494785');
INSERT INTO medicos(medico_id,nome,especialidade,email,telefone) VALUES (30,"Dra.Adriana Barbosa","Nutricionista","adriana284705@gmail.com",'61993708841');

INSERT INTO pacientes(paciente_id,nome,data_nascimento,telefone,endereco) VALUES (31,"Gabriela Esteves",'1994-05-11','21985119510',"Rua Das Palmeiras,45 - Copacabana, Rj");
INSERT INTO pacientes(paciente_id,nome,data_nascimento,telefone,endereco) VALUES (32, "Felipe Goncalves",'2001-03-21','21944765632',"Rua Das Laranjeiras,45- Laranjeiras,RJ");
INSERT INTO pacientes(paciente_id,nome,data_nascimento,telefone,endereco) VALUES (33,"Bruno Oliveira",'2003-03-15','21955123456',"Rua Visconde De Pirajá,88 - ipanema, RJ");
INSERT INTO pacientes(paciente_id,nome,data_nascimento,telefone,endereco) VALUES (34,"Leornado De Santana",'1961-06-02','21995432109',"Avenida Atlantica,5000 Copacabana, RJ");
INSERT INTO pacientes(paciente_id,nome,data_nascimento,telefone,endereco) VALUES (35,"Mario Almeida",'1885-06-10','21986543219',"Rua Dona Mariana,101, Botafogo, RJ");
INSERT INTO pacientes(paciente_id,nome,data_nascimento,telefone,endereco) VALUES (36,"Cristina Rocha",'1985-10-12','31987665544',"Rua Dos Guaranis,78 Centro, BH");
INSERT INTO pacientes(paciente_id,nome,data_nascimento,telefone,endereco) VALUES (37,"Murilo De Oliveira",'2003-09-15','31985432121',"Avenida Afonso Pena,1000 - Savassi, BH");
INSERT INTO pacientes(paciente_id,nome,data_nascimento,telefone,endereco) VALUES (38,"Marcio Costa",'2007-01-06','98111-2233',"Rua Espirito Santo,120- Lourdes, BH");
INSERT INTO pacientes(paciente_id,nome,data_nascimento,telefone,endereco) VALUES (39, "Lucas Pereira",'1998-05-10','31982227766',"Rua Da Bahia,456- Centro, BH");
INSERT INTO pacientes(paciente_id,nome,data_nascimento,telefone,endereco) VALUES (40,"Israel De Oliveira",'2001-09-11','31985558888',"Rua Tupis,800 - Centro, BH");
INSERT INTO pacientes(paciente_id,nome,data_nascimento,telefone,endereco) VALUES (41,"Amanda Barroso",'2001-09-16','11977223355',"Rua Augusta,1234 - Consolação, SP");
INSERT INTO pacientes(paciente_id,nome,data_nascimento,telefone,endereco) VALUES (42,"Beatriz Nascimento",'2004-03-25','11987694126',"Avenida Paulista,1578 - Bela Vista, SP");
INSERT INTO pacientes(paciente_id,nome,data_nascimento,telefone,endereco) VALUES (43, "Douglas Barbosa",'2008-06-28','11981112233',"Rua Haddock Lobo,250 - Jardim Paulista SP");
INSERT INTO pacientes(paciente_id,nome,data_nascimento,telefone,endereco) VALUES (44, "Samuel Messias",'1993-03-18','11991117733',"Avenida Brigadeiro Faria Lima, 3000- Itaim, SP");
INSERT INTO pacientes(paciente_id,nome,data_nascimento,telefone,endereco) VALUES (45,"Franscica Cardoso",'1996-04-10','615559876',"Avenida Central, Bloco B, 250 - Asa Sul, DF");
INSERT INTO pacientes(paciente_id,nome,data_nascimento,telefone,endereco) VALUES (46, "Ana Azevedo",'2008-04-20','619441234',"Estrada Parque Norte, Chácara 15 - Lago Norte , DF");
INSERT INTO pacientes(paciente_id,nome,data_nascimento,telefone,endereco) VALUES (47, "Helena Batista",'1999-08-20','6192228986',"Setor Comercial Sul, Quadra 3,  Plano Piloto, DF");
INSERT INTO pacientes(paciente_id,nome,data_nascimento,telefone,endereco) VALUES (48, "Matheus Castro",'2009-04-10','6197774543',"Rua Ipê Roxo, Quadra 6 , Lote 10 - Sobradinho, DF");
INSERT INTO pacientes(paciente_id,nome,data_nascimento,telefone,endereco) VALUES (49,"Marcela Rodrigues",'2015-02-06','6197771456',"Alameda Das Orquideas, Bloco F, Ap 301 - Aguas Claras, DF");
INSERT INTO pacientes(paciente_id,nome,data_nascimento,telefone,endereco) VALUES (50, "Leornado Andrade",'2011-11-25','616554890',"Rua Das Mangueiras, Quadra 9, Casa 15 - Guará, DF");

INSERT INTO consultas (consulta_id,medico_id,paciente_id,status,Data_Hora) VALUES (51,1,49,"Agendada",'2023-03-10 10:30:00');
INSERT INTO consultas (consulta_id,medico_id,paciente_id,status,Data_Hora) VALUES (52,2,31,"Concluida",'2023-03-10 14:30:00');
INSERT INTO consultas (consulta_id,medico_id,paciente_id,status,Data_Hora) VALUES (53,3,41,"Agendada",'2023-03-21 09:15:00');
INSERT INTO consultas (consulta_id,medico_id,paciente_id,status,Data_Hora) VALUES (54,4,31,"Concluida",'2023-02-15 10:00:00');
INSERT INTO consultas (consulta_id,medico_id,paciente_id,status,Data_Hora) VALUES (55,5,35,"Concluida", '2023-02-16 14:20:19');
INSERT INTO consultas (consulta_id,medico_id,paciente_id,status,Data_Hora) VALUES (56,6,36,"Concluida", '2023-04-02 15:15:49');
INSERT INTO consultas (consulta_id,medico_id,paciente_id,status,Data_Hora) VALUES (57,7,46, "Cancelada", '2023-04-02 16:00:00');
INSERT INTO consultas (consulta_id,medico_id,paciente_id,status,Data_Hora) VALUES (58,8,40, "Agendada", '2023-04-04 10:00:00');
INSERT INTO consultas (consulta_id,medico_id,paciente_id,status,Data_Hora) VALUES (59,9,41, "Concluida", '2023-04-04 11:15:00');
INSERT INTO consultas (consulta_id,medico_id,paciente_id,status,Data_Hora) VALUES (60,10,42, "Concluida", '2023-04-05 14:15:00');
INSERT INTO consultas (consulta_id,medico_id,paciente_id,status,Data_Hora) VALUES (61,11,47, "Cancelada", '2023-04-08 15:10:00');
INSERT INTO consultas (consulta_id,medico_id,paciente_id,status,Data_Hora) VALUES (62,12,48, "Concluida", '2023-04-25 10:15:35');
INSERT INTO consultas (consulta_id,medico_id,paciente_id,status,Data_Hora) VALUES (63,13,34, "Agendada", '2023-04-28 14:05:29');
INSERT INTO consultas (consulta_id,medico_id,paciente_id,status,Data_Hora) VALUES (64,14,32, "Cancelada", '2023-05-02 09:00:00');
INSERT INTO consultas (consulta_id,medico_id,paciente_id,status,Data_Hora) VALUES (65,15,33, "Cancelada", '2023-05-02 10:15:20');
INSERT INTO consultas (consulta_id,medico_id,paciente_id,status,Data_Hora) VALUES (66,16,50, "Concluida", '2023-05-02 14:00:39');
INSERT INTO consultas (consulta_id,medico_id,paciente_id,status,Data_Hora) VALUES (67,17,47, "Agendada", '2023-05-03 08:00:00');
INSERT INTO consultas (consulta_id,medico_id,paciente_id,status,Data_Hora) VALUES (68,18,49, "Cancelada", '2023-05-03 11:15:00');
INSERT INTO consultas (consulta_id,medico_id,paciente_id,status,Data_Hora) VALUES (69,19,39, "Concluida", '2023-05-03 14:00:00');
INSERT INTO consultas (consulta_id,medico_id,paciente_id,status,Data_Hora) VALUES (70,20,33, "Agendada", '2023-05-03 16:15:00');
INSERT INTO consultas (consulta_id,medico_id,paciente_id,status,Data_Hora) VALUES (71,21,36, "Concluida", '2023-05-04 09:30:50');
INSERT INTO consultas (consulta_id,medico_id,paciente_id,status,Data_Hora) VALUES (72,22,32, "Agendada", '2023-05-06 16:00:00');
INSERT INTO consultas (consulta_id,medico_id,paciente_id,status,Data_Hora) VALUES (73,23,35, "Agendada", '2023-05-06 17:30:00');
INSERT INTO consultas (consulta_id,medico_id,paciente_id,status,Data_Hora) VALUES (74,24,33, "Agendada", '2023-05-08 13:00:00');
INSERT INTO consultas (consulta_id,medico_id,paciente_id,status,Data_Hora) VALUES (75,29,45, "Agendada", '2023-06-15 15:30:49');
INSERT INTO consultas (consulta_id,medico_id,paciente_id,status,Data_Hora) VALUES (76,26,47, "Concluida", '2023-05-29 16:00:00');
INSERT INTO consultas (consulta_id,medico_id,paciente_id,status,Data_Hora) VALUES (77,30,42, "Concluida", '2023-06-01 09:45:00');
INSERT INTO consultas (consulta_id,medico_id,paciente_id,status,Data_Hora) VALUES (78,27,36, "Cancelada", '2023-06-16 14:30:00');
INSERT INTO consultas (consulta_id,medico_id,paciente_id,status,Data_Hora) VALUES (79,25,41, "Agendada", '2023-06-17 15:25:10');
INSERT INTO consultas (consulta_id,medico_id,paciente_id,status,Data_Hora) VALUES (80,28,39, "Agendada", '2023-07-05 11:00:00');

INSERT INTO exames(exame_id,nome,descricao,preco,paciente_id) VALUES (81,"Hemograma Completo","Exame de sangue para análise geral de saúde", 400.00, 49);
INSERT INTO exames(exame_id,nome,descricao,preco,paciente_id) VALUES (82,"Raio-X de Tórax","Imagem do tórax para análise dos pulmões e vias respiratórias",550.00,31);
INSERT INTO exames(exame_id,nome,descricao,preco,paciente_id) VALUES (83,"Biópsia de Pele","Retirada de uma pequena amostra de pele para análise laboratorial",350.00,41);
INSERT INTO exames(exame_id,nome,descricao,preco,paciente_id) VALUES (84, "Ressonância Magnética", "Investigar Lesôes Cerebrais,tumores, AVCs, Doenças do sistema nervoso central",700.00,31);
INSERT INTO exames(exame_id,nome,descricao,preco,paciente_id) VALUES (85, "Eletrocardiograma", "Registra a atividade Elétrica do coracão para detectar arritmias,infarto ou alterações no ritmo cardiaco",610.00,35);
INSERT INTO exames(exame_id,nome,descricao,preco,paciente_id) VALUES (86, "Papanicolau","Exame Preventivo Para detectar Cancer Cervical",850.00,36);
INSERT INTO exames(exame_id,nome,descricao,preco,paciente_id) VALUES (87, "Teste De Acuidade Visual", "Medição da Capacidade de enxergar diferentes distancias",400.00,46);
INSERT INTO exames(exame_id,nome,descricao,preco,paciente_id) VALUES (88, "Escalas De Avaliação Psiquiátrica", "Usadas Para Diagnosticar Condições como depressão,Ansiedade,esquizofrenia",360.00,40);
INSERT INTO exames(exame_id,nome,descricao,preco,paciente_id) VALUES (89, "Avaliação Funcional","Exame Para Verificar a mobilidade,força e cordernação dos Músculos",800.00,41);
INSERT INTO exames(exame_id,nome,descricao,preco,paciente_id) VALUES (90, "Teste De Inteligência", "Avaliação cognitiva para detectar déficits de inteligência",350.00,42);
INSERT INTO exames(exame_id,nome,descricao,preco,paciente_id) VALUES (91, "Teste De Coagulação", "Avaliação da capacidade de coagulação do sangue", 950.00, 47);
INSERT INTO exames(exame_id,nome,descricao,preco,paciente_id) VALUES (92, "Ultrassonografia Renal", "Avalia os rins e bexiga para detectar pedras,cistos e outros problemas",900.00,48);
INSERT INTO exames(exame_id,nome,descricao,preco,paciente_id) VALUES (93, "Avaliação cognitiva", "Exames para detectar doenças neurodegenerativas como alzheimer",950.00,34);
INSERT INTO exames(exame_id,nome,descricao,preco,paciente_id) VALUES (94, "Exames pré-operatorios", "Incluem exames de sangue,radiografia de tórax para avaliar saude geral antes da cirugia",900.00,32);
INSERT INTO exames(exame_id,nome,descricao,preco,paciente_id) VALUES (95, "Exames De Anicorpos", "Para diagnosticar doenças autoimunes como lupus", 3000.00,33);
INSERT INTO exames(exame_id,nome,descricao,preco,paciente_id) VALUES (96,"Audiometria", "Exame que avalia a audição e detecta problemas auditivos",650.00,50);
INSERT INTO exames(exame_id,nome,descricao,preco,paciente_id) VALUES (97, "Raio-x","Exame de Imagem para detectar fraturas, doenças pulmonares e outras condições",700.00,47);
INSERT INTO exames(exame_id,nome,descricao,preco,paciente_id) VALUES (98, "Eletromiografia","Testa a função dos musculos e nervos, diagnosticado lesões e doenças neuromusculares", 750.00,49);
INSERT INTO exames(exame_id,nome,descricao,preco,paciente_id) VALUES (99, "Tomografia de Crânio","Indetificar lesôes ou sangramentos cerebrais",800.00,39);
INSERT INTO exames(exame_id,nome,descricao,preco,paciente_id) VALUES (100,"Colposcopia", "Exame detalhado do colo do útero para investigar alterações celulares",480.00,33);
INSERT INTO exames(exame_id,nome,descricao,preco,paciente_id) VALUES (101, "Cultura de Pele", "indetifica infecções fúngicas,bacterianas ou virais",710.00,36);
INSERT INTO exames(exame_id,nome,descricao,preco,paciente_id) VALUES (102, "Teste Rápido de HIV", "Teste para detectar a infecção pelo HIV",250.00,32);
INSERT INTO exames(exame_id,nome,descricao,preco,paciente_id) VALUES (103,"Exame de Toque Retal","Avalia a presença de anormalidade no reto, como nódulos,tumores ou alterações na próstata" ,500.00,35);
INSERT INTO exames(exame_id,nome,descricao,preco,paciente_id) VALUES (104, "Artroscopia","Procedimento minimamente invasivo que pode ser usado tanto para diagnóstico quanto para tratamento de problemas nas articulações",550.00,33);
INSERT INTO exames(exame_id,nome,descricao,preco,paciente_id) VALUES (105, "Ultrassonografia", "Avalição de áreas a serem tratadas, como mamas ou gordura localizada",950.00,45);
INSERT INTO exames(exame_id,nome,descricao,preco,paciente_id) VALUES (106, "Raio-x de articulações", "Avalia danos nas articulações causados por artrite reumatoide", 900.00,47);
INSERT INTO exames(exame_id,nome,descricao,preco,paciente_id) VALUES (107, "Antropometria", "Avaliação de peso, altura e composição corporal", 650.00,42);
INSERT INTO exames(exame_id,nome,descricao,preco,paciente_id) VALUES (108, "Ultrassonografia abdominal", "Avalição de orgãos internos para indetificar tumores,cistos ou cáculos", 590.00,36);
INSERT INTO exames(exame_id,nome,descricao,preco,paciente_id) VALUES (109, "Teste alérgico", "Realizado para diagnosticar alergias de contato, como reações a produtos cosmésticos",750.00,41);
INSERT INTO exames(exame_id,nome,descricao,preco,paciente_id) VALUES (110, "Cultura de Secreções", "Indetifica o agente causador de infecções, como HiV, hepatite ou tuberculose", 980.00,39);    

INSERT INTO pagamentos (pagamento_id,consulta_id, valor, data_pagamento, forma_pagamento) VALUES (111,51, 400.00, '2023-03-10', "Cartão De Crédito");
INSERT INTO pagamentos (pagamento_id,consulta_id, valor, data_pagamento, forma_pagamento) VALUES (112,52, 550.00, '2023-03-10', "Dinheiro");
INSERT INTO pagamentos (pagamento_id,consulta_id, valor, data_pagamento, forma_pagamento) VALUES (113,53, 350.00, '2023-03-21', "Pix");
INSERT INTO pagamentos (pagamento_id,consulta_id, valor, data_pagamento, forma_pagamento) VALUES (114,54, 700.00, '2023-02-15', "Dinheiro");
INSERT INTO pagamentos (pagamento_id,consulta_id, valor, data_pagamento, forma_pagamento) VALUES (115,55, 120.00, '2023-02-16', "Pix");
INSERT INTO pagamentos (pagamento_id,consulta_id, valor, data_pagamento, forma_pagamento) VALUES (116,56, 300.00, '2023-04-05', "Cartão De Crédito");
INSERT INTO pagamentos (pagamento_id,consulta_id, valor, data_pagamento, forma_pagamento) VALUES (118,58, 160.00, '2023-04-20', "Dinheiro");
INSERT INTO pagamentos (pagamento_id,consulta_id, valor, data_pagamento, forma_pagamento) VALUES (119,59, 280.00, '2023-05-01', "Cartão De Crédito");
INSERT INTO pagamentos (pagamento_id,consulta_id, valor, data_pagamento, forma_pagamento) VALUES (120,60, 170.00, '2023-05-10', "Pix");
INSERT INTO pagamentos (pagamento_id,consulta_id, valor, data_pagamento, forma_pagamento) VALUES (123,62, 300.00, '2023-05-14', "Cartão De Crédito");
INSERT INTO pagamentos (pagamento_id,consulta_id, valor, data_pagamento, forma_pagamento) VALUES (124,63, 150.00, '2023-06-01', "Pix");
INSERT INTO pagamentos (pagamento_id,consulta_id, valor, data_pagamento, forma_pagamento) VALUES (125,66,650.00, '2023-05-02', "Dinheiro");
INSERT INTO pagamentos (pagamento_id,consulta_id, valor, data_pagamento, forma_pagamento) VALUES (127,67,950.00, '2023-05-03', "Pix");
INSERT INTO pagamentos (pagamento_id,consulta_id, valor, data_pagamento, forma_pagamento) VALUES (128,69,800.00, '2023-05-03', "Dinheiro");
INSERT INTO pagamentos (pagamento_id,consulta_id, valor, data_pagamento, forma_pagamento) VALUES (129,70,480.00, '2023-05-03', "Pix");
INSERT INTO pagamentos (pagamento_id,consulta_id, valor, data_pagamento, forma_pagamento) VALUES (130,71,710.00, '2023-05-04', "Dinheiro");
INSERT INTO pagamentos (pagamento_id,consulta_id, valor, data_pagamento, forma_pagamento) VALUES (131,72,250.00, '2023-05-06', "Pix");
INSERT INTO pagamentos (pagamento_id,consulta_id, valor, data_pagamento, forma_pagamento) VALUES (132,73,500.00, '2023-05-06', "Dinheiro");
INSERT INTO pagamentos (pagamento_id,consulta_id, valor, data_pagamento, forma_pagamento) VALUES (133,74,550.00, '2023-05-08', "Pix");
INSERT INTO pagamentos (pagamento_id,consulta_id, valor, data_pagamento, forma_pagamento) VALUES (134,75,950.00, '2023-06-15', "Cartão De Crédito");
INSERT INTO pagamentos (pagamento_id,consulta_id, valor, data_pagamento, forma_pagamento) VALUES (135,76,900.00, '2023-05-29', "Cartaõ De Crédito");
INSERT INTO pagamentos (pagamento_id,consulta_id, valor, data_pagamento, forma_pagamento) VALUES (136,77,650.00, '2023-06-01', "Cartão De Crédito");
INSERT INTO pagamentos (pagamento_id,consulta_id, valor, data_pagamento, forma_pagamento) VALUES (137,79,750.00, '2023-06-17', "Cartão De Crédito");
INSERT INTO pagamentos (pagamento_id,consulta_id, valor, data_pagamento, forma_pagamento) VALUES (138,80,980.00, '2023-07-05', "Dinheiro");

SELECT consultas.consulta_id, medicos.nome AS medico, pacientes.nome AS paciente, consultas.status, consultas.Data_Hora
FROM consultas
INNER JOIN medicos ON consultas.medico_id = medicos.medico_id
INNER JOIN pacientes ON consultas.paciente_id = pacientes.paciente_id;

SELECT medicos.nome AS medico, consultas.consulta_id, consultas.status, consultas.Data_hora
FROM medicos
LEFT JOIN consultas ON medicos.medico_id = medicos.medico_id;

SELECT consultas.consulta_id, pacientes.nome AS paciente, exames.nome AS exame, exames.preco
FROM consultas
LEFT JOIN pacientes ON consultas.paciente_id = pacientes.paciente_id
LEFT JOIN exames ON exames.paciente_id = pacientes.paciente_id;

SELECT consultas.consulta_id, pacientes.nome AS paciente, consultas.status, pagamentos.valor AS valor_pago, pagamentos.forma_pagamento
FROM consultas
LEFT JOIN pacientes ON consultas.paciente_id = pacientes.paciente_id
LEFT JOIN pagamentos ON consultas.consulta_id = pagamentos.consulta_id;

SELECT medicos.nome AS medico, COUNT(consultas.consulta_id) AS total_consultas
FROM medicos
LEFT JOIN consultas ON medicos.medico_id = consultas.medico_id
GROUP BY medicos.nome;

SELECT DISTINCT pacientes.nome AS paciente
FROM pacientes
INNER JOIN consultas ON pacientes.paciente_id = consultas.paciente_id;

SELECT exames.nome AS exame, pacientes.nome, medicos.nome AS medico
FROM exames
INNER JOIN pacientes ON exames.paciente_id = pacientes.paciente_id
INNER JOIN consultas ON consultas.paciente_id = pacientes.paciente_id
INNER JOIN medicos ON consultas.medico_id = medicos.medico_id;

SELECT medicos.nome AS medico
FROM medicos
LEFT JOIN consultas ON medicos.medico_id = consultas.medico_id
WHERE consultas.consulta_id;

SELECT COUNT(*) AS total_consultas FROM consultas;

SELECT status, COUNT(*) AS quantidade
FROM consultas
GROUP BY status;

SELECT AVG(valor) AS media_pagamentos FROM  pagamentos;

SELECT SUM(valor) AS total_recebido FROM pagamentos;

SELECT MAX(valor) AS maior_pagamento, MIN(valor) AS minimo_valor FROM pagamentos;

SELECT medicos.nome, COUNT(consultas.consulta_id) AS total_consultas
FROM medicos
INNER JOIN consultas ON medicos.medico_id = consultas.medico_id
GROUP BY medicos.nome
ORDER BY total_consultas;

SELECT pacientes.nome, COUNT(consultas.consulta_id) AS total_consultas
FROM pacientes
INNER JOIN consultas ON pacientes.paciente_id = consultas.paciente_id
GROUP BY pacientes.nome
ORDER BY total_consultas;

SELECT medicos.especialidade, COUNT(consultas.consulta_id) AS total_consultas
FROM medicos
INNER JOIN consultas ON medicos.medico_id = consultas.medico_id
GROUP BY medicos.especialidade
ORDER BY total_consultas;

SELECT pacientes.nome, SUM(pagamentos.valor) AS total_gasto
FROM pacientes
INNER JOIN consultas ON pacientes.paciente_id = consultas.paciente_id
INNER JOIN pagamentos ON consultas.consulta_id = pagamentos.consulta_id
GROUP BY pacientes.paciente_id
ORDER BY total_gasto
LIMIT 5;

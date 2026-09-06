// Porta local da API .NET (Desativada para modo portfólio estático)
const API_URL = "http://localhost:5000/api";

let categoriaAtiva = 'Todos';
let quantidadeCarrinho = 0;
let usuarioAutenticado = false;

// Variáveis globais do Carrossel
let bannerAtual = 0;
const totalBanners = 3;
let bannerInterval = null;

// AUXILIARES
function normalizarTexto(texto) {
    if (!texto) return '';
    return texto
        .toLowerCase()
        .normalize('NFD')
        .replace(/[\u0300-\u036f]/g, '')
        .trim();
}

// 🗺️ Mapeamento de Imagens Online 
const mapaImagensOnline = {
    // Alimentos
    "azeite extra virgem": "assets/img/azeite.jpeg",
    "arroz 5kg": "assets/img/arroz.png",
    "cafe premium 500g": "assets/img/cafépremium.jpeg",
    "chocolate lindt": "assets/img/chocolatelindt.jpeg",
    "feijao 1kg": "assets/img/feijão.jpeg",
    "leite integral 1l": "assets/img/leiteintegral.jpeg",
    "macarrao 500g": "assets/img/macarrão.jpeg",
    "refrigerante coca-cola 2l": "assets/img/coca-cola.jpeg",

    // Automotivo
    "bateria automotiva": "assets/img/bateria.jpeg",
    "capa para banco": "assets/img/capabanco.jpeg",
    "kit multimidia carro": "assets/img/kit-multimidia.jpeg",
    "lampada led": "assets/img/lampada-led.jpeg",
    "oleo motor 5w30": "assets/img/oleomotor.jpeg",
    "pneu michelin aro 15": "assets/img/pneu.jpeg",
    "sensor de re": "assets/img/sensor.webp",
    "som automotivo pioneer": "assets/img/som-pioneer.jpeg",

    // Beleza
    "base liquida boca rosa": "assets/img/baseboca.webp",
    "chapinha gama italy": "assets/img/chapinha.png",
    "kit pinceis de maquiagem": "assets/img/kit-maquiagem.jpeg",
    "mascara de cilios maybelline": "assets/img/mascara-de-cilios.jpeg",
    "perfume chanel no.5": "assets/img/perfume.webp",
    "protetor solar la roche-posay": "assets/img/protetor.jpeg",
    "secador de cabelo taiff": "assets/img/secador.jpeg",
    "serum facial vitamina c": "assets/img/serum-facial.webp",
    "kit maquiagem completo": "assets/img/kit-maquiagem-completo.webp",

    // Brinquedos
    "boneca barbie": "assets/img/boneca-barbie.jpeg",
    "carrinho hot wheels": "assets/img/carrinho-hotwheels.webp",
    "jogo imagem & acao": "assets/img/jogo-imagem-acao.jpeg",
    "lego classic 500 pecas": "assets/img/lego.jpeg",
    "massinha play-doh kit": "assets/img/massinha.jpeg",
    "pelucia pokemon pikachu": "assets/img/pelucia-pokemon.jpeg",
    "pista hot wheels loop": "assets/img/pista.jpeg",
    "quebra-cabeca 1000 pecas": "assets/img/quebra-cabeça.jpeg",

    // Casa
    "cadeira de escritorio": "assets/img/cadeira.webp",
    "cama box casal": "assets/img/camabox.webp",
    "cortina blackout": "assets/img/cortina.webp",
    "espelho decorativo": "assets/img/espelho.webp",
    "guarda roupa 6 portas": "assets/img/guarda-roupa.webp",
    "luminaria led": "assets/img/luminaria.webp",
    "mesa de jantar 6 cadeiras": "assets/img/mesa-de-jantar.jpeg",
    "panela de pressao 5l": "assets/img/panela-de-pressao.jpeg",
    "tapete sala 2x3m": "assets/img/tapete.jpeg",
    "ventilador arno": "assets/img/ventilador.jpeg",

    // Eletrodomésticos
    "aspirador de po electrolux": "assets/img/aspirador.webp",
    "batedeira arno": "assets/img/batedeira.jpeg",
    "cafeteira dolce gusto": "assets/img/cafeteira.webp",
    "fogao 4 bocas": "assets/img/fogao.jpeg",
    "geladeira brastemp": "assets/img/geladeira.jpeg",
    "liquidificador mondial": "assets/img/liquidificador.jpeg",
    "maquina de lavar 12kg": "assets/img/maquina-de-lavar.webp",
    "microondas eletrolux": "assets/img/microondas.jpeg",
    "purificador de agua": "assets/img/purificador.webp",

    // Eletrônicos
    "caixa de som jbl flip 6": "assets/img/caixa-jbl.webp",
    "camera canon eos rebel t7": "assets/img/camera.webp",
    "fone sony wh-1000xm5": "assets/img/fone-sony.jpeg",
    "iphone pro max": "assets/img/iphone.jpeg",
    "kindle paperwhite 16gb": "assets/img/kindle.webp",
    "macbook air m3": "assets/img/nootebook.jpeg",
    "monitor lg ultrawide 29": "assets/img/monitor.webp",
    "nitendo switch oled": "assets/img/nitendo.webp",
    "power bank 20000mah": "assets/img/powerbank.webp",
    "samsung galaxy s24 ultra": "assets/img/samsung-s24.jpeg",
    "smart tv samsung 50 4k": "assets/img/smart-tv.avif",
    "smartwatch apple watch series 9": "assets/img/Smartwatch Apple Watch Series 9.jpeg",
    "tablet samsung galaxy tab s9": "assets/img/tablet.jpeg",
    "teclado mecanico keychron": "assets/img/teclado.jpeg",

    // Esporte
    "bicicleta aro shimano": "assets/img/bicicleta.jpeg",
    "bola de futebol adidas champions": "assets/img/bola-de-futebol.webp",
    "capacete ciclismo absolute": "assets/img/capacete-ciclismo.webp",
    "chuteira nike": "assets/img/chuteira.jpeg",
    "corda de pular": "assets/img/corda-de-pular.jpeg",
    "esteira eletrica": "assets/img/esteira.webp",
    "halter 10kg": "assets/img/peso.jpeg",
    "kimono jiu jitsu": "assets/img/kimono.jpeg",
    "luva de boxe venum 12oz": "assets/img/luvadeboxe.webp",

    // Games
    "cadeira gamer thunderx3": "assets/img/cadeira-gamer.webp",
    "capa case silicone controle ps5": "assets/img/capa-controle.webp",
    "controle ps5 dualsense": "assets/img/controle-ps5.jpeg",
    "headset gamer hyperx": "assets/img/headset.jpeg",
    "jogo fifa 24": "assets/img/jogo-fifa24.jpeg",
    "jogo gta v": "assets/img/gtav.jpeg",
    "mouse gamer razer": "assets/img/mouse.jpeg",
    "playstation 5": "assets/img/Play5.jpeg",
    "suporte gamer para controle e fone": "assets/img/suporte-gamer.webp",
    "video game stick 20000 jogos": "assets/img/video-game-stick.jpeg",
    "volante logitech g29": "assets/img/volante.webp",
    "xbox series s": "assets/img/xbox.jpeg",

    // Informática
    "cabo hdmi 2.1 4k 2m": "assets/img/cabo.webp",
    "hub usb-c 7 em 1": "assets/img/hub-usb.webp",
    "impressora hp deskjet 2774": "assets/img/impressora.jpeg",
    "memoria ram 16gb ddr4": "assets/img/memoria-ram.jpeg",
    "roteador tp-link ac1200": "assets/img/roteador.webp",
    "ssd nvme 1tb kingston": "assets/img/ssd.jpeg",
    "webcam full hd logitech": "assets/img/webcam.webp",
    "placa de video": "assets/img/placa de video.webp",

    // Livros
    "livro arquitetura limpa": "assets/img/livroarquitetura.jpeg",
    "livro clean code": "assets/img/livro-cleanclode.webp",
    "livro entendendo algoritmos": "assets/img/livro-entendendo-algoritmo.jpeg",
    "livro harry potter": "assets/img/livro-harrypotter.jpeg",
    "livro o codificador limpo": "assets/img/livro-codificador-limpo.jpeg",
    "livro o hobbit": "assets/img/livro-hobbit.webp",
    "livro padroes de projeto": "assets/img/livro-padroes-projeto.jpeg",
    "livro batman -a ressurreicao": "assets/img/livro-batman.webp",

    // Moda
    "bone adidas": "assets/img/bone.jpeg",
    "camisa argentina adidas": "assets/img/camisa-argentina.jpeg",
    "camisa brasil nike": "assets/img/camisa-brasil.jpeg",
    "camisa oversized one piece": "assets/img/camisa-onepiece.jpeg",
    "camisa oversized superman": "assets/img/camisa-superman.jpeg",
    "jaqueta jeans masculina": "assets/img/jaqueta-jeans.webp",
    "mochila executiva para notebook": "assets/img/mochila.webp",
    "oculos de sol ray-ban": "assets/img/oculos.webp",
    "relogio casio": "assets/img/relogio-casio.webp",
    "tenis adidas ultraboost": "assets/img/tenis-adidas.jpeg",
    "tenis nike air force 1": "assets/img/tenis-nike.jpeg",
    "vestido feminino casual": "assets/img/vestido-casual.webp",

    // Pet
    "areia para gato": "assets/img/areiagato.webp",
    "arranhador para gato": "assets/img/arranhadorparagato.webp",
    "brinquedo para gato": "assets/img/brinquedo-gato.jpeg",
    "cama para cachorro": "assets/img/cama-cachorro.avif",
    "coleira pet": "assets/img/coleira.webp",
    "comedouro automatico": "assets/img/comedouro.webp",
    "racao para cachorro 10kg": "assets/img/racao-cachorro.jpeg",
    "shampoo pet": "assets/img/shampoopet.jpeg"
};

const IMAGEM_PADRAO = 'https://images.unsplash.com/photo-1526170375885-4d8ecf77b99f?w=400&q=80';

function obterCaminhoImagem(nomeProduto) {
    if (!nomeProduto) return IMAGEM_PADRAO;
    const chaveSemAcento = normalizarTexto(nomeProduto);

    for (const [chave, url] of Object.entries(mapaImagensOnline)) {
        if (chaveSemAcento === normalizarTexto(chave) || chaveSemAcento.includes(chave) || chave.includes(chaveSemAcento)) {
            return url;
        }
    }
    return IMAGEM_PADRAO;
}

window.tratarErroImagem = function(img) {
    img.onerror = null;
    img.src = IMAGEM_PADRAO;
};

// 📦 LISTA COMPLETA DE TODOS OS 122 PRODUTOS DO BANCO (CSV)
const todosProdutos = [
    { id: 1, nome: "IPhone Pro Max", categoria: "Eletronicos", preco: 7500.0, estoque: 50, descricao: "IPhone Pro Max de alta qualidade, categoria Eletronicos." },
    { id: 2, nome: "Samsung Galaxy S24 Ultra", categoria: "Eletronicos", preco: 5800.0, estoque: 30, descricao: "Samsung Galaxy S24 Ultra de alta qualidade, categoria Eletronicos." },
    { id: 3, nome: "MacBook Air M3", categoria: "Eletronicos", preco: 9500.0, estoque: 15, descricao: "MacBook Air M3 de alta qualidade, categoria Eletronicos." },
    { id: 4, nome: "Kit Maquiagem Completo", categoria: "Beleza", preco: 200.0, estoque: 50, descricao: "Kit Maquiagem Completo de alta qualidade, categoria Beleza." },
    { id: 5, nome: "Fone Sony WH-1000XM5", categoria: "Eletronicos", preco: 2100.0, estoque: 40, descricao: "Fone Sony WH-1000XM5 de alta qualidade, categoria Eletronicos." },
    { id: 6, nome: "Mesa de Jantar 6 Cadeiras", categoria: "Casa", preco: 2200.0, estoque: 5, descricao: "Mesa de Jantar 6 Cadeiras de alta qualidade, categoria Casa." },
    { id: 7, nome: "Secador de Cabelo Taiff", categoria: "Beleza", preco: 250.0, estoque: 40, descricao: "Secador de Cabelo Taiff de alta qualidade, categoria Beleza." },
    { id: 8, nome: "Tapete Sala 2x3m", categoria: "Casa", preco: 300.0, estoque: 25, descricao: "Tapete Sala 2x3m de alta qualidade, categoria Casa." },
    { id: 9, nome: "Nitendo Switch OLED", categoria: "Eletronicos", preco: 2400.0, estoque: 25, descricao: "Nitendo Switch OLED de alta qualidade, categoria Eletronicos." },
    { id: 10, nome: "Kindle Paperwhite 16GB", categoria: "Eletronicos", preco: 799.0, estoque: 100, descricao: "Kindle Paperwhite 16GB de alta qualidade, categoria Eletronicos." },
    { id: 11, nome: "Smart TV Samsung 50 4K", categoria: "Eletronicos", preco: 2300.0, estoque: 20, descricao: "Smart TV Samsung 50 4K de alta qualidade, categoria Eletronicos." },
    { id: 12, nome: "PlayStation 5", categoria: "Games", preco: 3800.0, estoque: 15, descricao: "PlayStation 5 de alta qualidade, categoria Games." },
    { id: 13, nome: "Xbox Series S", categoria: "Games", preco: 2500.0, estoque: 25, descricao: "Xbox Series S de alta qualidade, categoria Games." },
    { id: 14, nome: "Controle PS5 DualSense", categoria: "Games", preco: 450.0, estoque: 60, descricao: "Controle PS5 DualSense de alta qualidade, categoria Games." },
    { id: 15, nome: "Headset Gamer HyperX", categoria: "Games", preco: 350.0, estoque: 40, descricao: "Headset Gamer HyperX de alta qualidade, categoria Games." },
    { id: 16, nome: "Mouse Gamer Razer", categoria: "Games", preco: 250.0, estoque: 50, descricao: "Mouse Gamer Razer de alta qualidade, categoria Games." },
    { id: 17, nome: "Teclado Mecanico Keychron", categoria: "Eletronicos", preco: 500.0, estoque: 35, descricao: "Teclado Mecanico Keychron de alta qualidade, categoria Eletronicos." },
    { id: 18, nome: "Cadeira Gamer ThunderX3", categoria: "Games", preco: 1200.0, estoque: 10, descricao: "Cadeira Gamer ThunderX3 de alta qualidade, categoria Games." },
    { id: 19, nome: "Monitor LG Ultrawide 29", categoria: "Eletronicos", preco: 1400.0, estoque: 18, descricao: "Monitor LG Ultrawide 29 de alta qualidade, categoria Eletronicos." },
    { id: 20, nome: "Caixa de Som JBL Flip 6", categoria: "Eletronicos", preco: 600.0, estoque: 45, descricao: "Caixa de Som JBL Flip 6 de alta qualidade, categoria Eletronicos." },
    { id: 21, nome: "Smartwatch Apple Watch Series 9", categoria: "Eletronicos", preco: 3500.0, estoque: 20, descricao: "Smartwatch Apple Watch Series 9 de alta qualidade, categoria Eletronicos." },
    { id: 22, nome: "Tablet Samsung Galaxy Tab S9", categoria: "Eletronicos", preco: 4200.0, estoque: 15, descricao: "Tablet Samsung Galaxy Tab S9 de alta qualidade, categoria Eletronicos." },
    { id: 23, nome: "Camera Canon EOS Rebel T7", categoria: "Eletronicos", preco: 3200.0, estoque: 8, descricao: "Camera Canon EOS Rebel T7 de alta qualidade, categoria Eletronicos." },
    { id: 24, nome: "Power Bank 20000mAh", categoria: "Eletronicos", preco: 180.0, estoque: 80, descricao: "Power Bank 20000mAh de alta qualidade, categoria Eletronicos." },
    { id: 25, nome: "Volante Logitech G29", categoria: "Games", preco: 1900.0, estoque: 7, descricao: "Volante Logitech G29 de alta qualidade, categoria Games." },
    { id: 26, nome: "Jogo FIFA 24", categoria: "Games", preco: 250.0, estoque: 100, descricao: "Jogo FIFA 24 de alta qualidade, categoria Games." },
    { id: 27, nome: "Jogo GTA V", categoria: "Games", preco: 150.0, estoque: 100, descricao: "Jogo GTA V de alta qualidade, categoria Games." },
    { id: 28, nome: "Video Game Stick 20000 Jogos", categoria: "Games", preco: 160.0, estoque: 50, descricao: "Video Game Stick 20000 Jogos de alta qualidade, categoria Games." },
    { id: 29, nome: "Suporte Gamer para Controle e Fone", categoria: "Games", preco: 90.0, estoque: 40, descricao: "Suporte Gamer para Controle e Fone de alta qualidade, categoria Games." },
    { id: 30, nome: "Capa Case Silicone Controle PS5", categoria: "Games", preco: 50.0, estoque: 70, descricao: "Capa Case Silicone Controle PS5 de alta qualidade, categoria Games." },
    { id: 31, nome: "Geladeira Brastemp", categoria: "Eletrodomésticos", preco: 3500.0, estoque: 6, descricao: "Geladeira Brastemp de alta qualidade, categoria Eletrodomésticos." },
    { id: 32, nome: "Fogao 4 Bocas", categoria: "Eletrodomésticos", preco: 1200.0, estoque: 12, descricao: "Fogao 4 Bocas de alta qualidade, categoria Eletrodomésticos." },
    { id: 33, nome: "Maquina de Lavar 12kg", categoria: "Eletrodomésticos", preco: 2100.0, estoque: 9, descricao: "Maquina de Lavar 12kg de alta qualidade, categoria Eletrodomésticos." },
    { id: 34, nome: "Microondas Eletrolux", categoria: "Eletrodomésticos", preco: 750.0, estoque: 25, descricao: "Microondas Eletrolux de alta qualidade, categoria Eletrodomésticos." },
    { id: 35, nome: "Air Fryer Mondial 4L", categoria: "Eletrodomésticos", preco: 400.0, estoque: 35, descricao: "Air Fryer Mondial 4L de alta qualidade, categoria Eletrodomésticos." },
    { id: 36, nome: "Cafeteira Dolce Gusto", categoria: "Eletrodomésticos", preco: 450.0, estoque: 20, descricao: "Cafeteira Dolce Gusto de alta qualidade, categoria Eletrodomésticos." },
    { id: 37, nome: "Liquidificador Mondial", categoria: "Eletrodomésticos", preco: 120.0, estoque: 50, descricao: "Liquidificador Mondial de alta qualidade, categoria Eletrodomésticos." },
    { id: 38, nome: "Batedeira Arno", categoria: "Eletrodomésticos", preco: 280.0, estoque: 30, descricao: "Batedeira Arno de alta qualidade, categoria Eletrodomésticos." },
    { id: 39, nome: "Aspirador de Po Electrolux", categoria: "Eletrodomésticos", preco: 350.0, estoque: 22, descricao: "Aspirador de Po Electrolux de alta qualidade, categoria Eletrodomésticos." },
    { id: 40, nome: "Purificador de Agua", categoria: "Eletrodomésticos", preco: 600.0, estoque: 15, descricao: "Purificador de Agua de alta qualidade, categoria Eletrodomésticos." },
    { id: 41, nome: "Cama Box Casal", categoria: "Casa", preco: 1100.0, estoque: 8, descricao: "Cama Box Casal de alta qualidade, categoria Casa." },
    { id: 42, nome: "Guarda Roupa 6 Portas", categoria: "Casa", preco: 1800.0, estoque: 5, descricao: "Guarda Roupa 6 Portas de alta qualidade, categoria Casa." },
    { id: 43, nome: "Sofá 3 Lugares Retrátil", categoria: "Casa", preco: 1900.0, estoque: 7, descricao: "Sofá 3 Lugares Retrátil de alta qualidade, categoria Casa." },
    { id: 44, nome: "Painel para TV até 55 polegadas", categoria: "Casa", preco: 550.0, estoque: 15, descricao: "Painel para TV até 55 polegadas de alta qualidade, categoria Casa." },
    { id: 45, nome: "Colchão Casal D33", categoria: "Casa", preco: 750.0, estoque: 12, descricao: "Colchão Casal D33 de alta qualidade, categoria Casa." },
    { id: 46, nome: "Ventilador Arno", categoria: "Casa", preco: 250.0, estoque: 30, descricao: "Ventilador Arno de alta qualidade, categoria Casa." },
    { id: 47, nome: "Panela de Pressao 5L", categoria: "Casa", preco: 130.0, estoque: 40, descricao: "Panela de Pressao 5L de alta qualidade, categoria Casa." },
    { id: 48, nome: "Espelho Decorativo", categoria: "Casa", preco: 200.0, estoque: 18, descricao: "Espelho Decorativo de alta qualidade, categoria Casa." },
    { id: 49, nome: "Cortina Blackout", categoria: "Casa", preco: 150.0, estoque: 25, descricao: "Cortina Blackout de alta qualidade, categoria Casa." },
    { id: 50, nome: "Luminaria LED", categoria: "Casa", preco: 80.0, estoque: 50, descricao: "Luminaria LED de alta qualidade, categoria Casa." },
    { id: 51, nome: "Tênis Nike Air Force 1", categoria: "Moda", preco: 600.0, estoque: 25, descricao: "Tênis Nike Air Force 1 de alta qualidade, categoria Moda." },
    { id: 52, nome: "Tênis Adidas Ultraboost", categoria: "Moda", preco: 800.0, estoque: 20, descricao: "Tênis Adidas Ultraboost de alta qualidade, categoria Moda." },
    { id: 53, nome: "Camisa Brasil Nike", categoria: "Moda", preco: 300.0, estoque: 40, descricao: "Camisa Brasil Nike de alta qualidade, categoria Moda." },
    { id: 54, nome: "Camisa Argentina Adidas", categoria: "Moda", preco: 300.0, estoque: 35, descricao: "Camisa Argentina Adidas de alta qualidade, categoria Moda." },
    { id: 55, nome: "Jaqueta Jeans Masculina", categoria: "Moda", preco: 250.0, estoque: 15, descricao: "Jaqueta Jeans Masculina de alta qualidade, categoria Moda." },
    { id: 56, nome: "Vestido Feminino Casual", categoria: "Moda", preco: 180.0, estoque: 30, descricao: "Vestido Feminino Casual de alta qualidade, categoria Moda." },
    { id: 57, nome: "Mochila Executiva para Notebook", categoria: "Moda", preco: 200.0, estoque: 45, descricao: "Mochila Executiva para Notebook de alta qualidade, categoria Moda." },
    { id: 58, nome: "Oculos de Sol Ray-Ban", categoria: "Moda", preco: 500.0, estoque: 18, descricao: "Oculos de Sol Ray-Ban de alta qualidade, categoria Moda." },
    { id: 59, nome: "Relogio Casio", categoria: "Moda", preco: 250.0, estoque: 25, descricao: "Relogio Casio de alta qualidade, categoria Moda." },
    { id: 60, nome: "Bone Adidas", categoria: "Moda", preco: 120.0, estoque: 40, descricao: "Bone Adidas de alta qualidade, categoria Moda." },
    { id: 61, nome: "Perfume Chanel No.5", categoria: "Beleza", preco: 900.0, estoque: 12, descricao: "Perfume Chanel No.5 de alta qualidade, categoria Beleza." },
    { id: 62, nome: "Protetor Solar La Roche-Posay", categoria: "Beleza", preco: 90.0, estoque: 60, descricao: "Protetor Solar La Roche-Posay de alta qualidade, categoria Beleza." },
    { id: 63, nome: "Base Liquida Boca Rosa", categoria: "Beleza", preco: 70.0, estoque: 50, descricao: "Base Liquida Boca Rosa de alta qualidade, categoria Beleza." },
    { id: 64, nome: "Serum Facial Vitamina C", categoria: "Beleza", preco: 110.0, estoque: 40, descricao: "Serum Facial Vitamina C de alta qualidade, categoria Beleza." },
    { id: 65, nome: "Mascara de Cilios Maybelline", categoria: "Beleza", preco: 60.0, estoque: 55, descricao: "Mascara de Cilios Maybelline de alta qualidade, categoria Beleza." },
    { id: 66, nome: "Chapinha Gama Italy", categoria: "Beleza", preco: 220.0, estoque: 25, descricao: "Chapinha Gama Italy de alta qualidade, categoria Beleza." },
    { id: 67, nome: "Kit Pinceis de Maquiagem", categoria: "Beleza", preco: 80.0, estoque: 45, descricao: "Kit Pinceis de Maquiagem de alta qualidade, categoria Beleza." },
    { id: 68, nome: "Bicicleta Aro Shimano", categoria: "Esporte", preco: 1800.0, estoque: 10, descricao: "Bicicleta Aro Shimano de alta qualidade, categoria Esporte." },
    { id: 69, nome: "Esteira Eletrica", categoria: "Esporte", preco: 3200.0, estoque: 5, descricao: "Esteira Eletrica de alta qualidade, categoria Esporte." },
    { id: 70, nome: "Halter 10kg", categoria: "Esporte", preco: 120.0, estoque: 30, descricao: "Halter 10kg de alta qualidade, categoria Esporte." },
    { id: 71, nome: "Corda de Pular", categoria: "Esporte", preco: 40.0, estoque: 80, descricao: "Corda de Pular de alta qualidade, categoria Esporte." },
    { id: 72, nome: "Bola de Futebol Adidas Champions", categoria: "Esporte", preco: 180.0, estoque: 40, descricao: "Bola de Futebol Adidas Champions de alta qualidade, categoria Esporte." },
    { id: 73, nome: "Chuteira Nike", categoria: "Esporte", preco: 350.0, estoque: 25, descricao: "Chuteira Nike de alta qualidade, categoria Esporte." },
    { id: 74, nome: "Luva de Boxe Venum 12oz", categoria: "Esporte", preco: 280.0, estoque: 15, descricao: "Luva de Boxe Venum 12oz de alta qualidade, categoria Esporte." },
    { id: 75, nome: "Kimono Jiu Jitsu", categoria: "Esporte", preco: 450.0, estoque: 12, descricao: "Kimono Jiu Jitsu de alta qualidade, categoria Esporte." },
    { id: 76, nome: "Capacete Ciclismo Absolute", categoria: "Esporte", preco: 150.0, estoque: 20, descricao: "Capacete Ciclismo Absolute de alta qualidade, categoria Esporte." },
    { id: 77, nome: "Livro Clean Code", categoria: "Livros", preco: 85.0, estoque: 50, descricao: "Livro Clean Code de alta qualidade, categoria Livros." },
    { id: 78, nome: "Livro Arquitetura Limpa", categoria: "Livros", preco: 90.0, estoque: 45, descricao: "Livro Arquitetura Limpa de alta qualidade, categoria Livros." },
    { id: 79, nome: "Livro O Codificador Limpo", categoria: "Livros", preco: 80.0, estoque: 30, descricao: "Livro O Codificador Limpo de alta qualidade, categoria Livros." },
    { id: 80, nome: "Livro Entendendo Algoritmos", categoria: "Livros", preco: 75.0, estoque: 40, descricao: "Livro Entendendo Algoritmos de alta qualidade, categoria Livros." },
    { id: 81, nome: "Livro Padroes de Projeto", categoria: "Livros", preco: 95.0, estoque: 25, descricao: "Livro Padroes de Projeto de alta qualidade, categoria Livros." },
    { id: 82, nome: "Livro Harry Potter", categoria: "Livros", preco: 60.0, estoque: 60, descricao: "Livro Harry Potter de alta qualidade, categoria Livros." },
    { id: 83, nome: "Livro O Hobbit", categoria: "Livros", preco: 50.0, estoque: 55, descricao: "Livro O Hobbit de alta qualidade, categoria Livros." },
    { id: 84, nome: "Lego Classic 500 Pecas", categoria: "Brinquedos", preco: 250.0, estoque: 20, descricao: "Lego Classic 500 Pecas de alta qualidade, categoria Brinquedos." },
    { id: 85, nome: "Boneca Barbie", categoria: "Brinquedos", preco: 120.0, estoque: 35, descricao: "Boneca Barbie de alta qualidade, categoria Brinquedos." },
    { id: 86, nome: "Carrinho Hot Wheels", categoria: "Brinquedos", preco: 20.0, estoque: 150, descricao: "Carrinho Hot Wheels de alta qualidade, categoria Brinquedos." },
    { id: 87, nome: "Pista Hot Wheels Loop", categoria: "Brinquedos", preco: 220.0, estoque: 15, descricao: "Pista Hot Wheels Loop de alta qualidade, categoria Brinquedos." },
    { id: 88, nome: "Quebra-Cabeca 1000 Pecas", categoria: "Brinquedos", preco: 70.0, estoque: 30, descricao: "Quebra-Cabeca 1000 Pecas de alta qualidade, categoria Brinquedos." },
    { id: 89, nome: "Massinha Play-Doh Kit", categoria: "Brinquedos", preco: 60.0, estoque: 40, descricao: "Massinha Play-Doh Kit de alta qualidade, categoria Brinquedos." },
    { id: 90, nome: "Pelucia Pokemon Pikachu", categoria: "Brinquedos", preco: 90.0, estoque: 25, descricao: "Pelucia Pokemon Pikachu de alta qualidade, categoria Brinquedos." },
    { id: 91, nome: "Jogo Imagem & Acao", categoria: "Brinquedos", preco: 110.0, estoque: 20, descricao: "Jogo Imagem & Acao de alta qualidade, categoria Brinquedos." },
    { id: 92, nome: "Racao para Cachorro 10kg", categoria: "Pet", preco: 130.0, estoque: 40, descricao: "Racao para Cachorro 10kg de alta qualidade, categoria Pet." },
    { id: 93, nome: "Cama para Cachorro", categoria: "Pet", preco: 120.0, estoque: 25, descricao: "Cama para Cachorro de alta qualidade, categoria Pet." },
    { id: 94, nome: "Brinquedo para Gato", categoria: "Pet", preco: 30.0, estoque: 60, descricao: "Brinquedo para Gato de alta qualidade, categoria Pet." },
    { id: 95, nome: "Arranhador para Gato", categoria: "Pet", preco: 150.0, estoque: 18, descricao: "Arranhador para Gato de alta qualidade, categoria Pet." },
    { id: 96, nome: "Areia para Gato", categoria: "Pet", preco: 40.0, estoque: 70, descricao: "Areia para Gato de alta qualidade, categoria Pet." },
    { id: 97, nome: "Comedouro Automatico", categoria: "Pet", preco: 90.0, estoque: 20, descricao: "Comedouro Automatico de alta qualidade, categoria Pet." },
    { id: 98, nome: "Shampoo Pet", categoria: "Pet", preco: 35.0, estoque: 50, descricao: "Shampoo Pet de alta qualidade, categoria Pet." },
    { id: 99, nome: "Coleira Pet", categoria: "Pet", preco: 45.0, estoque: 45, descricao: "Coleira Pet de alta qualidade, categoria Pet." },
    { id: 100, nome: "Arroz 5kg", categoria: "Alimentos", preco: 28.0, estoque: 100, descricao: "Arroz 5kg de alta qualidade, categoria Alimentos." },
    { id: 101, nome: "Feijao 1kg", categoria: "Alimentos", preco: 9.0, estoque: 100, descricao: "Feijao 1kg de alta qualidade, categoria Alimentos." },
    { id: 102, nome: "Azeite Extra Virgem", categoria: "Alimentos", preco: 35.0, estoque: 50, descricao: "Azeite Extra Virgem de alta qualidade, categoria Alimentos." },
    { id: 103, nome: "Cafe Premium 500g", categoria: "Alimentos", preco: 22.0, estoque: 60, descricao: "Cafe Premium 500g de alta qualidade, categoria Alimentos." },
    { id: 104, nome: "Leite Integral 1L", categoria: "Alimentos", preco: 6.0, estoque: 120, descricao: "Leite Integral 1L de alta qualidade, categoria Alimentos." },
    { id: 105, nome: "Macarrao 500g", categoria: "Alimentos", preco: 5.0, estoque: 100, descricao: "Macarrao 500g de alta qualidade, categoria Alimentos." },
    { id: 106, nome: "Chocolate Lindt", categoria: "Alimentos", preco: 25.0, estoque: 80, descricao: "Chocolate Lindt de alta qualidade, categoria Alimentos." },
    { id: 107, nome: "Refrigerante Coca-Cola 2L", categoria: "Alimentos", preco: 10.0, estoque: 150, descricao: "Refrigerante Coca-Cola 2L de alta qualidade, categoria Alimentos." },
    { id: 108, nome: "Pneu Michelin Aro 15", categoria: "Automotivo", preco: 600.0, estoque: 16, descricao: "Pneu Michelin Aro 15 de alta qualidade, categoria Automotivo." },
    { id: 109, nome: "Oleo Motor 5W30", categoria: "Automotivo", preco: 60.0, estoque: 50, descricao: "Oleo Motor 5W30 de alta qualidade, categoria Automotivo." },
    { id: 110, nome: "Bateria Automotiva", categoria: "Automotivo", preco: 500.0, estoque: 10, descricao: "Bateria Automotiva de alta qualidade, categoria Automotivo." },
    { id: 111, nome: "Kit Multimidia Carro", categoria: "Automotivo", preco: 1100.0, estoque: 12, descricao: "Kit Multimidia Carro de alta qualidade, categoria Automotivo." },
    { id: 112, nome: "Lampada LED", categoria: "Automotivo", preco: 40.0, estoque: 70, descricao: "Lampada LED de alta qualidade, categoria Automotivo." },
    { id: 113, nome: "Capa para Banco", categoria: "Automotivo", preco: 180.0, estoque: 20, descricao: "Capa para Banco de alta qualidade, categoria Automotivo." },
    { id: 114, nome: "Sensor de Re", categoria: "Automotivo", preco: 120.0, estoque: 30, descricao: "Sensor de Re de alta qualidade, categoria Automotivo." },
    { id: 115, nome: "Som Automotivo Pioneer", categoria: "Automotivo", preco: 450.0, estoque: 15, descricao: "Som Automotivo Pioneer de alta qualidade, categoria Automotivo." },
    { id: 116, nome: "SSD NVMe 1TB Kingston", categoria: "Informatica", preco: 450.0, estoque: 40, descricao: "SSD NVMe 1TB Kingston de alta qualidade, categoria Informatica." },
    { id: 117, nome: "Memoria RAM 16GB DDR4", categoria: "Informatica", preco: 280.0, estoque: 50, descricao: "Memoria RAM 16GB DDR4 de alta qualidade, categoria Informatica." },
    { id: 118, nome: "Placa de Video", categoria: "Informatica", preco: 2500.0, estoque: 8, descricao: "Placa de Video de alta qualidade, categoria Informatica." },
    { id: 119, nome: "Roteador TP-Link AC1200", categoria: "Informatica", preco: 200.0, estoque: 30, descricao: "Roteador TP-Link AC1200 de alta qualidade, categoria Informatica." },
    { id: 120, nome: "Impressora HP DeskJet 2774", categoria: "Informatica", preco: 380.0, estoque: 15, descricao: "Impressora HP DeskJet 2774 de alta qualidade, categoria Informatica." },
    { id: 121, nome: "Webcam Full HD Logitech", categoria: "Informatica", preco: 250.0, estoque: 25, descricao: "Webcam Full HD Logitech de alta qualidade, categoria Informatica." },
    { id: 122, nome: "Hub USB-C 7 em 1", categoria: "Informatica", preco: 150.0, estoque: 35, descricao: "Hub USB-C 7 em 1 de alta qualidade, categoria Informatica." }
];

// CARREGAMENTO DE PRODUTOS LOCAL (Modo Portfólio Estático)
function carregarProdutos() {
    console.log('Carregando catálogo estático completo com', todosProdutos.length, 'produtos...');
    
    // Associa as imagens mapeadas a cada produto
    const produtosFormatados = todosProdutos.map(produto => ({
        ...produto,
        imagemUrl: obterCaminhoImagem(produto.nome)
    }));

    renderizarProdutos(produtosFormatados);
    atualizarContadorCarrinho();
}

// Renderiza os produtos na tela
function renderizarProdutos(produtos) {
    exibirProdutos(produtos);
}

// EXIBIÇÃO NA TELA
function exibirProdutos(produtos) {
    const container = document.querySelector('.lista-produtos');
    if (!container) return;

    if (!produtos || produtos.length === 0) {
        container.innerHTML = '<p style="grid-column: 1/-1; text-align: center; padding: 20px; color: #666; width: 100%;">Nenhum produto encontrado.</p>';
        return;
    }

    container.innerHTML = produtos.map((prod, index) => {
        const precoNum = typeof prod.preco === 'number' ? prod.preco : 0;
        const precoFormatado = precoNum.toLocaleString('pt-BR', { style: 'currency', currency: 'BRL' });

        const nomeParaCodigo = (prod.nome || '').split('').reduce((acc, char) => acc + char.charCodeAt(0), 0);
        const vendidosSimulados = ((index * 37 + nomeParaCodigo * 13) % 280) + 12;
        const identificador = prod.id ? prod.id : `'${(prod.nome || '').replace(/'/g, "\\'")}'`;

        const imagemFinal = obterCaminhoImagem(prod.nome);
        prod.imagemUrl = imagemFinal;

        return `
            <article class="card-produto" style="border: 1px solid #eee; padding: 15px; border-radius: 8px; background: white; text-align: center;">
                 <img src="${imagemFinal}" 
                    alt="${prod.nome || 'Produto'}" 
                    onerror="tratarErroImagem(this);" 
                    style="width: 100%; height: 160px; object-fit: contain; border-radius: 4px; margin-bottom: 8px;">
                <h4 style="margin: 10px 0 5px 0;">${prod.nome || 'Produto'}</h4>
                <p class="preco" style="font-weight: bold; color: #e65100; font-size: 1.1rem; margin: 5px 0;">${precoFormatado}</p>
                <span class="vendidos" style="display: block; font-size: 0.8rem; color: #888; margin-bottom: 12px;">${vendidosSimulados} vendidos</span>
                
                <div style="display: flex; gap: 5px; flex-direction: column;">
                    <button type="button" onclick="verDetalhes(${identificador})" style="background: #f5f5f5; color: #333; border: 1px solid #ccc; padding: 6px; border-radius: 4px; cursor: pointer; font-size: 0.85rem;">Ver Detalhes</button>
                    <button type="button" onclick="adicionarAoCarrinho('${(prod.nome || '').replace(/'/g, "\\'")}')" style="background: #fff3e0; color: #e65100; border: 1px solid #e65100; padding: 8px; border-radius: 4px; cursor: pointer; font-weight: bold;">Adicionar ao Carrinho</button>
                    <button type="button" onclick="comprarAgora('${(prod.nome || '').replace(/'/g, "\\'")}')" style="background: #e65100; color: white; border: none; padding: 8px; border-radius: 4px; cursor: pointer; font-weight: bold;">Compre Agora</button>
                </div>
            </article>
        `;
    }).join('');
}

// FILTRAGEM DE PRODUTOS CORRIGIDA
function aplicarFiltros() {
    const inputBusca = document.querySelector('.busca input');
    const termoBuscaNorm = normalizarTexto(inputBusca ? inputBusca.value : '');
    const catFiltroNorm = normalizarTexto(categoriaAtiva);
    const tituloSecao = document.querySelector('.produtos h3');

    if (termoBuscaNorm === '' && (catFiltroNorm === 'todos' || catFiltroNorm === '')) {
        if (tituloSecao) tituloSecao.innerText = 'Produtos em Destaque';
        const destaques = [...todosProdutos].sort((a, b) => (a.preco || 0) - (b.preco || 0)).slice(0, 12);
        exibirProdutos(destaques);
        return;
    }

    if (tituloSecao) tituloSecao.innerText = `Resultados para: ${inputBusca && inputBusca.value ? inputBusca.value : categoriaAtiva}`;

    const filtrados = todosProdutos.filter(prod => {
        const nomeNorm = normalizarTexto(prod.nome);
        const catNorm = normalizarTexto(prod.categoria);

        const bateBusca = termoBuscaNorm === '' || nomeNorm.includes(termoBuscaNorm) || catNorm.includes(termoBuscaNorm);
        const bateCategoria = catFiltroNorm === 'todos' || catFiltroNorm === '' || catNorm === catFiltroNorm;

        return bateBusca && bateCategoria;
    });

    exibirProdutos(filtrados);
}

// VOLTAR À HOME / RESETA BUSCA
function voltarParaHome() {
    const inputBusca = document.querySelector('.busca input');
    if (inputBusca) inputBusca.value = '';

    categoriaAtiva = 'Todos';
    aplicarFiltros();
}

// ATUALIZAR CONTADOR CARRINHO
function atualizarContadorCarrinho() {
    const btnCarrinho = document.getElementById('btnCarrinho');
    if (btnCarrinho) {
        btnCarrinho.innerText = `Carrinho (${quantidadeCarrinho})`;
    }
}

// AÇÕES DE COMPRA E DETALHES COM AVISO DE TESTE/PORTFÓLIO
window.comprarAgora = function(nomeProduto) {
    alert(`⚠️ Atenção: Este é um projeto de portfólio/demonstrativo (ExpressMarket). A compra do item "${nomeProduto}" é apenas um teste e não pode ser finalizada.`);
};

window.adicionarAoCarrinho = function(nome) {
    quantidadeCarrinho++;
    atualizarContadorCarrinho();
    alert(`⚠️ Aviso de Demonstração: "${nome}" foi adicionado ao carrinho de teste (este é um projeto de portfólio).`);
};

// EXIBE O LOCAL DE ENVIO APENAS NA MODAL DE DETALHES
window.verDetalhes = function(chaveBusca) {
    const produto = todosProdutos.find(p => p.id === chaveBusca || p.nome === chaveBusca);
    
    if (!produto) {
        console.warn('Produto não encontrado:', chaveBusca);
        return;
    }

    const locaisEnvio = [
        'Brasília, Distrito Federal',
        'São Paulo, São Paulo',
        'Rio de Janeiro, Rio de Janeiro',
        'Salvador, Bahia',
        'Curitiba, Paraná',
        'Recife, Pernambuco',
        'Goiânia, Goiás',
        'Florianópolis, Santa Catarina',
        'Internacional',
        'Internacional'
    ];

    const idParaCalculo = produto.id || (produto.nome || '').length;
    const envioOrigem = produto.enviadoDe || locaisEnvio[idParaCalculo % locaisEnvio.length];
    const imagemModal = obterCaminhoImagem(produto.nome);

    const conteudoModal = document.getElementById('modalDetalhesConteudo');
    if (conteudoModal) {
        conteudoModal.innerHTML = `
            <h2>${produto.nome}</h2>
            <img src="${imagemModal}" 
                   alt="${produto.nome}" 
                   onerror="this.onerror=null; this.src='${IMAGEM_PADRAO}';" 
                   style="max-width: 200px; height: 160px; object-fit: contain; margin: 10px 0;">
            <p class="preco-destaque" style="font-size: 1.5rem; color: #e65100; font-weight: bold;">
                ${(produto.preco || 0).toLocaleString('pt-BR', { style: 'currency', currency: 'BRL' })}
            </p>
            <hr style="margin: 10px 0;">
            <div class="detalhes-grid" style="text-align: left; display: grid; gap: 8px;">
                <p><strong>Categoria:</strong> ${produto.categoria || 'Geral'}</p>
                <p><strong>Estoque Disponível:</strong> ${produto.estoque !== undefined ? produto.estoque : 10} unidades</p>
                <p style="color: #2e7d32; font-weight: bold;">📍 Envio de: ${envioOrigem}</p>
                <p><strong>Garantia:</strong> ${envioOrigem === 'Internacional' ? '1 Mês (Garantia Internacional)' : '3 Meses (Garantia do Fabricante)'}</p>
                <p><strong>Condição:</strong> Novo</p>
            </div>
            <hr style="margin: 10px 0;">
            <h4>Descrição do Produto</h4>
            <p style="text-align: left; color: #555;">
                ${produto.descricao || `${produto.nome} de excelente qualidade. Envio rápido diretamente de ${envioOrigem}.`}
            </p>
        `;
        abrirModal('modalDetalhes');
    }
};

// CONTROLE DE MODAIS
function abrirModal(id) {
    const el = document.getElementById(id);
    if (el) el.style.display = 'flex';
}

function fecharModal(id) {
    const el = document.getElementById(id);
    if (el) el.style.display = 'none';
    
    const errBox = document.getElementById('mensagemErroLogin');
    if (errBox) errBox.style.display = 'none';
}

function alternarAbaAuth(aba) {
    const formLogin = document.getElementById('formLoginModal');
    const formCadastro = document.getElementById('formCadastroModal');
    const errBox = document.getElementById('mensagemErroLogin');

    if (errBox) errBox.style.display = 'none';

    if (aba === 'login') {
        formLogin.style.display = 'block';
        formCadastro.style.display = 'none';
    } else {
        formLogin.style.display = 'none';
        formCadastro.style.display = 'block';
    }
}

function consultarRastreio() {
    const cod = document.getElementById('inputCodigoRastreio').value.trim();
    const statusDiv = document.getElementById('statusRastreio');

    if (!cod) {
        statusDiv.style.color = '#d32f2f';
        statusDiv.innerText = 'Por favor, digite um código válido.';
        return;
    }

    statusDiv.style.color = '#2e7d32';
    statusDiv.innerText = `Status [${cod.toUpperCase()}]: Pacote em trânsito. Unidade de Distribuição -> Brasília/DF.`;
}

// AUTENTICAÇÃO
function realizarLogin(e) {
    e.preventDefault();
    const emailInput = document.getElementById('emailLogin').value.trim();
    const senhaInput = document.getElementById('senhaLogin').value.trim();
    const errBox = document.getElementById('mensagemErroLogin');

    if (emailInput === 'cliente@teste.com' && senhaInput === '123456') {
        usuarioAutenticado = true;
        alert(`Login realizado com sucesso! Bem-vindo(a)`);
        fecharModal('modalLogin');
        
        const btnLogin = document.getElementById('btnLogin');
        if (btnLogin) btnLogin.innerText = 'Minha Conta';
    } else {
        if (errBox) errBox.style.display = 'block';
    }
}

function realizarCadastro(e) {
    e.preventDefault();
    const nome = document.getElementById('cadNome').value;
    alert(`Conta criada com sucesso! Seja bem-vindo(a), ${nome}.`);
    alternarAbaAuth('login');
}

function fazerLoginSocial(provedor) {
    usuarioAutenticado = true;
    alert(`Login realizado com sucesso via ${provedor}!`);
    fecharModal('modalLogin');
    
    const btnLogin = document.getElementById('btnLogin');
    if (btnLogin) {
        btnLogin.innerText = 'Minha Conta';
    }
}

// CARROSSEL DE BANNERS
function atualizarCarrossel() {
    const slider = document.getElementById('sliderBanners');
    const dots = document.querySelectorAll('.dot-banner');

    if (slider) {
        slider.style.transform = `translateX(-${bannerAtual * (100 / totalBanners)}%)`;
    }

    dots.forEach((dot, idx) => {
        dot.style.opacity = idx === bannerAtual ? '1' : '0.4';
    });
}

function proximoBanner() {
    bannerAtual = (bannerAtual + 1) % totalBanners;
    atualizarCarrossel();
}

function bannerAnterior() {
    bannerAtual = (bannerAtual - 1 + totalBanners) % totalBanners;
    atualizarCarrossel();
}

function resetarTimer() {
    if (bannerInterval) clearInterval(bannerInterval);
    bannerInterval = setInterval(proximoBanner, 4000);
}

function inicializarCarrossel() {
    const btnNext = document.getElementById('btnNextBanner');
    const btnPrev = document.getElementById('btnPrevBanner');
    const dots = document.querySelectorAll('.dot-banner');

    if (btnNext) {
        btnNext.onclick = (e) => {
            e.preventDefault();
            e.stopPropagation();
            proximoBanner();
            resetarTimer();
        };
    }

    if (btnPrev) {
        btnPrev.onclick = (e) => {
            e.preventDefault();
            e.stopPropagation();
            bannerAnterior();
            resetarTimer();
        };
    }

    dots.forEach((dot, index) => {
        dot.onclick = (e) => {
            e.preventDefault();
            e.stopPropagation();
            bannerAtual = index;
            atualizarCarrossel();
            resetarTimer();
        };
    });

    resetarTimer();
}

// CONFIGURAÇÃO DOS EVENTOS DO DOM
function configurarEventos() {
    const logoHome = document.getElementById('logoHome');
    if (logoHome) {
        logoHome.style.cursor = 'pointer';
        logoHome.addEventListener('click', voltarParaHome);
    }

    const itensCategoria = document.querySelectorAll('.categorias ul li');
    itensCategoria.forEach(item => {
        item.style.cursor = 'pointer';
        item.addEventListener('click', (e) => {
            categoriaAtiva = e.target.innerText.trim();
            aplicarFiltros();
        });
    });

    const inputBusca = document.querySelector('.busca input');
    const btnBuscar = document.querySelector('.busca button');

    if (inputBusca) {
        inputBusca.addEventListener('keypress', (e) => {
            if (e.key === 'Enter') {
                e.preventDefault();
                aplicarFiltros();
            }
        });
    }

    if (btnBuscar) {
        btnBuscar.addEventListener('click', (e) => {
            e.preventDefault();
            aplicarFiltros();
        });
    }

    const btnRastreio = document.getElementById('btnRastreio');
    const btnLogin = document.getElementById('btnLogin');
    const btnCarrinho = document.getElementById('btnCarrinho');

    if (btnRastreio) {
        btnRastreio.addEventListener('click', () => abrirModal('modalRastreio'));
    }

    if (btnLogin) {
        btnLogin.addEventListener('click', () => abrirModal('modalLogin'));
    }

    if (btnCarrinho) {
        btnCarrinho.addEventListener('click', () => {
            alert(`⚠️ Este carrinho faz parte de um ambiente de demonstração/portfólio. Você tem ${quantidadeCarrinho} item(ns) simulado(s).`);
        });
    }
}

// INICIALIZAÇÃO DA APLICAÇÃO
document.addEventListener('DOMContentLoaded', () => {
    carregarProdutos();
    configurarEventos();
    inicializarCarrossel();
});

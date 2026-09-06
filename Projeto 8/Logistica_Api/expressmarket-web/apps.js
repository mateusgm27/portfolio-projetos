// Porta local da API .NET
const API_URL = "http://localhost:5000/api";

let todosProdutos = [];
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

// Manipulador inteligente de erro para fallback automático
window.tratarErroImagem = function(img) {
    img.onerror = null;
    img.src = IMAGEM_PADRAO;
};

// CARREGAMENTO DE PRODUTOS DIRETO DA API DO BANCO DE DADOS
async function carregarProdutos() {
    console.log('Buscando produtos do banco de dados na API...');
    
    try {
        const resposta = await fetch(`${API_URL}/produtos`);
        if (!resposta.ok) {
            throw new Error('Erro ao buscar produtos da API.');
        }

        const dadosDoBanco = await resposta.json();
        
        // Mapeia os dados garantindo compatibilidade com as propriedades do banco (id, nome, preco, categoria, estoque, descricao)
        todosProdutos = dadosDoBanco.map(prod => {
            return {
                id: prod.id || prod.Id,
                nome: prod.nome || prod.Nome,
                preco: Number(prod.preco || prod.Preco || 0),
                categoria: prod.categoria || prod.Categoria || "Geral",
                estoque: prod.estoque || prod.Estoque || 0,
                descricao: prod.descricao || prod.Descricao || `${prod.nome || prod.Nome} de excelente qualidade disponível no ExpressMarket.`
            };
        });

        console.log(`${todosProdutos.length} produtos carregados do banco de dados com sucesso!`);
    } catch (erro) {
        console.warn('⚠️ Falha ao conectar com a API local. Usando catálogo estático de segurança.', erro);
        
        // Fallback caso a API esteja desligada
        todosProdutos = Object.keys(mapaImagensOnline).map((chave, index) => {
            const nomeFormatado = chave.split(' ').map(palavra => palavra.charAt(0).toUpperCase() + palavra.slice(1)).join(' ');
            return {
                id: index + 1,
                nome: nomeFormatado,
                preco: 99.90,
                categoria: "Geral",
                estoque: 10,
                descricao: `${nomeFormatado} disponível (modo offline).`
            };
        });
    }

    aplicarFiltros();
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
        const destaques = [...todosProdutos].sort((a, b) => (a.preco || 0) - (b.preco || 0)).slice(0, 6);
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

// AÇÕES DE COMPRA E DETALHES COM AVISO DE TESTE/PORTFÓLIO
window.comprarAgora = function(nomeProduto) {
    alert(`⚠️ Atenção: Este é um projeto de portfólio/demonstrativo (ExpressMarket). A compra do item "${nomeProduto}" é apenas um teste e não pode ser finalizada.`);
};

window.adicionarAoCarrinho = function(nome) {
    quantidadeCarrinho++;
    const btnCarrinho = document.getElementById('btnCarrinho');
    if (btnCarrinho) {
        btnCarrinho.innerText = `Carrinho (${quantidadeCarrinho})`;
    }
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

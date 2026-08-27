// URL base da sua API C#
const API_URL = 'http://localhost:5242/api'; // Ajuste a porta se a sua for diferente (ex: 5001, 7000)

// Função para buscar produtos do banco via API
async function carregarProdutos() {
    try {
        const resposta = await fetch(`${API_URL}/Produtos`);
        if (!resposta.ok) throw new Error('Erro ao buscar produtos');

        const produtos = await resposta.json();
        exibirProdutos(produtos);
    } catch (erro) {
        console.error('Erro na requisição:', erro);
    }
}

// Função para desenhar os cards na tela dinamicamente
function exibirProdutos(produtos) {
    const container = document.querySelector('.lista-produtos');
    container.innerHTML = ''; // Limpa os 3 produtos de teste

    produtos.forEach(prod => {
        // Imagem genérica para exibição (pode trocar por URLs do banco se tiver)
        const imagemUrl = 'https://via.placeholder.com/200?text=' + encodeURIComponent(prod.nome);

        const card = `
            <article class="card-produto">
                <img src="${imagemUrl}" alt="${prod.nome}">
                <h4>${prod.nome}</h4>
                <p class="preco">R$ ${prod.preco.toFixed(2).replace('.', ',')}</p>
                <button onclick="adicionarAoCarrinho(${prod.id_produto})">Adicionar ao Carrinho</button>
            </article>
        `;
        container.innerHTML += card;
    });
}

// Carrega os dados quando a página abre
document.addEventListener('DOMContentLoaded', carregarProdutos);
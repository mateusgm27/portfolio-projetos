using System.Threading.Tasks;
using Microsoft.Extensions.Configuration;

// Importação de bibliotecas essenciais
using Microsoft.AspNetCore.Mvc; // Recursos para criação de APIs REST no .NET (Controller, HttpGet, HttpPost, etc)
using MySqlConnector;           // Driver para conectar o C# ao banco de dados MySQL
using Dapper;                   // Micro-ORM que facilita a execução de comandos SQL e mapeia os dados para objetos C#
using Logistica_Api.Models;     // Namespace onde está a nossa classe de modelo 'Produto'

namespace Logistica_Api.Controllers
{
    // Indicação de que esta classe é um controller de API (habilita validações automáticas de modelo)
    [ApiController] 
    // Define a rota base da API como 'api/produtos' (pega o nome da controller sem a palavra 'Controller')
    [Route("api/[controller]")] 
    public class ProdutosController : ControllerBase
    {
        // Variável privada para armazenar as configurações da aplicação (incluindo a string de conexão do MySQL)
        private readonly IConfiguration _config;

        // Construtor: Injeta a configuração do sistema (appsettings.json) na controller
        public ProdutosController(IConfiguration config)
        {
            _config = config;
        }

        // ==========================================
        // 1. GET: LISTAR TODOS OS PRODUTOS
        // ==========================================
        [HttpGet]
        public async Task<IActionResult> ObterProdutos()
        {
            // 'using' garante que a conexão com o banco será FECHADA automaticamente após a execução
            using var connection = new MySqlConnection(_config.GetConnectionString("DefaultConnection"));
            
            // Query SQL pura para buscar os registros
            string sql = "SELECT id_produto, nome, categoria, preco, peso, estoque FROM produtos";
            
            // Dapper executa a consulta de forma assíncrona e converte cada linha da tabela em um objeto 'Produto'
            var produtos = await connection.QueryAsync<Produto>(sql);
            
            // Retorna HTTP status 200 (OK) com a lista JSON de produtos
            return Ok(produtos);
        }

        // ==========================================
        // 2. GET POR ID: BUSCAR APENAS UM PRODUTO
        // ==========================================
        [HttpGet("{id}")] // O {id} indica que a URL receberá um parâmetro (ex: api/produtos/5)
        public async Task<IActionResult> ObterProdutoPorId(int id)
        {
            using var connection = new MySqlConnection(_config.GetConnectionString("DefaultConnection"));
            
            // Usamos '@id' para evitar SQL Injection (nunca concatene variáveis direto na string SQL)
            string sql = "SELECT id_produto, nome, categoria, preco, peso, estoque FROM produtos WHERE id_produto = @id";
            
            // Busca o primeiro registro ou retorna 'null' se não encontrar nada
            var produto = await connection.QueryFirstOrDefaultAsync<Produto>(sql, new { id });

            // Se o produto não existir no banco, retorna HTTP status 404 (Not Found)
            if (produto == null)
                return NotFound(new { mensagem = "Produto não encontrado!" });

            // Se encontrou, retorna HTTP status 200 (OK) com o produto
            return Ok(produto);
        }

        // ==========================================
        // 3. POST: CADASTRAR UM NOVO PRODUTO
        // ==========================================
        [HttpPost]
        // [FromBody] diz ao .NET para pegar o JSON vindo no corpo da requisição e converter na classe Produto
        public async Task<IActionResult> CadastrarProduto([FromBody] Produto produto)
        {
            using var connection = new MySqlConnection(_config.GetConnectionString("DefaultConnection"));
            
            // Comando SQL de inserção usando parâmetros com '@'
            string sql = @"INSERT INTO produtos (nome, categoria, preco, peso, estoque) 
                           VALUES (@nome, @categoria, @preco, @peso, @estoque)";

            // O Dapper substitui automaticamente os parâmetros (@nome, @preco...) pelas propriedades do objeto 'produto'
            await connection.ExecuteAsync(sql, produto);
            
            // Retorna HTTP status 200 (OK) com uma mensagem de sucesso
            return Ok(new { mensagem = "Produto cadastrado com sucesso!" });
        }

        // ==========================================
        // 4. PUT: ATUALIZAR UM PRODUTO EXISTENTE
        // ==========================================
        [HttpPut("{id}")] // Recebe o ID do produto a ser alterado pela URL (ex: api/produtos/10)
        public async Task<IActionResult> AtualizarProduto(int id, [FromBody] Produto produto)
        {
            using var connection = new MySqlConnection(_config.GetConnectionString("DefaultConnection"));
            
            // Comando SQL para atualizar as colunas onde o id_produto for igual ao id informado
            string sql = @"UPDATE produtos 
                           SET nome = @nome, categoria = @categoria, preco = @preco, peso = @peso, estoque = @estoque 
                           WHERE id_produto = @id_produto";

            // Garante que o objeto receba o mesmo ID enviado na URL
            produto.id_produto = id;

            // ExecuteAsync retorna a quantidade de linhas afetadas no banco de dados
            int linhasAfetadas = await connection.ExecuteAsync(sql, produto);

            // Se 0 linhas foram alteradas, significa que aquele ID não existia no banco
            if (linhasAfetadas == 0)
                return NotFound(new { mensagem = "Produto não encontrado para atualização!" });

            return Ok(new { mensagem = "Produto atualizado com sucesso!" });
        }

        // ==========================================
        // 5. DELETE: REMOVER UM PRODUTO
        // ==========================================
        [HttpDelete("{id}")] // Recebe o ID a ser deletado pela URL (ex: api/produtos/101)
        public async Task<IActionResult> DeletarProduto(int id)
        {
            using var connection = new MySqlConnection(_config.GetConnectionString("DefaultConnection"));
            
            string sql = "DELETE FROM produtos WHERE id_produto = @id";

            // Passa o parâmetro 'id' anonimamente para o Dapper
            int linhasAfetadas = await connection.ExecuteAsync(sql, new { id });

            // Se nada foi alterado/deletado, retorna status 404
            if (linhasAfetadas == 0)
                return NotFound(new { mensagem = "Produto não encontrado para remoção!" });

            return Ok(new { mensagem = "Produto deletado com sucesso!" });
        }
    }
}
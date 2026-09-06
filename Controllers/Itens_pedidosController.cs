using System.Threading.Tasks;
using Microsoft.Extensions.Configuration;

// Importações de bibliotecas necessárias para o funcionamento do controller REST e Dapper
using Microsoft.AspNetCore.Mvc; // Atributos de rotas e retornos HTTP (ControllerBase, HttpGet, etc.)
using MySqlConnector; // Driver oficial de conexão assíncrona com o MySQL
using Dapper; // Micro-ORM que converte registros do banco em objetos C#
using Logistica_Api.Models; // Namespace que contém o model 'ItemPedido'

namespace Logistica_Api.Controllers
{
    // Define que a classe responde a requisições de API e valida automaticamente o ModelState
    [ApiController]
    // Define a rota base da API como 'api/ItensPedidos' (pega o nome da classe sem a palavra Controller)
    [Route("api/[controller]")]
    public class ItensPedidosController : ControllerBase
    {
        // Interface responsável por ler as configurações da aplicação (appsettings.json)
        private readonly IConfiguration _config;

        // Construtor: Injeta a dependência de IConfiguration para acessar a string de conexão
        public ItensPedidosController(IConfiguration config)
        {
            _config = config;
        }

        // ==========================================
        // 1. GET: LISTAR TODOS OS ITENS
        // ==========================================
        [HttpGet]
        public async Task<IActionResult> ObterTodos()
        {
            // O 'using var' garante o fechamento e descarte automático da conexão após o término do método
            using var connection = new MySqlConnection(_config.GetConnectionString("DefaultConnection"));

            // Consulta SQL para selecionar todos os registros da tabela 'itens_pedidos'
            string sql = @"SELECT id_item, id_pedido, id_produto, quantidade, preco_unitario 
                           FROM itens_pedidos";

            // Executa a busca assíncrona e converte cada linha da tabela em um objeto 'ItemPedido'
            var itens = await connection.QueryAsync<ItemPedido>(sql);

            // Retorna o status HTTP 200 (OK) contendo a lista no formato JSON
            return Ok(itens);
        }

        // ==========================================
        // 2. GET POR ID: BUSCAR ITEM PELO ID_ITEM
        // ==========================================
        [HttpGet("{id}")] // O parâmetro {id} é passado via URL (ex: api/ItensPedidos/5)
        public async Task<IActionResult> ObterPorId(int id)
        {
            using var connection = new MySqlConnection(_config.GetConnectionString("DefaultConnection"));

            // Query com parâmetro '@id' para prevenir ataques de SQL Injection
            string sql = @"SELECT id_item, id_pedido, id_produto, quantidade, preco_unitario 
                           FROM itens_pedidos 
                           WHERE id_item = @id";

            // Busca apenas o primeiro registro correspondente ou retorna 'null' caso não exista
            var item = await connection.QueryFirstOrDefaultAsync<ItemPedido>(sql, new { id });

            // Se o objeto não for encontrado, retorna HTTP Status 404 (Not Found)
            if (item == null)
                return NotFound(new { mensagem = "Item de pedido não encontrado!" });

            // Retorna HTTP Status 200 (OK) enviando o item localizado
            return Ok(item);
        }

        // ==========================================
        // 3. GET POR PEDIDO: BUSCAR ITENS DE UM PEDIDO
        // ==========================================
        [HttpGet("pedido/{idPedido}")] // Rota personalizada para evitar conflito (ex: api/ItensPedidos/pedido/1)
        public async Task<IActionResult> ObterPorPedido(int idPedido)
        {
            using var connection = new MySqlConnection(_config.GetConnectionString("DefaultConnection"));

            // Query para filtrar todos os itens que pertencem ao mesmo id_pedido (Chave Estrangeira)
            string sql = @"SELECT id_item, id_pedido, id_produto, quantidade, preco_unitario 
                           FROM itens_pedidos 
                           WHERE id_pedido = @idPedido";

            // Retorna a coleção de itens associados àquele pedido específico
            var itens = await connection.QueryAsync<ItemPedido>(sql, new { idPedido });

            return Ok(itens);
        }

        // ==========================================
        // 4. POST: CADASTRAR NOVO ITEM NO PEDIDO
        // ==========================================
        [HttpPost]
        public async Task<IActionResult> Cadastrar([FromBody] ItemPedido item)
        {
            using var connection = new MySqlConnection(_config.GetConnectionString("DefaultConnection"));

            // Comando SQL de inserção utilizando os nomes dos atributos do objeto 'item'
            string sql = @"INSERT INTO itens_pedidos (id_pedido, id_produto, quantidade, preco_unitario) 
                           VALUES (@id_pedido, @id_produto, @quantidade, @preco_unitario)";

            // Mapeia automaticamente as propriedades de 'item' para os parâmetros com '@'
            await connection.ExecuteAsync(sql, item);

            // Retorna HTTP Status 200 (OK) com uma mensagem informativa
            return Ok(new { mensagem = "Item adicionado ao pedido com sucesso!" });
        }

        // ==========================================
        // 5. PUT: ATUALIZAR ITEM EXISTENTE
        // ==========================================
        [HttpPut("{id}")]
        public async Task<IActionResult> Atualizar(int id, [FromBody] ItemPedido item)
        {
            using var connection = new MySqlConnection(_config.GetConnectionString("DefaultConnection"));

            // Comando SQL de atualização de registro existente filtrado pelo id_item
            string sql = @"UPDATE itens_pedidos 
                           SET id_pedido = @id_pedido, 
                               id_produto = @id_produto, 
                               quantidade = @quantidade, 
                               preco_unitario = @preco_unitario 
                           WHERE id_item = @id";

            // Atribui o ID recebido pela URL ao objeto instanciado
            item.id_item = id;

            // Retorna a contagem de linhas afetadas pela alteração no banco
            int linhasAfetadas = await connection.ExecuteAsync(sql, item);

            // Se nenhuma linha foi alterada, o ID informado não existia no banco
            if (linhasAfetadas == 0)
                return NotFound(new { mensagem = "Item não encontrado para atualização!" });

            return Ok(new { mensagem = "Item atualizado com sucesso!" });
        }

        // ==========================================
        // 6. DELETE: REMOVER ITEM DO PEDIDO
        // ==========================================
        [HttpDelete("{id}")]
        public async Task<IActionResult> Deletar(int id)
        {
            using var connection = new MySqlConnection(_config.GetConnectionString("DefaultConnection"));

            // Comando SQL para apagar o registro pelo id_item
            string sql = "DELETE FROM itens_pedidos WHERE id_item = @id";

            // Executa a instrução passando o ID seguro por parâmetro
            int linhasAfetadas = await connection.ExecuteAsync(sql, new { id });

            // Caso a instrução não encontre o registro para deletar, informa o cliente
            if (linhasAfetadas == 0)
                return NotFound(new { mensagem = "Item não encontrado para remoção!" });

            return Ok(new { mensagem = "Item removido com sucesso!" });
        }
    }
}
// Importações de bibliotecas essenciais para o funcionamento da Controller
using Microsoft.AspNetCore.Mvc; // Recursos REST (ControllerBase, HttpGet, HttpPost, etc.)
using MySqlConnector; // Driver de conexão com o banco de dados MySQL
using Dapper; // Micro-ORM para simplificar consultas SQL no C#
using Logistica_Api.Models; // Namespace onde está a classe 'Pedido'

namespace Logistica_Api.Controllers
{
    // Indica que esta classe é uma Controller de API (ativa validações automáticas de modelo)
    [ApiController]
    // Define a rota base da API como 'api/pedidos'
    [Route("api/[controller]")]
    public class PedidosController : ControllerBase
    {
        private readonly IConfiguration _config;

        // Construtor: Recebe as configurações do sistema (ex: string de conexão do appsettings.json)
        public PedidosController(IConfiguration config)
        {
            _config = config;
        }

        // ==========================================
        // 1. GET: LISTAR TODOS OS PEDIDOS
        // ==========================================
        [HttpGet]
        public async Task<IActionResult> ObterPedidos()
        {
            // O 'using' garante o fechamento automático da conexão com o banco ao finalizar o método
            using var connection = new MySqlConnection(_config.GetConnectionString("DefaultConnection"));

            // Query SQL pura para buscar todos os registros da tabela 'pedidos'
            string sql = @"SELECT id_pedido, endereco_origem, endereco_destino, data_pedido, status, valor_total, id_cliente 
                           FROM pedidos";

            // O Dapper executa a consulta e mapeia os resultados diretamente para objetos do tipo 'Pedido'
            var pedidos = await connection.QueryAsync<Pedido>(sql);

            // Retorna HTTP 200 (OK) com a lista JSON dos pedidos
            return Ok(pedidos);
        }

        // ==========================================
        // 2. GET POR ID: BUSCAR APENAS UM PEDIDO
        // ==========================================
        [HttpGet("{id}")] // O {id} é passado diretamente na URL (ex: api/pedidos/3)
        public async Task<IActionResult> ObterPedidoPorId(int id)
        {
            using var connection = new MySqlConnection(_config.GetConnectionString("DefaultConnection"));

            // Uso de '@id' para evitar falhas de segurança por SQL Injection
            string sql = @"SELECT id_pedido, endereco_origem, endereco_destino, data_pedido, status, valor_total, id_cliente 
                           FROM pedidos 
                           WHERE id_pedido = @id";

            // Retorna o primeiro pedido encontrado ou 'null' se o ID não existir
            var pedido = await connection.QueryFirstOrDefaultAsync<Pedido>(sql, new { id });

            // Se não encontrar o pedido no banco, retorna HTTP status 404 (Not Found)
            if (pedido == null)
                return NotFound(new { mensagem = "Pedido não encontrado!" });

            // Se encontrar, retorna HTTP status 200 (OK) com o objeto retornado
            return Ok(pedido);
        }

        // ==========================================
        // 3. POST: CADASTRAR UM NOVO PEDIDO
        // ==========================================
        // ==========================================
        // 3. POST: CADASTRAR UM NOVO PEDIDO
        // ==========================================
        [HttpPost]
        public async Task<IActionResult> CadastrarPedido([FromBody] Pedido pedido)
        {
            // Validação simples de campos obrigatórios
            if (string.IsNullOrWhiteSpace(pedido.endereco_origem) || string.IsNullOrWhiteSpace(pedido.endereco_destino))
            {
                return BadRequest(new { mensagem = "Endereço de origem e destino são obrigatórios." });
            }

            try
            {
                using var connection = new MySqlConnection(_config.GetConnectionString("DefaultConnection"));

                string sql = @"INSERT INTO pedidos (endereco_origem, endereco_destino, data_pedido, status, valor_total, id_cliente) 
                               VALUES (@endereco_origem, @endereco_destino, @data_pedido, @status, @valor_total, @id_cliente);
                               SELECT LAST_INSERT_ID();";

                int idGerado = await connection.ExecuteScalarAsync<int>(sql, pedido);
                pedido.id_pedido = idGerado;

                return Ok(new { mensagem = "Pedido cadastrado com sucesso!", id = idGerado });
            }
            catch (MySqlException ex) when (ex.Number == 1452) // Trata o erro de Foreign Key (Cliente inexistente)
            {
                return BadRequest(new { mensagem = "O id_cliente informado não existe cadastrado no sistema!" });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { mensagem = "Erro interno no servidor ao cadastrar pedido.", detalhe = ex.Message });
            }
        }

        // ==========================================
        // 4. PUT: ATUALIZAR PEDIDO EXISTENTE
        // ==========================================
        [HttpPut("{id}")]
        public async Task<IActionResult> AtualizarPedido(int id, [FromBody] Pedido pedido)
        {
            using var connection = new MySqlConnection(_config.GetConnectionString("DefaultConnection"));

            string sql = @"UPDATE pedidos 
                           SET endereco_origem = @endereco_origem, 
                               endereco_destino = @endereco_destino, 
                               data_pedido = @data_pedido, 
                               status = @status, 
                               valor_total = @valor_total, 
                               id_cliente = @id_cliente 
                           WHERE id_pedido = @id_pedido";

            // Garante que o ID do parâmetro da rota seja aplicado ao objeto alterado
            pedido.id_pedido = id;

            // Retorna a quantidade de linhas que sofreram alteração no banco
            int linhasAfetadas = await connection.ExecuteAsync(sql, pedido);

            // Se nenhuma linha foi alterada, o registro não existia no banco
            if (linhasAfetadas == 0)
                return NotFound(new { mensagem = "Pedido não encontrado para atualização!" });

            return Ok(new { mensagem = "Pedido atualizado com sucesso!" });
        }

        // ==========================================
        // 5. DELETE: DELETAR PEDIDO
        // ==========================================
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeletarPedido(int id)
        {
            using var connection = new MySqlConnection(_config.GetConnectionString("DefaultConnection"));

            string sql = "DELETE FROM pedidos WHERE id_pedido = @id";

            // Executa a instrução de remoção no banco
            int linhasAfetadas = await connection.ExecuteAsync(sql, new { id });

            if (linhasAfetadas == 0)
                return NotFound(new { mensagem = "Pedido não encontrado para remoção!" });

            return Ok(new { mensagem = "Pedido deletado com sucesso!" });

            
        }
    }
}
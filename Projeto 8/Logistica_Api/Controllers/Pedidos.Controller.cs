// Importações globais do .NET
using System;
using System.Threading.Tasks;
using Microsoft.Extensions.Configuration;

// Importações de bibliotecas essenciais para o funcionamento da Controller
using Microsoft.AspNetCore.Mvc; // Recursos REST (ControllerBase, HttpGet, HttpPost, etc.)
using MySqlConnector;           // Driver de conexão com o banco de dados MySQL
using Dapper;                   // Micro-ORM para simplificar consultas SQL no C#
using Logistica_Api.Models;     // Namespace onde está a classe 'Pedido'

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
            using var connection = new MySqlConnection(_config.GetConnectionString("DefaultConnection"));

            string sql = @"SELECT id_pedido, endereco_origem, endereco_destino, data_pedido, status, valor_total, id_cliente 
                           FROM pedidos";

            var pedidos = await connection.QueryAsync<Pedido>(sql);

            return Ok(pedidos);
        }

        // ==========================================
        // 2. GET POR ID: BUSCAR APENAS UM PEDIDO
        // ==========================================
        [HttpGet("{id}")]
        public async Task<IActionResult> ObterPedidoPorId(int id)
        {
            using var connection = new MySqlConnection(_config.GetConnectionString("DefaultConnection"));

            string sql = @"SELECT id_pedido, endereco_origem, endereco_destino, data_pedido, status, valor_total, id_cliente 
                           FROM pedidos 
                           WHERE id_pedido = @id";

            var pedido = await connection.QueryFirstOrDefaultAsync<Pedido>(sql, new { id });

            if (pedido == null)
                return NotFound(new { mensagem = "Pedido não encontrado!" });

            return Ok(pedido);
        }

        // ==========================================
        // 3. POST: CADASTRAR UM NOVO PEDIDO
        // ==========================================
        [HttpPost]
        public async Task<IActionResult> CadastrarPedido([FromBody] Pedido pedido)
        {
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
            catch (MySqlException ex) when (ex.Number == 1452)
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

            pedido.id_pedido = id;

            int linhasAfetadas = await connection.ExecuteAsync(sql, pedido);

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

            int linhasAfetadas = await connection.ExecuteAsync(sql, new { id });

            if (linhasAfetadas == 0)
                return NotFound(new { mensagem = "Pedido não encontrado para remoção!" });

            return Ok(new { mensagem = "Pedido deletado com sucesso!" });
        }
    }
}
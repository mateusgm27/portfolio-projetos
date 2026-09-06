using System.Threading.Tasks;
using Microsoft.Extensions.Configuration;

// Importações de bibliotecas essenciais para o funcionamento da Controller
using Microsoft.AspNetCore.Mvc; // Recursos REST (ControllerBase, HttpGet, HttpPost, etc.)
using System.Linq; 
using MySqlConnector; // Driver de conexão com o banco de dados MySQL
using Dapper; // Micro-ORM para simplificar consultas SQL no C#
using Logistica_Api.Models; // Namespace onde está a classe 'Rastreamento'
namespace Logistica_Api.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class RastreamentosController : ControllerBase
    {
        private readonly IConfiguration _config;

        public RastreamentosController(IConfiguration config)
        {
            _config = config;
        }

        // 1. GET: Listar todas os rastreamentos
        [HttpGet]
        public async Task<IActionResult> ObterTodos()
        {
            using var connection = new MySqlConnection(_config.GetConnectionString("DefaultConnection"));

            string sql = @"SELECT id_rastreamento, id_entrega, status, data_hora,
                          localizacao, codigo_rastreio FROM rastreamentos";
            
            var rastreamentos = await connection.QueryAsync<Rastreamentos>(sql);
            return Ok(rastreamentos);
        }

        // 2. GET POR ID: Buscar rastreamento especifico
        [HttpGet("{id}")]
        public async Task<IActionResult> ObterPorId(int id)
        {
            using var connection = new MySqlConnection(_config.GetConnectionString("DefaultConnection"));

            string sql = @"SELECT id_rastreamento, id_entrega, status, data_hora, localizacao, codigo_rastreio
                           FROM rastreamentos 
                           WHERE id_rastreamento = @id";

            var rastreamento = await connection.QueryFirstOrDefaultAsync<Rastreamentos>(sql, new { id });

            if (rastreamento == null)
                return NotFound(new { mensagem = "Rastreamento não encontrado" });

            return Ok(rastreamento);
        }

        // 3. POST: CRIAR NOVO REGISTRO DE RASTREAMENTO
        [HttpPost]
        public async Task<IActionResult> Criar([FromBody] Rastreamentos rastreamento)
        {
            using var connection = new MySqlConnection(_config.GetConnectionString("DefaultConnection"));

            string sql = @"INSERT INTO rastreamentos (id_entrega, status, data_hora, localizacao, codigo_rastreio) 
                           VALUES (@id_entrega, @status, @data_hora, @localizacao, @codigo_rastreio);
                           SELECT LAST_INSERT_ID();";

            int idGerado = await connection.ExecuteScalarAsync<int>(sql, rastreamento);
            rastreamento.id_rastreamento = idGerado;

            return CreatedAtAction(nameof(ObterPorId), new { id = idGerado }, rastreamento);
        }

        // 4. PUT: ATUALIZAR RASTREAMENTO EXISTENTE
        [HttpPut("{id}")]
        public async Task<IActionResult> Atualizar(int id, [FromBody] Rastreamentos rastreamento)
        {
            using var connection = new MySqlConnection(_config.GetConnectionString("DefaultConnection"));

            string sql = @"UPDATE rastreamentos 
                           SET id_entrega = @id_entrega, 
                               status = @status, 
                               data_hora = @data_hora, 
                               localizacao = @localizacao, 
                               codigo_rastreio = @codigo_rastreio 
                           WHERE id_rastreamento = @id_rastreamento";

            rastreamento.id_rastreamento = id;

            int linhasAfetadas = await connection.ExecuteAsync(sql, rastreamento);

            if (linhasAfetadas == 0)
                return NotFound(new { mensagem = "Rastreamento não encontrado para atualização!" });

            return Ok(new { mensagem = "Rastreamento atualizado com sucesso!" });
        }

        // 5. DELETE: REMOVER REGISTRO DE RASTREAMENTO
        [HttpDelete("{id}")]
        public async Task<IActionResult> Deletar(int id)
        {
            using var connection = new MySqlConnection(_config.GetConnectionString("DefaultConnection"));

            string sql = "DELETE FROM rastreamentos WHERE id_rastreamento = @id";

            int linhasAfetadas = await connection.ExecuteAsync(sql, new { id });

            if (linhasAfetadas == 0)
                return NotFound(new { mensagem = "Rastreamento não encontrado para remoção!" });

            return Ok(new { mensagem = "Rastreamento removido com sucesso!" });
        } // Chave do método Deletar fechada aqui!

        // 6. GET DETALHADO POR CÓDIGO (JOIN)
        [HttpGet("detalhado/{codigo}")]
        public async Task<IActionResult> ObterDetalhadoPorCodigo(string codigo)
        {
            using var connection = new MySqlConnection(_config.GetConnectionString("DefaultConnection"));

            string sql = @"
                SELECT 
                    r.codigo_rastreio,
                    r.status AS status_rastreamento,
                    r.localizacao,
                    r.data_hora,
                    c.nome AS nome_cliente,
                    p.endereco_destino,
                    m.nome AS nome_motorista
                FROM rastreamentos r
                INNER JOIN entregas e ON r.id_entrega = e.id_entrega
                INNER JOIN pedidos p ON e.id_pedido = p.id_pedido
                INNER JOIN clientes c ON p.id_cliente = c.id_cliente
                INNER JOIN motoristas m ON e.id_motorista = m.id_motorista
                WHERE r.codigo_rastreio = @codigo
                ORDER BY r.data_hora DESC";

            var resultado = await connection.QueryAsync<RastreamentoDetalhadoDto>(sql, new { codigo });

            if (!resultado.Any())
                return NotFound(new { mensagem = "Nenhum histórico encontrado para este código de rastreio." });

            return Ok(resultado);
        }
    }
}
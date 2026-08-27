// Importações de bibliotecas essenciais para o funcionamento da Controller
using Microsoft.AspNetCore.Mvc; // Atributos de rotas e retornos HTTP (ControllerBase, HttpGet, etc.)
using MySqlConnector; // Driver oficial de conexão assíncrona com o MySQL
using Dapper; //  Micro-ORM que converte registros do banco em objetos C#
using Logistica_Api.Models; //  Namespace que contém o model 'Entregas'

namespace Logistica_Api.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class EntregasController : ControllerBase
    {
        private readonly IConfiguration _config;

        public EntregasController(IConfiguration config)
        {
            _config = config;
        }

        // 1. GET: Listar todas as entregas
        [HttpGet]
        public async Task<IActionResult> ObterTodas()
        {
            using var connection = new MySqlConnection(_config.GetConnectionString("DefaultConnection"));

            string sql = @"SELECT id_entrega, id_pedido, id_motorista, id_veiculo, 
                                  data_saida, data_entrega, previsao_entrega, status 
                           FROM entregas";

            var entregas = await connection.QueryAsync<Entregas>(sql);
            return Ok(entregas);
        }

        // 2. GET POR ID: Buscar entrega por id_entrega
        [HttpGet("{id}")]
        public async Task<IActionResult> ObterPorId(int id)
        {
            using var connection = new MySqlConnection(_config.GetConnectionString("DefaultConnection"));

            string sql = @"SELECT id_entrega, id_pedido, id_motorista, id_veiculo, 
                                  data_saida, data_entrega, previsao_entrega, status 
                           FROM entregas 
                           WHERE id_entrega = @id";

            var entrega = await connection.QueryFirstOrDefaultAsync<Entregas>(sql, new { id });

            if (entrega == null)
                return NotFound(new { mensagem = "Entrega não encontrada!" });

            return Ok(entrega);
        }

        // 3. GET POR PEDIDO: Buscar a entrega vinculada a um pedido específico
        [HttpGet("pedido/{idPedido}")]
        public async Task<IActionResult> ObterPorPedido(int idPedido)
        {
            using var connection = new MySqlConnection(_config.GetConnectionString("DefaultConnection"));

            string sql = @"SELECT id_entrega, id_pedido, id_motorista, id_veiculo, 
                                  data_saida, data_entrega, previsao_entrega, status 
                           FROM entregas 
                           WHERE id_pedido = @idPedido";

            var entrega = await connection.QueryFirstOrDefaultAsync<Entregas>(sql, new { idPedido });

            if (entrega == null)
                return NotFound(new { mensagem = "Nenhuma entrega encontrada para este pedido!" });

            return Ok(entrega);
        }

        // 4. POST: Cadastrar nova entrega
        [HttpPost]
        public async Task<IActionResult> Cadastrar([FromBody] Entregas entrega)
        {
            using var connection = new MySqlConnection(_config.GetConnectionString("DefaultConnection"));

            string sql = @"INSERT INTO entregas (id_pedido, id_motorista, id_veiculo, data_saida, data_entrega, previsao_entrega, status) 
                           VALUES (@id_pedido, @id_motorista, @id_veiculo, @data_saida, @data_entrega, @previsao_entrega, @status)";

            await connection.ExecuteAsync(sql, entrega);

            return Ok(new { mensagem = "Entrega registrada com sucesso!" });
        }

       // 5. PUT: ATUALIZAR ENTREGA EXISTENTE
[HttpPut("{id}")]
public async Task<IActionResult> Atualizar(int id, [FromBody] Entregas entrega)
{
    using var connection = new MySqlConnection(_config.GetConnectionString("DefaultConnection"));

    // CORREÇÃO: Usar @id_entrega no WHERE para bater com a propriedade do objeto 'entrega'
    string sql = @"UPDATE entregas 
                   SET id_pedido = @id_pedido, 
                       id_motorista = @id_motorista, 
                       id_veiculo = @id_veiculo, 
                       data_saida = @data_saida, 
                       data_entrega = @data_entrega, 
                       previsao_entrega = @previsao_entrega, 
                       status = @status 
                   WHERE id_entrega = @id_entrega";

    // Atribui o ID recebido da URL para a propriedade 'id_entrega' do objeto
    entrega.id_entrega = id;

    int linhasAfetadas = await connection.ExecuteAsync(sql, entrega);

    if (linhasAfetadas == 0)
        return NotFound(new { mensagem = "Entrega não encontrada para atualização!" });

    return Ok(new { mensagem = "Entrega atualizada com sucesso!" });
}

// 6. DELETE: REMOVER REGISTRO DE ENTREGA
[HttpDelete("{id}")]
public async Task<IActionResult> Deletar(int id)
{
    using var connection = new MySqlConnection(_config.GetConnectionString("DefaultConnection"));

    string sql = "DELETE FROM entregas WHERE id_entrega = @id";

    // No Delete passamos um objeto anônimo { id }, então o @id funciona perfeitamente
    int linhasAfetadas = await connection.ExecuteAsync(sql, new { id });

    if (linhasAfetadas == 0)
        return NotFound(new { mensagem = "Entrega não encontrada para remoção!" });

    return Ok(new { mensagem = "Entrega removida com sucesso!" });
}
    }
}
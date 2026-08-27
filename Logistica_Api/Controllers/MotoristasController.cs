// importações de biblioteca essenciais
using Microsoft.AspNetCore.Mvc; // Recursos para criação de APIs REST no .NET (Controller, HttpGet, HttpPost, etc)
using MySqlConnector; // drive para conectar o c# ao banco de dados mysql
using Dapper; // / Micro-ORM que facilita a execução de comandos SQL e mapeia os dados para objetos C#
using Logistica_Api.Models; // Namespace onde está a nossa classe de modelo 'Motorista'

namespace Logistica_Api.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class MotoristasController : ControllerBase
    {
        private readonly IConfiguration _config;

        public MotoristasController(IConfiguration config)
        {
            _config = config;
        }

        // ==========================================
        // 1. GET: LISTAR TODOS OS MOTORISTAS
        // ==========================================
        [HttpGet]
        public async Task<IActionResult> ObterMotoristas()
        {
            using var connection = new MySqlConnection(_config.GetConnectionString("DefaultConnection"));
            
            // Query com todas as colunas correspondentes ao seu Model
            string sql = @"SELECT id_motorista, nome, telefone, data_nascimento, CNH, Categoria_CNH, data_admissao, status 
                           FROM motoristas";
            
            var motoristas = await connection.QueryAsync<Motorista>(sql);
            return Ok(motoristas);
        }

        // ==========================================
        // 2. GET POR ID: BUSCAR APENAS UM MOTORISTA
        // ==========================================
        [HttpGet("{id}")]
        public async Task<IActionResult> ObterMotoristaPorId(int id)
        {
            using var connection = new MySqlConnection(_config.GetConnectionString("DefaultConnection"));
            
            string sql = @"SELECT id_motorista, nome, telefone, data_nascimento, CNH, Categoria_CNH, data_admissao, status 
                           FROM motoristas 
                           WHERE id_motorista = @id";
            
            var motorista = await connection.QueryFirstOrDefaultAsync<Motorista>(sql, new { id });

            if (motorista == null)
                return NotFound(new { mensagem = "Motorista não encontrado!" });

            return Ok(motorista);
        }

        // ==========================================
        // 3. POST: CADASTRAR UM NOVO MOTORISTA
        // ==========================================
        [HttpPost]
        public async Task<IActionResult> CadastrarMotorista([FromBody] Motorista motorista)
        {
            using var connection = new MySqlConnection(_config.GetConnectionString("DefaultConnection"));
            
            string sql = @"INSERT INTO motoristas (nome, telefone, data_nascimento, CNH, Categoria_CNH, data_admissao, status) 
                           VALUES (@nome, @telefone, @data_nascimento, @CNH, @Categoria_CNH, @data_admissao, @status)";

            await connection.ExecuteAsync(sql, motorista);
            return Ok(new { mensagem = "Motorista cadastrado com sucesso!" });
        }

        // ==========================================
        // 4. PUT: ATUALIZAR MOTORISTA EXISTENTE
        // ==========================================
        [HttpPut("{id}")]
        public async Task<IActionResult> AtualizarMotorista(int id, [FromBody] Motorista motorista)
        {
            using var connection = new MySqlConnection(_config.GetConnectionString("DefaultConnection"));
            
            string sql = @"UPDATE motoristas 
                           SET nome = @nome, 
                               telefone = @telefone, 
                               data_nascimento = @data_nascimento, 
                               CNH = @CNH, 
                               Categoria_CNH = @Categoria_CNH, 
                               data_admissao = @data_admissao, 
                               status = @status 
                           WHERE id_motorista = @id";

            motorista.id_motorista = id;

            int linhasAfetadas = await connection.ExecuteAsync(sql, motorista);

            if (linhasAfetadas == 0)
                return NotFound(new { mensagem = "Motorista não encontrado para atualização!" });

            return Ok(new { mensagem = "Motorista atualizado com sucesso!" });
        }

        // ==========================================
        // 5. DELETE: DELETAR MOTORISTA
        // ==========================================
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeletarMotorista(int id)
        {
            using var connection = new MySqlConnection(_config.GetConnectionString("DefaultConnection"));
            
            string sql = "DELETE FROM motoristas WHERE id_motorista = @id";

            int linhasAfetadas = await connection.ExecuteAsync(sql, new { id });

            if (linhasAfetadas == 0)
                return NotFound(new { mensagem = "Motorista não encontrado para remoção!" });

            return Ok(new { mensagem = "Motorista deletado com sucesso!" });
        }
    }
}
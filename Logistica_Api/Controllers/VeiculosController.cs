// Importações de bibliotecas essenciais para o funcionamento da Controller
using Microsoft.AspNetCore.Mvc; // Recursos REST (ControllerBase, HttpGet, HttpPost, etc.)
using MySqlConnector; // Driver de conexão com o banco de dados MySQL
using Dapper; // Micro-ORM para simplificar consultas SQL no C#
using Logistica_Api.Models; // Namespace onde está a classe 'Veiculos'

namespace Logistica_Api.Controllers
{
    // Indica que esta classe é uma Controller de API (ativa validações automáticas de modelo)
    [ApiController]
    // Define a rota base da API como 'api/veiculos'
    [Route("api/[controller]")]
    public class VeiculosController : ControllerBase
    {
        private readonly IConfiguration _config;

        // Construtor: Recebe as configurações do sistema (ex: string de conexão do appsettings.json)
        public VeiculosController(IConfiguration config)
        {
            _config = config;
        }

        // ==========================================
        // 1. GET: LISTAR TODOS OS VEÍCULOS
        // ==========================================
        [HttpGet]
        public async Task<IActionResult> ObterVeiculos()
        {
            // O 'using' garante o fechamento automático da conexão com o banco ao finalizar o método
            using var connection = new MySqlConnection(_config.GetConnectionString("DefaultConnection"));
            
            // Query SQL pura para buscar todos os registros da tabela 'veiculos'
            string sql = @"SELECT id_veiculo, marca, modelo, placa, tipo_veiculo, capacidade_de_carga, ano 
                           FROM veiculos";
            
            // O Dapper executa a consulta e mapeia os resultados diretamente para objetos do tipo 'Veiculos'
            var veiculos = await connection.QueryAsync<Veiculos>(sql);
            
            // Retorna HTTP 200 (OK) com a lista JSON dos veículos
            return Ok(veiculos);
        }

        // ==========================================
        // 2. GET POR ID: BUSCAR APENAS UM VEÍCULO
        // ==========================================
        [HttpGet("{id}")] // O {id} é passado diretamente na URL (ex: api/veiculos/3)
        public async Task<IActionResult> ObterVeiculoPorId(int id)
        {
            using var connection = new MySqlConnection(_config.GetConnectionString("DefaultConnection"));
            
            // Uso de '@id' para evitar falhas de segurança por SQL Injection
            string sql = @"SELECT id_veiculo, marca, modelo, placa, tipo_veiculo, capacidade_de_carga, ano 
                           FROM veiculos 
                           WHERE id_veiculo = @id";
            
            // Retorna o primeiro veículo encontrado ou 'null' se o ID não existir
            var veiculo = await connection.QueryFirstOrDefaultAsync<Veiculos>(sql, new { id });

            // Se não encontrar o veículo no banco, retorna HTTP status 404 (Not Found)
            if (veiculo == null)
                return NotFound(new { mensagem = "Veículo não encontrado!" });

            // Se encontrar, retorna HTTP status 200 (OK) com o objeto retornado
            return Ok(veiculo);
        }

        // ==========================================
        // 3. POST: CADASTRAR UM NOVO VEÍCULO
        // ==========================================
        [HttpPost]
        public async Task<IActionResult> CadastrarVeiculo([FromBody] Veiculos veiculo)
        {
            using var connection = new MySqlConnection(_config.GetConnectionString("DefaultConnection"));
            
            // Query para inserção dos dados recebidos no corpo da requisição (JSON)
            string sql = @"INSERT INTO veiculos (marca, modelo, placa, tipo_veiculo, capacidade_de_carga, ano) 
                           VALUES (@marca, @modelo, @placa, @tipo_veiculo, @capacidade_de_carga, @ano)";

            // Substitui os parâmetros (@marca, @modelo, etc.) pelas propriedades do objeto 'veiculo'
            await connection.ExecuteAsync(sql, veiculo);
            
            // Retorna HTTP status 200 (OK) com a mensagem de confirmação
            return Ok(new { mensagem = "Veículo cadastrado com sucesso!" });
        }

        // ==========================================
        // 4. PUT: ATUALIZAR VEÍCULO EXISTENTE
        // ==========================================
        [HttpPut("{id}")]
        public async Task<IActionResult> AtualizarVeiculo(int id, [FromBody] Veiculos veiculo)
        {
            using var connection = new MySqlConnection(_config.GetConnectionString("DefaultConnection"));
            
            string sql = @"UPDATE veiculos 
                           SET marca = @marca, 
                               modelo = @modelo, 
                               placa = @placa, 
                               tipo_veiculo = @tipo_veiculo, 
                               capacidade_de_carga = @capacidade_de_carga, 
                               ano = @ano 
                           WHERE id_veiculo = @id";

            // Garante que o ID do parâmetro da rota seja aplicado ao objeto alterado
            veiculo.id_veiculo = id;

            // Retorna a quantidade de linhas que sofreram alteração no banco
            int linhasAfetadas = await connection.ExecuteAsync(sql, veiculo);

            // Se nenhuma linha foi alterada, o registro não existia no banco
            if (linhasAfetadas == 0)
                return NotFound(new { mensagem = "Veículo não encontrado para atualização!" });

            return Ok(new { mensagem = "Veículo atualizado com sucesso!" });
        }

        // ==========================================
        // 5. DELETE: DELETAR VEÍCULO
        // ==========================================
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeletarVeiculo(int id)
        {
            using var connection = new MySqlConnection(_config.GetConnectionString("DefaultConnection"));
            
            string sql = "DELETE FROM veiculos WHERE id_veiculo = @id";

            // Executa a instrução de remoção no banco
            int linhasAfetadas = await connection.ExecuteAsync(sql, new { id });

            if (linhasAfetadas == 0)
                return NotFound(new { mensagem = "Veículo não encontrado para remoção!" });

            return Ok(new { mensagem = "Veículo deletado com sucesso!" });
        }
    }
}
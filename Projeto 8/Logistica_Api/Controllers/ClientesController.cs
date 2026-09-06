// importações de biblioteca essenciais
using Microsoft.AspNetCore.Mvc; // Recursos para criação de APIs REST no .NET (Controller, HttpGet, HttpPost, etc)
using MySqlConnector; // drive para conectar o c# ao banco de dados mysql
using Dapper; // Micro-ORM que facilita a execução de comandos SQL
using Logistica_Api.Models;
using Microsoft.Extensions.Configuration;     // Namespace onde está a nossa classe de modelo 'Clientes'

namespace Logistica_Api.Controllers
{

    using System;
using System.Threading.Tasks;
    // indicação de que esta classe é um controller de API (habilita validações  automaticas do modelo)
    [ApiController]
    // Define a rota base da API como 'api/clientes' (pega o nome da controller sem a palavra 'Controller')
    [Route("api/[controller]")]
    public class ClientesController : ControllerBase
    {
        private readonly IConfiguration _config;

        // Construtor: Injeta a configuração do sistema (appsettings.json) na controller
        public ClientesController(IConfiguration config)
        {
            _config = config;
        }

        // ==========================================
        // 1. GET: LISTAR TODOS OS CLIENTES
        // ==========================================
        [HttpGet] 
        public async Task<IActionResult> ObterClientes()
        {
            // 'using' garante que a conexão com o banco será FECHADA automaticamente após a execução
            using var connection = new MySqlConnection(_config.GetConnectionString("DefaultConnection"));
            // Query SQL pura para buscar os registros
            string sql = "SELECT id_cliente, nome, cpf, telefone, endereco, cep FROM clientes";
            // Dapper executa a consulta de forma assíncrona e converte cada linha da tabela em um objeto 'Clientes'
            var clientes = await connection.QueryAsync<Cliente>(sql);

            // Retorna HTTP status 200 (OK) com a lista JSON de clientes
            return Ok(clientes);
        }

        // 2. GET por ID: Buscar cliente específico
        [HttpGet("{id}")] // O {id} indica que a URL receberá um parâmetro (ex: api/cliente/5)
        public async Task<IActionResult> ObterClientePorId(int id)
        {
            using var connection = new MySqlConnection(_config.GetConnectionString("DefaultConnection"));
            // Usamos '@id' para evitar SQL Injection (nunca concatene variáveis direto na string SQL)
            string sql = "SELECT id_cliente, nome, cpf, telefone, cep, endereco FROM clientes WHERE id_cliente = @id";
            // Busca o primeiro registro ou retorna 'null' se não encontrar nada
            var cliente = await connection.QueryFirstOrDefaultAsync<Cliente>(sql, new { id });
            // Se o produto não existir no banco, retorna HTTP status 404 (Not Found)
            if (cliente == null)
                return NotFound(new { mensagem = "Cliente não encontrado!" });

            // Se encontrou, retorna HTTP status 200 (OK) com o produto
            return Ok(cliente);
        }

        // 3. POST: Cadastrar novo cliente
        [HttpPost]
        public async Task<IActionResult> CadastrarCliente([FromBody] Cliente cliente)
        {
            using var connection = new MySqlConnection(_config.GetConnectionString("DefaultConnection"));
            string sql = @"INSERT INTO clientes (nome, cpf, telefone, cep, endereco) 
                           VALUES (@nome, @cpf, @telefone, @cep, @endereco)";
            // O Dapper substitui automaticamente os parâmetros (@nome, @email...) pelas propriedades do objeto 'cliente'

            await connection.ExecuteAsync(sql, cliente);
            // Retorna HTTP status 200 (OK) com uma mensagem de sucesso
            return Ok(new { mensagem = "Cliente cadastrado com sucesso!" });
        }

        // PUT: Atualizar cliente
        [HttpPut("{id}")]
        public async Task<IActionResult> AtualizarCliente(int id, [FromBody] Cliente cliente)
        {
            using var connection = new MySqlConnection(_config.GetConnectionString("DefaultConnection"));
            string sql = @"UPDATE clientes 
                           SET nome = @nome, cpf = @cpf, telefone = @telefone, endereco = @endereco, cep = @cep 
                           WHERE id_cliente = @id";

            cliente.id_cliente = id;
            int linhasAfetadas = await connection.ExecuteAsync(sql, cliente);

            if (linhasAfetadas == 0)
                return NotFound(new { mensagem = "Cliente não encontrado para atualização!" });

            return Ok(new { mensagem = "Cliente atualizado com sucesso!" });
        }

        // DELETE: Remover cliente
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeletarCliente(int id)
        {
            using var connection = new MySqlConnection(_config.GetConnectionString("DefaultConnection"));
            string sql = "DELETE FROM clientes WHERE id_cliente = @id";

            int linhasAfetadas = await connection.ExecuteAsync(sql, new { id });

            if (linhasAfetadas == 0)
                return NotFound(new { mensagem = "Cliente não encontrado para remoção!" });

            return Ok(new { mensagem = "Cliente deletado com sucesso!" });
        }
    }
}
            
            
 
// O 'namespace' define a localização/endereço desta classe dentro do projeto.
// Indica que ela pertence à pasta 'Models' do projeto 'Logistica_Api'.
namespace Logistica_Api.Models
{
    public class Rastreamentos // 'public class': 'public' permite que outras partes do sistema (como os Controllers)
// enxerguem esta estrutura. 'class' define o molde/modelo da tabela do banco de dados.
    {
        // Chave Primaria (INT  PRIMARY_KEY AUTO_INCREMENT)
        public int id_rastreamento {get; set;} //// 'public': Permite o acesso externo aos dados.
// 'get': Permite LER o valor armazenado na variável.
// 'set': Permite GRAVAR/ALTERAR o valor na variável.
// '= string.Empty;': Inicializa textos como vazios ("") para evitar erros de ponteiro nulo (Null Reference).
        // Chave Estrageira (INT Foreign Key)
        public int id_entrega {get; set;}
        // Status do Rastreamento (ENUM) ENUM vira string
        public string status {get; set;} = String.Empty;
        // // Data e hora do registro da movimentação (DATETIME)
        public DateTime data_hora {get;set;}
        // Cidade/UF ou local atual da carga (VARCHAR(100))
        public string localizacao {get; set;} = String.Empty;
        // Código único de rastreio fornecido ao cliente, ex: BR1234567890 (VARCHAR(13))
        public string codigo_rastreio {get; set;} = String.Empty;
    }
}
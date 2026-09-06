// O 'namespace' define a localização/endereço desta classe dentro do projeto.
// Indica que ela pertence à pasta 'Models' do projeto 'Logistica_Api'.
namespace Logistica_Api.Models
{
   // representa  a tebela clientes do Mysql
   public class Cliente // 'public class': 'public' permite que outras partes do sistema (como os Controllers)
// enxerguem esta estrutura. 'class' define o molde/modelo da tabela do banco de dados.
    {
        // chave primaria (INT Primary Key Auto_increment)
        public int id_cliente {get; set;} // 'public': Permite o acesso externo aos dados.
// 'get': Permite LER o valor armazenado na variável.
// 'set': Permite GRAVAR/ALTERAR o valor na variável.
// '= string.Empty;': Inicializa textos como vazios ("") para evitar erros de ponteiro nulo (Null Reference).
        
        // Nome Do Cliente (Varchar(45))
        public string nome {get; set;} = string.Empty;

        // CPF Do Cliente (varchar(14))
        public string cpf {get; set;} = string.Empty;

        // Numero de Telefone do Cliente Varchar(20))
        public string telefone{get; set;} = string.Empty; // O = string.Empty; serve para evitar erros graves de sistema (NLL Pointer / NullReferenceException) no C# moderno.

        // Endereço residencial/comercial Varchar(50))
        public string endereco {get; set;} = string.Empty;

        // Código de Endereçamento Postal Varchar(9))
        public string cep { get; set; } = string.Empty;

       


    }
}
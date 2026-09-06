// O 'namespace' define a localização/endereço desta classe dentro do projeto.
// Indica que ela pertence à pasta 'Models' do projeto 'Logistica_Api'.
namespace Logistica_Api.Models
{
    public class Motorista // 'public class': 'public' permite que outras partes do sistema (como os Controllers)
// enxerguem esta estrutura. 'class' define o molde/modelo da tabela do banco de dados.
    {
        // chave primaria (primary key auto_increment)
        public int id_motorista {get; set;} // // 'public': Permite o acesso externo aos dados.
// 'get': Permite LER o valor armazenado na variável.
// 'set': Permite GRAVAR/ALTERAR o valor na variável.
// '= string.Empty;': Inicializa textos como vazios ("") para evitar erros de ponteiro nulo (Null Reference).
        // nome do motorista (varchar(45))
        public string nome {get; set;} = string.Empty;
        // telefone do motorista (varchar (12))
        public string telefone {get; set;} = string.Empty;
        // data_nascimento Do motorista DATETIME
        public DateTime data_nascimento {get; set;}

        // CNH do Motorista (VARCHAR(11))
        public string CNH {get; set;} = string.Empty;
        // Categoria da CNH: A, B, C, D, E (Tratada como string no C# vinda do ENUM)
        public string Categoria_CNH {get; set;} = string.Empty;
        // Data_admissao do motorista DATE
        public DateTime? data_admissao {get; set;}

        // Status atual: Ativo, Ferias, Inativo (Tratada como string vinda do ENUM)
        public string status {get; set;} = string.Empty;
    }
}
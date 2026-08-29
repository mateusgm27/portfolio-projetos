// O 'namespace' define a localização/endereço desta classe dentro do projeto.
// Indica que ela pertence à pasta 'Models' do projeto 'Logistica_Api'.
namespace Logistica_Api.Models
{
    // Representa a tabela produtos no Mysql
     public class Produto // 'public class': 'public' permite que outras partes do sistema (como os Controllers)
// enxerguem esta estrutura. 'class' define o molde/modelo da tabela do banco de dados.
    {
        // chave primaria (Int Primary Key Auto_Increment)
        public int id_produto {get; set;} // 'public': Permite o acesso externo aos dados.
// 'get': Permite LER o valor armazenado na variável.
// 'set': Permite GRAVAR/ALTERAR o valor na variável.
// '= string.Empty;': Inicializa textos como vazios ("") para evitar erros de ponteiro nulo (Null Reference).
        

        // nome do produto (varchar(50)
        public string nome {get; set;} = string.Empty;

        // categoria do produto (varchar(40))
        public string categoria {get; set;} = string.Empty;

        // Preço de venda. No C#, usa-se 'decimal' para valores monetários exatos (DECIMAL(10,2))
        public decimal preco {get; set;}

        // peso do produto em kg (decimal (6,2))
        public decimal peso {get; set;}
        // // Quantidade de itens disponíveis em estoque (INT)
        public int estoque {get; set;}

    }
}
    

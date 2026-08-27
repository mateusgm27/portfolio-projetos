// O 'namespace' define a localização/endereço desta classe dentro do projeto.
// Indica que ela pertence à pasta 'Models' do projeto 'Logistica_Api'.
namespace Logistica_Api.Models
{
    public class Pedido // 'public class': 'public' permite que outras partes do sistema (como os Controllers)
// enxerguem esta estrutura. 'class' define o molde/modelo da tabela do banco de dados.
    {
        // Chave Primaria(INT PRIMARY KEY AUTO_INCREMENT)
        public int id_pedido {get; set;} // // 'public': Permite o acesso externo aos dados.
// 'get': Permite LER o valor armazenado na variável.
// 'set': Permite GRAVAR/ALTERAR o valor na variável.
// '= string.Empty;': Inicializa textos como vazios ("") para evitar erros de ponteiro nulo (Null Reference).
        // endereço de origem do pedido (Varchar(150))
        public string endereco_origem {get; set;} = String.Empty;
        // endereco de destino do pedido (Varchar(150))
        public string endereco_destino{get; set;} = String.Empty;
        // Data do pedido DATE
        public DateTime data_pedido {get; set;}
        // status do pedido (ENUM)
        public string status {get;set;} = String.Empty;
        // valor_total do pedido (Decimal(10,2))
        public decimal valor_total{get; set;} 

        // Chave Estrangeira que referencia a tabela 'clientes' (FOREIGN KEY id_cliente)
        public int id_cliente {get; set;}
    }
}

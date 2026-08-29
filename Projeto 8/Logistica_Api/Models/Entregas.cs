// O 'namespace' define a localização/endereço desta classe dentro do projeto.
// Indica que ela pertence à pasta 'Models' do projeto 'Logistica_Api'.
namespace Logistica_Api.Models
{
    public class Entregas // 'public class': 'public' permite que outras partes do sistema (como os Controllers)
// enxerguem esta estrutura. 'class' define o molde/modelo da tabela do banco de dados.
    {
        // Chave Primaria (INT PRIMARY KEY AUTO_INCREMENT)
        public int id_entrega {get; set;} // // 'public': Permite o acesso externo aos dados.
// 'get': Permite LER o valor armazenado na variável.
// 'set': Permite GRAVAR/ALTERAR o valor na variável.
// '= string.Empty;': Inicializa textos como vazios ("") para evitar erros de ponteiro nulo (Null Reference).
        // Chave Estrangeira(INT FOREIGN KEY id_pedido)
        public int id_pedido {get; set;}
        // Chave Estrangeira(INT FOREIGN KEY id_motorista)
        public int id_motorista {get;set;}
        // Chave Estrageira (INT FOREING KEY id_veiculo)
        public int id_veiculo {get; set;}
        // Data e hora de saída do centro de distribuição (DATETIME)
        public DateTime data_saida {get; set;}
        // // Data e hora em que foi efetivamente entregue (DATETIME)
        public DateTime data_entrega {get; set;}
        // Previsão estimada para entrega (DATETIME)
        public DateTime previsao_entrega {get;set;}
        // Status da Entrega (ENUM) ENUM vira string
        public string status {get;set;} = String.Empty;

    }
}
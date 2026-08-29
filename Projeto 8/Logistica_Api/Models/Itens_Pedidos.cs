// O 'namespace' define a localização/endereço desta classe dentro do projeto.
// Indica que ela pertence à pasta 'Models' do projeto 'Logistica_Api'.
namespace Logistica_Api.Models
{
    public class ItemPedido // 'public class': 'public' permite que outras partes do sistema (como os Controllers)
// enxerguem esta estrutura. 'class' define o molde/modelo da tabela do banco de dados.
    {
        // chave primaria (int primary key auto_increment)
        public int id_item {get; set;} // // 'public': Permite o acesso externo aos dados.
// 'get': Permite LER o valor armazenado na variável.
// 'set': Permite GRAVAR/ALTERAR o valor na variável.
// '= string.Empty;': Inicializa textos como vazios ("") para evitar erros de ponteiro nulo (Null Reference).

        // Chave Estrangeira (FOREIGN KEY id_pedido)
        public int id_pedido {get; set;}
        // Chave Estrageira (Foreign Key id_produto)
        public int id_produto {get; set;}
        // quantidade do item_pedidos (INT)
        public int quantidade {get; set;}
        // preço unitario do itens_pedidos DECIMAL(10,2)
        public decimal preco_unitario {get; set;}
        
    }
}
// O 'namespace' define a localização/endereço desta classe dentro do projeto.
// Indica que ela pertence à pasta 'Models' do projeto 'Logistica_Api'.
namespace Logistica_Api.Models
{
   // Representa a tabela veiculos
  public class Veiculos // 'public class': 'public' permite que outras partes do sistema (como os Controllers)
// enxerguem esta estrutura. 'class' define o molde/modelo da tabela do banco de dados.
    {
        // chave primaria (int primary key auto_increment)
        public int id_veiculo {get; set;} // // 'public': Permite o acesso externo aos dados.
// 'get': Permite LER o valor armazenado na variável.
// 'set': Permite GRAVAR/ALTERAR o valor na variável.
// '= string.Empty;': Inicializa textos como vazios ("") para evitar erros de ponteiro nulo (Null Reference).
         // marca do veiculo (VARCHAR(30))
        public string marca {get; set;} = String.Empty;
        // modelo do veiculo (VARCHAR(45))
        public string modelo{get; set;} = String.Empty;
        //Placa do veiculo (Varchar (10))
        public string placa {get; set;} = String.Empty;
        // Tipo de veículo: Caminhão, Carro, Moto, Van (ENUM)
        public string tipo_veiculo {get; set;} = String.Empty;
        // Capacidade Máxima de carga em toneladas ou kg (DECIMAL(10,2))
        public decimal capacidade_de_carga {get; set;}

        // Ano de fabricação (int)
        public int ano {get;set;}


    }

}

    

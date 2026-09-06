namespace Logistica_Api.Models
{
    public class RastreamentoDetalhadoDto
    {
        public string codigo_rastreio { get; set; } = string.Empty;
        public string status_rastreamento { get; set; } = string.Empty;
        public string localizacao { get; set; } = string.Empty;
        public DateTime data_hora { get; set; }
        public string nome_cliente { get; set; } = string.Empty;
        public string endereco_destino { get; set; } = string.Empty;
        public string nome_motorista { get; set; } = string.Empty;
    }
}
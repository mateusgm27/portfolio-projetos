// 1. Inicializa o construtor da aplicação .NET
var builder = WebApplication.CreateBuilder(args);

// Registra o suporte para Controllers na aplicação
builder.Services.AddControllers();

// Configura o CORS para permitir que o Front-End acesse a API
builder.Services.AddCors(options =>
{
    options.AddPolicy("PermitirTudo", policy =>
    {
        policy.AllowAnyOrigin()
              .AllowAnyMethod()
              .AllowAnyHeader();
    });
});

// Configura o Swagger (documentação visual das rotas da API)
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();

// 3. Ativa a interface visual do Swagger no modo de desenvolvimento
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

// Habilita a política de CORS liberada
app.UseCors("PermitirTudo");

app.UseHttpsRedirection();

// 4. Mapeia automaticamente todas as rotas dos Controllers (ex: /api/produtos)
app.MapControllers();

// 5. Inicia a API
app.Run();
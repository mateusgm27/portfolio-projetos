using Microsoft.AspNetCore.Builder;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;

var builder = WebApplication.CreateBuilder(args);

// Configurar CORS para liberar o Vercel
builder.Services.AddCors(options => {
    options.AddPolicy("AllowAll", policy => {
  policy.AllowAnyOrigin().AllowAnyMethod().AllowAnyHeader();
    });
});

builder.Services.AddControllers();
var app = builder.Build();

app.UseCors("AllowAll");
app.UseAuthorization();
app.MapControllers();

// Porta dinâmica exigida por servidores em nuvem (Render/Railway)
var port = Environment.GetEnvironmentVariable("PORT") ?? "5000";
app.Run($"http://0.0.0.0:{port}");

# Usamos a imagem oficial do SDK do .NET 8.0
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build

# Define o diretório de trabalho principal dentro do contêiner
WORKDIR /source

# Copia TODOS os arquivos do seu repositório para o diretório /source
# Esta é a etapa mais importante. A estrutura de pastas será preservada.
COPY . .

# Agora, executamos o restore especificando o caminho completo para o arquivo de projeto
# a partir da raiz do diretório de trabalho.
RUN dotnet restore "./DialogosAPI/DialogosAPI.csproj"

# Executamos o build, também especificando o caminho
RUN dotnet build "./DialogosAPI/DialogosAPI.csproj" -c Release --no-restore

# Publicamos a aplicação, especificando o caminho e a pasta de saída
RUN dotnet publish "./DialogosAPI/DialogosAPI.csproj" -c Release -o /app/publish --no-build

# --- Etapa Final ---
# Usamos a imagem de runtime do ASP.NET, que é menor e mais segura
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS final
WORKDIR /app
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "DialogosAPI.dll"]
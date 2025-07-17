# Etapa 1: Build
# Usar a imagem oficial do SDK do .NET 8.0
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copiar o arquivo de solução (.sln) e os arquivos de projeto (.csproj)
# Isso permite restaurar os pacotes antes de copiar todo o código, otimizando o cache.
COPY *.sln .
COPY DialogosAPI/*.csproj ./DialogosAPI/

# Restaurar os pacotes de todo o projeto a partir do arquivo de solução
RUN dotnet restore

# Copiar todo o resto do código-fonte
COPY . .

# Publicar a aplicação, especificando a pasta do projeto
WORKDIR /src/DialogosAPI
RUN dotnet publish -c Release -o /app/publish

# Etapa 2: Execução
# Usar a imagem de runtime do ASP.NET, que é menor e mais segura
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS final
WORKDIR /app
COPY --from=build /app/publish .

# Comando para iniciar a API
ENTRYPOINT ["dotnet", "DialogosAPI.dll"]
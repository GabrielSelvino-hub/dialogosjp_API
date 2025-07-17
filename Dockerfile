# Etapa 1: Build - Usa o SDK do .NET 8.0 para compilar o projeto
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# Copia o arquivo .csproj para o contêiner e restaura os pacotes
# Isso otimiza o cache do Docker
COPY DialogosAPI/*.csproj ./DialogosAPI/
RUN dotnet restore ./DialogosAPI/DialogosAPI.csproj

# Copia todo o resto do código da API
COPY ./DialogosAPI ./DialogosAPI

# Publica a aplicação
WORKDIR /app/DialogosAPI
RUN dotnet publish -c Release -o /app/out

# Etapa 2: Execução - Usa uma imagem menor, apenas com o necessário para rodar
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app
COPY --from=build /app/out ./

# Define a porta que a aplicação vai usar dentro do contêiner
ENV PORT=8080

# Comando para iniciar a API quando o contêiner rodar
ENTRYPOINT ["dotnet", "DialogosAPI.dll"]
# Etapa 1: Build - AGORA USANDO O SDK DO .NET 8.0
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# Copia os arquivos de projeto e restaura os pacotes (NuGet)
COPY *.csproj ./
RUN dotnet restore

# Copia todo o resto do código e publica a aplicação
COPY . ./
RUN dotnet publish -c Release -o out

# Etapa 2: Execução - AGORA USANDO A RUNTIME DO ASP.NET 8.0
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app
COPY --from=build /app/out ./

# Define a porta que a aplicação vai usar dentro do contêiner
ENV PORT=8080

# Comando para iniciar a API quando o contêiner rodar
ENTRYPOINT ["dotnet", "DialogosAPI.dll"] 
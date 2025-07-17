# Etapa 1: Build
# Usamos a imagem oficial do SDK do .NET 8.0
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build

# Define o diretório de trabalho principal
WORKDIR /source

# Copia primeiro o arquivo de projeto para otimizar o cache do Docker
COPY DialogosAPI/DialogosAPI.csproj DialogosAPI/
RUN dotnet restore DialogosAPI/DialogosAPI.csproj

# Copia todo o resto do código da sua API
COPY DialogosAPI/ ./DialogosAPI

# Define o diretório de trabalho para a pasta do projeto e publica
WORKDIR /source/DialogosAPI
RUN dotnet publish -c Release -o /app/publish

# --- Etapa Final ---
# Usa a imagem de runtime, que é menor e mais segura
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS final
WORKDIR /app
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "DialogosAPI.dll"]
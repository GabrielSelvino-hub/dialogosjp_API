# Etapa 1: Build
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# Copia apenas o arquivo .csproj para a raiz do diretório de trabalho
# e restaura os pacotes. Isso é um passo otimizado.
COPY DialogosAPI/DialogosAPI.csproj .
RUN dotnet restore "DialogosAPI.csproj"

# Copia o resto do código-fonte do projeto para o mesmo diretório
COPY ./DialogosAPI .

# Publica a aplicação
RUN dotnet publish "DialogosAPI.csproj" -c Release -o /app/publish /p:UseAppHost=false

# Etapa 2: Execução
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS final
WORKDIR /app
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "DialogosAPI.dll"]
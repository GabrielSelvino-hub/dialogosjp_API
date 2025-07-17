# Etapa 1: Build - Começamos com uma imagem limpa do Ubuntu
FROM ubuntu:22.04 AS build
ENV DEBIAN_FRONTEND=noninteractive

# Instala dependências necessárias e o SDK do .NET 8.0 manualmente
RUN apt-get update \
    && apt-get install -y --no-install-recommends wget \
    && wget https://packages.microsoft.com/config/ubuntu/22.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb \
    && dpkg -i packages-microsoft-prod.deb \
    && rm packages-microsoft-prod.deb \
    && apt-get update \
    && apt-get install -y --no-install-recommends dotnet-sdk-8.0

# Define o diretório de trabalho
WORKDIR /source

# Copia e restaura os pacotes
COPY DialogosAPI/DialogosAPI.csproj ./DialogosAPI/
RUN dotnet restore ./DialogosAPI/DialogosAPI.csproj

# Copia o resto do código
COPY DialogosAPI/ ./DialogosAPI

# Publica a aplicação
RUN dotnet publish ./DialogosAPI/DialogosAPI.csproj -c Release -o /app/publish

# --- Etapa Final ---
# Usa a imagem de runtime do ASP.NET 8.0, que é pequena e segura
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS final
WORKDIR /app
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "DialogosAPI.dll"]
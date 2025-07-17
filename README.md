# DialogosJP API

API para gerenciamento de diálogos em japonês, permitindo criar, listar e editar diálogos para fins de estudo ou aplicações educacionais.

## Funcionalidades
- Listar todos os diálogos cadastrados
- Criar novos diálogos (protegido por chave de API)
- Editar diálogos existentes (protegido por chave de API)

## Tecnologias Utilizadas
- ASP.NET Core 8
- Entity Framework Core
- PostgreSQL
- DotNetEnv (para variáveis de ambiente locais)

## Como rodar localmente

1. **Clone o repositório:**
   ```bash
   git clone <url-do-repositorio>
   cd dialogosjp_API
   ```

2. **Configure o arquivo `.env`:**
   Crie um arquivo `.env` na raiz do projeto com o seguinte conteúdo:
   ```env
   DIALOGOS_API_KEY=dialogoslv
   ```
   (Você pode escolher outro valor para a chave se desejar)

3. **Configure a string de conexão com o banco de dados**
   - Edite o arquivo `appsettings.json` e ajuste a seção `ConnectionStrings:DefaultConnection` para apontar para seu banco PostgreSQL.

4. **Instale as dependências:**
   ```bash
   dotnet restore
   dotnet tool restore
   dotnet add package DotNetEnv
   ```

5. **Rode as migrações (se necessário):**
   ```bash
   dotnet ef database update
   ```

6. **Inicie a aplicação:**
   ```bash
   dotnet run
   ```

A API estará disponível em `http://localhost:5000` (ou outra porta configurada).

## Rotas da API

### Listar diálogos
- **GET** `/api/dialogos`
- **Acesso:** Público
- **Exemplo de resposta:**
  ```json
  [
    {
      "id": 1,
      "nome": "Saudação",
      "url_Img": "...",
      "japones": "こんにちは",
      "japones_Sem_Kanji": "...",
      "romaji": "Konnichiwa",
      "traducao": "Olá"
    }
  ]
  ```

### Criar diálogo
- **POST** `/api/dialogos`
- **Headers obrigatórios:**
  - `X-Api-Key: <sua-chave-do-env>`
  - `Content-Type: application/json`
- **Body exemplo:**
  ```json
  {
    "nome": "Despedida",
    "url_Img": "...",
    "japones": "さようなら",
    "japones_Sem_Kanji": "...",
    "romaji": "Sayonara",
    "traducao": "Tchau"
  }
  ```

### Editar diálogo
- **PUT** `/api/dialogos/{id}`
- **Headers obrigatórios:**
  - `X-Api-Key: <sua-chave-do-env>`
  - `Content-Type: application/json`
- **Body exemplo:**
  ```json
  {
    "id": 1,
    "nome": "Despedida Atualizada",
    "url_Img": "...",
    "japones": "さようなら",
    "japones_Sem_Kanji": "...",
    "romaji": "Sayonara",
    "traducao": "Até logo"
  }
  ```

## Segurança
- As rotas de criação e edição exigem a chave de API definida na variável de ambiente `DIALOGOS_API_KEY`.
- Envie a chave no header `X-Api-Key`.

## Deploy no Azure
- No Azure App Service, defina a variável de ambiente `DIALOGOS_API_KEY` nas configurações do portal (não use o arquivo `.env` em produção).
- Não esqueça de configurar também a string de conexão do banco de dados nas configurações do Azure.

## Observações
- O projeto utiliza DotNetEnv apenas para ambiente de desenvolvimento local.
- Para produção, sempre use as configurações de ambiente do serviço de hospedagem.

---

Se tiver dúvidas, abra uma issue ou entre em contato com o mantenedor do projeto. 
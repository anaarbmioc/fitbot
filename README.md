\# FitBot 🏃‍♂️



Bot do Telegram para desafios de atividade física em grupo.



\## Stack

\- Telegram Bot API

\- N8N (automação de workflows)

\- PostgreSQL (banco de dados)

\- Google Fit API (dados de atividade)



\## Como rodar localmente



\### Pré-requisitos

\- Docker Desktop

\- ngrok

\- Conta no Telegram



\### Passo a passo



1\. Clone o repositório

git clone https://github.com/SEU\_USUARIO/fitbot.git

cd fitbot



2\. Suba os containers

docker network create fitbot-network



docker run -d --name postgres --restart unless-stopped \\

&#x20; -p 5432:5432 \\

&#x20; --network fitbot-network \\

&#x20; -e POSTGRES\_PASSWORD=fitbot123 \\

&#x20; -e POSTGRES\_DB=fitbot \\

&#x20; postgres:15



docker run -d --name n8n --restart unless-stopped \\

&#x20; -p 5678:5678 \\

&#x20; --network fitbot-network \\

&#x20; -e N8N\_BASIC\_AUTH\_ACTIVE=true \\

&#x20; -e N8N\_BASIC\_AUTH\_USER=admin \\

&#x20; -e N8N\_BASIC\_AUTH\_PASSWORD=suasenha123 \\

&#x20; n8nio/n8n



3\. Exponha com ngrok

ngrok http 5678



4\. Registre o webhook do Telegram

curl "https://api.telegram.org/botSEU\_TOKEN/setWebhook?url=https://SUA\_URL\_NGROK/webhook/fitbot"



5\. Importe o workflow

\- Acesse http://localhost:5678

\- Vá em Workflows → Import

\- Selecione o arquivo workflows/workflow.json



6\. Configure as credenciais no N8N

\- PostgreSQL: host=postgres, db=fitbot, user=postgres, password=fitbot123

\- Telegram Token: substitua SEU\_TOKEN nas URLs dos nós HTTP Request



\## Banco de dados



Execute o script SQL em docs/schema.sql para criar as tabelas.



\## Estrutura do projeto

fitbot/

├── workflows/

│   └── workflow.json    # Workflow do N8N

├── docs/

│   └── schema.sql       # Script de criação das tabelas

└── README.md


\# FitBot — Desafio Movimente 🏃‍♂️🏆



Bot do Telegram para desafios de atividade física em grupo, integrando com o Google Fit para coleta automática de dados diários.



\## Como funciona



1\. O bot é adicionado a um grupo do Telegram

2\. Cada membro clica em "Aceitar desafio" e autoriza o Google Fit

3\. Um administrador define a duração e a data de início

4\. Todo dia às 08h o bot coleta os dados de atividade de cada membro

5\. O ranking diário é enviado no grupo com pontuação baseada em passos

6\. Todo dia às 18h uma mensagem motivacional é enviada

7\. Ao final do desafio o bot exibe o resultado com 🥇 🥈 🥉



\## Stack



\- \*\*Telegram Bot API\*\* — interface com os usuários

\- \*\*N8N\*\* — orquestração dos workflows

\- \*\*PostgreSQL\*\* — banco de dados

\- \*\*Google Fit API\*\* — coleta de dados de atividade física

\- \*\*Docker\*\* — containerização local

\- \*\*ngrok\*\* — exposição pública para desenvolvimento



\## Pré-requisitos



\- Docker Desktop instalado

\- ngrok instalado e autenticado

\- Conta no Telegram e bot criado via BotFather

\- Projeto no Google Cloud com Fitness API ativada e OAuth2 configurado



\## Como rodar localmente



\### 1. Clone o repositório



```bash

git clone https://github.com/anaarbmioc/fitbot.git

cd fitbot

```



\### 2. Crie a rede Docker e suba os containers



```powershell

docker network create fitbot-network



docker run -d --name postgres --restart unless-stopped `

&#x20; -p 5432:5432 `

&#x20; --network fitbot-network `

&#x20; -e POSTGRES\_PASSWORD=fitbot123 `

&#x20; -e POSTGRES\_DB=fitbot `

&#x20; postgres:15



docker run -d --name n8n --restart unless-stopped `

&#x20; -p 5678:5678 `

&#x20; --network fitbot-network `

&#x20; -v ${PWD}/n8n\_data:/home/node/.n8n `

&#x20; -e N8N\_BASIC\_AUTH\_ACTIVE=true `

&#x20; -e N8N\_BASIC\_AUTH\_USER=admin `

&#x20; -e N8N\_BASIC\_AUTH\_PASSWORD=suasenha `

&#x20; -e WEBHOOK\_URL=https://SUA\_URL\_NGROK `

&#x20; -e N8N\_EDITOR\_BASE\_URL=https://SUA\_URL\_NGROK `

&#x20; n8nio/n8n

```



\### 3. Exponha com ngrok



```powershell

ngrok http 5678

```



\### 4. Registre o webhook do Telegram



```powershell

curl "https://api.telegram.org/botSEU\_TOKEN/setWebhook?url=https://SUA\_URL\_NGROK/webhook/fitbot"

```



\### 5. Crie as tabelas no banco



Execute o script em `docs/schema.sql` em um nó Postgres do N8N.



\### 6. Importe os workflows



Siga as instruções em `workflows/COMO-IMPORTAR.md`.



\## Banco de dados



```sql

\-- Execute o script completo em docs/schema.sql

```



Veja o schema completo em `docs/schema.sql`.



\## Estrutura do projeto



fitbot/

├── docs/

│   └── schema.sql          # Script de criação das tabelas

├── workflows/

│   └── COMO-IMPORTAR.md    # Instruções de importação dos workflows

├── .gitignore

└── README.md



\## Comandos disponíveis



| Comando | Quem pode usar | Descrição |

|---|---|---|

| Botão "Aceitar desafio" | Todos | Inicia o fluxo de participação |

| `/start` | Todos (DM) | Recebe o link de autorização do Google Fit |

| `/duracao X` | Admin | Define a duração do desafio em dias |

| `/inicio AAAA-MM-DD` | Admin | Define a data de início |

| `/finalizar` | Admin (no grupo) | Finaliza o desafio antes do prazo |



\## Pontuação



| Passos | Pontuação |

|---|---|

| Até 4.999 | 2 pts |

| 5.000 - 7.999 | 5 pts |

| 8.000 - 9.999 | 8 pts |

| 10.000 ou mais | 10 pts |



\## Contribuindo



1\. Faça um fork do repositório

2\. Crie uma branch para sua feature (`git checkout -b feature/nova-feature`)

3\. Commit suas mudanças (`git commit -m 'adiciona nova feature'`)

4\. Push para a branch (`git push origin feature/nova-feature`)

5\. Abra um Pull Request


\# Workflows do N8N



\## Como exportar e importar



1\. Acesse o N8N em http://localhost:5678

2\. Abra cada workflow

3\. Clique nos 3 pontinhos → Download

4\. Para importar em outro ambiente: Workflows → Import



\## Workflows disponíveis



\- \*\*Projeto integrador\*\* — workflow principal (bot, aceite, duracao, inicio, finalizar)

\- \*\*FitBot - OAuth Callback\*\* — fluxo de autorização do Google Fit

\- \*\*Schedule Trigger - Ranking Diário\*\* — coleta dados e envia ranking às 08h

\- \*\*Schedule Trigger - Mensagem Motivacional\*\* — envia mensagem motivacional às 18h



\## Variáveis que precisam ser configuradas



\- `SEU\_TOKEN\_BOT` — token do BotFather

\- `SEU\_CLIENT\_ID` — Google Cloud OAuth2 Client ID

\- `SEU\_CLIENT\_SECRET` — Google Cloud OAuth2 Client Secret

\- URL do ngrok ou domínio fixo

\- Credencial PostgreSQL


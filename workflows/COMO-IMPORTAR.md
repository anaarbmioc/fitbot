\# Como importar os workflows



\## Exportar do N8N

1\. Acesse http://localhost:5678

2\. Abra cada workflow

3\. Clique nos 3 pontinhos no canto superior direito

4\. Clique em "Download"



\## Importar em outro ambiente

1\. Acesse o N8N

2\. Vá em Workflows → Import

3\. Selecione o arquivo .json baixado



\## Workflows do projeto



\### 1. Projeto integrador (workflow principal)

Responsável por receber todos os eventos do Telegram e processar os comandos.



\*\*Comandos tratados:\*\*

\- Bot adicionado ao grupo → envia mensagem de boas-vindas com botão "Aceitar desafio"

\- `/aceitar` ou clique no botão → inicia fluxo de autorização do Google Fit

\- `/start` → envia link de autorização do Google Fit por DM

\- `/duracao X` → define duração do desafio (apenas admins)

\- `/inicio AAAA-MM-DD` → define data de início (apenas admins)

\- `/finalizar` → finaliza o desafio e exibe resultado final (apenas admins no grupo)



\### 2. FitBot - OAuth Callback

Recebe o retorno da autorização do Google Fit e salva o token no banco.



\*\*Fluxo:\*\*

1\. Usuário autoriza o Google Fit

2\. Google redireciona para o webhook

3\. Token é salvo no banco

4\. Confirmação enviada ao usuário por DM

5\. Grupo recebe mensagem com lista de quem já aceitou



\### 3. Schedule Trigger - Ranking Diário

Executa todo dia às 08h e coleta dados do Google Fit de cada participante.



\*\*Fluxo:\*\*

1\. Busca grupos ativos no banco

2\. Para cada membro, renova o token e busca dados do Google Fit

3\. Salva passos, calorias e minutos ativos no banco

4\. Calcula pontuação e envia ranking no grupo

5\. Verifica se o desafio terminou e envia resultado final se necessário



\*\*Fórmula de pontuação:\*\*

| Passos | Pontuação |

|---|---|

| Até 4.999 | 2 pts |

| 5.000 - 7.999 | 5 pts |

| 8.000 - 9.999 | 8 pts |

| 10.000 ou mais | 10 pts |



\### 4. Schedule Trigger - Mensagem Motivacional

Envia uma mensagem motivacional aleatória todos os dias às 18h para os grupos ativos.



\## Credenciais necessárias no N8N



| Credencial | Tipo | Descrição |

|---|---|---|

| Credencial Postgres | PostgreSQL | Conexão com o banco de dados |

| Google OAuth2 | OAuth2 API | Acesso ao Google Fit |



\## Variáveis que precisam ser substituídas nos workflows



| Variável | Onde substituir |

|---|---|

| `SEU\_TOKEN\_BOT` | URL de todos os nós HTTP Request da Telegram API |

| `SEU\_CLIENT\_ID` | Link de autorização do Google Fit |

| `SEU\_CLIENT\_SECRET` | Nó HTTP de renovação de token |

| URL do ngrok | WEBHOOK\_URL e links de callback |

| IP do PostgreSQL | Credencial do banco |


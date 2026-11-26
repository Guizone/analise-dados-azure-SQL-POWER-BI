# Premissas do projeto

Este documento define os termos e registra as decisões de tratamento.
As decisões vêm do perfil de qualidade dos dados (`sql/02_profiling.sql`).

## 1. Definições

| Termo | Definição |
|---|---|
| **Contato** | Uma linha da tabela. Uma ligação de telemarketing. |
| **Conversão** | Contato em que `y = 'yes'`. Na view, `converted = 1`. |
| **Taxa de conversão** | Conversões divididas por contatos. Medida DAX `Conversion Rate`. |
| **Faixa de idade** | 17-25, 26-35, 36-45, 46-55, 56-65 e 66+. Coluna `age_group`. |
| **Já contatado antes** | Contato com `previous > 0`. Coluna `contacted_before`. |
| **unknown** | Valor desconhecido na origem. Fica como categoria própria. |
| **Período** | Mês do contato. A base não tem coluna de ano (maio/2008 a novembro/2010). |

## 2. Decisões de tratamento

| Problema | Evidência | Decisão |
|---|---|---|
| Valores `unknown` | `credit_default`: 8.597 (cerca de 21%). `education`: 1.731. `housing` e `loan`: 990 cada. `job`: 330. `marital`: 80. | Manter `unknown` como categoria. Apagar linhas distorceria a análise. Transformar em nulo esconderia a informação. |
| `pdays = 999` | 39.673 linhas. 4.110 delas têm resultado de campanha anterior. | `contacted_before` usa `previous > 0`. `days_since_last_contact` fica nulo quando `pdays = 999`. |
| Idade contínua | 17 a 98 anos | Coluna `age_group` com 6 faixas. |
| Mês em texto | Ordem alfabética | `month_num` na view e tabela `Dim_Meses` no Power BI. |
| Dia da semana em texto | Ordem alfabética | `day_of_week_num` na view. |
| Duração em segundos | 0 a 4.918 segundos | `duration_min` (segundos divididos por 60). |
| Resultado em yes e no | A taxa precisa de um número | `converted` (1 ou 0) na view. `Status Conversão` no Power BI. |
| Nomes com ponto e palavra reservada | `emp.var.rate`, `default` | Colunas renomeadas na importação. |
| Tipos inferidos errados | `nr_employed` falhou. `housing` e `loan` viraram bit. | Tipos revisados no assistente de importação. |
| Tabela bruta | Dados originais | Não é alterada. Todo o tratamento fica na view. |

## 3. Limites da análise

- Os dados mostram **associação**. Eles não provam causa.
- A faixa 66+ tem 619 contatos. Leia essa taxa junto com o volume.
- Sem coluna de ano, cada mês mistura anos diferentes.
- A taxa de conversão por canal (celular e telefone fixo) ainda não foi calculada.
- A taxa por resultado da campanha anterior (`poutcome`) ainda não foi calculada.
- Segundo a documentação do UCI, `duration` só é conhecida depois da ligação. Não use essa coluna para prever uma conversão futura.
- O dataset é histórico (2008 a 2010) e de um banco português. Não generalize para outros mercados.

## 4. Pendências conhecidas no dashboard

Estas pendências existem no arquivo `powerbi/Dataview_bank_marketing.pbix`:

- A aba Campanha ainda mostra o cabeçalho "Bank Marketing | Customer Profile".
- A página do tooltip se chama "Tolltip" (erro de digitação).
- Um cartão da aba Overview tem o título "A".
- Os cartões de resumo da aba Overview exibem "Mil" (por exemplo, "41,188 Mil").
- A aba Campanha repete dois gráficos da aba Perfil do Consumidor (perfil de crédito e inadimplência).
- Os rótulos do gráfico Euribor 3M mostram "Mil".
- A publicação no Power BI Service com atualização agendada não foi feita. Ela exige conta de trabalho ou escola.

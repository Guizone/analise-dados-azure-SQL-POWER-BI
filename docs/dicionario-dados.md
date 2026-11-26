# Dicionário de dados

## View `dbo.vw_bank_marketing`

Fonte única do Power BI. Origem: `dbo.bank_marketing_raw`, 41.188 linhas.

| Coluna | Origem | Significado |
|---|---|---|
| `age` | original | Idade do cliente, em anos |
| `age_group` | criada | Faixa de idade: 17-25, 26-35, 36-45, 46-55, 56-65, 66+ |
| `job` | original | Ocupação |
| `marital` | original | Estado civil |
| `education` | original | Nível educacional |
| `credit_default` | original (`default`) | Inadimplência: `yes`, `no` ou `unknown` |
| `housing` | original | Tem financiamento imobiliário: `yes`, `no` ou `unknown` |
| `loan` | original | Tem empréstimo pessoal: `yes`, `no` ou `unknown` |
| `contact` | original | Canal do contato: `cellular` ou `telephone` |
| `month` | original | Mês do último contato (texto) |
| `month_num` | criada | Mês como número (jan = 1 até dec = 12), para ordenar |
| `day_of_week` | original | Dia da semana do contato (texto) |
| `day_of_week_num` | criada | Dia como número (mon = 1 até fri = 5), para ordenar |
| `duration` | original | Duração da ligação, em segundos |
| `duration_min` | criada | Duração da ligação, em minutos |
| `campaign` | original | Número de contatos nesta campanha para o cliente |
| `contacted_before` | criada | `yes` se `previous > 0`, senão `no` |
| `days_since_last_contact` | criada (de `pdays`) | Dias desde o último contato. Nulo quando `pdays = 999` |
| `previous` | original | Número de contatos antes desta campanha |
| `poutcome` | original | Resultado da campanha anterior: `nonexistent`, `failure` ou `success` |
| `emp_var_rate` | original (`emp.var.rate`) | Taxa de variação do emprego (indicador econômico) |
| `cons_price_idx` | original (`cons.price.idx`) | Índice de preços ao consumidor |
| `cons_conf_idx` | original (`cons.conf.idx`) | Índice de confiança do consumidor |
| `euribor3m` | original | Taxa Euribor de 3 meses. É uma taxa interbancária europeia. Não é a taxa oferecida ao cliente. |
| `nr_employed` | original (`nr.employed`) | Número estimado de empregados |
| `y` | original | Resultado: `yes` ou `no` |
| `converted` | criada | 1 se `y = 'yes'`, senão 0 |

A coluna `pdays` da tabela bruta não aparece na view. Use `days_since_last_contact`.

## Medidas e colunas do Power BI

Veja `powerbi/medidas-dax.md`.

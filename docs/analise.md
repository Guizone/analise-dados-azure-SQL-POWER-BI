# O que a análise mostra

Taxa de conversão = contatos que aceitaram a oferta, divididos pelos contatos feitos.
No projeto: 4.640 de 41.188, ou 11,27%. Isso é cerca de 1 em cada 9 contatos.

O dashboard repete essa conta para grupos diferentes. O objetivo é achar onde a taxa fica acima ou abaixo da média.

## Como ler

1. Confira se o total e a taxa geral batem com o arquivo original.
2. Divida os contatos em grupos (idade, ocupação, mês, crédito, estado civil).
3. Leia sempre a taxa junto com o volume de contatos. Uma taxa alta em um grupo pequeno engana.

## Achados

| Tema | O que os números mostram | Em palavras simples |
|---|---|---|
| **Idade** | 17-25: 20,95%. 26-35: 11,72%. 36-45: 8,51%. 46-55: 8,69%. 56-65: 15,22%. 66+: 46,85% (619 contatos). | Os mais jovens e os mais velhos aceitam mais. A faixa do meio aceita menos. Cerca de metade dos contatos (21.093 de 41.188) foi para 36-55 anos, justamente a faixa com menor conversão. |
| **Ocupação** | Estudantes: 31,43%. Aposentados: 25,23%. Operários (blue-collar): 6,89%. | Os grupos que mais aceitam combinam com as idades que mais aceitam. É uma pista, não uma prova. |
| **Mês** | Maio: 13.769 contatos e 6,4%. Março: 546 contatos e 50,5%. Setembro: 570 e 44,9%. Outubro: 718 e 43,9%. Dezembro: 182 e 48,9%. | Os meses com muitas ligações converteram menos. Os meses com poucas ligações converteram mais. Os dados não dizem o motivo. |
| **Crédito** | Perfis de financiamento e empréstimo: de 10,72% a 11,73%. Inadimplência: `no` 12,88% e `unknown` 5,15%. | Ter financiamento ou empréstimo pouco muda a chance de aceitar. Os clientes sem informação de inadimplência (cerca de 21% da base) aceitaram bem menos. |
| **Estado civil** | Solteiros: 14,00%. Divorciados: 10,32%. Casados: 10,16%. | Solteiros aceitam um pouco mais. Casados geram mais conversões em volume (2.532 contra 1.620), porque são mais numerosos. |
| **Histórico** | Sem histórico: 35.563 contatos. Falha anterior: 4.252. Sucesso anterior: 1.373. | Só 13,7% dos contatos já tinha participado de uma campanha anterior. |
| **Canal** | Celular: 26.144 contatos (63,5%). Telefone fixo: 15.044 (36,5%). | A maior parte dos contatos foi por celular. |

## Cuidados

- Os dados mostram relações. Eles não explicam causas.
- Sem coluna de ano, cada mês mistura anos diferentes.
- Veja os limites completos em `docs/premissas.md`.

## Ideias para testar (não são conclusões)

- Revisar a abordagem para 36-55 anos.
- Entender o que foi diferente nos meses de poucas ligações e alta conversão.
- Medir quanto o sucesso em uma campanha anterior aumenta a chance de aceitar de novo.

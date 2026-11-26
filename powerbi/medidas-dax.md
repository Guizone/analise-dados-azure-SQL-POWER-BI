# Medidas e colunas DAX

Tabela principal do modelo: `vw_bank_marketing` (view `dbo.vw_bank_marketing`, modo Import).
As medidas abaixo foram lidas do modelo com `EVALUATE INFO.MEASURES()`.

## Medidas

| Medida | Expressão DAX | Formato |
|---|---|---|
| Total Contacts | `COUNTROWS(vw_bank_marketing)` | `#,0.000` |
| Conversions | `SUM(vw_bank_marketing[converted])` | `#,0.00` |
| Conversion Rate | `DIVIDE([Conversions], [Total Contacts])` | `0.00%` |
| Avg Call Duration (min) | `AVERAGE(vw_bank_marketing[duration_min])` | padrão |
| Contacted Before | `CALCULATE([Total Contacts], vw_bank_marketing[contacted_before] = "yes")` | `0.000` |
| Contacted Before % | `DIVIDE([Contacted Before], [Total Contacts])` | `0.00%` |
| Convertido | `CALCULATE(vw_bank_marketing[Total Contacts], vw_bank_marketing[converted]=1)` | `0` |
| Não convertido | `CALCULATE(vw_bank_marketing[Total Contacts], vw_bank_marketing[converted]=0)` | `0` |

`Convertido` e `Não convertido` alimentam o gráfico de pizza da aba Overview.

## Colunas calculadas

Crie com **Modelagem > Nova coluna**, não como medida. Uma medida não avalia cada linha.

```DAX
Status Conversão =
IF (
    'vw_bank_marketing'[converted] = 1,
    "Convertido",
    "Não convertido"
)
```

```DAX
Perfil de Crédito =
SWITCH (
    TRUE (),
    'vw_bank_marketing'[housing] = "yes"
        && 'vw_bank_marketing'[loan] = "yes", "Imobiliário + pessoal",
    'vw_bank_marketing'[housing] = "yes"
        && 'vw_bank_marketing'[loan] = "no", "Somente imobiliário",
    'vw_bank_marketing'[housing] = "no"
        && 'vw_bank_marketing'[loan] = "yes", "Somente pessoal",
    'vw_bank_marketing'[housing] = "no"
        && 'vw_bank_marketing'[loan] = "no", "Sem empréstimos",
    "Não informado"
)
```

## Tabela calculada: meses

```DAX
Dim_Meses =
FILTER (
    DISTINCT (
        SELECTCOLUMNS (
            'vw_bank_marketing',
            "Mes", 'vw_bank_marketing'[month],
            "OrdemMes", 'vw_bank_marketing'[month_num]
        )
    ),
    NOT ISBLANK ( [Mes] )
        && NOT ISBLANK ( [OrdemMes] )
)
```

Passos depois de criar a tabela:

1. Selecione `Dim_Meses[Mes]`.
2. Abra **Ferramentas de coluna > Classificar por coluna** e escolha `OrdemMes`.
3. Crie o relacionamento `Dim_Meses[Mes]` (um) para `vw_bank_marketing[month]` (muitos).

## Ordenação das colunas da view

- Classifique `month` por `month_num`.
- Classifique `day_of_week` por `day_of_week_num`.

## Tema visual

O arquivo `Bank-Marketing-TV-Executive-Theme.json` guarda o tema escuro (azul e verde-água).
Para reaplicar: **Exibição > Temas > Procurar temas**.

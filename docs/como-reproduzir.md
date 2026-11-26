# Como reproduzir o projeto

Siga os passos na ordem. Cada passo tem uma ação e um resultado esperado.

**Regras de escrita deste guia** (estilo inspirado no ASD-STE100; a norma original só existe em inglês):
uma ação por frase, verbo no imperativo, frases curtas e um termo para cada significado.

## Termos usados

| Termo | Significado |
|---|---|
| Contato | Uma linha da tabela |
| Conversão | Contato com `y = 'yes'` |
| Tabela bruta | `dbo.bank_marketing_raw`. Não é alterada. |
| View | `dbo.vw_bank_marketing`. Fonte do Power BI. |

## Requisitos

- Conta no Azure.
- Visual Studio Code com a extensão **SQL Server (mssql)**.
- Power BI Desktop.

## Parte 1. Obter os dados

1. Siga `data/README.md`.
2. Confirme que você tem o arquivo `bank-additional-full.csv`.

## Parte 2. Criar o banco no Azure

1. Abra o portal do Azure.
2. Crie um grupo de recursos.
3. Crie um servidor SQL e um banco. Use a oferta gratuita do Azure SQL Database.
4. Escolha a autenticação por login SQL. Guarde o usuário e a senha.

## Parte 3. Liberar o acesso à rede

1. Abra o servidor. Vá em **Rede** (Networking).
2. Em acesso à rede pública, escolha **Redes selecionadas**.
3. Adicione o IP do seu computador como regra de firewall.
4. Marque a exceção para serviços do Azure.
5. Salve.

Sem este passo, a conexão é negada.

## Parte 4. Conectar o VS Code

1. Abra o VS Code.
2. Abra a extensão **SQL Server**.
3. Crie uma conexão com o nome do servidor (`<seu-servidor>.database.windows.net`), o banco, o usuário e a senha.
4. Conecte.

## Parte 5. Importar o CSV

1. Abra a paleta de comandos.
2. Execute **MS SQL: Import Flat File**.
3. Escolha o arquivo `bank-additional-full.csv`.
4. Defina a tabela de destino: `dbo.bank_marketing_raw`.
5. Renomeie as colunas:
   - `emp.var.rate` para `emp_var_rate`
   - `cons.price.idx` para `cons_price_idx`
   - `cons.conf.idx` para `cons_conf_idx`
   - `nr.employed` para `nr_employed`
   - `default` para `credit_default` (`default` é palavra reservada do SQL)
6. Ajuste os tipos:
   - `nr_employed` e as colunas de taxa e índice: decimal (float).
   - `housing`, `loan` e `y`: texto. Não use bit, porque os valores `unknown` virariam nulos.
7. Ative **Allow Nulls** em todas as colunas.
8. Importe.

Se a importação falhar, apague a tabela criada (`DROP TABLE` em `sql/01_importacao_e_validacao.sql`) e repita.

## Parte 6. Validar, perfilar e tratar

1. Execute `sql/01_importacao_e_validacao.sql`, sem o bloco `DROP`.
2. Confirme: 41.188 linhas, 4.640 conversões e taxa de 11,27%.
3. Execute `sql/02_profiling.sql`. Leia os resultados.
4. Execute `sql/03_view_bank_marketing.sql`.
5. Execute `sql/04_validacao_da_view.sql`.
6. Confirme: 41.188 linhas na view, 5.625 `yes` e 35.563 `no` em `contacted_before`.

## Parte 7. Montar o Power BI

1. Abra o Power BI Desktop.
2. Escolha **Obter dados** e **Banco de dados SQL do Azure**.
3. Informe o servidor e o banco. Escolha o modo **Importar**.
4. Carregue somente a view `dbo.vw_bank_marketing`.
5. Crie as medidas, as colunas e a tabela `Dim_Meses`. Use `powerbi/medidas-dax.md`.
6. Aplique o tema `powerbi/Bank-Marketing-TV-Executive-Theme.json`.
7. Monte as páginas Overview, Perfil do Consumidor e Campanha, e a página de tooltip.

Para ver o resultado pronto, abra `powerbi/Dataview_bank_marketing.pbix` e atualize a conexão para o seu servidor.

-- 01_importacao_e_validacao.sql
-- Projeto Bank Marketing: apoio à importação do CSV e validação da carga.
-- Banco: Azure SQL Database (T-SQL). Ferramenta: VS Code com a extensão SQL Server (mssql).
--
-- A importação em si é feita pelo assistente "Import Flat File" (veja docs/como-reproduzir.md).
-- Este script não altera dados, exceto o DROP opcional do bloco 1.

-- 1) Apagar a tabela de uma tentativa que falhou (opcional).
--    O assistente cria uma tabela nova a cada importação.
--    O comando não faz nada se a tabela não existir.
DROP TABLE IF EXISTS dbo.bank_marketing_raw;

-- 2) Conferir a estrutura da tabela importada (esperado: 21 colunas).
SELECT TOP 10 *
FROM dbo.bank_marketing_raw;

SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'bank_marketing_raw'
ORDER BY ORDINAL_POSITION;

-- 3) Total de linhas (esperado: 41188).
SELECT COUNT(*) AS total_linhas
FROM dbo.bank_marketing_raw;

-- 4) Taxa de conversão geral (esperado: 4640 conversões, 11,27%).
SELECT
    COUNT(*) AS total,
    SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) AS conversoes,
    ROUND(100.0 * SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS taxa_conversao_pct
FROM dbo.bank_marketing_raw;

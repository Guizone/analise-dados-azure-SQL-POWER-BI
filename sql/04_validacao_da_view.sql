-- 04_validacao_da_view.sql
-- Projeto Bank Marketing: validação da view e conferência da taxa por mês (só leitura).

-- 1) Total de linhas (esperado: 41188, igual à tabela bruta).
SELECT COUNT(*) AS total FROM dbo.vw_bank_marketing;

-- 2) Faixas de idade e taxa de conversão (as faixas somam 41188).
SELECT age_group, COUNT(*) AS total,
       ROUND(100.0 * AVG(CAST(converted AS FLOAT)), 2) AS taxa_conversao_pct
FROM dbo.vw_bank_marketing
GROUP BY age_group
ORDER BY age_group;

-- 3) contacted_before (esperado: 5625 yes e 35563 no).
SELECT contacted_before, COUNT(*) AS total
FROM dbo.vw_bank_marketing
GROUP BY contacted_before;

-- 4) Amostra com as colunas novas.
SELECT TOP 10 age, age_group, month, month_num, duration, duration_min,
       contacted_before, days_since_last_contact, converted
FROM dbo.vw_bank_marketing;

-- 5) Taxa de conversão por mês (reproduz o gráfico do dashboard).
SELECT
    month_num,
    month,
    COUNT(*) AS contatos,
    SUM(converted) AS conversoes,
    ROUND(100.0 * SUM(converted) / COUNT(*), 2) AS taxa_conversao_pct
FROM dbo.vw_bank_marketing
GROUP BY month_num, month
ORDER BY month_num;

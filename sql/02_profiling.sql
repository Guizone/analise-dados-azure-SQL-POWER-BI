-- 02_profiling.sql
-- Projeto Bank Marketing: perfil de qualidade dos dados (só leitura).
-- Rode depois da importação. Cada consulta responde a uma pergunta de qualidade.

-- 1) Quantos 'unknown' existem em cada coluna de texto?
SELECT
    SUM(CASE WHEN job = 'unknown' THEN 1 ELSE 0 END) AS job_unknown,
    SUM(CASE WHEN marital = 'unknown' THEN 1 ELSE 0 END) AS marital_unknown,
    SUM(CASE WHEN education = 'unknown' THEN 1 ELSE 0 END) AS education_unknown,
    SUM(CASE WHEN credit_default = 'unknown' THEN 1 ELSE 0 END) AS credit_default_unknown,
    SUM(CASE WHEN CAST(housing AS NVARCHAR(20)) = 'unknown' THEN 1 ELSE 0 END) AS housing_unknown,
    SUM(CASE WHEN CAST(loan AS NVARCHAR(20)) = 'unknown' THEN 1 ELSE 0 END) AS loan_unknown
FROM dbo.bank_marketing_raw;

-- 2) Limites dos valores numéricos e o caso especial do pdays (999).
SELECT
    MIN(age) AS idade_min, MAX(age) AS idade_max,
    MIN(duration) AS duracao_min, MAX(duration) AS duracao_max,
    SUM(CASE WHEN pdays = 999 THEN 1 ELSE 0 END) AS pdays_999,
    SUM(CASE WHEN duration = 0 THEN 1 ELSE 0 END) AS duracao_zero
FROM dbo.bank_marketing_raw;

-- 3) pdays = 999 x resultado de campanha anterior.
SELECT
    SUM(CASE WHEN pdays = 999 AND poutcome <> 'nonexistent' THEN 1 ELSE 0 END) AS pdays999_com_resultado_anterior,
    SUM(CASE WHEN pdays <> 999 AND poutcome = 'nonexistent' THEN 1 ELSE 0 END) AS pdays_real_sem_resultado,
    SUM(CASE WHEN previous > 0 THEN 1 ELSE 0 END) AS previous_maior_que_zero
FROM dbo.bank_marketing_raw;

-- 4) Categorias existentes nas colunas principais.
SELECT 'month' AS coluna, month AS valor, COUNT(*) AS qtd
FROM dbo.bank_marketing_raw GROUP BY month
UNION ALL
SELECT 'day_of_week', day_of_week, COUNT(*)
FROM dbo.bank_marketing_raw GROUP BY day_of_week
UNION ALL
SELECT 'contact', contact, COUNT(*)
FROM dbo.bank_marketing_raw GROUP BY contact
UNION ALL
SELECT 'poutcome', poutcome, COUNT(*)
FROM dbo.bank_marketing_raw GROUP BY poutcome
UNION ALL
SELECT 'y', y, COUNT(*)
FROM dbo.bank_marketing_raw GROUP BY y
ORDER BY coluna, qtd DESC;

-- 03_view_bank_marketing.sql
-- Projeto Bank Marketing: view de tratamento. É a única fonte do Power BI.
-- A tabela bruta (dbo.bank_marketing_raw) não é alterada.
-- Pode ser rodado de novo: CREATE OR ALTER substitui a view.

CREATE OR ALTER VIEW dbo.vw_bank_marketing AS
SELECT
    -- Perfil do cliente
    age,
    CASE
        WHEN age <= 25 THEN '17-25'
        WHEN age <= 35 THEN '26-35'
        WHEN age <= 45 THEN '36-45'
        WHEN age <= 55 THEN '46-55'
        WHEN age <= 65 THEN '56-65'
        ELSE '66+'
    END AS age_group,
    job, marital, education, credit_default, housing, loan,

    -- Contato
    contact,
    month,
    CASE month
        WHEN 'jan' THEN 1 WHEN 'feb' THEN 2 WHEN 'mar' THEN 3
        WHEN 'apr' THEN 4 WHEN 'may' THEN 5 WHEN 'jun' THEN 6
        WHEN 'jul' THEN 7 WHEN 'aug' THEN 8 WHEN 'sep' THEN 9
        WHEN 'oct' THEN 10 WHEN 'nov' THEN 11 WHEN 'dec' THEN 12
    END AS month_num,
    day_of_week,
    CASE day_of_week
        WHEN 'mon' THEN 1 WHEN 'tue' THEN 2 WHEN 'wed' THEN 3
        WHEN 'thu' THEN 4 WHEN 'fri' THEN 5
    END AS day_of_week_num,
    duration,
    CAST(duration / 60.0 AS DECIMAL(6,2)) AS duration_min,
    campaign,

    -- Histórico de campanhas anteriores
    CASE WHEN previous > 0 THEN 'yes' ELSE 'no' END AS contacted_before,
    CASE WHEN pdays = 999 THEN NULL ELSE pdays END AS days_since_last_contact,
    previous,
    poutcome,

    -- Indicadores econômicos
    emp_var_rate, cons_price_idx, cons_conf_idx, euribor3m, nr_employed,

    -- Resultado
    y,
    CASE WHEN y = 'yes' THEN 1 ELSE 0 END AS converted
FROM dbo.bank_marketing_raw;

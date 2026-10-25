SET PAGESIZE 100
SET LINESIZE 200

--Fråga 1: Beviljandegrad (%) per utbildningsomrade
SELECT
    utbildningsomrade,
    COUNT(*) AS antal_ansokningar,
    SUM(CASE WHEN beslut = 'Beviljad' THEN 1 ELSE 0 END) AS antal_beviljade,
    SUM(CASE WHEN beslut = 'Avslag' THEN 1 ELSE 0 END) AS antal_avslag,
    ROUND(
        100.0 * SUM(CASE WHEN beslut = 'Beviljad' THEN 1 ELSE 0 END) / COUNT(*),
        1
    ) AS beviljandegrad_pct
FROM ansokningar
GROUP BY utbildningsomrade
ORDER BY beviljandegrad_pct DESC;

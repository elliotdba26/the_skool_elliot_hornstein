SET PAGESIZE 100

SELECT
    utbildningsomrade,
    COUNT(*) AS totalt,
    SUM(CASE WHEN studieform = 'Distans' THEN 1 ELSE 0 END) AS antal_distans,
    SUM(CASE WHEN studieform = 'Bunden'  THEN 1 ELSE 0 END) AS antal_bunden,
    ROUND(100.0 * SUM(CASE WHEN studieform = 'Distans' THEN 1 ELSE 0 END) / COUNT(*), 1) AS andel_distans_procent,
    ROUND(100.0 * SUM(CASE WHEN studieform = 'Bunden'  THEN 1 ELSE 0 END) / COUNT(*), 1) AS andel_bunden_procent
FROM ansokningar
GROUP BY utbildningsomrade
ORDER BY totalt DESC;

EXIT


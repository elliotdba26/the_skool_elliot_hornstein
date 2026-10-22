SET PAGESIZE 100

SELECT
    utbildningsomrade,
    COUNT(*) AS antal_ansokningar
FROM ansokningar
GROUP BY utbildningsomrade
ORDER BY antal_ansokningar DESC;

EXIT


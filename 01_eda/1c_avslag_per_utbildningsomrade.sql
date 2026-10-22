SET PAGESIZE 100

SELECT
    utbildningsomrade,
    COUNT(*) AS antal_avslag
FROM ansokningar
WHERE beslut = 'Avslag'
GROUP BY utbildningsomrade
ORDER BY antal_avslag DESC;

EXIT

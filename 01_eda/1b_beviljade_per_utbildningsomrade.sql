SET PAGESIZE 100

SELECT
    utbildningsomrade,
    COUNT(*) AS antal_beviljade
FROM ansokningar
WHERE beslut = 'Beviljad'
GROUP BY utbildningsomrade
ORDER BY antal_beviljade DESC;

EXIT

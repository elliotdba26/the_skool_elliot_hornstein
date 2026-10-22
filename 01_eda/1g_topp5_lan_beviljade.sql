SET PAGESIZE 100

SELECT
    lan,
    COUNT(*) AS antal_beviljade
FROM ansokningar
WHERE beslut = 'Beviljad'
GROUP BY lan
ORDER BY antal_beviljade DESC
FETCH FIRST 5 ROWS ONLY;

EXIT


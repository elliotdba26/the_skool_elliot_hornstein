SET PAGESIZE 100

SELECT
    lan,
    COUNT(*) AS antal_beviljade
FROM ansokningar
WHERE beslut = 'Beviljad'
  AND LOWER(lan) NOT LIKE '%flera%'
GROUP BY lan
ORDER BY antal_beviljade DESC, lan
FETCH FIRST 5 ROWS ONLY;

EXIT


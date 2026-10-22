SET PAGESIZE 100

SELECT
    utbildningsnamn,
    COUNT(*) AS antal_beviljade
FROM ansokningar
WHERE utbildningsomrade = 'Data/IT'
  AND beslut = 'Beviljad'
GROUP BY utbildningsnamn
ORDER BY antal_beviljade DESC, utbildningsnamn;

EXIT


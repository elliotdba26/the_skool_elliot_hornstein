SET PAGESIZE 100

SELECT
    utbildningsnamn,
    COUNT(*) AS antal_avslag
FROM ansokningar
WHERE utbildningsomrade = 'Data/IT'
  AND beslut = 'Avslag'
GROUP BY utbildningsnamn
ORDER BY antal_avslag DESC, utbildningsnamn;

EXIT


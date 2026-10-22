SET PAGESIZE 100

SELECT
    anordnare,
    utbildningsnamn,
    COUNT(*) AS antal_beviljade
FROM ansokningar
WHERE utbildningsomrade = 'Data/IT'
  AND beslut = 'Beviljad'
GROUP BY anordnare, utbildningsnamn
ORDER BY antal_beviljade DESC, anordnare, utbildningsnamn;

EXIT


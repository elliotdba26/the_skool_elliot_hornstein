SET PAGESIZE 100

SELECT
    COUNT(*) AS antal_med_ai
FROM ansokningar
WHERE UPPER(utbildningsnamn) LIKE '%AI%';

SELECT
    utbildningsnamn,
    beslut,
    COUNT(*) AS antal
FROM ansokningar
WHERE UPPER(utbildningsnamn) LIKE '%AI%'
GROUP BY utbildningsnamn, beslut
ORDER BY antal DESC;

EXIT


SET PAGESIZE 100

SELECT
    COUNT(*) AS antal_med_ai
FROM ansokningar
WHERE REGEXP_LIKE(utbildningsnamn, '(^|[^A-Za-zÅÄÖåäö])AI([^A-Za-zÅÄÖåäö]|$)', 'i');

-- Detaljerad lista
SELECT
    utbildningsnamn,
    beslut,
    COUNT(*) AS antal
FROM ansokningar
WHERE REGEXP_LIKE(utbildningsnamn, '(^|[^A-Za-zÅÄÖåäö])AI([^A-Za-zÅÄÖåäö]|$)', 'i')
GROUP BY utbildningsnamn, beslut
ORDER BY antal DESC;

EXIT

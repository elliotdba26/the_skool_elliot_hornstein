LOAD ansokningar ansokningar.csv

COMMIT;

SELECT COUNT(*) AS antal_rader FROM ansokningar;

SELECT utbildningsomrade, beslut, lan, anordnare
FROM ansokningar
FETCH FIRST 5 ROWS ONLY;

EXIT

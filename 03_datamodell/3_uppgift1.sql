--Uppgift 4 fast med frågor från uppgift 1

SET PAGESIZE 100
SET LINESIZE 200

-- 1a) Antal ansökningar per utbildningsområde
SELECT
    u.utbildningsomrade_name AS "utbildningsområde",
    COUNT(*) AS "antal_ansökningar"
FROM ansokan a
JOIN sun5_inriktning s ON s.sun5_kod = a.sun5_kod
JOIN utbildningsomrade u ON u.utbildningsomrade_id = s.utbildningsomrade_id
GROUP BY u.utbildningsomrade_name
ORDER BY COUNT(*) DESC;


-- 1b) Beviljade per utbildningsområde
SELECT
    u.utbildningsomrade_name AS "utbildningsområde",
    COUNT(*) AS "antal_beviljade"
FROM ansokan a
JOIN sun5_inriktning s ON s.sun5_kod = a.sun5_kod
JOIN utbildningsomrade u ON u.utbildningsomrade_id = s.utbildningsomrade_id
WHERE a.beslut = 'Beviljad'
GROUP BY u.utbildningsomrade_name
ORDER BY COUNT(*) DESC;


-- 1c) Avslag per utbildningsområde
SELECT
    u.utbildningsomrade_name AS "utbildningsområde",
    COUNT(*) AS "antal_avslag"
FROM ansokan a
JOIN sun5_inriktning s ON s.sun5_kod = a.sun5_kod
JOIN utbildningsomrade u ON u.utbildningsomrade_id = s.utbildningsomrade_id
WHERE a.beslut = 'Avslag'
GROUP BY u.utbildningsomrade_name
ORDER BY COUNT(*) DESC;


-- 1d) Beviljade per utbildningsnamn inom Data/IT
SELECT
    a.utbildningsnamn AS "utbildningsnamn",
    COUNT(*) AS "antal_beviljade"
FROM ansokan a
JOIN sun5_inriktning s ON s.sun5_kod = a.sun5_kod
JOIN utbildningsomrade u ON u.utbildningsomrade_id = s.utbildningsomrade_id
WHERE u.utbildningsomrade_name = 'Data/IT'
  AND a.beslut = 'Beviljad'
GROUP BY a.utbildningsnamn
ORDER BY COUNT(*) DESC, a.utbildningsnamn;


-- 1e) Avslag per utbildningsnamn inom Data/IT
SELECT
    a.utbildningsnamn AS "utbildningsnamn",
    COUNT(*) AS "antal_avslag"
FROM ansokan a
JOIN sun5_inriktning s ON s.sun5_kod = a.sun5_kod
JOIN utbildningsomrade u ON u.utbildningsomrade_id = s.utbildningsomrade_id
WHERE u.utbildningsomrade_name = 'Data/IT'
  AND a.beslut = 'Avslag'
GROUP BY a.utbildningsnamn
ORDER BY COUNT(*) DESC, a.utbildningsnamn;


-- 1f) Beviljade per anordnare & utbildningsnamn inom Data/IT
SELECT
    an.name AS "anordnare",
    a.utbildningsnamn AS "utbildningsnamn",
    COUNT(*) AS "antal_beviljade"
FROM ansokan a
JOIN sun5_inriktning s ON s.sun5_kod = a.sun5_kod
JOIN utbildningsomrade u ON u.utbildningsomrade_id = s.utbildningsomrade_id
JOIN utbildningsanordnare an ON an.anordnare_id = a.anordnare_id
WHERE u.utbildningsomrade_name = 'Data/IT'
  AND a.beslut = 'Beviljad'
GROUP BY an.name, a.utbildningsnamn
ORDER BY COUNT(*) DESC, an.name, a.utbildningsnamn;


-- 1g) Topp 5 län efter antal beviljade
SELECT
    l.lan_name AS "län",
    COUNT(*) AS "antal_beviljade"
FROM ansokan a
JOIN ansokan_kommun ak ON ak.diarienummer = a.diarienummer
JOIN kommun k ON k.kommun_id = ak.kommun_id
JOIN lan l ON l.lan_id = k.lan_id
WHERE a.beslut = 'Beviljad'
  AND LOWER(l.lan_name) NOT LIKE '%flera%'
GROUP BY l.lan_name
ORDER BY COUNT(DISTINCT a.diarienummer) DESC, l.lan_name
FETCH FIRST 5 ROWS ONLY;


-- 1h) Andel bunden och distans per utbildningsområde
SELECT
    u.utbildningsomrade_name AS "utbildningsområde",
    COUNT(*) AS "totalt",
    SUM(CASE WHEN a.studieform = 'Bunden'  THEN 1 ELSE 0 END) AS "antal_bunden",
    SUM(CASE WHEN a.studieform = 'Distans' THEN 1 ELSE 0 END) AS "antal_distans",
    ROUND(100.0 * SUM(CASE WHEN a.studieform = 'Bunden'  THEN 1 ELSE 0 END) / COUNT(*), 1) AS "andel_bunden_procent",
    ROUND(100.0 * SUM(CASE WHEN a.studieform = 'Distans' THEN 1 ELSE 0 END) / COUNT(*), 1) AS "andel_distans_procent"
FROM ansokan a
JOIN sun5_inriktning s ON s.sun5_kod = a.sun5_kod
JOIN utbildningsomrade u ON u.utbildningsomrade_id = s.utbildningsomrade_id
GROUP BY u.utbildningsomrade_name
ORDER BY COUNT(*) DESC;

-- 1i) Antal utbildningar som innehåller ordet AI
SELECT COUNT(*) AS "antal_med_ai"
FROM ansokan
WHERE REGEXP_LIKE(utbildningsnamn, '(^|[^A-Za-zÅÄÖåäö])AI([^A-Za-zÅÄÖåäö]|$)', 'i');

SELECT
    utbildningsnamn AS "utbildningsnamn",
    beslut AS "beslut",
    COUNT(*) AS "antal"
FROM ansokan
WHERE REGEXP_LIKE(utbildningsnamn, '(^|[^A-Za-zÅÄÖåäö])AI([^A-Za-zÅÄÖåäö]|$)', 'i')
GROUP BY utbildningsnamn, beslut
ORDER BY COUNT(*) DESC;

EXIT

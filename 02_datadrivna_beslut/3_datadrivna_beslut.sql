SET PAGESIZE 100
SET LINESIZE 200

-- Fråga 1: Beviljandegrad (%) per utbildningsområde
SELECT
    utbildningsomrade,
    COUNT(*) AS antal_ansökningar,
    SUM(CASE WHEN beslut = 'Beviljad' THEN 1 ELSE 0 END) AS antal_beviljade,
    SUM(CASE WHEN beslut = 'Avslag' THEN 1 ELSE 0 END) AS antal_avslag,
    ROUND(
        100.0 * SUM(CASE WHEN beslut = 'Beviljad' THEN 1 ELSE 0 END) / COUNT(*),
        1
    ) AS beviljandegrad_procent
FROM ansokningar
GROUP BY utbildningsomrade
ORDER BY beviljandegrad_procent DESC;

-- Fråga 2: Beviljandegrad Distans vs Bunden inom Data/IT
SELECT
    studieform,
    COUNT(*) AS antal_ansokningar,
    SUM(CASE WHEN beslut = 'Beviljad' THEN 1 ELSE 0 END) AS antal_beviljade,
    ROUND(
        100.0 * SUM(CASE WHEN beslut = 'Beviljad' THEN 1 ELSE 0 END) / COUNT(*),
        1
    ) AS beviljandegrad_procent
FROM ansokningar
WHERE utbildningsomrade = 'Data/IT'
GROUP BY studieform
ORDER BY beviljandegrad_procent DESC;

-- Fråga 3: Topp anordnare inom Data/IT (beviljade + beviljandegrad)
SELECT
    anordnare,
    COUNT(*) AS antal_ansökningar,
    SUM(CASE WHEN beslut = 'Beviljad' THEN 1 ELSE 0 END) AS antal_beviljade,
    ROUND(
        100.0 * SUM(CASE WHEN beslut = 'Beviljad' THEN 1 ELSE 0 END) / COUNT(*),
        1
    ) AS beviljandegrad_procent
FROM ansokningar
WHERE utbildningsomrade = 'Data/IT'
GROUP BY anordnare
HAVING SUM(CASE WHEN beslut = 'Beviljad' THEN 1 ELSE 0 END) >= 1
ORDER BY antal_beviljade DESC, beviljandegrad_procent DESC
FETCH FIRST 15 ROWS ONLY;

-- Fråga 4: Medel YH-poäng för beviljade vs avslag inom Data/IT
SELECT
    beslut,
    COUNT(*) AS antal,
    ROUND(AVG(yh_poang), 1) AS medel_yh_poang,
    MIN(yh_poang) AS min_yh_poang,
    MAX(yh_poang) AS max_yh_poang
FROM ansokningar
WHERE utbildningsomrade = 'Data/IT'
  AND beslut IN ('Beviljad', 'Avslag')
GROUP BY beslut
ORDER BY beslut;

-- Fråga 5: Beviljade platser totalt per län
SELECT
    lan,
    COUNT(*) AS antal_beviljade_ansökningar,
    SUM(beviljade_platser_totalt) AS summa_beviljade_platser
FROM ansokningar
WHERE beslut = 'Beviljad'
GROUP BY lan
ORDER BY
    CASE WHEN LOWER(lan) LIKE '%flera%' THEN 1 ELSE 0 END,
    summa_beviljade_platser DESC
FETCH FIRST 10 ROWS ONLY;

EXIT


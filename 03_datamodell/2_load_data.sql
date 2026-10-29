-- Utbildningsområden
INSERT INTO utbildningsomrade (utbildningsomrade_name) VALUES ('Data/IT');
INSERT INTO utbildningsomrade (utbildningsomrade_name) VALUES ('Ekonomi, administration och försäljning');
INSERT INTO utbildningsomrade (utbildningsomrade_name) VALUES ('Friskvård och kroppsvård');
INSERT INTO utbildningsomrade (utbildningsomrade_name) VALUES ('Hotell, restaurang och turism');
INSERT INTO utbildningsomrade (utbildningsomrade_name) VALUES ('Hälso- och sjukvård samt socialt arbete');
INSERT INTO utbildningsomrade (utbildningsomrade_name) VALUES ('Journalistik och information');
INSERT INTO utbildningsomrade (utbildningsomrade_name) VALUES ('Juridik');
INSERT INTO utbildningsomrade (utbildningsomrade_name) VALUES ('Kultur, media och design');
INSERT INTO utbildningsomrade (utbildningsomrade_name) VALUES ('Lantbruk, djurvård, trädgård, skog och fiske');
INSERT INTO utbildningsomrade (utbildningsomrade_name) VALUES ('Pedagogik och undervisning');
INSERT INTO utbildningsomrade (utbildningsomrade_name) VALUES ('Samhällsbyggnad och byggteknik');
INSERT INTO utbildningsomrade (utbildningsomrade_name) VALUES ('Säkerhetstjänster');
INSERT INTO utbildningsomrade (utbildningsomrade_name) VALUES ('Teknik och tillverkning');
INSERT INTO utbildningsomrade (utbildningsomrade_name) VALUES ('Transporttjänster');

-- Län
INSERT INTO lan (lan_name) VALUES ('Blekinge');
INSERT INTO lan (lan_name) VALUES ('Dalarna');
INSERT INTO lan (lan_name) VALUES ('Flera kommuner');
INSERT INTO lan (lan_name) VALUES ('Gävleborg');
INSERT INTO lan (lan_name) VALUES ('Halland');
INSERT INTO lan (lan_name) VALUES ('Jämtland');
INSERT INTO lan (lan_name) VALUES ('Jönköping');
INSERT INTO lan (lan_name) VALUES ('Kalmar');
INSERT INTO lan (lan_name) VALUES ('Kronoberg');
INSERT INTO lan (lan_name) VALUES ('Norrbotten');
INSERT INTO lan (lan_name) VALUES ('Skåne');
INSERT INTO lan (lan_name) VALUES ('Stockholm');
INSERT INTO lan (lan_name) VALUES ('Södermanland');
INSERT INTO lan (lan_name) VALUES ('Uppsala');
INSERT INTO lan (lan_name) VALUES ('Värmland');
INSERT INTO lan (lan_name) VALUES ('Västerbotten');
INSERT INTO lan (lan_name) VALUES ('Västernorrland');
INSERT INTO lan (lan_name) VALUES ('Västmanland');
INSERT INTO lan (lan_name) VALUES ('Västra Götaland');
INSERT INTO lan (lan_name) VALUES ('Örebro');
INSERT INTO lan (lan_name) VALUES ('Östergötland');

-- SeQF
INSERT INTO seqf (seqf_kod, examenstyp) VALUES (5, 'Yrkeshögskoleexamen');
INSERT INTO seqf (seqf_kod, examenstyp) VALUES (6, 'KvalificeradYrkeshögskoleexamen');

-- Kommuner (från staging, kopplade till län)
INSERT INTO kommun (kommun_name, lan_id)
SELECT DISTINCT a.kommun, l.lan_id
FROM ansokningar a
JOIN lan l ON l.lan_name = a.lan
WHERE a.kommun IS NOT NULL;

-- Utbildningsanordnare
INSERT INTO utbildningsanordnare (name, huvudmannatyp)
SELECT anordnare, MIN(huvudmannatyp)
FROM ansokningar
WHERE anordnare IS NOT NULL
GROUP BY anordnare;

-- SUN5-inriktning
INSERT INTO sun5_inriktning (sun5_kod, utbildningsomrade_id, sun5_namn)
SELECT s.sun5_inriktning, u.utbildningsomrade_id, s.sun5_inriktning_namn
FROM (
    SELECT sun5_inriktning,
           MIN(utbildningsomrade) AS utbildningsomrade,
           MIN(sun5_inriktning_namn) AS sun5_inriktning_namn
    FROM ansokningar
    WHERE sun5_inriktning IS NOT NULL
    GROUP BY sun5_inriktning
) s
JOIN utbildningsomrade u ON u.utbildningsomrade_name = s.utbildningsomrade;

-- Ansökan (faktatabell)
INSERT INTO ansokan (
    diarienummer, sun5_kod, seqf_kod, anordnare_id,
    utbildningsnamn, beslut, yh_poang, studieform, studietakt_procent,
    smalt_yrkesomrade, sokta_utbildningsomgangar, beviljade_utbildningsomgangar,
    sokta_platser_totalt, beviljade_platser_totalt
)
SELECT
    a.diarienummer,
    a.sun5_inriktning,
    TO_NUMBER(a.seqf_niva),
    an.anordnare_id,
    a.utbildningsnamn,
    a.beslut,
    a.yh_poang,
    a.studieform,
    a.studietakt_procent,
    a.smalt_yrkesomrade,
    a.sokta_omgangar,
    a.beviljade_omgangar,
    a.sokta_platser_totalt,
    a.beviljade_platser_totalt
FROM ansokningar a
LEFT JOIN utbildningsanordnare an ON an.name = a.anordnare;

-- Ansökan ↔ kommun
INSERT INTO ansokan_kommun (diarienummer, kommun_id)
SELECT a.diarienummer, k.kommun_id
FROM ansokningar a
JOIN lan l ON l.lan_name = a.lan
JOIN kommun k ON k.kommun_name = a.kommun AND k.lan_id = l.lan_id
WHERE a.diarienummer IS NOT NULL
  AND a.kommun IS NOT NULL;

COMMIT;

-- Kontroll
SELECT 'utbildningsomrade' AS tabell, COUNT(*) AS antal FROM utbildningsomrade
UNION ALL SELECT 'lan', COUNT(*) FROM lan
UNION ALL SELECT 'kommun', COUNT(*) FROM kommun
UNION ALL SELECT 'seqf', COUNT(*) FROM seqf
UNION ALL SELECT 'utbildningsanordnare', COUNT(*) FROM utbildningsanordnare
UNION ALL SELECT 'sun5_inriktning', COUNT(*) FROM sun5_inriktning
UNION ALL SELECT 'ansokan', COUNT(*) FROM ansokan
UNION ALL SELECT 'ansokan_kommun', COUNT(*) FROM ansokan_kommun;

EXIT


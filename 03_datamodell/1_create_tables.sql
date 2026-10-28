CREATE TABLE utbildningsomrade (
    utbildningsomrade_id    NUMBER           GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    utbildningsomrade_name  VARCHAR2(100)    NOT NULL UNIQUE
);

CREATE TABLE sun5_inriktning (
    sun5_kod                VARCHAR2(10)     PRIMARY KEY,
    utbildningsomrade_id    NUMBER           NOT NULL,
    sun5_namn               VARCHAR2(200),
    CONSTRAINT fk_sun5_omrade FOREIGN KEY (utbildningsomrade_id)
        REFERENCES utbildningsomrade (utbildningsomrade_id)
);

CREATE TABLE seqf (
    seqf_kod                NUMBER(2)        PRIMARY KEY,
    examenstyp              VARCHAR2(50)
);

CREATE TABLE utbildningsanordnare (
    anordnare_id            NUMBER           GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name                    VARCHAR2(200)    NOT NULL UNIQUE,
    huvudmannatyp           VARCHAR2(30)
);

CREATE TABLE lan (
    lan_id                  NUMBER           GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    lan_name                VARCHAR2(60)     NOT NULL UNIQUE
);

CREATE TABLE kommun (
    kommun_id               NUMBER           GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    kommun_name             VARCHAR2(100)    NOT NULL,
    lan_id                  NUMBER           NOT NULL,
    CONSTRAINT fk_kommun_lan FOREIGN KEY (lan_id)
        REFERENCES lan (lan_id),
    CONSTRAINT uq_kommun_lan UNIQUE (kommun_name, lan_id)
);


CREATE TABLE ansokan (
    diarienummer                    VARCHAR2(20)     PRIMARY KEY,
    sun5_kod                        VARCHAR2(10),
    seqf_kod                        NUMBER(2),
    anordnare_id                    NUMBER,
    utbildningsnamn                 VARCHAR2(300),
    beslut                          VARCHAR2(20),
    yh_poang                        NUMBER(5),
    studieform                      VARCHAR2(20),
    studietakt_procent              NUMBER(3),
    smalt_yrkesomrade               VARCHAR2(3),
    sokta_utbildningsomgangar       NUMBER(3),
    beviljade_utbildningsomgangar   NUMBER(3),
    sokta_platser_totalt            NUMBER(6),
    beviljade_platser_totalt        NUMBER(6),
    CONSTRAINT fk_ansokan_sun5 FOREIGN KEY (sun5_kod)
        REFERENCES sun5_inriktning (sun5_kod),
    CONSTRAINT fk_ansokan_seqf FOREIGN KEY (seqf_kod)
        REFERENCES seqf (seqf_kod),
    CONSTRAINT fk_ansokan_anordnare FOREIGN KEY (anordnare_id)
        REFERENCES utbildningsanordnare (anordnare_id)
);

CREATE TABLE ansokan_kommun (
    ansokan_kommun_id       NUMBER           GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    diarienummer            VARCHAR2(20)     NOT NULL,
    kommun_id               NUMBER           NOT NULL,
    CONSTRAINT fk_ak_ansokan FOREIGN KEY (diarienummer)
        REFERENCES ansokan (diarienummer),
    CONSTRAINT fk_ak_kommun FOREIGN KEY (kommun_id)
        REFERENCES kommun (kommun_id),
    CONSTRAINT uq_ansokan_kommun UNIQUE (diarienummer, kommun_id)
);

CREATE INDEX idx_sun5_omrade        ON sun5_inriktning (utbildningsomrade_id);
CREATE INDEX idx_kommun_lan         ON kommun (lan_id);
CREATE INDEX idx_ansokan_sun5       ON ansokan (sun5_kod);
CREATE INDEX idx_ansokan_seqf       ON ansokan (seqf_kod);
CREATE INDEX idx_ansokan_anordnare  ON ansokan (anordnare_id);
CREATE INDEX idx_ak_ansokan         ON ansokan_kommun (diarienummer);
CREATE INDEX idx_ak_kommun          ON ansokan_kommun (kommun_id);

EXIT

DROP TABLE ansokningar PURGE;
CREATE TABLE ansokningar (
    utbildningsomrade        VARCHAR2(100),
    sun5_inriktning          VARCHAR2(10),
    sun5_inriktning_namn     VARCHAR2(200),
    utbildningsnamn          VARCHAR2(300),
    beslut                   VARCHAR2(20),
    diarienummer             VARCHAR2(20) PRIMARY KEY,
    flera_kommuner           VARCHAR2(3),
    antal_kommuner           NUMBER(3),
    lan                      VARCHAR2(60),
    kommun                   VARCHAR2(60),
    yh_poang                 NUMBER(5),
    studieform               VARCHAR2(20),
    studietakt_procent       NUMBER(3),
    examenstyp               VARCHAR2(50),
    seqf_niva                NUMBER(2),
    smalt_yrkesomrade        VARCHAR2(3),
    anordnare                VARCHAR2(200),
    huvudmannatyp            VARCHAR2(20),
    sokta_omgangar           NUMBER(3),
    beviljade_omgangar       NUMBER(3),
    sokta_platser_per_omgang NUMBER(5),
    sokta_platser_totalt     NUMBER(6),
    beviljade_platser_omg1   NUMBER(5),
    beviljade_platser_omg2   NUMBER(5),
    beviljade_platser_omg3   NUMBER(5),
    beviljade_platser_omg4   NUMBER(5),
    beviljade_platser_omg5   NUMBER(5),
    beviljade_platser_totalt NUMBER(6)
);
 
EXIT

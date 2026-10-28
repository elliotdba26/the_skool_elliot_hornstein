# The Skool – YH-ansökningar 2025

SQL-labb som hjälper **The Skool** att fatta datadrivna beslut utifrån
MYH:s beslut om YH-ansökningar.

## Uppgift 1 – EDA

| Skript | Fråga |
| ------ | ----- |
| 1a | Antal ansökningar per utbildningsområde |
| 1b | Beviljade per utbildningsområde |
| 1c | Avslag per utbildningsområde |
| 1d–1f | Data/IT: beviljade och avslag per namn/anordnare |
| 1g | Topp 5 län efter beviljade |
| 1h | Andel bunden vs distans |
| 1i | Utbildningar som innehåller "AI" |


## Uppgift 3 – Datadrivna beslut

SQL: `02_beslut/3_datadrivna_beslut.sql`

### Beviljandegrad per utbildningsområde

Data/IT har många ansökningar men låg beviljandegrad (~14 %). Bra att
veta innan The Skool satsar vidare i området.

### Distans vs bunden inom Data/IT

Studieform påverkar utfallet. Bunden har högre beviljandegrad än distans.

### Topp-anordnare inom Data/IT

Vilka aktörer får flest ja, och hur hög är deras hitrate?

### Medel YH-poäng beviljade vs avslag

Nästan samma nivå – programlängd skiljer knappt. Fokusera på annat.

### Beviljade platser per län

Visar var MYH lägger volym. Underlag för var The Skool bör söka.

## Uppgift 4 – Datamodell (bonus)

Bryter upp `ansokningar` i åtta tabeller enligt ER-diagrammet.

```bash
./orac 03_datamodell/1_create_tables.sql
```

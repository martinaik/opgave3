# Opgave 3 - Lagerstyringssystem (SAP ABAP RAP)

## Beskrivelse af projektet
Dette projekt er et lagerstyringssystem udviklet med SAP ABAP RAP. Formålet med projektet er at bygge en Fiori app, hvor brugeren kan oprette og administrere produkter og lagre, registrere lagerbeholdninger samt få et overblik over, hvilke produkter der findes på de enkelte lagre.

## Funktionalitet
Systemet består af tre hovedområder:

**Produkter**: 
Brugeren kan oprette, se, redigere og slette produkter. For hvert produkt gemmes følgende oplysninger:
- Produkt ID
- Produktnavn
- Produktbeskrivelse
- Kategori
- Minimumsbeholdning
- Status (ACTIVE/INACTIVE)

**Lagre**: Brugeren kan oprette, se, redigere og slette lagre. For hvert lager gemmes følgende oplysninger:
- Lager ID
- Lagernavn
- Adresse
- By
- Postnummer

**Lagerbeholdning**: Brugeren kan registrere, hvor mange enheder af et bestemt produkt der findes på et bestemt lager. 

Systemet tildeler automatisk unikke ID'er, når der oprettes nye produkter og lagre. 
Status for et produkt vises med grønt flueben (ACTIVE) og rødt ikon (INACTIVE). 
Lagerbeholdning vises med rødt ikon, når den er under produktets minimum, og grøn flueben ellers. Lagerbeholdninger under minimum kan genopfyldes med ét klik via knappen “Restock to minimum”, som sætter beholdningen op til dobbelt minimum. Knappen er kun aktiv, når beholdningen er under produktets minimum, og produktet ikke er udgået. 

## Datavalidering
For at sikre korrekte data er der implementeret flere valideringer:

**Validering for produkter**
- Produktnavn skal være unikt.
- Produktnavn, produktbeskrivelse, kategori og status må ikke være tomme.
- Kategori skal findes på listen over godkendte kategorier.
- Status skal være ACTIVE eller INACTIVE.
- Produkt med lagerbeholdning kan ikke slettes.

**Validering for lagre**
- Lagernavn skal være unikt.
- Lagernavn, adresse, by og postnummer må ikke være tomme.
- Postnummer skal være præcis 4 cifre (sikre dansk postnummer).
- Lager med lagerbeholdning kan ikke slettes.

**Validering for lagerbeholdning**
- Antal kan ikke være negativt.
- Samme produkt og lager kan ikke oprettes to gange.
- Produktet skal findes og må ikke være udgået (INACTIVE).
- Lageret skal findes.
- Advarsel, når beholdningen er under produktets minimum.

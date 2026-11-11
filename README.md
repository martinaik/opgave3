# Opgave 3 - SAP

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

**Lagre**: Brugeren kan oprette, se, redigere og slette lagre. For hvert lager gemmes følgende oplysninger:
- Lager ID
- Lagernavn
- Adresse
- By
- Postnummer

**Lagerbeholdning**: Brugeren kan registrere, hvor mange enheder af et bestemt produkt der findes på et bestemt lager. 

Systemet tildeler automatisk unikke ID'er, når der oprettes nye produkter og lagre.

## Datavalidering
For at sikre korrekte data er der implementeret flere valideringer:

**Validering for produkter**
- Produktnavn skal være unikt - der kan ikke oprettes produkter med samme navn.
- Produktnavn, produktbeskrivelse og kategori må ikke være tomme.
- Produkt med lagerbeholdning kan ikke slettes.

**Validering for lagre**
- Lagernavn skal være unikt.
- Lagernavn, adresse, by og postnummer må ikke være tomme.
- Postnummer skal være præcis 4 cifre - sikre dansk postnummer.
- Lager med lagerbeholdning kan ikke slettes.

**Validering for lagerbeholdning**
- Antal kan ikke være negativt.
- Samme produkt og lager kan ikke oprettes to gange.
- Produktet skal findes.
- Lageret skal findes.




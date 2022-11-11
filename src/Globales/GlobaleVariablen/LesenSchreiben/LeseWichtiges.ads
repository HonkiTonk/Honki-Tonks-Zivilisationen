with RassenDatentypen; use RassenDatentypen;
with EinheitenDatentypen; use EinheitenDatentypen;
with StadtDatentypen; use StadtDatentypen;
with ForschungenDatentypen;
with ProduktionDatentypen;
with SpielVariablen;

package LeseWichtiges is
   pragma Elaborate_Body;

   function Geldmenge
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return Integer
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   function GeldZugewinnProRunde
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return ProduktionDatentypen.Produktion
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );

   function GesamteForschungsrate
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return ProduktionDatentypen.Lagermenge
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   function Forschungsmenge
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return ProduktionDatentypen.Lagermenge
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   function VerbleibendeForschungszeit
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return ProduktionDatentypen.Lagermenge
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   function Forschungsprojekt
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return ForschungenDatentypen.ForschungIDMitNullWert
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );

   function Erforscht
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      WelcheTechnologieExtern : in ForschungenDatentypen.ForschungID)
      return Boolean
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   function AnzahlStädte
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return StadtDatentypen.MaximaleStädteMitNullWert
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              ),
   
       Post => (
                  AnzahlStädte'Result <= SpielVariablen.Grenzen (RasseExtern).Städtegrenze
               );
   
   function AnzahlEinheiten
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return EinheitenDatentypen.MaximaleEinheitenMitNullWert
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              ),
   
       Post => (
                  AnzahlEinheiten'Result <= SpielVariablen.Grenzen (RasseExtern).Einheitengrenze
               );
   
   function AnzahlArbeiter
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return EinheitenDatentypen.MaximaleEinheitenMitNullWert
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              ),
   
       Post => (
                  AnzahlArbeiter'Result <= SpielVariablen.Grenzen (RasseExtern).Einheitengrenze
               );
     
   function AnzahlKämpfer
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return EinheitenDatentypen.MaximaleEinheitenMitNullWert
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              ),
   
       Post => (
                  AnzahlKämpfer'Result <= SpielVariablen.Grenzen (RasseExtern).Einheitengrenze
               );
     
   function AnzahlSonstiges
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return EinheitenDatentypen.MaximaleEinheitenMitNullWert
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              ),
   
       Post => (
                  AnzahlSonstiges'Result <= SpielVariablen.Grenzen (RasseExtern).Einheitengrenze
               );

end LeseWichtiges;

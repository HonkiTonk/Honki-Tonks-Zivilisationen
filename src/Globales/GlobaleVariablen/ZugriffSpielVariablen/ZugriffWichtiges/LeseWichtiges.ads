with RassenDatentypen;
with EinheitenDatentypen;
with StadtDatentypen;
with ForschungenDatentypen;
with ProduktionDatentypen;
with SpielVariablen;
with SpielRecords;

with LeseGrenzen;

package LeseWichtiges is
   pragma Elaborate_Body;
   use type RassenDatentypen.Spieler_Enum;
   use type StadtDatentypen.MaximaleStädteMitNullWert;
   use type EinheitenDatentypen.MaximaleEinheitenMitNullWert;

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
                  AnzahlStädte'Result <= LeseGrenzen.Städtegrenzen (RasseExtern => RasseExtern)
               );
   
   function AnzahlEinheiten
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return EinheitenDatentypen.MaximaleEinheitenMitNullWert
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              ),
   
       Post => (
                  AnzahlEinheiten'Result <= LeseGrenzen.Einheitengrenze (RasseExtern => RasseExtern)
               );
   
   function AnzahlArbeiter
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return EinheitenDatentypen.MaximaleEinheitenMitNullWert
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              ),
   
       Post => (
                  AnzahlArbeiter'Result <= LeseGrenzen.Einheitengrenze (RasseExtern => RasseExtern)
               );
     
   function AnzahlKämpfer
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return EinheitenDatentypen.MaximaleEinheitenMitNullWert
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              ),
   
       Post => (
                  AnzahlKämpfer'Result <= LeseGrenzen.Einheitengrenze (RasseExtern => RasseExtern)
               );
     
   function AnzahlSonstiges
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return EinheitenDatentypen.MaximaleEinheitenMitNullWert
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              ),
   
       Post => (
                  AnzahlSonstiges'Result <= LeseGrenzen.Einheitengrenze (RasseExtern => RasseExtern)
               );
   
   function GanzerEintrag
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return SpielRecords.WichtigesRecord
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );

end LeseWichtiges;

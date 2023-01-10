with SpeziesDatentypen;
with EinheitenDatentypen;
with StadtDatentypen;
with ForschungenDatentypen;
with ProduktionDatentypen;
with SpielRecords;

with LeseGrenzen;
with LeseSpeziesbelegung;

package LeseWichtiges is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;
   use type StadtDatentypen.MaximaleStädteMitNullWert;
   use type EinheitenDatentypen.MaximaleEinheitenMitNullWert;

   function Geldmenge
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return Integer
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   function GeldZugewinnProRunde
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return ProduktionDatentypen.Produktion
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );

   function GesamteForschungsrate
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return ProduktionDatentypen.Lagermenge
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   function Forschungsmenge
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return ProduktionDatentypen.Lagermenge
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   function VerbleibendeForschungszeit
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return ProduktionDatentypen.Lagermenge
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   function Forschungsprojekt
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return ForschungenDatentypen.ForschungIDMitNullWert
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );

   function Erforscht
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      WelcheTechnologieExtern : in ForschungenDatentypen.ForschungID)
      return Boolean
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   function AnzahlStädte
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return StadtDatentypen.MaximaleStädteMitNullWert
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              ),
   
       Post => (
                  AnzahlStädte'Result <= LeseGrenzen.Städtegrenzen (SpeziesExtern => SpeziesExtern)
               );
   
   function AnzahlEinheiten
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return EinheitenDatentypen.MaximaleEinheitenMitNullWert
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              ),
   
       Post => (
                  AnzahlEinheiten'Result <= LeseGrenzen.Einheitengrenze (SpeziesExtern => SpeziesExtern)
               );
   
   function AnzahlArbeiter
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return EinheitenDatentypen.MaximaleEinheitenMitNullWert
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              ),
   
       Post => (
                  AnzahlArbeiter'Result <= LeseGrenzen.Einheitengrenze (SpeziesExtern => SpeziesExtern)
               );
     
   function AnzahlKämpfer
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return EinheitenDatentypen.MaximaleEinheitenMitNullWert
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              ),
   
       Post => (
                  AnzahlKämpfer'Result <= LeseGrenzen.Einheitengrenze (SpeziesExtern => SpeziesExtern)
               );
     
   function AnzahlSonstiges
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return EinheitenDatentypen.MaximaleEinheitenMitNullWert
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              ),
   
       Post => (
                  AnzahlSonstiges'Result <= LeseGrenzen.Einheitengrenze (SpeziesExtern => SpeziesExtern)
               );
   
   function GanzerEintrag
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return SpielRecords.WichtigesRecord
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );

end LeseWichtiges;

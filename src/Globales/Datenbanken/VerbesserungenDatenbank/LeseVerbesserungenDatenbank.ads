with SpeziesDatentypen;
with EinheitenDatentypen;
with KartenverbesserungDatentypen;
with ProduktionDatentypen;
with KampfDatentypen;

with LeseSpeziesbelegung;

package LeseVerbesserungenDatenbank is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;
   
   function PassierbarkeitWeg
     (WegExtern : in KartenverbesserungDatentypen.Weg_Enum;
      UmgebungExtern : in EinheitenDatentypen.Passierbarkeit_Enum)
      return Boolean;
   
   function BewegungWeg
     (WegExtern : in KartenverbesserungDatentypen.Weg_Enum;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return EinheitenDatentypen.Bewegungspunkte
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   function ProduktionVerbesserung
     (VerbesserungExtern : in KartenverbesserungDatentypen.Verbesserung_Enum;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      ProduktionsartExtern : in ProduktionDatentypen.Produktion_Enum)
      return ProduktionDatentypen.Produktionsbonus
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   function ProduktionWeg
     (WegExtern : in KartenverbesserungDatentypen.Weg_Enum;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      ProduktionsartExtern : in ProduktionDatentypen.Produktion_Enum)
      return ProduktionDatentypen.Produktionsbonus
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   function KampfVerbesserung
     (VerbesserungExtern : in KartenverbesserungDatentypen.Verbesserung_Enum;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      KampfartExtern : in KampfDatentypen.Kampf_Enum)
      return KampfDatentypen.Kampfbonus
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   function KampfWeg
     (WegExtern : in KartenverbesserungDatentypen.Weg_Enum;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      KampfartExtern : in KampfDatentypen.Kampf_Enum)
      return KampfDatentypen.Kampfbonus
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );

end LeseVerbesserungenDatenbank;

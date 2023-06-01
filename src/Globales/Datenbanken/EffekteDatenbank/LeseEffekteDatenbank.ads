with SpeziesDatentypen;
with ProduktionDatentypen;
with KampfDatentypen;
with KarteneffektDatentypen;

with LeseSpeziesbelegung;

package LeseEffekteDatenbank is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;

   function Produktion
     (EffektExtern : in KarteneffektDatentypen.Effekt_Kartenfeld_Enum;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      ProduktionsartExtern : in ProduktionDatentypen.Produktion_Enum)
      return ProduktionDatentypen.Produktionsbonus
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   function Kampf
     (EffektExtern : in KarteneffektDatentypen.Effekt_Kartenfeld_Enum;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      KampfartExtern : in KampfDatentypen.Kampf_Enum)
      return ProduktionDatentypen.Produktionsbonus
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );

end LeseEffekteDatenbank;

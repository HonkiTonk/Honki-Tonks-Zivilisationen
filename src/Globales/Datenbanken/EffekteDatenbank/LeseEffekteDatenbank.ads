with SpeziesDatentypen;
with ProduktionDatentypen;
with KampfDatentypen;
with KartenextraDatentypen;

with LeseSpeziesbelegung;

package LeseEffekteDatenbank is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;

   function Produktion
     (EffektExtern : in KartenextraDatentypen.Effekt_Kartenfeld_Enum;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      ProduktionsartExtern : in ProduktionDatentypen.Produktion_Enum)
      return ProduktionDatentypen.Produktionsbonus
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   function Kampf
     (EffektExtern : in KartenextraDatentypen.Effekt_Kartenfeld_Enum;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      KampfartExtern : in KampfDatentypen.Kampf_Enum)
      return KampfDatentypen.Kampfbonus
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );

end LeseEffekteDatenbank;

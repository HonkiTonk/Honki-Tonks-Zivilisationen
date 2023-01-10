with SpeziesDatentypen;

with LeseSpeziesbelegung;

package KIDiplomatieLogik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;

   procedure Diplomatie
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.KI_Spieler_Enum
              );

   procedure DiplomatieKIMensch
     (SpeziesMenschExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      SpeziesKIExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesMenschExtern) = SpeziesDatentypen.Mensch_Spieler_Enum
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesKIExtern) = SpeziesDatentypen.KI_Spieler_Enum
              );

   procedure DiplomatieKIKI
     (EigeneSpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      FremdeSpeziesKIExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EigeneSpeziesExtern) = SpeziesDatentypen.KI_Spieler_Enum
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => FremdeSpeziesKIExtern) = SpeziesDatentypen.KI_Spieler_Enum
              );

end KIDiplomatieLogik;

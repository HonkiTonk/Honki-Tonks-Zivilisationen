with SpeziesDatentypen;

private with RueckgabeDatentypen;

with LeseSpeziesbelegung;

package DiplomatieLogik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;

   procedure DiplomatieMöglich
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.Mensch_Spieler_Enum
              );

private

   KontaktierteSpezies : SpeziesDatentypen.Spezies_Verwendet_Enum;

   AktionAuswahl : RueckgabeDatentypen.Rückgabe_Werte_Enum;

   Auswahl : Natural;

   procedure Speziesprüfungen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );

   procedure Diplomatie
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );

end DiplomatieLogik;

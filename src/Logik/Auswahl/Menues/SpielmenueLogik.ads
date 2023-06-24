with SpeziesDatentypen;
with RueckgabeDatentypen;

with LeseSpeziesbelegung;

package SpielmenueLogik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;

   function Spielmenü
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return RueckgabeDatentypen.Rückgabe_Werte_Enum
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.Mensch_Spieler_Enum
              );
   
private
   
   AuswahlSpielmenü : RueckgabeDatentypen.Rückgabe_Werte_Enum;
   RückgabeOptionen : RueckgabeDatentypen.Rückgabe_Werte_Enum;

end SpielmenueLogik;

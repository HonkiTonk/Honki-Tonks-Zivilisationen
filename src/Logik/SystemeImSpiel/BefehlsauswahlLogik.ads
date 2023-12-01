with SpeziesDatentypen;
with RueckgabeDatentypen;

private with TastenbelegungDatentypen;

with LeseSpeziesbelegung;

package BefehlsauswahlLogik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;

   function Befehlsauswahl
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return RueckgabeDatentypen.Rückgabe_Werte_Enum
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.Mensch_Spieler_Enum
              );
   
private
      
   Befehl : TastenbelegungDatentypen.Allgemeine_Belegung_Enum;
   
   
   
   function Tasteneingabe
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      BefehlExtern : in TastenbelegungDatentypen.Allgemeine_Belegung_Enum)
      return RueckgabeDatentypen.Rückgabe_Werte_Enum
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.Mensch_Spieler_Enum
              );

end BefehlsauswahlLogik;

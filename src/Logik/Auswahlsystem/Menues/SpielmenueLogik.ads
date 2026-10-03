with SpeziesDatentypen;
with RueckgabeDatentypen;

with LeseSpeziesbelegung;

package SpielmenueLogik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;

   function Spielmenü
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return RueckgabeDatentypen.Rückgabe_Werte_Enum
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.Mensch_Spieler_Enum
              );
   
private
   
   -- Das hier immer identisch mit den Werten in SpielLogik halten oder mal in GlobaleKonstanten auslagern. äöü
   Weiter : constant RueckgabeDatentypen.Auswahl_Enum := RueckgabeDatentypen.Auswahl_Enum'First;
   Speichern : constant RueckgabeDatentypen.Auswahl_Enum := RueckgabeDatentypen.Auswahl_Enum'Succ (Weiter);
   Laden : constant RueckgabeDatentypen.Auswahl_Enum := RueckgabeDatentypen.Auswahl_Enum'Succ (Speichern);
   Optionen : constant RueckgabeDatentypen.Auswahl_Enum := RueckgabeDatentypen.Auswahl_Enum'Succ (Laden);
   
   AuswahlSpielmenü : RueckgabeDatentypen.Rückgabe_Werte_Enum;
   RückgabeOptionen : RueckgabeDatentypen.Rückgabe_Werte_Enum;

end SpielmenueLogik;

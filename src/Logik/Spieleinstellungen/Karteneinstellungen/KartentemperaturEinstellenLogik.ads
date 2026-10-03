private with RueckgabeDatentypen;

package KartentemperaturEinstellenLogik is
   pragma Elaborate_Body;
   
   procedure Kartentemperatur;
   
private
   
   Zufall : constant RueckgabeDatentypen.Auswahl_Enum := RueckgabeDatentypen.Auswahl_Enum'Succ (RueckgabeDatentypen.Kartentemperatur_Enum'Last);
   
   KartentemperaturAuswahl : RueckgabeDatentypen.Rückgabe_Werte_Enum;
   
end KartentemperaturEinstellenLogik;

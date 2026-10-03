private with RueckgabeDatentypen;

package HauptmenueLogik is
   pragma Elaborate_Body;

   procedure Hauptmenü;
   
private
   
   StartWeiter : constant RueckgabeDatentypen.Auswahl_Enum := RueckgabeDatentypen.Auswahl_Enum'First;
   Schnellstart : constant RueckgabeDatentypen.Auswahl_Enum := RueckgabeDatentypen.Auswahl_Enum'Succ (StartWeiter);
   Laden : constant RueckgabeDatentypen.Auswahl_Enum := RueckgabeDatentypen.Auswahl_Enum'Succ (Schnellstart);
   Optionen : constant RueckgabeDatentypen.Auswahl_Enum := RueckgabeDatentypen.Auswahl_Enum'Succ (Laden);
   Editoren : constant RueckgabeDatentypen.Auswahl_Enum := RueckgabeDatentypen.Auswahl_Enum'Succ (Optionen);
   Würdigungen : constant RueckgabeDatentypen.Auswahl_Enum := RueckgabeDatentypen.Auswahl_Enum'Succ (Editoren);
  
   RückgabeAuswahl : RueckgabeDatentypen.Rückgabe_Werte_Enum;

end HauptmenueLogik;

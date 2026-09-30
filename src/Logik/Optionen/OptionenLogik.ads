with RueckgabeDatentypen;

package OptionenLogik is
   pragma Elaborate_Body;

   function Optionen
     return RueckgabeDatentypen.Rückgabe_Werte_Enum;

private

   Grafik : constant RueckgabeDatentypen.Auswahl_Enum := RueckgabeDatentypen.Auswahl_Enum'First;
   Sound : constant RueckgabeDatentypen.Auswahl_Enum := RueckgabeDatentypen.Auswahl_Enum'Succ (Grafik);
   Steuerung : constant RueckgabeDatentypen.Auswahl_Enum := RueckgabeDatentypen.Auswahl_Enum'Succ (Sound);
   Sonstiges : constant RueckgabeDatentypen.Auswahl_Enum := RueckgabeDatentypen.Auswahl_Enum'Succ (Steuerung);

   AuswahlWert : RueckgabeDatentypen.Rückgabe_Werte_Enum;
   RückgabeWert : RueckgabeDatentypen.Rückgabe_Werte_Enum;

end OptionenLogik;

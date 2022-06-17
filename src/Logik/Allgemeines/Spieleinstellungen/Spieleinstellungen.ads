pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RueckgabeDatentypen;

package Spieleinstellungen is

   function Spieleinstellungen
     (SchnellstartExtern : in Boolean)
      return RueckgabeDatentypen.Rückgabe_Werte_Enum;

private

   RassenVorhanden : Boolean;

   Auswahl : RueckgabeDatentypen.Rückgabe_Werte_Enum;
   Rückgabewert : RueckgabeDatentypen.Rückgabe_Werte_Enum;

   function AutomatischeEinstellungen
      return RueckgabeDatentypen.Rückgabe_Werte_Enum;

end Spieleinstellungen;

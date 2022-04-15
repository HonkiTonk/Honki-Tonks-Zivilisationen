pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RueckgabeDatentypen;

package Auswahl is

   function AuswahlJaNein
     (FrageZeileExtern : in Positive)
      return RueckgabeDatentypen.Rückgabe_Werte_Enum;
   
private

   AktuelleAuswahl : Positive;
   
   Anfang : Natural;
   Ende : Natural;
   
end Auswahl;

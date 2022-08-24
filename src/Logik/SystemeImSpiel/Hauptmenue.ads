pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

private with RueckgabeDatentypen;

package Hauptmenue is

   procedure Hauptmenü;
   
private
  
   RückgabeKampagne : RueckgabeDatentypen.Rückgabe_Werte_Enum;

end Hauptmenue;

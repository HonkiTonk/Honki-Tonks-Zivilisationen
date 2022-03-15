pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with SystemDatentypen;

package Hauptmenue is

   procedure Hauptmenü;
   
private
  
   RückgabeKampagne : SystemDatentypen.Rückgabe_Werte_Enum;

end Hauptmenue;

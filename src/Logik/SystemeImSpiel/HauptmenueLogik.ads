pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

private with RueckgabeDatentypen;

package HauptmenueLogik is

   procedure Hauptmenü;
   
private
  
   RückgabeKampagne : RueckgabeDatentypen.Rückgabe_Werte_Enum;

end HauptmenueLogik;

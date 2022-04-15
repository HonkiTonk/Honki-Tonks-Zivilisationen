pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

package body KIKriegBeenden is
   
   function KriegBeenden
     (EigeneRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      FeindlicheRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return Boolean
   is begin
      
      if
        EigeneRasseExtern = FeindlicheRasseExtern
      then
         null;
         
      else
         null;
      end if;
      
      return True;
      
   end KriegBeenden;

end KIKriegBeenden;

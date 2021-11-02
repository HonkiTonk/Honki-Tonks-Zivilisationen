pragma SPARK_Mode (On);

package body KIKriegBeenden is
   
   function KriegBeenden
     (EigeneRasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      FeindlicheRasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
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

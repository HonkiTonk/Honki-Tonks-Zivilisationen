pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KIDatentypen; use KIDatentypen;

with KIKriegErmitteln;

package body KIEinheitAufgabeNichts is

   function NichtsTun
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return KIDatentypen.AufgabenWichtigkeit
   is begin
      
      case
        KIKriegErmitteln.IstImKrieg (RasseExtern => RasseExtern)
      is
         when True =>
            return -1;
            
         when False =>
            return 1;
      end case;
      
   end NichtsTun;

end KIEinheitAufgabeNichts;

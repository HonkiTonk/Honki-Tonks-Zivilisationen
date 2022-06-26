pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KIDatentypen; use KIDatentypen;

with KIKriegErmitteln;

package body KIEinheitAufgabeErkunden is

   function Erkunden
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
     return KIDatentypen.AufgabenWichtigkeitKlein
   is begin
      
      case
        KIKriegErmitteln.IstImKrieg (RasseExtern => EinheitRasseNummerExtern.Rasse)
      is
         when True =>
            return -1;
            
         when False =>
            null;
      end case;
      
      return 5;
      
   end Erkunden;

end KIEinheitAufgabeErkunden;

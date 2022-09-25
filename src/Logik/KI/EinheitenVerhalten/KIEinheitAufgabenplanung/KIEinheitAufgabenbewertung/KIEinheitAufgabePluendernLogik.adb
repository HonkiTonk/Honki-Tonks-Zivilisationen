pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KIDatentypen; use KIDatentypen;

with KIKriegErmittelnLogik;

package body KIEinheitAufgabePluendernLogik is

   function StadtumgebungZerstören
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return KIDatentypen.AufgabenWichtigkeitKlein
   is begin
      
      case
        KIKriegErmittelnLogik.IstImKrieg (RasseExtern => EinheitRasseNummerExtern.Rasse)
      is
         when True =>
            null;
            
         when False =>
            return -1;
      end case;
      
      return 0;
      
   end StadtumgebungZerstören;

end KIEinheitAufgabePluendernLogik;

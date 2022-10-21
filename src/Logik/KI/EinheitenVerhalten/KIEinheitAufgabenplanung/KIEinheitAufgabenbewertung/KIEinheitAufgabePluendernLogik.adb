pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KIKonstanten;

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
            return KIKonstanten.UnmöglichAufgabenbewertung;
      end case;
      
      return KIKonstanten.LeerAufgabenbewertung;
      
   end StadtumgebungZerstören;

end KIEinheitAufgabePluendernLogik;

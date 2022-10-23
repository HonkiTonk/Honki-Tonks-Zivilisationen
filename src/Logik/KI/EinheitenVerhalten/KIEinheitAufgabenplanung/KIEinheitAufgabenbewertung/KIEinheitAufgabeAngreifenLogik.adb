pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with EinheitenRecords; use EinheitenRecords;
with EinheitenKonstanten;

with KIKonstanten;

with KIKriegErmittelnLogik;
with KIGefahrErmittelnLogik;

package body KIEinheitAufgabeAngreifenLogik is

   function Angreifen
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
      
      if
        KIGefahrErmittelnLogik.GefahrErmitteln (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = EinheitenKonstanten.LeerRasseNummer
      then
         return KIKonstanten.LeerAufgabenbewertung;
         
      else
         return 50;
      end if;
            
   end Angreifen;

end KIEinheitAufgabeAngreifenLogik;

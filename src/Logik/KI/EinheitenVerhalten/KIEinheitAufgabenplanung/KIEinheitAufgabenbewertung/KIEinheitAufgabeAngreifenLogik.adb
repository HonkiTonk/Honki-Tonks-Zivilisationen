pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with EinheitenRecords; use EinheitenRecords;
with EinheitenKonstanten;

with KIDatentypen; use KIDatentypen;

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
            return -1;
      end case;
      
      if
        KIGefahrErmittelnLogik.GefahrErmitteln (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = EinheitenKonstanten.LeerRasseNummer
      then
         null;
         
      else
         null;
      end if;
      
      return 0;
      
   end Angreifen;

end KIEinheitAufgabeAngreifenLogik;

pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KIKriegErmitteln;

package body KIEinheitUmsetzenAngreifen is

   function Angreifen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is begin
      
      -- Platzhalter
      case
        KIKriegErmitteln.IstImKrieg (RasseExtern => EinheitRasseNummerExtern.Rasse)
      is
         when True =>
            null;
            
         when False =>
            null;
      end case;
      
      return False;
      
   end Angreifen;

end KIEinheitUmsetzenAngreifen;

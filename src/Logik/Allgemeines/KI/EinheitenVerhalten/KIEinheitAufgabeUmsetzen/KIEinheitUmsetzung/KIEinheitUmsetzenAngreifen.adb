pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KIKriegErmitteln;

package body KIEinheitUmsetzenAngreifen is

   function Angreifen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is begin
      
      --------------------------------------- Hier direkt nächste Einheit zum Angreifen suchen?
      --------------------------------------- KIEinheitFestlegenAngreifen.Angreifen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
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

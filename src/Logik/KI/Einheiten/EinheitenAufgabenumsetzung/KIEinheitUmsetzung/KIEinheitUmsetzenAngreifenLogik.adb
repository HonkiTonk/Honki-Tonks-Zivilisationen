with KIKriegErmittelnLogik;

package body KIEinheitUmsetzenAngreifenLogik is

   function Angreifen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is begin
      
      -- Hier direkt nächste Einheit zum Angreifen suchen? äöü
      -- KIEinheitFestlegenAngreifen.Angreifen (EinheitRasseNummerExtern => EinheitRasseNummerExtern); äöü
      
      -- Platzhalter
      case
        KIKriegErmittelnLogik.IstImKrieg (RasseExtern => EinheitRasseNummerExtern.Rasse)
      is
         when True =>
            null;
            
         when False =>
            null;
      end case;
      
      return False;
      
   end Angreifen;

end KIEinheitUmsetzenAngreifenLogik;

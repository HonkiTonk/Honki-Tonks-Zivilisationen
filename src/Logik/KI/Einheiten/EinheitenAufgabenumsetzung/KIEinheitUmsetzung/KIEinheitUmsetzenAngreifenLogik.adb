with KIKriegErmittelnLogik;

package body KIEinheitUmsetzenAngreifenLogik is

   function Angreifen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is begin
      
      -- Hier direkt nächste Einheit zum Angreifen suchen? äöü
      -- KIEinheitFestlegenAngreifen.Angreifen (EinheitRasseNummerExtern => EinheitRasseNummerExtern); äöü
      
      -- Platzhalter
        return KIKriegErmittelnLogik.IstImKrieg (RasseExtern => EinheitRasseNummerExtern.Rasse);
      
   end Angreifen;

end KIEinheitUmsetzenAngreifenLogik;

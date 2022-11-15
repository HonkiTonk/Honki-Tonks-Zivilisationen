with LeseEinheitenGebaut;

with StadtBauenLogik;

with KIKartenfeldbewertungModifizierenLogik;

package body KIEinheitUmsetzenSiedelnLogik is

   function StadtErrichten
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is begin
      
      case
        KIKartenfeldbewertungModifizierenLogik.StadtabstandVorhanden (KoordinatenExtern => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern))
      is
         when True =>
            return StadtBauenLogik.StadtBauen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when False =>
            return False;
      end case;
      
   end StadtErrichten;

end KIEinheitUmsetzenSiedelnLogik;

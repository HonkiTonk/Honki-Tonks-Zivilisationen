with LeseEinheitenGebaut;

with StadtBauenLogik;

with KIKartenfeldbewertungModifizierenLogik;

package body KIEinheitUmsetzenSiedelnLogik is

   function StadtErrichten
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return Boolean
   is begin
      
      case
        KIKartenfeldbewertungModifizierenLogik.StadtabstandVorhanden (KoordinatenExtern => LeseEinheitenGebaut.Koordinaten (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern))
      is
         when True =>
            return StadtBauenLogik.StadtBauen (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
            
         when False =>
            return False;
      end case;
      
   end StadtErrichten;

end KIEinheitUmsetzenSiedelnLogik;

with BefehleDatentypen;

with LeseEinheitenGebaut;

with AufgabenLogik;

with KIDatentypen;

with KIEinheitUmsetzenBewachenLogik;

package body KIEinheitUmsetzenModernisierenLogik is

   function EinheitVerbessern
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is begin
      
      NullWert := AufgabenLogik.Aufgabe (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                         BefehlExtern             => BefehleDatentypen.Einheit_Verbessern_Enum,
                                         KoordinatenExtern        => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern));
      
      case
        LeseEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern)
      is
         when KIDatentypen.Stadt_Bewachen_Enum =>
            NullWert := KIEinheitUmsetzenBewachenLogik.StadtBewachen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when others =>
            null;
      end case;
      
      return False;
            
   end EinheitVerbessern;

end KIEinheitUmsetzenModernisierenLogik;

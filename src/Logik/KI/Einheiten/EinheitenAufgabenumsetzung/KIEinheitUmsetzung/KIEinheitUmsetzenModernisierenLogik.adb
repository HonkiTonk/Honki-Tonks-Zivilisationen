with BefehleDatentypen;

with LeseEinheitenGebaut;

with AufgabenLogik;

package body KIEinheitUmsetzenModernisierenLogik is

   function EinheitVerbessern
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is begin
      
      NullWert := AufgabenLogik.Aufgabe (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                         BefehlExtern             => BefehleDatentypen.Einheit_Verbessern_Enum,
                                         KoordinatenExtern        => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern));
      
      return False;
      
   end EinheitVerbessern;

end KIEinheitUmsetzenModernisierenLogik;

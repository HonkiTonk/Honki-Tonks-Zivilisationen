with BefehleDatentypen;

with LeseEinheitenGebaut;

with AufgabenLogik;

package body KIEinheitUmsetzenBefestigenLogik is

   function Befestigen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is begin
      
      return AufgabenLogik.Aufgabe (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                    BefehlExtern             => BefehleDatentypen.Verschanzen_Enum,
                                    KoordinatenExtern        => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern));
      
   end Befestigen;

end KIEinheitUmsetzenBefestigenLogik;

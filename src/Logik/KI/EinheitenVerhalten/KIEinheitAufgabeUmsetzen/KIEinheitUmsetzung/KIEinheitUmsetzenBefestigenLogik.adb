pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with TastenbelegungDatentypen;

with LeseEinheitenGebaut;

with AufgabenLogik;

package body KIEinheitUmsetzenBefestigenLogik is

   function Befestigen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is begin
      
      return AufgabenLogik.Aufgabe (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                    BefehlExtern             => TastenbelegungDatentypen.Verschanzen_Enum,
                                    KoordinatenExtern        => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern));
      
   end Befestigen;

end KIEinheitUmsetzenBefestigenLogik;

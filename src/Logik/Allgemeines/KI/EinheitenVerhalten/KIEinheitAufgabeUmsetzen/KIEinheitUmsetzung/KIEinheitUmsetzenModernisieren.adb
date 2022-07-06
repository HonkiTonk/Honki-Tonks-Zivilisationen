pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with TastenbelegungDatentypen;

with LeseEinheitenGebaut;

with Aufgaben;

package body KIEinheitUmsetzenModernisieren is

   function EinheitVerbessern
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is begin
      
      NullWert := Aufgaben.Aufgabe (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                BefehlExtern             => TastenbelegungDatentypen.Einheit_Verbessern_Enum,
                                                KoordinatenExtern        => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern));
      
      return False;
      
   end EinheitVerbessern;

end KIEinheitUmsetzenModernisieren;

pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with TastenbelegungDatentypen;

with Aufgaben;

package body KIEinheitUmsetzenModernisieren is

   function EinheitVerbessern
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is begin
      
      NullWert := Aufgaben.VerbesserungAnlegen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                BefehlExtern             => TastenbelegungDatentypen.Einheit_Verbessern_Enum);
      
      return False;
      
   end EinheitVerbessern;

end KIEinheitUmsetzenModernisieren;

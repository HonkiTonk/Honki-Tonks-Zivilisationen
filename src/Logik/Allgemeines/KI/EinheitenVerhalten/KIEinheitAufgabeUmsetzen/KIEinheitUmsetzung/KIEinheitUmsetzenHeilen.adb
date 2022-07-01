pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with TastenbelegungDatentypen;

with Aufgaben;

package body KIEinheitUmsetzenHeilen is

   function Heilen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is begin
      
      return Aufgaben.VerbesserungAnlegen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                           BefehlExtern             => TastenbelegungDatentypen.Heilen_Enum);
      
   end Heilen;

end KIEinheitUmsetzenHeilen;

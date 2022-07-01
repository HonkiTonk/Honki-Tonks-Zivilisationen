pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with TastenbelegungDatentypen;

with Aufgaben;

package body KIEinheitUmsetzenBefestigen is

   function Befestigen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is begin
      
      return Aufgaben.VerbesserungAnlegen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                           BefehlExtern             => TastenbelegungDatentypen.Verschanzen_Enum);
      
   end Befestigen;

end KIEinheitUmsetzenBefestigen;

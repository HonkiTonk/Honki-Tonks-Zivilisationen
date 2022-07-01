pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with TastenbelegungDatentypen;

with Aufgaben;

package body KIEinheitUmsetzenBewachen is

   function StadtBewachen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is begin
      
      return Aufgaben.VerbesserungAnlegen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                           BefehlExtern             => TastenbelegungDatentypen.Verschanzen_Enum);
      
   end StadtBewachen;
     
end KIEinheitUmsetzenBewachen;

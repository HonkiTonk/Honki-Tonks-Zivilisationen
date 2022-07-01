pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with TastenbelegungDatentypen;

with Aufgaben;

package body KIEinheitUmsetzenPluendern is

   function StadtumgebungZerstören
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is begin
      
      return Aufgaben.VerbesserungAnlegen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                           BefehlExtern             => TastenbelegungDatentypen.Plündern_Enum);
      
   end StadtumgebungZerstören;

end KIEinheitUmsetzenPluendern;

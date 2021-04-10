pragma SPARK_Mode (On);

with KIDatentypen;

with KIBewegung;

package body KIFernkampfLandEinheit is

   procedure KIFernkampfLandEinheit
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      KIBewegung.KIBewegung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                             AufgabeExtern            => KIDatentypen.Erkunden);
      
   end KIFernkampfLandEinheit;

end KIFernkampfLandEinheit;

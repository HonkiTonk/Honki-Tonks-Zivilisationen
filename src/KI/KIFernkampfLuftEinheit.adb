pragma SPARK_Mode (On);

with KIDatentypen;

with KIBewegung;

package body KIFernkampfLuftEinheit is

   procedure KIFernkampfLuftEinheit
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      KIBewegung.KIBewegung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                             AufgabeExtern            => KIDatentypen.Erkunden);
      
   end KIFernkampfLuftEinheit;

end KIFernkampfLuftEinheit;

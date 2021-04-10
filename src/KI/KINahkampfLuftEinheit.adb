pragma SPARK_Mode (On);

with KIDatentypen;

with KIBewegung;

package body KINahkampfLuftEinheit is

   procedure KINahkampfLuftEinheit
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      KIBewegung.KIBewegung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                             AufgabeExtern            => KIDatentypen.Erkunden);
      
   end KINahkampfLuftEinheit;

end KINahkampfLuftEinheit;

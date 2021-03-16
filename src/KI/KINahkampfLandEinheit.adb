pragma SPARK_Mode (On);

with KIDatentypen;

with KIBewegung;

package body KINahkampfLandEinheit is

   procedure KINahkampfLandEinheit (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord) is
   begin
      
      KIBewegung.KIBewegung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                             AufgabeExtern            => KIDatentypen.Erkunden);
      
   end KINahkampfLandEinheit;

end KINahkampfLandEinheit;

pragma SPARK_Mode (On);

with KIDatentypen;

with KIBewegung;

package body KINahkampfSeeEinheit is

   procedure KINahkampfSeeEinheit (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord) is
   begin
      
      KIBewegung.KIBewegung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                             AufgabeExtern            => KIDatentypen.Erkunden);
      
   end KINahkampfSeeEinheit;

end KINahkampfSeeEinheit;

pragma SPARK_Mode (On);

with KIDatentypen;

with KIBewegung;

package body KIFernkampfSeeEinheit is

   procedure KIFernkampfSeeEinheit (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord) is
   begin
      
      KIBewegung.KIBewegung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                             AufgabeExtern            => KIDatentypen.Erkunden);
      
   end KIFernkampfSeeEinheit;

end KIFernkampfSeeEinheit;

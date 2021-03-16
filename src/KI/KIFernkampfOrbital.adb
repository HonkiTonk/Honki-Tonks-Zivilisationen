pragma SPARK_Mode (On);

with KIDatentypen;

with KIBewegung;

package body KIFernkampfOrbital is

   procedure KIFernkampfOrbital (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord) is
   begin
      
      KIBewegung.KIBewegung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                             AufgabeExtern            => KIDatentypen.Erkunden);
      
   end KIFernkampfOrbital;

end KIFernkampfOrbital;

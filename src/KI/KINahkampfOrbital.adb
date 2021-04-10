pragma SPARK_Mode (On);

with KIDatentypen;

with KIBewegung;

package body KINahkampfOrbital is

   procedure KINahkampfOrbital
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      KIBewegung.KIBewegung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                             AufgabeExtern            => KIDatentypen.Erkunden);
      
   end KINahkampfOrbital;

end KINahkampfOrbital;

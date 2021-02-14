pragma SPARK_Mode (On);

with KIBewegung, KIDatentypen;

package body KINahkampfOrbital is

   procedure KINahkampfOrbital (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord) is
   begin
      
      KIBewegung.KIBewegung (EinheitRasseNummer => EinheitRasseNummer,
                             Aufgabe            => KIDatentypen.Erkunden);
      
   end KINahkampfOrbital;

end KINahkampfOrbital;

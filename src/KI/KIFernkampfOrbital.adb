pragma SPARK_Mode (On);

with KIDatentypen;

with KIBewegung;

package body KIFernkampfOrbital is

   procedure KIFernkampfOrbital (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord) is
   begin
      
      KIBewegung.KIBewegung (EinheitRasseNummer => EinheitRasseNummer,
                             Aufgabe            => KIDatentypen.Erkunden);
      
   end KIFernkampfOrbital;

end KIFernkampfOrbital;

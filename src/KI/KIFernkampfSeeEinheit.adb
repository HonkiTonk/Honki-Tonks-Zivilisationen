pragma SPARK_Mode (On);

with KIBewegung, KIDatentypen;

package body KIFernkampfSeeEinheit is

   procedure KIFernkampfSeeEinheit (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord) is
   begin
      
      KIBewegung.KIBewegung (EinheitRasseNummer => EinheitRasseNummer,
                             Aufgabe            => KIDatentypen.Erkunden);
      
   end KIFernkampfSeeEinheit;

end KIFernkampfSeeEinheit;

pragma SPARK_Mode (On);

with KIDatentypen;

with KIBewegung;

package body KIFernkampfLandEinheit is

   procedure KIFernkampfLandEinheit (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord) is
   begin
      
      KIBewegung.KIBewegung (EinheitRasseNummer => EinheitRasseNummer,
                             Aufgabe            => KIDatentypen.Erkunden);
      
   end KIFernkampfLandEinheit;

end KIFernkampfLandEinheit;

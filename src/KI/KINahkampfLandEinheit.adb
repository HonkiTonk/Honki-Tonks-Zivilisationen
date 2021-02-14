pragma SPARK_Mode (On);

with KIBewegung, KIDatentypen;

package body KINahkampfLandEinheit is

   procedure KINahkampfLandEinheit (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord) is
   begin
      
      KIBewegung.KIBewegung (EinheitRasseNummer => EinheitRasseNummer,
                             Aufgabe            => KIDatentypen.Erkunden);
      
   end KINahkampfLandEinheit;

end KINahkampfLandEinheit;

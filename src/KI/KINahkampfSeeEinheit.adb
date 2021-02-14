pragma SPARK_Mode (On);

with KIBewegung, KIDatentypen;

package body KINahkampfSeeEinheit is

   procedure KINahkampfSeeEinheit (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord) is
   begin
      
      KIBewegung.KIBewegung (EinheitRasseNummer => EinheitRasseNummer,
                             Aufgabe            => KIDatentypen.Erkunden);
      
   end KINahkampfSeeEinheit;

end KINahkampfSeeEinheit;

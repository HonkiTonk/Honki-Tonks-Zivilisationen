pragma SPARK_Mode (On);

with KIBewegung, KIDatentypen;

package body KINahkampfLuftEinheit is

   procedure KINahkampfLuftEinheit (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord) is
   begin
      
      KIBewegung.KIBewegung (EinheitRasseNummer => EinheitRasseNummer,
                             Aufgabe            => KIDatentypen.Erkunden);
      
   end KINahkampfLuftEinheit;

end KINahkampfLuftEinheit;

pragma SPARK_Mode (On);

with KIBewegung, KIDatentypen;

package body KIFernkampfLuftEinheit is

   procedure KIFernkampfLuftEinheit (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord) is
   begin
      
      KIBewegung.KIBewegung (EinheitRasseNummer => EinheitRasseNummer,
                             Aufgabe            => KIDatentypen.Erkunden);
      
   end KIFernkampfLuftEinheit;

end KIFernkampfLuftEinheit;

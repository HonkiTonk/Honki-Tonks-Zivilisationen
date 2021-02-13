pragma SPARK_Mode (On);

with KIBewegung;

package body KIFernkampfLuftEinheit is

   procedure KIFernkampfLuftEinheit (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord) is
   begin
      
      KIBewegung.KIBewegung (EinheitRasseNummer => EinheitRasseNummer,
                             Aufgabe               => 'e');
      
   end KIFernkampfLuftEinheit;

end KIFernkampfLuftEinheit;

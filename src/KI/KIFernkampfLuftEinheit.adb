pragma SPARK_Mode (On);

with KIBewegung;

package body KIFernkampfLuftEinheit is

   procedure KIFernkampfLuftEinheit (EinheitRasseUndNummer : in GlobaleRecords.RasseUndPlatznummerRecord) is
   begin
      
      KIBewegung.KIBewegung (EinheitRasseUndNummer => EinheitRasseUndNummer,
                             Aufgabe               => 'e');
      
   end KIFernkampfLuftEinheit;

end KIFernkampfLuftEinheit;

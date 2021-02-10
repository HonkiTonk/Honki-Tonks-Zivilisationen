pragma SPARK_Mode (On);

with KIBewegung;

package body KINahkampfLuftEinheit is

   procedure KINahkampfLuftEinheit (EinheitRasseUndNummer : in GlobaleRecords.RasseUndPlatznummerRecord) is
   begin
      
      KIBewegung.KIBewegung (EinheitRasseUndNummer => EinheitRasseUndNummer,
                             Aufgabe               => 'e');
      
   end KINahkampfLuftEinheit;

end KINahkampfLuftEinheit;

pragma SPARK_Mode (On);

with KIBewegung;

package body KINahkampfLandEinheit is

   procedure KINahkampfLandEinheit (EinheitRasseUndNummer : in GlobaleRecords.RasseUndPlatznummerRecord) is
   begin
      
      KIBewegung.KIBewegung (EinheitRasseUndNummer => EinheitRasseUndNummer,
                             Aufgabe               => 'e');
      
   end KINahkampfLandEinheit;

end KINahkampfLandEinheit;

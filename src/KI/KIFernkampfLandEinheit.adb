pragma SPARK_Mode (On);

with KIBewegung;

package body KIFernkampfLandEinheit is

   procedure KIFernkampfLandEinheit (EinheitRasseUndNummer : in GlobaleRecords.RasseUndPlatznummerRecord) is
   begin
      
      KIBewegung.KIBewegung (EinheitRasseUndNummer => EinheitRasseUndNummer,
                             Aufgabe               => 'e');
      
   end KIFernkampfLandEinheit;

end KIFernkampfLandEinheit;

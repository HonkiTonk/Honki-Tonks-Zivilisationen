pragma SPARK_Mode (On);

with KIBewegung;

package body KIFernkampfLandEinheit is

   procedure KIFernkampfLandEinheit (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord) is
   begin
      
      KIBewegung.KIBewegung (EinheitRasseNummer => EinheitRasseNummer,
                             Aufgabe               => 'e');
      
   end KIFernkampfLandEinheit;

end KIFernkampfLandEinheit;

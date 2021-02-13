pragma SPARK_Mode (On);

with KIBewegung;

package body KINahkampfLandEinheit is

   procedure KINahkampfLandEinheit (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord) is
   begin
      
      KIBewegung.KIBewegung (EinheitRasseNummer => EinheitRasseNummer,
                             Aufgabe               => 'e');
      
   end KINahkampfLandEinheit;

end KINahkampfLandEinheit;

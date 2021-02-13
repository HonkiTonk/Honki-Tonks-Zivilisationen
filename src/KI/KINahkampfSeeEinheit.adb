pragma SPARK_Mode (On);

with KIBewegung;

package body KINahkampfSeeEinheit is

   procedure KINahkampfSeeEinheit (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord) is
   begin
      
      KIBewegung.KIBewegung (EinheitRasseNummer => EinheitRasseNummer,
                             Aufgabe               => 'e');
      
   end KINahkampfSeeEinheit;

end KINahkampfSeeEinheit;

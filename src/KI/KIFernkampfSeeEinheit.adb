pragma SPARK_Mode (On);

with KIBewegung;

package body KIFernkampfSeeEinheit is

   procedure KIFernkampfSeeEinheit (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord) is
   begin
      
      KIBewegung.KIBewegung (EinheitRasseNummer => EinheitRasseNummer,
                             Aufgabe               => 'e');
      
   end KIFernkampfSeeEinheit;

end KIFernkampfSeeEinheit;

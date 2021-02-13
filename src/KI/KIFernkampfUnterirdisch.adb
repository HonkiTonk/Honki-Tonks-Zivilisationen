pragma SPARK_Mode (On);

with KIBewegung;

package body KIFernkampfUnterirdisch is

   procedure KIFernkampfUnterirdisch (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord) is
   begin
      
      KIBewegung.KIBewegung (EinheitRasseNummer => EinheitRasseNummer,
                             Aufgabe               => 'e');
      
   end KIFernkampfUnterirdisch;

end KIFernkampfUnterirdisch;

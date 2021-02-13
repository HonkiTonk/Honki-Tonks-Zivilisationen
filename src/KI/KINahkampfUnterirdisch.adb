pragma SPARK_Mode (On);

with KIBewegung;

package body KINahkampfUnterirdisch is

   procedure KINahkampfUnterirdisch (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord) is
   begin
      
      KIBewegung.KIBewegung (EinheitRasseNummer => EinheitRasseNummer,
                             Aufgabe               => 'e');
      
   end KINahkampfUnterirdisch;

end KINahkampfUnterirdisch;

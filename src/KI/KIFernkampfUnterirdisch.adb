pragma SPARK_Mode (On);

with KIBewegung;

package body KIFernkampfUnterirdisch is

   procedure KIFernkampfUnterirdisch (EinheitRasseUndNummer : in GlobaleRecords.RasseUndPlatznummerRecord) is
   begin
      
      KIBewegung.KIBewegung (EinheitRasseUndNummer => EinheitRasseUndNummer,
                             Aufgabe               => 'e');
      
   end KIFernkampfUnterirdisch;

end KIFernkampfUnterirdisch;

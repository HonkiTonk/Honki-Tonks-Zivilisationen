pragma SPARK_Mode (On);

with KIBewegung;

package body KINahkampfUnterirdisch is

   procedure KINahkampfUnterirdisch (EinheitRasseUndNummer : in GlobaleRecords.RasseUndPlatznummerRecord) is
   begin
      
      KIBewegung.KIBewegung (EinheitRasseUndNummer => EinheitRasseUndNummer,
                             Aufgabe               => 'e');
      
   end KINahkampfUnterirdisch;

end KINahkampfUnterirdisch;

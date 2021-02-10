pragma SPARK_Mode (On);

with KIBewegung;

package body KINahkampfSeeEinheit is

   procedure KINahkampfSeeEinheit (EinheitRasseUndNummer : in GlobaleRecords.RasseUndPlatznummerRecord) is
   begin
      
      KIBewegung.KIBewegung (EinheitRasseUndNummer => EinheitRasseUndNummer,
                             Aufgabe               => 'e');
      
   end KINahkampfSeeEinheit;

end KINahkampfSeeEinheit;

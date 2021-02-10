pragma SPARK_Mode (On);

with KIBewegung;

package body KIFernkampfSeeEinheit is

   procedure KIFernkampfSeeEinheit (EinheitRasseUndNummer : in GlobaleRecords.RasseUndPlatznummerRecord) is
   begin
      
      KIBewegung.KIBewegung (EinheitRasseUndNummer => EinheitRasseUndNummer,
                             Aufgabe               => 'e');
      
   end KIFernkampfSeeEinheit;

end KIFernkampfSeeEinheit;

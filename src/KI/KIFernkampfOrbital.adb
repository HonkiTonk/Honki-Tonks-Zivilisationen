pragma SPARK_Mode (On);

with KIBewegung;

package body KIFernkampfOrbital is

   procedure KIFernkampfOrbital (EinheitRasseUndNummer : in GlobaleRecords.RasseUndPlatznummerRecord) is
   begin
      
      KIBewegung.KIBewegung (EinheitRasseUndNummer => EinheitRasseUndNummer,
                             Aufgabe               => 'e');
      
   end KIFernkampfOrbital;

end KIFernkampfOrbital;

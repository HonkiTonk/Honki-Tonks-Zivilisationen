pragma SPARK_Mode (On);

with KIBewegung;

package body KINahkampfOrbital is

   procedure KINahkampfOrbital (EinheitRasseUndNummer : in GlobaleRecords.RasseUndPlatznummerRecord) is
   begin
      
      KIBewegung.KIBewegung (EinheitRasseUndNummer => EinheitRasseUndNummer,
                             Aufgabe               => 'e');
      
   end KINahkampfOrbital;

end KINahkampfOrbital;

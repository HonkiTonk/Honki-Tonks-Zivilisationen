pragma SPARK_Mode (On);

with KIBewegung;

package body KINahkampfOrbital is

   procedure KINahkampfOrbital (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord) is
   begin
      
      KIBewegung.KIBewegung (EinheitRasseNummer => EinheitRasseNummer,
                             Aufgabe               => 'e');
      
   end KINahkampfOrbital;

end KINahkampfOrbital;

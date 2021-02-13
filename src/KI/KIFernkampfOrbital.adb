pragma SPARK_Mode (On);

with KIBewegung;

package body KIFernkampfOrbital is

   procedure KIFernkampfOrbital (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord) is
   begin
      
      KIBewegung.KIBewegung (EinheitRasseNummer => EinheitRasseNummer,
                             Aufgabe               => 'e');
      
   end KIFernkampfOrbital;

end KIFernkampfOrbital;

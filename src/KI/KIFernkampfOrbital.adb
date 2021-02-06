pragma SPARK_Mode (On);

with KIBewegung;

package body KIFernkampfOrbital is

   procedure KIFernkampfOrbital (RasseExtern : in GlobaleDatentypen.Rassen; EinheitNummer : in Integer) is
   begin
      
      KIBewegung.KIBewegung (RasseExtern   => RasseExtern,
                             EinheitNummer => EinheitNummer,
                             Aufgabe       => 'e');
      
   end KIFernkampfOrbital;

end KIFernkampfOrbital;

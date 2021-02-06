pragma SPARK_Mode (On);

with KIBewegung;

package body KIFernkampfSeeEinheit is

   procedure KIFernkampfSeeEinheit (RasseExtern : in GlobaleDatentypen.Rassen; EinheitNummer : in Integer) is
   begin
      
      KIBewegung.KIBewegung (RasseExtern   => RasseExtern,
                             EinheitNummer => EinheitNummer,
                             Aufgabe       => 'e');
      
   end KIFernkampfSeeEinheit;

end KIFernkampfSeeEinheit;

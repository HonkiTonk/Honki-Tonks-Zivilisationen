pragma SPARK_Mode (On);

with KIBewegung;

package body KINahkampfSeeEinheit is

   procedure KINahkampfSeeEinheit (RasseExtern : in GlobaleDatentypen.Rassen; EinheitNummer : in Integer) is
   begin
      
      KIBewegung.KIBewegung (RasseExtern   => RasseExtern,
                             EinheitNummer => EinheitNummer,
                             Aufgabe       => 'e');
      
   end KINahkampfSeeEinheit;

end KINahkampfSeeEinheit;

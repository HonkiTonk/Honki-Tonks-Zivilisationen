pragma SPARK_Mode (On);

with KIBewegung;

package body KINahkampfLandEinheit is

   procedure KINahkampfLandEinheit (RasseExtern : in GlobaleDatentypen.Rassen; EinheitNummer : in Integer) is
   begin
      
      KIBewegung.KIBewegung (RasseExtern   => RasseExtern,
                             EinheitNummer => EinheitNummer,
                             Aufgabe       => 'e');
      
   end KINahkampfLandEinheit;

end KINahkampfLandEinheit;

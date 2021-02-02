with KIBewegung;

package body KIFernkampfLandEinheit is

   procedure KIFernkampfLandEinheit (RasseExtern : in GlobaleDatentypen.Rassen; EinheitNummer : in Integer) is
   begin
      
      KIBewegung.KIBewegung (RasseExtern   => RasseExtern,
                             EinheitNummer => EinheitNummer,
                             Aufgabe       => 'e');
      
   end KIFernkampfLandEinheit;

end KIFernkampfLandEinheit;

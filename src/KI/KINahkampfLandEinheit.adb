package body KINahkampfLandEinheit is

   procedure KINahkampfLandEinheit (RasseExtern : in GlobaleDatentypen.Rassen; EinheitNummer : in Integer) is
   begin
      
      KIBewegung.KIBewegung (RasseExtern   => RasseExtern,
                             EinheitNummer => EinheitNummer,
                             Aufgabe       => 'b');
      
   end KINahkampfLandEinheit;

end KINahkampfLandEinheit;

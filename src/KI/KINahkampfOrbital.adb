with KIBewegung;

package body KINahkampfOrbital is

   procedure KINahkampfOrbital (RasseExtern : in GlobaleDatentypen.Rassen; EinheitNummer : in Integer) is
   begin
      
      KIBewegung.KIBewegung (RasseExtern   => RasseExtern,
                             EinheitNummer => EinheitNummer,
                             Aufgabe       => 'e');
      
   end KINahkampfOrbital;

end KINahkampfOrbital;

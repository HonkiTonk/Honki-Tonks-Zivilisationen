with KIBewegung;

package body KINahkampfLuftEinheit is

   procedure KINahkampfLuftEinheit (RasseExtern : in GlobaleDatentypen.Rassen; EinheitNummer : in Integer) is
   begin
      
      KIBewegung.KIBewegung (RasseExtern   => RasseExtern,
                             EinheitNummer => EinheitNummer,
                             Aufgabe       => 'e');
      
   end KINahkampfLuftEinheit;

end KINahkampfLuftEinheit;

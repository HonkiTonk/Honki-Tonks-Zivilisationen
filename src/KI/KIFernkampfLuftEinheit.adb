with KIBewegung;

package body KIFernkampfLuftEinheit is

   procedure KIFernkampfLuftEinheit (RasseExtern : in GlobaleDatentypen.Rassen; EinheitNummer : in Integer) is
   begin
      
      KIBewegung.KIBewegung (RasseExtern   => RasseExtern,
                             EinheitNummer => EinheitNummer,
                             Aufgabe       => 'e');
      
   end KIFernkampfLuftEinheit;

end KIFernkampfLuftEinheit;

pragma SPARK_Mode (On);

with KIBewegung;

package body KINahkampfUnterirdisch is

   procedure KINahkampfUnterirdisch (RasseExtern : in GlobaleDatentypen.Rassen; EinheitNummer : in Integer) is
   begin
      
      KIBewegung.KIBewegung (RasseExtern   => RasseExtern,
                             EinheitNummer => EinheitNummer,
                             Aufgabe       => 'e');
      
   end KINahkampfUnterirdisch;

end KINahkampfUnterirdisch;

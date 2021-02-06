pragma SPARK_Mode (On);

with KIBewegung;

package body KIFernkampfUnterirdisch is

   procedure KIFernkampfUnterirdisch (RasseExtern : in GlobaleDatentypen.Rassen; EinheitNummer : in Integer) is
   begin
      
      KIBewegung.KIBewegung (RasseExtern   => RasseExtern,
                             EinheitNummer => EinheitNummer,
                             Aufgabe       => 'e');
      
   end KIFernkampfUnterirdisch;

end KIFernkampfUnterirdisch;

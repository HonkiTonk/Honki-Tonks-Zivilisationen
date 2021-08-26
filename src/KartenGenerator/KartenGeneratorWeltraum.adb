pragma SPARK_Mode (On);

with GlobaleDatentypen;

with SchreibeKarten;

with Karten;

package body KartenGeneratorWeltraum is

   procedure Weltraum
   is begin
      
      YAchseWeltraumSchleife:
      for YAchseWeltraumSchleifenwert in Karten.WeltkarteArray'First (2) .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße loop
         XAchseWeltraumSchleife:
         for XAchseWeltraumSchleifenwert in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop

            SchreibeKarten.Grund (PositionExtern => (2, YAchseWeltraumSchleifenwert, XAchseWeltraumSchleifenwert),
                                  GrundExtern    => GlobaleDatentypen.Weltraum);
               
         end loop XAchseWeltraumSchleife;
      end loop YAchseWeltraumSchleife;
      
   end Weltraum;

end KartenGeneratorWeltraum;

pragma SPARK_Mode (On);

with Ada.Calendar;
use Ada.Calendar;

with Ladezeiten, Karten;

package body KartenGeneratorWeltraum is

   procedure Weltraum
   is begin
      
      Ladezeiten.SpielweltErstellenZeit (8, 1) := Clock;

      YAchseWeltraumSchleife:
      for YAchseWeltraumSchleifenwert in Karten.WeltkarteArray'First (2) .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße loop
         XAchseWeltraumSchleife:
         for XAchseWeltraumSchleifenwert in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop

            Karten.Weltkarte (2, YAchseWeltraumSchleifenwert, XAchseWeltraumSchleifenwert).Grund := 38;
               
         end loop XAchseWeltraumSchleife;
      end loop YAchseWeltraumSchleife;

      Ladezeiten.SpielweltErstellenZeit (8, 2) := Clock;
      
   end Weltraum;

end KartenGeneratorWeltraum;

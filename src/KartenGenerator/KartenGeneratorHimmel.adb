pragma SPARK_Mode (On);

with Ada.Calendar;
use Ada.Calendar;

with Ladezeiten, Karten;

package body KartenGeneratorHimmel is

   procedure Himmel
   is begin
      
      Ladezeiten.SpielweltErstellenZeit (7, 1) := Clock;
         
      YAchseHimmelSchleife:
      for YAchseHimmelSchleifenwert in Karten.WeltkarteArray'First (2) .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße loop
         XAchseHimmelSchleife:
         for XAchseHimmelSchleifenwert in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop
               
            Karten.Weltkarte (1, YAchseHimmelSchleifenwert, XAchseHimmelSchleifenwert).Grund := 37;
               
         end loop XAchseHimmelSchleife;
      end loop YAchseHimmelSchleife;
         
      Ladezeiten.SpielweltErstellenZeit (7, 2) := Clock;

   end Himmel;

end KartenGeneratorHimmel;

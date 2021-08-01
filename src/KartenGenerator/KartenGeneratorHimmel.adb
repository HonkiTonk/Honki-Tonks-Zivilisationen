pragma SPARK_Mode (On);

with Ada.Calendar;
use Ada.Calendar;

with GlobaleDatentypen;

with Ladezeiten, Karten;

package body KartenGeneratorHimmel is

   procedure Himmel
   is begin
      
      Ladezeiten.SpielweltErstellenZeit (Ladezeiten.Generiere_Ebene_Himmel, GlobaleDatentypen.Anfangswert) := Clock;
         
      YAchseHimmelSchleife:
      for YAchseHimmelSchleifenwert in Karten.WeltkarteArray'First (2) .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße loop
         XAchseHimmelSchleife:
         for XAchseHimmelSchleifenwert in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop
               
            Karten.Weltkarte (1, YAchseHimmelSchleifenwert, XAchseHimmelSchleifenwert).Grund := GlobaleDatentypen.Wolken;
               
         end loop XAchseHimmelSchleife;
      end loop YAchseHimmelSchleife;
         
      Ladezeiten.SpielweltErstellenZeit (Ladezeiten.Generiere_Ebene_Himmel, GlobaleDatentypen.Endwert) := Clock;

   end Himmel;

end KartenGeneratorHimmel;

pragma SPARK_Mode (On);

with Ada.Calendar;
use Ada.Calendar;

with GlobaleDatentypen;
use GlobaleDatentypen;

with Karten, Ladezeiten;

package body KartenGeneratorPlanetenInneres is

   procedure PlanetenInneres
   is begin
      
      Ladezeiten.LadezeitenSpielweltErstellenZeit (1, 9) := Clock;
         
      YAchseInneresSchleife:
      for YAchseInneresSchleifenwert in Karten.WeltkarteArray'First (2) .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße loop
         XAchseInneresSchleife:
         for XAchseInneresSchleifenwert in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop
               
            Karten.Weltkarte (-2, YAchseInneresSchleifenwert, XAchseInneresSchleifenwert).Grund := 39;
               
         end loop XAchseInneresSchleife;
      end loop YAchseInneresSchleife;
         
      Ladezeiten.LadezeitenSpielweltErstellenZeit (2, 9) := Clock;
      
   end PlanetenInneres;

end KartenGeneratorPlanetenInneres;

pragma SPARK_Mode (On);

with Ada.Calendar;
use Ada.Calendar;

with GlobaleDatentypen;
use GlobaleDatentypen;

with Karten, Ladezeiten;

package body KartenGeneratorPlanetenInneres is

   procedure PlanetenInneres
   is begin
      
      Ladezeiten.SpielweltErstellenZeit (Ladezeiten.Generiere_Ebene_Planeteninneres, GlobaleDatentypen.Anfangswert) := Clock;
         
      YAchseInneresSchleife:
      for YAchseInneresSchleifenwert in Karten.WeltkarteArray'First (2) .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße loop
         XAchseInneresSchleife:
         for XAchseInneresSchleifenwert in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop
               
            Karten.Weltkarte (-2, YAchseInneresSchleifenwert, XAchseInneresSchleifenwert).Grund := GlobaleDatentypen.Erde;
               
         end loop XAchseInneresSchleife;
      end loop YAchseInneresSchleife;
         
      Ladezeiten.SpielweltErstellenZeit (Ladezeiten.Generiere_Ebene_Planeteninneres, GlobaleDatentypen.Endwert) := Clock;
      
   end PlanetenInneres;

end KartenGeneratorPlanetenInneres;

pragma SPARK_Mode (On);

with GlobaleDatentypen;
use GlobaleDatentypen;

with Karten, ZufallGeneratorenKarten;

package body KartenGeneratorPlanetenInneres is

   procedure PlanetenInneres
   is begin
      
      YKernanfang := Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße / 2 - Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße / 10;
      XKernanfang := Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße / 2 - Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße / 10;
      YKernende := Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße / 2 + Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße / 10;
      XKernende := Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße / 2 + Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße / 10;
               
      YAchseInneresSchleife:
      for YAchseInneresSchleifenwert in Karten.WeltkarteArray'First (2) .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße loop
         XAchseInneresSchleife:
         for XAchseInneresSchleifenwert in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop
               
            if
              YAchseInneresSchleifenwert in YKernanfang .. YKernende
              and
                XAchseInneresSchleifenwert in XKernanfang .. XKernende
            then
               Karten.Weltkarte (-2, YAchseInneresSchleifenwert, XAchseInneresSchleifenwert).Grund := GlobaleDatentypen.Planetenkern;
            
            elsif
              ZufallGeneratorenKarten.ZufälligerWert > 0.65
            then
               Karten.Weltkarte (-2, YAchseInneresSchleifenwert, XAchseInneresSchleifenwert).Grund := GlobaleDatentypen.Lava;
               
            else
               Karten.Weltkarte (-2, YAchseInneresSchleifenwert, XAchseInneresSchleifenwert).Grund := GlobaleDatentypen.Gestein;
            end if;
               
         end loop XAchseInneresSchleife;
      end loop YAchseInneresSchleife;
               
   end PlanetenInneres;

end KartenGeneratorPlanetenInneres;

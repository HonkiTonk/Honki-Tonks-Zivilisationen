pragma SPARK_Mode (On);

with GlobaleDatentypen;

with Karten;

package body KartenGeneratorHimmel is

   procedure Himmel
   is begin
               
      YAchseHimmelSchleife:
      for YAchseHimmelSchleifenwert in Karten.WeltkarteArray'First (2) .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße loop
         XAchseHimmelSchleife:
         for XAchseHimmelSchleifenwert in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop
               
            Karten.Weltkarte (1, YAchseHimmelSchleifenwert, XAchseHimmelSchleifenwert).Grund := GlobaleDatentypen.Wolken;
               
         end loop XAchseHimmelSchleife;
      end loop YAchseHimmelSchleife;
         
   end Himmel;

end KartenGeneratorHimmel;

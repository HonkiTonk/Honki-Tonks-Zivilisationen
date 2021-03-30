pragma SPARK_Mode (On);

with GlobaleDatentypen;
use GlobaleDatentypen;

with Karten, ZufallGeneratorenKarten;

package body KartenGeneratorChaos is

   procedure Chaos is
   begin
            
      EAchseSchleife:
      for EAchseSchleifenwert in Karten.WeltkarteArray'Range (1) loop
         YAchseSchleife:
         for YAchseSchleifenwert in Karten.WeltkarteArray'First (2) .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße loop
            XAchseSchleife:
            for XAchseSchleifenwert in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop
                        
               if
                 YAchseSchleifenwert = Karten.Weltkarte'First (2)
                 or
                   YAchseSchleifenwert = Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
               then
                  Karten.Weltkarte (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert).Grund := 1;
               
               else
                  Karten.Weltkarte (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert).Grund := ZufallGeneratorenKarten.Chaoskarte;
               end if;
            
            end loop XAchseSchleife;
         end loop YAchseSchleife;
      end loop EAchseSchleife;
      
   end Chaos;

end KartenGeneratorChaos;

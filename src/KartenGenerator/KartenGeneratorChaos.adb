pragma SPARK_Mode (On);

with GlobaleDatentypen;
use GlobaleDatentypen;

with Karten, ZufallGeneratorenKarten;

package body KartenGeneratorChaos is

   procedure Chaos
   is begin
            
      EAchseSchleife:
      for EAchseSchleifenwert in Karten.WeltkarteArray'Range (1) loop
         YAchseSchleife:
         for YAchseSchleifenwert in Karten.WeltkarteArray'First (2) .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße loop
            XAchseSchleife:
            for XAchseSchleifenwert in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop
               
               GrundZufall := ZufallGeneratorenKarten.ChaoskarteGrund;
               Karten.Weltkarte (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert).Grund := GrundZufall;               
               
               case
                 GrundZufall
               is
                  when GlobaleDatentypen.Karten_Grund_Wasser_Mit_Eis_Enum'Range | GlobaleDatentypen.Lava | GlobaleDatentypen.Planetenkern =>
                     null;
                     
                  when others =>
                     Karten.Weltkarte (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert).Fluss := ZufallGeneratorenKarten.ChaoskarteFluss;
               end case;
               
               case
                 GrundZufall
               is
                  when GlobaleDatentypen.Karten_Grund_Wasser_Enum'Range =>
                     Karten.Weltkarte (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert).Ressource := ZufallGeneratorenKarten.ChaoskarteRessource (WasserLandExtern => True);
                     
                  when GlobaleDatentypen.Karten_Grund_Land_Ohne_Eis_Enum =>
                     Karten.Weltkarte (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert).Ressource := ZufallGeneratorenKarten.ChaoskarteRessource (WasserLandExtern => False);
                     
                  when others =>
                     null;
               end case;
            
            end loop XAchseSchleife;
         end loop YAchseSchleife;
      end loop EAchseSchleife;
      
   end Chaos;

end KartenGeneratorChaos;

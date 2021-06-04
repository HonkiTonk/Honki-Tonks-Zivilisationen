pragma SPARK_Mode (Off);

package body ZufallGeneratorenKarten is

   function YXPosition
     return GlobaleRecords.AchsenKartenfeldPositivRecord
   is begin

      case
        Karten.Kartengröße
      is
         when 1 =>
            WerteWählen20.Reset (PositionGewählt20);
            return (0, WerteWählen20.Random (PositionGewählt20), WerteWählen20.Random (PositionGewählt20));

         when 2 =>
            WerteWählen40.Reset (PositionGewählt40);
            return(0, WerteWählen40.Random (PositionGewählt40), WerteWählen40.Random (PositionGewählt40));
            
         when 3 =>
            WerteWählen80.Reset (PositionGewählt80);
            return (0, WerteWählen80.Random (PositionGewählt80), WerteWählen80.Random (PositionGewählt80));
            
         when 4 =>
            WerteWählen80.Reset (PositionGewählt80);
            WerteWählen120.Reset (PositionGewählt120);
            return (0, WerteWählen120.Random (PositionGewählt120), WerteWählen80.Random (PositionGewählt80));
            
         when 5 =>
            WerteWählen120.Reset (PositionGewählt120);
            WerteWählen160.Reset (PositionGewählt160);
            return (0, WerteWählen120.Random (PositionGewählt120), WerteWählen160.Random (PositionGewählt160));
            
         when 6 =>
            WerteWählen160.Reset (PositionGewählt160);
            return (0, WerteWählen160.Random (PositionGewählt160), WerteWählen160.Random (PositionGewählt160));
            
         when 7 =>
            WerteWählen240.Reset (PositionGewählt240);
            return (0, WerteWählen240.Random (PositionGewählt240), WerteWählen240.Random (PositionGewählt240));
            
         when 8 =>
            WerteWählen320.Reset (PositionGewählt320);
            return (0, WerteWählen320.Random (PositionGewählt320), WerteWählen320.Random (PositionGewählt320));
            
         when 9 =>
            WerteWählen1000.Reset (PositionGewählt1000);
            return (0, WerteWählen1000.Random (PositionGewählt1000), WerteWählen1000.Random (PositionGewählt1000));

         when others => -- 10, benutzerdefinierte Auswahl
            WerteWählen1000.Reset (PositionGewählt1000);
            BenutzerdefinierteAuswahlSchleife:
            loop
               
               ZufallsPunktKarte := (0, WerteWählen1000.Random (PositionGewählt1000), WerteWählen1000.Random (PositionGewählt1000));

               if
                 ZufallsPunktKarte.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
                 and
                   ZufallsPunktKarte.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
               then
                  return ZufallsPunktKarte;

               else
                  null;
               end if;
               
            end loop BenutzerdefinierteAuswahlSchleife;
      end case;
      
   end YXPosition;



   function ZufälligerWert
     return Float
   is begin

      Ada.Numerics.Float_Random.Reset (ZufälligerFloatWert);
      return Ada.Numerics.Float_Random.Random (ZufälligerFloatWert);
      
   end ZufälligerWert;



   function Chaoskarte
     return GlobaleDatentypen.KartenGrund
   is begin
      
      WerteWählenChaoskarte.Reset (GrundGewählt);
      
      ChaosSchleife:
      loop
         
         KartenGrundGewählt := WerteWählenChaoskarte.Random (GrundGewählt);
      
         case
           KartenGrundGewählt
         is
            when 1 .. 9 | 31 .. 32 | 35 .. 40 =>
               return KartenGrundGewählt;
            
            when others =>
               null;
         end case;
         
      end loop ChaosSchleife;
      
   end Chaoskarte;

end ZufallGeneratorenKarten;

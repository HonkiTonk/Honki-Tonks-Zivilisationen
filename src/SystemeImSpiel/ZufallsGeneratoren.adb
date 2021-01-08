package body ZufallsGeneratoren is

   function YXPosition return GlobaleDatentypen.AchsenAusKartenfeldPositiv is
   begin

      case Karten.Kartengröße is
         when 1 =>
            WerteWählen20.Reset (PositionGewählt20);
            return (0, WerteWählen20.Random (PositionGewählt20), WerteWählen20.Random (PositionGewählt20));

         when 2 =>
            WerteWählen40.Reset (PositionGewählt40);
            return (0, WerteWählen40.Random (PositionGewählt40), WerteWählen40.Random (PositionGewählt40));
            
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
            
         when others =>
            WerteWählen1000.Reset (PositionGewählt1000);
            return (0, WerteWählen1000.Random (PositionGewählt1000), WerteWählen1000.Random (PositionGewählt1000));
      end case;
      
   end YXPosition;



   function Chaoskarte return GlobaleDatentypen.KartenGrund is
   begin
      
      WerteWählenChaoskarte.Reset (GrundGewählt);
      
      loop
         
         Wert := WerteWählenChaoskarte.Random (GrundGewählt);
      
         case Wert is
            when 1 .. 9 | 31 .. 32 | 35 .. 40 =>
               return Wert;
            
            when others =>
               null;
         end case;
         
      end loop;
      
   end Chaoskarte;

end ZufallsGeneratoren;

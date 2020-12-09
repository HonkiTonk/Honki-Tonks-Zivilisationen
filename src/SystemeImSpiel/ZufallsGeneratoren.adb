package body ZufallsGeneratoren is

   function YXPosition return GlobaleDatentypen.YWertXWertAusKartenfeld is
   begin

      case Karten.Kartengröße is
         when 1 =>
            WerteWählen20.Reset (PositionGewählt20);
            return (WerteWählen20.Random (PositionGewählt20), WerteWählen20.Random (PositionGewählt20));

         when 2 =>
            WerteWählen40.Reset (PositionGewählt40);
            return (WerteWählen40.Random (PositionGewählt40), WerteWählen40.Random (PositionGewählt40));
            
         when 3 =>
            WerteWählen80.Reset (PositionGewählt80);
            return (WerteWählen80.Random (PositionGewählt80), WerteWählen80.Random (PositionGewählt80));
            
         when 4 =>
            WerteWählen80.Reset (PositionGewählt80);
            WerteWählen120.Reset (PositionGewählt120);
            return (WerteWählen120.Random (PositionGewählt120), WerteWählen80.Random (PositionGewählt80));
            
         when 5 =>
            WerteWählen120.Reset (PositionGewählt120);
            WerteWählen160.Reset (PositionGewählt160);
            return (WerteWählen120.Random (PositionGewählt120), WerteWählen160.Random (PositionGewählt160));
            
         when 6 =>
            WerteWählen160.Reset (PositionGewählt160);
            return (WerteWählen160.Random (PositionGewählt160), WerteWählen160.Random (PositionGewählt160));
            
         when 7 =>
            WerteWählen240.Reset (PositionGewählt240);
            return (WerteWählen240.Random (PositionGewählt240), WerteWählen240.Random (PositionGewählt240));
            
         when 8 =>
            WerteWählen320.Reset (PositionGewählt320);
            return (WerteWählen320.Random (PositionGewählt320), WerteWählen320.Random (PositionGewählt320));
            
         when others =>
            WerteWählen1000.Reset (PositionGewählt1000);
            return (WerteWählen1000.Random (PositionGewählt1000), WerteWählen1000.Random (PositionGewählt1000));
      end case;
      
   end YXPosition;

end ZufallsGeneratoren;

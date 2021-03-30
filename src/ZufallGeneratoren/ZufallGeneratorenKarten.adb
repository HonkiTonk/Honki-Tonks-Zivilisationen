pragma SPARK_Mode (Off);

package body ZufallGeneratorenKarten is

   function YXPosition return GlobaleRecords.AchsenKartenfeldPositivRecord is
   begin

      case
        Karten.Kartengröße
      is
         when 1 =>
            WerteWählen20.Reset (PositionGewählt20);
            ZufallsPunktKarte := (0, WerteWählen20.Random (PositionGewählt20), WerteWählen20.Random (PositionGewählt20));
            return ZufallsPunktKarte;

         when 2 =>
            WerteWählen40.Reset (PositionGewählt40);
            ZufallsPunktKarte := (0, WerteWählen40.Random (PositionGewählt40), WerteWählen40.Random (PositionGewählt40));
            return ZufallsPunktKarte;
            
         when 3 =>
            WerteWählen80.Reset (PositionGewählt80);
            ZufallsPunktKarte := (0, WerteWählen80.Random (PositionGewählt80), WerteWählen80.Random (PositionGewählt80));
            return ZufallsPunktKarte;
            
         when 4 =>
            WerteWählen80.Reset (PositionGewählt80);
            WerteWählen120.Reset (PositionGewählt120);
            ZufallsPunktKarte := (0, WerteWählen120.Random (PositionGewählt120), WerteWählen80.Random (PositionGewählt80));
            return ZufallsPunktKarte;
            
         when 5 =>
            WerteWählen120.Reset (PositionGewählt120);
            WerteWählen160.Reset (PositionGewählt160);
            ZufallsPunktKarte := (0, WerteWählen120.Random (PositionGewählt120), WerteWählen160.Random (PositionGewählt160));
            return ZufallsPunktKarte;
            
         when 6 =>
            WerteWählen160.Reset (PositionGewählt160);
            ZufallsPunktKarte := (0, WerteWählen160.Random (PositionGewählt160), WerteWählen160.Random (PositionGewählt160));
            return ZufallsPunktKarte;
            
         when 7 =>
            WerteWählen240.Reset (PositionGewählt240);
            ZufallsPunktKarte := (0, WerteWählen240.Random (PositionGewählt240), WerteWählen240.Random (PositionGewählt240));
            return ZufallsPunktKarte;
            
         when 8 =>
            WerteWählen320.Reset (PositionGewählt320);
            ZufallsPunktKarte := (0, WerteWählen320.Random (PositionGewählt320), WerteWählen320.Random (PositionGewählt320));
            return ZufallsPunktKarte;
            
         when 9 =>
            WerteWählen1000.Reset (PositionGewählt1000);
            ZufallsPunktKarte := (0, WerteWählen1000.Random (PositionGewählt1000), WerteWählen1000.Random (PositionGewählt1000));
            return ZufallsPunktKarte;

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



   function ZufälligerWert return Float is
   begin

      Ada.Numerics.Float_Random.Reset (ZufälligerFloatWert);
      GewählterFloatWert := Ada.Numerics.Float_Random.Random (ZufälligerFloatWert);
      
      return GewählterFloatWert;
      
   end ZufälligerWert;



   function Chaoskarte return GlobaleDatentypen.KartenGrund is
   begin
      
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

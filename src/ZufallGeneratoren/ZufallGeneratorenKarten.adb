pragma SPARK_Mode (Off);

with BewegungPassierbarkeitPruefen;

package body ZufallGeneratorenKarten is

   function StartPosition
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleRecords.AchsenKartenfeldPositivRecord
   is begin
      
      case
        RasseExtern
      is
         when GlobaleDatentypen.Talbidahr | GlobaleDatentypen.Tesorahn =>
            EAchse := -1;
            
         when others =>
            EAchse := 0;
      end case;

      PositionBestimmenSchleife:
      loop
         
         case
           Karten.Kartengröße
         is
            when GlobaleDatentypen.Karte_20_20 =>
               WerteWählen20.Reset (PositionGewählt20);
               YAchse := WerteWählen20.Random (PositionGewählt20);
               XAchse := WerteWählen20.Random (PositionGewählt20);

            when GlobaleDatentypen.Karte_40_40 =>
               WerteWählen40.Reset (PositionGewählt40);
               YAchse := WerteWählen40.Random (PositionGewählt40);
               XAchse := WerteWählen40.Random (PositionGewählt40);
            
            when GlobaleDatentypen.Karte_80_80 =>
               WerteWählen80.Reset (PositionGewählt80);
               YAchse := WerteWählen80.Random (PositionGewählt80);
               XAchse := WerteWählen80.Random (PositionGewählt80);
            
            when GlobaleDatentypen.Karte_120_80 =>
               WerteWählen80.Reset (PositionGewählt80);
               WerteWählen120.Reset (PositionGewählt120);
               YAchse := WerteWählen120.Random (PositionGewählt120);
               XAchse := WerteWählen80.Random (PositionGewählt80);
            
            when GlobaleDatentypen.Karte_120_160 =>
               WerteWählen120.Reset (PositionGewählt120);
               WerteWählen160.Reset (PositionGewählt160);
               YAchse := WerteWählen120.Random (PositionGewählt120);
               XAchse := WerteWählen160.Random (PositionGewählt160);
            
            when GlobaleDatentypen.Karte_160_160 =>
               WerteWählen160.Reset (PositionGewählt160);
               YAchse := WerteWählen160.Random (PositionGewählt160);
               XAchse := WerteWählen160.Random (PositionGewählt160);
            
            when GlobaleDatentypen.Karte_240_240 =>
               WerteWählen240.Reset (PositionGewählt240);
               YAchse := WerteWählen240.Random (PositionGewählt240);
               XAchse := WerteWählen240.Random (PositionGewählt240);
            
            when GlobaleDatentypen.Karte_320_320 =>
               WerteWählen320.Reset (PositionGewählt320);
               YAchse := WerteWählen320.Random (PositionGewählt320);
               XAchse := WerteWählen320.Random (PositionGewählt320);
            
            when GlobaleDatentypen.Karte_1000_1000 =>
               WerteWählen1000.Reset (PositionGewählt1000);
               YAchse := WerteWählen1000.Random (PositionGewählt1000);
               XAchse := WerteWählen1000.Random (PositionGewählt1000);

            when others =>
               WerteWählen1000.Reset (PositionGewählt1000);
               BenutzerdefinierteAuswahlSchleife:
               loop
               
                  YAchse := WerteWählen1000.Random (PositionGewählt1000);
                  XAchse := WerteWählen1000.Random (PositionGewählt1000);

                  if
                    YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
                    and
                      XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
                  then
                     exit BenutzerdefinierteAuswahlSchleife;

                  else
                     null;
                  end if;
               
               end loop BenutzerdefinierteAuswahlSchleife;
         end case;
         
         case
           BewegungPassierbarkeitPruefen.PassierbarkeitPrüfenID (RasseExtern        => RasseExtern,
                                                                  IDExtern           => 1,
                                                                  NeuePositionExtern => (EAchse, YAchse, XAchse))
         is
            when True =>
               return (EAchse, YAchse, XAchse);
               
            when False =>
               null;
         end case;
         
      end loop PositionBestimmenSchleife;      
      
   end StartPosition;



   function ZufälligerWert
     return Float
   is begin

      Ada.Numerics.Float_Random.Reset (ZufälligerFloatWert);
      return Ada.Numerics.Float_Random.Random (ZufälligerFloatWert);
      
   end ZufälligerWert;



   function Chaoskarte
     return GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum
   is begin
      
      WerteWählenChaoskarte.Reset (GrundGewählt);
      return WerteWählenChaoskarte.Random (GrundGewählt);
      
   end Chaoskarte;

end ZufallGeneratorenKarten;
